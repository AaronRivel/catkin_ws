#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from quadruped_robot.kbhit import KBHit 
from quadruped_robot.common_libs import rospy, tm, np, constants, time_state, period
from quadruped_robot.common_tools import *

kb = KBHit()
run_time = tm.time()

q0 = np.array([ 0 ,
                0 ,
                0 ,  
                0 ,
                0 ])
def callback(datain):
    set_period(datain.T)

def main():
    open_port()

    rospy.init_node('motor_scan', anonymous=True)

    pub = rospy.Publisher('currently_motors_state', time_state, queue_size = 10)
    rospy.Subscriber('current_period', period, callback)

    if init_dynamixel([constants.LEG_4_F, constants.LEG_4_P]) == False:
        close_port()
        return
    
    #set_period_ref(20)

    animation = time_state()

    T = 0.1

    init_time = 0

    while True:
        global q0
        rospy.spin()

        current_time = tm.time() - run_time
        
        if((current_time - init_time) > T):
            init_time = current_time
            
            theta_f, theta_p = read_pos(constants.LEG_4_F, constants.LEG_4_P)

            if(theta_f > 4095): theta_f = 0
            if(theta_p > 4095): theta_p = 0
            
            theta_f = theta_f*(2*np.pi/4095)
            theta_p = theta_p*(2*np.pi/4095)

            animation.q0 = theta_f
            animation.q1 = theta_p - theta_f + np.pi  
            animation.t = current_time
            
            
            q0 = np.array([0          ,
                0            ,
                theta_f      ,
                theta_p - theta_f + np.pi  ,  
                0            ])
            
            
            h = T 

            pub.publish(animation)
            q , q_dot = rk4(q0 , current_time , h )
            
            theta_p =  q[3] + q[2] - np.pi
            vel_p = q_dot[3] + q_dot[2]

            #print('theta f: {:.2f}'.format(q[2]*57.3),'   RPM: {:.2f}'.format(q_dot[2]*60/(2*np.pi)),'   theta p: {:.2f}'.format(theta_p*57.3),'   RPM: {:.2f}'.format(vel_p*60/(2*np.pi)))
            
            dxl_vel_f = ((q_dot[2]*60)/(2*np.pi))*(1023/229)
            dxl_vel_p = ((vel_p*60)/(2*np.pi))*(1023/229)

            goal_velocity(dxl_vel_f, dxl_vel_p, constants.LEG_4_F, constants.LEG_4_P)
            
            c_ord = ''
            if (kb.kbhit()):
                c = kb.getch()
                c_ord = ord(c)
            if (c_ord == constants.ESC_ASCII_VALUE):
                rospy.loginfo("EXIT PROGRAM!!")
                goal_velocity(0,0,constants.LEG_4_F,constants.LEG_4_P)
                torque_off(constants.LEG_4_F, constants.LEG_4_P)
                close_port()
                break

if __name__ == '__main__' :
    main()

