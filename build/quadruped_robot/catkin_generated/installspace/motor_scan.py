#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from quadruped_robot.kbhit import KBHit
from quadruped_robot.timer import Timer 
from quadruped_robot.common_libs import rospy, np, constants, leg_state, write_dxl, read_dxl, multi_leg_control
from quadruped_robot.common_tools import *

kb = KBHit()
tm = Timer()

LEG_NAME = ''

q0 = np.array([ 0 ,
                0 ,
                0 ,  
                0 ,
                0 ])

def callback(datain):
    set_period_ref(datain.T)

    if (LEG_NAME == 'LEG_1'):
        set_walk_flag(datain.L1.walk_flag)
    if (LEG_NAME == 'LEG_2'):
        set_walk_flag(datain.L2.walk_flag)
    if (LEG_NAME == 'LEG_3'):
        set_walk_flag(datain.L3.walk_flag)
    if (LEG_NAME == 'LEG_4'):
        set_walk_flag(datain.L4.walk_flag)

def main():
    global LEG_NAME
    rospy.init_node('motor_scan', anonymous=True)

    half_elipse(5,2)

    namespace = rospy.get_namespace()

    LEG_F = rospy.get_param(namespace + 'LEG_F')
    LEG_P = rospy.get_param(namespace + 'LEG_P')
    LEG_NAME = rospy.get_param(namespace + 'LEG_NAME')

    Kp = rospy.get_param(namespace + 'Kp')
    Kd = rospy.get_param(namespace + 'Kd')
    Ki = rospy.get_param(namespace + 'Ki')

    set_PID(Kp,Kd,Ki)

    pub = rospy.Publisher('currently_motors_state', leg_state, queue_size = 10)
    msg = leg_state()

    rospy.Subscriber('/legs_control', multi_leg_control, callback)

    rospy.wait_for_service('/write_dxl')
    rospy.wait_for_service('/read_dxl')

    write = rospy.ServiceProxy('/write_dxl', write_dxl)
    read = rospy.ServiceProxy('/read_dxl', read_dxl)

    write_result = write('init_dynamixel', LEG_F, LEG_P,0,0)

    if(write_result.result == False):
        rospy.loginfo("FAIL initializing %s", LEG_NAME)
        write('shutdown_all', 0, 0,0,0)
        return
    
    tm.start()

    T = 0.05
    init_time = 0

    avoid_flag = False

    while True:
        global q0

        pos_ee = get_end_efector_pos()

        msg.leg_pos = pos_ee
        msg.walk_flag = get_walk_flag()

        if(pos_ee == 'POSTERIOR_FINISH'):
            tm.reset()

        if(not get_walk_flag() and not avoid_flag):
            avoid_flag = True
            write('goal_velocity', LEG_F, LEG_P,0, 0)
            tm.pause()

        if(get_walk_flag()): 
            avoid_flag = False
            read_result = read('shutdown_flag',0,0)

            if(read_result.result_1):
                break
            tm.resume()

        current_time = tm.get_time()

        if(((current_time - init_time) > T) and get_walk_flag()):

            init_time = current_time
            
            read_result = read('read_position', LEG_F, LEG_P)

            actual_theta_f = read_result.result_1
            actual_theta_p = read_result.result_2

         
            while(round(read_result.result_1) == 0 or round(read_result.result_2) == 0):
                read_result = read('read_position', LEG_F, LEG_P)

                actual_theta_f = read_result.result_1
                actual_theta_p = read_result.result_2

            #actual_theta_f, actual_theta_p = read_pos(constants.LEG_4_F, constants.LEG_4_P)


            actual_theta_f = actual_theta_f - constants.OFFSET*(4095/360) #motor f hace a fisical offset to avoid encoder cross zero and give missvalues
            
            actual_theta_f = actual_theta_f*(2*np.pi/4095)
            actual_theta_p = actual_theta_p*(2*np.pi/4095)
            
            msg.q0 = actual_theta_f
            msg.q1 = actual_theta_p - actual_theta_f + np.pi  
            msg.t = current_time
            
            if(actual_theta_p*57.3 > (actual_theta_f*57.3 + 180) - constants.JOINT_LIMIT or actual_theta_p*57.3 < actual_theta_f*57.3 + constants.JOINT_LIMIT or actual_theta_p*57.3 > constants.PROTECCION_LIMIT_P or actual_theta_f < constants.PROTECCION_LIMIT_F):
                print(actual_theta_f*57.3, actual_theta_p*57.3)
                
                rospy.loginfo("JOINT LIMIT of %s",LEG_NAME )

                write_result = write('shutdown', LEG_F, LEG_P,0,0)
                #shutdown(constants.LEG_4_F,constants.LEG_4_P)
                break
            #print(actual_theta_f*57.3, (actual_theta_p - actual_theta_f + np.pi)*57.3)
            
            
            q0 = np.array([0          ,
                0            ,
                actual_theta_f      ,
                actual_theta_p - actual_theta_f + np.pi  ,  
                0            ])
            
            h = T 

            q , q_dot = rk4(q0 , current_time , h )
            

            set_current_velocity(q_dot)
            
            
            #theta_p =  q[3] + q[2] - np.pi
            vel_p = q_dot[3] + q_dot[2]

            #print('theta f: {:.2f}'.format(q[2]*57.3),'   RPM: {:.2f}'.format(q_dot[2]*60/(2*np.pi)),'   theta p: {:.2f}'.format(theta_p*57.3),'   RPM: {:.2f}'.format(vel_p*60/(2*np.pi)))
            #print('error = ', 57.3*(actual_theta_f - q[2]), 57.3*(actual_theta_p - theta_p))
            #print((2*(actual_theta_p - actual_theta_f) + 2*(np.pi*2-(actual_theta_p - actual_theta_f + np.pi)))*57.3)
            
            dxl_vel_f = ((q_dot[2]*60)/(2*np.pi))*(1023/234)
            dxl_vel_p = ((vel_p*60)/(2*np.pi))*(1023/234)

            #print(dxl_vel_f, dxl_vel_p)

            write('goal_velocity', LEG_F, LEG_P,dxl_vel_f, dxl_vel_p)
            #goal_velocity(dxl_vel_f, dxl_vel_p, constants.LEG_4_F, constants.LEG_4_P)

        pub.publish(msg)
            
        c_ord = ''
        if (kb.kbhit()):
            c = kb.getch()
            c_ord = ord(c)
        if (c_ord == constants.ESC_ASCII_VALUE ):
            rospy.loginfo("EXIT PROGRAM!!")

            #write_result = write('shutdown', LEG_F, LEG_P,0,0)
            write('shutdown_all', 0, 0,0,0)

            #write_result = write('close_port', 0,0,0,0)
            #shutdown(LEG_F,LEG_P)
            break
            
if __name__ == '__main__' :
    main()

