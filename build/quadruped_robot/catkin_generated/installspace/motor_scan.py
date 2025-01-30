#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from quadruped_robot.kbhit import KBHit
from quadruped_robot.timer import Timer 
from quadruped_robot.common_libs import rospy, np, constantsXM, leg_state, write_dxl, read_dxl, multi_leg_control
from quadruped_robot.common_tools import RobotController

tm = Timer()
R = RobotController('motor_scan',tm)
kb = KBHit()

LEG_PATHS = {
    'LEG_1': lambda datain: datain.L1.path,
    'LEG_2': lambda datain: datain.L2.path,
    'LEG_3': lambda datain: datain.L3.path,
    'LEG_4': lambda datain: datain.L4.path,
}
def callback(datain):
    R.walk_flag = datain.walk_flag

    if R.walk_flag:
        path_func = LEG_PATHS.get(R.LEG_NAME)
        if path_func:
            R.gate([5,2], datain.way, path_func(datain),datain.cm_s)

def read_positions(read, leg_f, leg_p):
    read_result = read('read_position',constantsXM.PROTOCOL_VERSION, leg_f, leg_p)

    dxl_theta_f = read_result.result_1
    dxl_theta_p = read_result.result_2

    dxl_theta_f = dxl_theta_f - constantsXM.OFFSET*(constantsXM.MAX_POSITION/constantsXM.MAX_ANGLE) #motor f has a fisical offset to avoid encoder cross zero and give missvalues
                
    dxl_theta_f = dxl_theta_f*(2*np.pi/constantsXM.MAX_POSITION)
    dxl_theta_p = dxl_theta_p*(2*np.pi/constantsXM.MAX_POSITION)

    return dxl_theta_f, dxl_theta_p

def check_joint_limits(theta_f, theta_p):
    """Verifica si las posiciones de las articulaciones están dentro de los límites seguros."""
    theta_p_deg, theta_f_deg = theta_p * 57.3, theta_f * 57.3
    
    return (
        theta_p_deg > theta_f_deg + 180 - constantsXM.JOINT_LIMIT or 
        theta_p_deg < theta_f_deg + constantsXM.JOINT_LIMIT or 
        theta_p_deg > constantsXM.PROTECCION_LIMIT_P or 
        theta_f_deg < constantsXM.PROTECCION_LIMIT_F
    )

    
def main():

    pub = rospy.Publisher('currently_motors_state', leg_state, queue_size = 10)
    msg = leg_state()

    rospy.Subscriber('/legs_control', multi_leg_control, callback)

    rospy.wait_for_service('/write_dxl')
    rospy.wait_for_service('/read_dxl')

    write = rospy.ServiceProxy('/write_dxl', write_dxl)
    read = rospy.ServiceProxy('/read_dxl', read_dxl)

    write_result = write('init_dynamixel',constantsXM.PROTOCOL_VERSION, R.LEG_F, R.LEG_P,0,0)

    if(write_result.result == False):
        rospy.loginfo("FAIL initializing %s", R.LEG_NAME)
        write('shutdown_all',constantsXM.PROTOCOL_VERSION, 0, 0,0,0)
        return

    while True:
        
        while R.walk_flag:
            read_result = read('shutdown_flag',constantsXM.PROTOCOL_VERSION,0,0)

            if(read_result.result_1):
                break

            current, final = R.get_current_time()

            if not current >= final:
                tm.resume()
            else:
                tm.pause()

            if not R.path == 'wait':
                dxl_theta_f, dxl_theta_p = read_positions(read, R.LEG_F, R.LEG_P)
                '''
                if check_joint_limits(dxl_theta_f, dxl_theta_p):
                    write('shutdown',constantsXM.PROTOCOL_VERSION, R.LEG_F, R.LEG_P, 0, 0)
                    rospy.loginfo("JOINT LIMIT of %s", R.LEG_NAME)
                    rospy.loginfo("F = %d   P = %d", dxl_theta_f * 57.3, dxl_theta_p * 57.3)
                    R.walk_flag = False
                    write('shutdown_all',constantsXM.PROTOCOL_VERSION, 0, 0, 0, 0)
                
                    msg.q0 = dxl_theta_f
                    msg.q1 = dxl_theta_p - dxl_theta_f + np.pi  
                    msg.t = R.t
                    pub.publish(msg)
                    
                    break
                '''
                q0 = np.array([0          ,
                    0            ,
                    dxl_theta_f      ,
                    dxl_theta_p - dxl_theta_f + np.pi  ,  
                    0            ])
                
                dt = 0.1
                q_dot = R.f(tm.get_time(),q0,dt)
                
                vel_p = q_dot[3] + q_dot[2]

                dxl_vel_f = ((q_dot[2]*60)/(2*np.pi))*(constantsXM.MAX_VEL/234)
                dxl_vel_p = ((vel_p*60)/(2*np.pi))*(constantsXM.MAX_VEL/234)

                write('goal_velocity',constantsXM.PROTOCOL_VERSION, R.LEG_F, R.LEG_P,dxl_vel_f, dxl_vel_p)
                
                msg.finish = False
                msg.q0 = dxl_theta_f
                msg.q1 = dxl_theta_p - dxl_theta_f + np.pi  
                msg.t = current

                if R.margin_error(0.3):
                    write('goal_velocity',constantsXM.PROTOCOL_VERSION, R.LEG_F, R.LEG_P,0, 0)
                    tm.reset()
                    msg.finish = True
                    R.walk_flag = False
            else:
                msg.finish = True
                R.walk_flag = False

            pub.publish(msg)
            
            c_ord = ''
            if (kb.kbhit()):
                c = kb.getch()
                c_ord = ord(c)

                if (c_ord == constantsXM.ESC_ASCII_VALUE ):
                    rospy.loginfo("SHUTDOWN")
                    write('shutdown',constantsXM.PROTOCOL_VERSION, R.LEG_F, R.LEG_P,0,0)
                    break

            if not R.walk_flag :
                write('goal_velocity',constantsXM.PROTOCOL_VERSION, R.LEG_F, R.LEG_P,0, 0)
                tm.pause()

        c_ord = ''
        if (kb.kbhit()):
            c = kb.getch()
            c_ord = ord(c)
            if (c_ord == constantsXM.ESC_ASCII_VALUE ):
                rospy.loginfo("EXIT PROGRAM!!, %s", R.LEG_NAME)
                write('shutdown',constantsXM.PROTOCOL_VERSION, R.LEG_F, R.LEG_P,0,0)
                break
            
if __name__ == '__main__' :
    main()

