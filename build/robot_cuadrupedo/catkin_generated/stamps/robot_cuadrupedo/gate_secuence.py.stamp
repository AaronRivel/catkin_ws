#!/usr/bin/env python
import rospy
from robot_cuadrupedo.msg import robot_state
from robot_cuadrupedo.msg import motors_states
import time 
import numpy as np

LEG_1_F = 1
LEG_1_P = 2

#LEG_2_F = 3
#LEG_2_P = 8

LEG_3_F = 5
LEG_3_P = 6

LEG_4_F = 4
LEG_4_P = 7

OFFSET = 90
INIT_POSITION_F = 45
INIT_POSITION_P = 135
POINTS = 5
Q0 = [20,5]

secuence = ((LEG_1_F,LEG_1_P),
            (LEG_3_F,LEG_3_P),
            (LEG_4_F,LEG_4_P))

index = 0
secuence_index = 0
init_flag = True

velocity = 0
walk = True

def inverse_kinematic(x,y):
    ld1,ld2,lf,lp,lt = [7,7,7,7,14]
    origin_x = 20
    origin_y = 20

    index = 0
    Theta_f_vector = []
    Theta_p_vector = []

    while(True):
        x_value = x[round(index)]- origin_x
        y_value = y[round(index)]- origin_y  

        c = np.sqrt(x_value**2+y_value**2)
        B = np.arctan2(x_value,y_value)*180/np.pi
        phi=  B-90
        alpha2 = np.arccos((lt**2-lf**2-c**2)/(-2*lf*c))*180/np.pi
        theta_f = 180-phi-alpha2
        theta_d_2  = np.arccos((c**2-lf**2-lt**2)/(-2*lf*lt))*180/np.pi
        beta = 90 - theta_d_2/2
        theta_p = theta_f +2*beta

        if(theta_f > 300): theta_f = theta_f-360

        if(theta_p > 400): theta_p = theta_p-360

        Theta_f_vector.append(theta_f)
        Theta_p_vector.append(theta_p)

        index = index + 1
        if (index == len(x)-1):
            break

    return Theta_f_vector, Theta_p_vector

def elipse(ar, br):
    x = np.linspace(Q0[0]+ar,Q0[0]-ar,POINTS)
    x0 = Q0[0]
    y0 = Q0[1]
    y =(br*np.sqrt(ar**2-x**2+2*x*x0-x0**2))/(ar)+y0
    line = np.linspace(Q0[0]-ar,Q0[0]+ar,POINTS)
    walk = []
    x2 = []
    for i in range (len(x)*2):
        if (i < POINTS):
            x2.append(x[i])
            walk.append(y[i])
        else:
            x2.append(line[i-POINTS])
            walk.append(5)
    f, p = inverse_kinematic(x2,walk)
    return f,p


def pos_to_front(ar,br):
    x = np.linspace(Q0[0]+ar,Q0[0]-ar,POINTS)
    x0 = Q0[0]
    y0 = Q0[1]
    y =(br*np.sqrt(ar**2-x**2+2*x*x0-x0**2))/(ar)+y0

    f,p = inverse_kinematic(x,y)
    return f,p,f[0],p[0]

def front_to_pos(init_x,end_x,higth):
    x = np.linspace(init_x,end_x,POINTS)
    y = np.full(len(x),higth)

    f,p = inverse_kinematic(x,y)
    
    return f,p,f[0],p[0]

def send_parameters(theta_f, theta_p, id_f, id_p):
    dataout = motors_states()

    dataout.frontal_motor = theta_f 
    dataout.posterior_motor = theta_p 
    dataout.walk = True
    dataout.id_f = id_f
    dataout.id_p = id_p
    rospy.loginfo("I send gate parameters: Theta f [%f], Theta p [%f] , Walkin state [%d]",dataout.frontal_motor,dataout.posterior_motor,dataout.walk)


    return dataout

def callback(datain):
    rospy.loginfo("callback")
    velocity = datain.velocity
    walk = datain.walk
        
    rospy.loginfo("I recive Robot State: velocity [%f], Walking state [%d]", velocity,walk)
    

def feedback_callback(feedback_data, args):
    pub = args[0]
    theta_f = args[1]
    theta_p = args[2]

    rospy.loginfo("feedback callback")
    goal_position_feedback = feedback_data.goal_position_feedback

    if goal_position_feedback == True:
        global index
        global secuence_index

        if(walk == True ):

            if (index == len(theta_f)):
                index = 0
                secuence_index = secuence_index + 1
                if (secuence_index == len(secuence)): secuence_index = 0

            id_f = secuence[secuence_index][0]
            id_p = secuence[secuence_index][1]

            dataout = send_parameters(theta_f[index],theta_p[index],id_f,id_p)
            pub.publish(dataout)

            index = index + 1
        
        else:
            dataout.walk = False
            pub.publish(dataout)
    else: 
        return
    
def main():
    ar = 5
    br = 2

    f,p = elipse(ar,br)
    
    rospy.init_node('Gate_secuence', anonymous=True)

    pub = rospy.Publisher('Gate_control', motors_states, queue_size=10)

    rospy.loginfo("Init conection 'Gate control'... ")
    time.sleep(3)

    dataout = send_parameters(INIT_POSITION_F,INIT_POSITION_P,LEG_1_F,LEG_1_P)
    pub.publish(dataout)

    time.sleep(3)

    dataout = send_parameters(INIT_POSITION_F,INIT_POSITION_P,LEG_3_F,LEG_3_P)
    pub.publish(dataout)

    time.sleep(3)

    dataout = send_parameters(INIT_POSITION_F,INIT_POSITION_P,LEG_4_F,LEG_4_P)
    pub.publish(dataout)

   
    rospy.Subscriber("Feedback", motors_states, feedback_callback,(pub,f,p)) 
    rospy.Subscriber("RC_control", robot_state,callback)
    rospy.loginfo("Suscribing to feedback and RC_control")
    time.sleep(1)

    
    rospy.spin()

if __name__ == '__main__':
    main()