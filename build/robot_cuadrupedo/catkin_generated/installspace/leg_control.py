#!/usr/bin/env python3
from dynamixel_sdk.port_handler import *
from dynamixel_sdk.packet_handler import *
import rospy
from robot_cuadrupedo.msg import robot_state
from robot_cuadrupedo.msg import motors_states
import os, sys

if os.name == 'nt':
    import msvcrt
    def getch():
        return msvcrt.getch().decode()
else:
    import tty, termios
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    tty.setraw(sys.stdin.fileno())
    def getch():
        return sys.stdin.read(1)

os.sys.path.append('../dynamixel_sdk_py')             # Path setting
                   
OFFSET = 90
PI = 3.14159265359
ADD_TORQUE_ENABLE = 64
ADD_GOAL_POSITION = 116
ADD_PRESENT_POSTION = 132
ADD_MOVING_STATUS = 122

PROTOCOL_VERSION = 2.0

ID_F = 1
ID_P = 2
INIT_POSITION_F = 10
INIT_POSITION_P = 10

BAUDRATE = 1000000
DEVICE_NAME = "/dev/ttyUSB0"#.encode('utf-8')

MAX_GOAL_VALUE = 4095
MIN_ERROR = 5
VELOCITY = 400
ACELERATION = 150
TORQUE_ENABLE = 1
TORQUE_DISABLE = 0

ESC_ASCII_VALUE             = 0x1b

flag = False
shutdown_flag = False
dxl_flag = True

port_num =  PortHandler(DEVICE_NAME)
packet_handler = Protocol2PacketHandler()

def init_dxl():
    packet_handler.write1ByteTxOnly(port_num,ID_F,ADD_TORQUE_ENABLE,TORQUE_ENABLE)
    packet_handler.write1ByteTxOnly(port_num,ID_F,ADD_TORQUE_ENABLE,TORQUE_ENABLE)
def shutdown():
    shutdown_flag = True

    theta_f = INIT_POSITION_F + OFFSET
    theta_p = INIT_POSITION_P + OFFSET

    set_leg_position(theta_f, theta_p)

    packet_handler.write1ByteTxOnly(port_num,ID_F,ADD_TORQUE_ENABLE,TORQUE_DISABLE)
    packet_handler.write1ByteTxOnly(port_num,ID_F,ADD_TORQUE_ENABLE,TORQUE_DISABLE)

def set_leg_position(theta_f,theta_p):

    goal_position_f = MAX_GOAL_VALUE*(theta_f/360.0)
    goal_position_p = MAX_GOAL_VALUE*(theta_p/360.0)

    rospy.loginfo("I recive GoalPosition F : [%0f], GoalPosition P : [%0f]",goal_position_f,goal_position_p)

    if ((goal_position_f + goal_position_p) > (MAX_GOAL_VALUE - 100)):
        rospy.loginfo("JOINT COLISION")
        shutdown()
    else:
        packet_handler.write4ByteTxOnly(port_num,ID_F,ADD_GOAL_POSITION,int(goal_position_f))
        packet_handler.write4ByteTxOnly(port_num,ID_P,ADD_GOAL_POSITION,int(goal_position_p))
        moving_status_f = packet_handler.read1ByteTxRx(port_num,ID_F, ADD_MOVING_STATUS)
        moving_status_p = packet_handler.read1ByteTxRx(port_num,ID_P, ADD_MOVING_STATUS)

        count = 0
        
        while(count < 15 and  (moving_status_f or moving_status_p) ):
            
            packet_handler.write4ByteTxOnly(port_num,ID_F,ADD_GOAL_POSITION,int(goal_position_f))
            packet_handler.write4ByteTxOnly(port_num,ID_P,ADD_GOAL_POSITION,int(goal_position_p))

            moving_status_f = packet_handler.read1ByteTxRx(port_num,ID_F, ADD_MOVING_STATUS)
            moving_status_p = packet_handler.read1ByteTxRx(port_num,ID_P, ADD_MOVING_STATUS)

            present_position_f = packet_handler.read4ByteTxRx(port_num,ID_F,ADD_PRESENT_POSTION)
            present_position_p = packet_handler.read4ByteTxRx(port_num,ID_P,ADD_PRESENT_POSTION)

            rospy.loginfo(ID_F)
            #rospy.loginfo(ID_F,ID_P,goal_position_f,goal_position_p,present_position_f,present_position_p)
            #rospy.loginfo("[ID:%d] GoalPos:%0f  PresPos:%d,[ID:%d] GoalPos:%0f  PresPos:%d\n", ID_F,goal_position_f,present_position_f, ID_P,goal_position_p,present_position_p)

            count = count + 1
            if (count == 15): rospy.loginfo("Couldnt reach position")


        

def callback(datain):
    global flag

    theta_f = datain.leg1.frontal_motor
    theta_p = datain.leg1.posterior_motor
    walk = datain.leg1.walk
    if (walk == True and flag == True):
        flag = False
        init_dxl()
    elif (walk == False):
        flag = True
        #shutdown()
        #rospy.loginfo("SHUTDOWN: POWER OFF")
    
    if(theta_f > 300): theta_f = theta_f-360
  
    if(theta_p > 400): theta_p = theta_p-360

    if(shutdown_flag == False and dxl_flag == True):
        rospy.loginfo("I recive Theta f : [%f]deg, Theta p : [%f]deg, Walk ? : [%d]",theta_f,theta_p,walk)

        theta_f = OFFSET+theta_f
        theta_p = OFFSET+(180-theta_p)

        #set_leg_position(theta_f,theta_p)

        

def main():
    PortHandler.openPort(port_num)
    PortHandler.setBaudRate(port_num,BAUDRATE)

    result = packet_handler.write1ByteTxOnly(port_num,ID_F,ADD_TORQUE_ENABLE, TORQUE_ENABLE)
    #rospy.loginfo("Torque Enabled of dxl [%d] : %s",ID_F,packet_handler.getTxRxResult(result))
    result = packet_handler.write1ByteTxOnly(port_num,ID_P,ADD_TORQUE_ENABLE, TORQUE_ENABLE)
    #rospy.loginfo("Torque Enabled of dxl [%d] : %s",ID_P,packet_handler.getTxRxResult(result))


    rospy.init_node('Leg_control', anonymous=True)
    rospy.Subscriber("Gate_control", motors_states, callback)
    rospy.spin()

if __name__ == '__main__':
    main()