#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from quadruped_robot.kbhit import KBHit
from quadruped_robot.timer import Timer 
from quadruped_robot.common_libs import rospy, np, constants, leg_state, write_dxl, read_dxl, multi_leg_control
from quadruped_robot.common_tools import RobotController

R = RobotController('motor_scan')

kb = KBHit()
tm = Timer()

LEG_GATES = {
    'LEG_1': lambda datain: datain.L1.gate,
    'LEG_2': lambda datain: datain.L2.gate,
    'LEG_3': lambda datain: datain.L3.gate,
    'LEG_4': lambda datain: datain.L4.gate,
}

def callback(datain):
    R.toggle_flag = True if R.way != datain.way else False

    R.walk_flag = datain.walk_flag
    if R.walk_flag:
        R.tf = datain.tf
        gate_func = LEG_GATES.get(R.LEG_NAME)
        if gate_func:
            R.gate(2, 5, datain.way, gate_func(datain))
        tm.config(R.tmapp)

def read_positions(read, leg_f, leg_p):
    read_result = read('read_position', leg_f, leg_p)

    actual_theta_f = read_result.result_1
    actual_theta_p = read_result.result_2

    while round(actual_theta_f) == 0 or round(actual_theta_p) == 0:
        read_result = read('read_position', leg_f, leg_p)
        actual_theta_f = read_result.result_1
        actual_theta_p = read_result.result_2

    actual_theta_f = actual_theta_f - constants.OFFSET*(4095/360) #motor f have a fisical offset to avoid encoder cross zero and give missvalues
                
    actual_theta_f = actual_theta_f*(2*np.pi/4095)
    actual_theta_p = actual_theta_p*(2*np.pi/4095)

    return actual_theta_f, actual_theta_p

def check_joint_limits(theta_f, theta_p):
    """Verifica si las posiciones de las articulaciones están dentro de los límites seguros."""
    theta_p_deg, theta_f_deg = theta_p * 57.3, theta_f * 57.3
    return (
        theta_p_deg > theta_f_deg + 180 - constants.JOINT_LIMIT or 
        theta_p_deg < theta_f_deg + constants.JOINT_LIMIT or 
        theta_p_deg > constants.PROTECCION_LIMIT_P or 
        theta_f_deg < constants.PROTECCION_LIMIT_F
    )

def main():

    pub = rospy.Publisher('currently_motors_state', leg_state, queue_size = 10)
    msg = leg_state()

    rospy.Subscriber('/legs_control', multi_leg_control, callback)

    rospy.wait_for_service('/write_dxl')
    rospy.wait_for_service('/read_dxl')

    write = rospy.ServiceProxy('/write_dxl', write_dxl)
    read = rospy.ServiceProxy('/read_dxl', read_dxl)

    write_result = write('init_dynamixel', R.LEG_F, R.LEG_P,0,0)

    if(write_result.result == False):
        rospy.loginfo("FAIL initializing %s", R.LEG_NAME)
        write('shutdown_all', 0, 0,0,0)
        return
    
    
    T = 0.05
    avoid_flag = False

    tm.start()
    init_time = 0
    while True:
            
        if((not R.walk_flag or R.path == 'wait') and not avoid_flag):
            avoid_flag = True
            write('goal_velocity', R.LEG_F, R.LEG_P,0, 0)
            tm.pause()

        if(R.walk_flag and R.path != 'wait'): 
            avoid_flag = False
            read_result = read('shutdown_flag',0,0)

            if(read_result.result_1):
                break
            tm.resume()

        R.t = tm.get_time()

        if(((R.t - init_time) > T) and R.walk_flag):

            init_time = R.t
            
            actual_theta_f, actual_theta_p = read_positions(read, R.LEG_F, R.LEG_P)
            
            if check_joint_limits(actual_theta_f, actual_theta_p):
                rospy.loginfo("JOINT LIMIT of %s", R.LEG_NAME)
                write('shutdown', R.LEG_F, R.LEG_P, 0, 0)
                break
                
            msg.q0 = actual_theta_f
            msg.q1 = actual_theta_p - actual_theta_f + np.pi  
            msg.t = R.t
            
            
            q0 = np.array([0          ,
                0            ,
                actual_theta_f      ,
                actual_theta_p - actual_theta_f + np.pi  ,  
                0            ])
            
            h = T 

            q , q_dot = R.rk4(q0 , R.t , h )
            

            R.q_dot = q_dot
            
            
            vel_p = q_dot[3] + q_dot[2]

            
            dxl_vel_f = ((q_dot[2]*60)/(2*np.pi))*(1023/234)
            dxl_vel_p = ((vel_p*60)/(2*np.pi))*(1023/234)

            write('goal_velocity', R.LEG_F, R.LEG_P,dxl_vel_f, dxl_vel_p)

            if R.t >= R.tf :
                msg.finish = True
                R.walk_flag = False
                tm.pause()
                tm.reset()

            pub.publish(msg)
            
        c_ord = ''
        if (kb.kbhit()):
            c = kb.getch()
            c_ord = ord(c)
        if (c_ord == constants.ESC_ASCII_VALUE ):
            rospy.loginfo("EXIT PROGRAM!!")
            write('shutdown_all', 0, 0,0,0)
            break
        


            
if __name__ == '__main__' :
    main()

