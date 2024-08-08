#!/usr/bin/env python3
import rospy
from robot_cuadrupedo.msg import robot_state
from robot_cuadrupedo.msg import motors_states
import time 
OFFSET = 90
INIT_POSITION_F = 10
INIT_POSITION_P = 170 

theta_p =  [134.70322775290674, 134.70322775290674, 134.43726792867216, 131.0831441941569, 126.86907230375515, 122.18927876429053, 477.2998335885741, 472.3836338684413, 467.55292731735096, 462.8370042617942, 457.8333301070627, 457.8333301070627, 462.3114188711919, 466.7642550948859, 471.17723774781894, 475.5236136048184, 119.76580639814134, 123.85762123963873, 127.74720911954908, 131.38032903227202, 134.70322775290674]
theta_f =  [46.16501335837322, 46.16501335837322, 32.360161990021695, 23.439349415940427, 15.870609400252391, 9.574289185817534, 364.6848440101011, 361.38517096493854, 359.9091325391345, 360.7598983231438, 369.2951157125292, 369.2951157125292, 370.88573428288544, 373.1709892733404, 376.13624359299706, 379.75760168178704, 23.99979447510995, 28.816627084816844, 34.15394329800357, 39.95464444396556, 46.16501335837322]
index = 0
init_flag = True
velocity = 0
walk = True

def callback(datain):
    rospy.loginfo("callback")
    velocity = datain.rc.velocity
    walk = datain.rc.walk
        
    rospy.loginfo("I recive Robot State: velocity [%f], Walking state [%d]", velocity,walk)
    

def feedback_callback(feedback_data, pub):
    rospy.loginfo("feedback callback")
    goal_position_feedback = feedback_data.leg1.goal_position_feedback

    if goal_position_feedback == True:

        global index
        dataout = motors_states()
        if(walk == True ):
            if (index == len(theta_f)):
                index = 0

            if(theta_f[index] > 300): theta_f[index] = theta_f[index]-360

            if(theta_p[index] > 400): theta_p[index] = theta_p[index]-360
            
            dataout.leg1.frontal_motor = theta_f[index]
            dataout.leg1.posterior_motor = theta_p[index]
            dataout.leg1.walk = True
            rospy.loginfo("I send gate parameters: Theta f [%f], Theta p [%f] , Walkin state [%d]",dataout.leg1.frontal_motor,dataout.leg1.posterior_motor,dataout.leg1.walk)
            pub.publish(dataout)
            index = index + 1

        if(walk == False):
            dataout.leg1.walk = False
            pub.publish(dataout)
        
def main():
    rospy.init_node('Gate_secuence', anonymous=True)
    pub = rospy.Publisher('Gate_control', motors_states, queue_size=10)
    dataout = motors_states()

    dataout.leg1.frontal_motor = INIT_POSITION_F 
    dataout.leg1.posterior_motor = INIT_POSITION_P 
    dataout.leg1.walk = True

    rospy.loginfo("Init conection 'Gate control'... ")
    time.sleep(1)
    rospy.loginfo("Sucesfully conected ")

    pub.publish(dataout)


    rospy.Subscriber("Feedback", motors_states, feedback_callback,pub) 
    rospy.Subscriber("RC_control", robot_state,callback)
    rospy.loginfo("Suscribing to feedback and RC_control")
    time.sleep(1)

    
    rospy.spin()

if __name__ == '__main__':
    main()