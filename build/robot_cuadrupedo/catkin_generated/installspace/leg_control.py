#!/usr/bin/env python3
#funcion write4BytesTxOnly() causes a fail whit read4BytesTxRx()
import rospy
from dynamixel_sdk.port_handler import *
from dynamixel_sdk.packet_handler import *
from robot_cuadrupedo.msg import robot_state
from robot_cuadrupedo.msg import motors_states
from robot_cuadrupedo.kbhit import KBHit 

OFFSET = 90
PI = 3.14159265359
ADD_TORQUE_ENABLE = 64
ADD_GOAL_POSITION = 116
ADD_PRESENT_POSTION = 132
ADD_MOVING_STATUS = 122
ADD_PROTOCOL_TYPE = 13
ADD_VELOCITY = 112
ADD_ACCELERATION = 108
ADD_BAUDRATE = 8

PROTOCOL_VERSION = 2

ID_F = 1
ID_P = 2
INIT_POSITION_F = 10
INIT_POSITION_P = 10

BAUDRATE = 1000000
DEVICE_NAME = "/dev/ttyUSB0"

MAX_GOAL_VALUE = 4095
MIN_ERROR = 10
VELOCITY = 400
ACCELERATION = 150
TORQUE_ENABLE = 1
TORQUE_DISABLE = 0
TIME_OUT = 30

ESC_ASCII_VALUE             = 27 #0x1b

flag = False
shutdown_flag = False
dxl_flag = True

kb = KBHit()

port_num =  PortHandler(DEVICE_NAME)
packet_handler = PacketHandler(PROTOCOL_VERSION)
    
def init_dxl():
    dxl_id = [ID_F,ID_P]

    for i in range(len(dxl_id)):
        global dxl_flag

        result, error = packet_handler.write1ByteTxRx(port_num,dxl_id[i],ADD_TORQUE_ENABLE, TORQUE_DISABLE)
        data, _ ,_ = packet_handler.read1ByteTxRx(port_num,dxl_id[i],ADD_TORQUE_ENABLE)
        if (result == COMM_SUCCESS):
            rospy.loginfo("Torque of dxl [ID %d] : |%d|",dxl_id[i],data)
        else:
            rospy.loginfo("FAIL Torque disable of dxl [ID %d] : %s  %s",dxl_id[i],packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            dxl_flag = False

        result, error = packet_handler.write1ByteTxRx(port_num,dxl_id[i],ADD_PROTOCOL_TYPE,PROTOCOL_VERSION)
        data, _, _ = packet_handler.read1ByteTxRx(port_num,dxl_id[i],ADD_PROTOCOL_TYPE)
        if (result == COMM_SUCCESS):
            rospy.loginfo("Protocol version |%0.1f| to dxl [ID %d]",data,dxl_id[i])
        else:
            rospy.loginfo("FAIL Writing protocol version |%0.1f| to dxl [ID %d] : %s  %s",PROTOCOL_VERSION,dxl_id[i],packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            dxl_flag = False
        
        result, error = packet_handler.write1ByteTxRx(port_num,dxl_id[i],ADD_TORQUE_ENABLE, TORQUE_ENABLE)
        data, _ ,_ = packet_handler.read1ByteTxRx(port_num,dxl_id[i],ADD_TORQUE_ENABLE)
        if (result == COMM_SUCCESS):
            rospy.loginfo("Torque of dxl [ID %d] : |%d|",dxl_id[i],data)
        else:
            rospy.loginfo("FAIL Torque Enable of dxl [ID %d] : %s  %s",dxl_id[i],packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            dxl_flag = False

        result, error = packet_handler.write1ByteTxRx(port_num,dxl_id[i],ADD_BAUDRATE,3) # 3 -> 1,000,000 bauds
        data,_,_ = packet_handler.read1ByteTxRx(port_num,dxl_id[i],ADD_BAUDRATE)
        if (result == COMM_SUCCESS):
            rospy.loginfo("[ID %d] buad rate: |%d|",dxl_id[i],data)
        else:
            rospy.loginfo("FAIL [ID %d] baud rate: |%d| %s  %s",dxl_id[i],BAUDRATE,packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            dxl_flag = False

        model,result,error = packet_handler.ping(port_num,dxl_id[i])
        if (result == COMM_SUCCESS):
            rospy.loginfo("Ping dxl [ID %d] Model: %s ",dxl_id[i],model)
        else:
            rospy.loginfo("FAIL Ping dxl [ID %d] Model: %s  %s  %s",dxl_id[i],model,packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            dxl_flag = False

        result, error = packet_handler.write4ByteTxRx(port_num,dxl_id[i],ADD_VELOCITY,VELOCITY)
        data, _, _ = packet_handler.read4ByteTxRx(port_num,dxl_id[i],ADD_VELOCITY)
        if (result == COMM_SUCCESS):
            rospy.loginfo("Velocity of dxl [ID %d] to |%d| ",dxl_id[i],data)
        else:
            rospy.loginfo("FAIL Writing velocity of dxl [ID %d] to |%d| : %s  %s",dxl_id[i],VELOCITY,packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            dxl_flag = False

        result, error = packet_handler.write4ByteTxRx(port_num,dxl_id[i],ADD_ACCELERATION,ACCELERATION)
        data, _, _ = packet_handler.read4ByteTxRx(port_num,dxl_id[i],ADD_ACCELERATION)
        if (result == COMM_SUCCESS):
            rospy.loginfo("Acceleration of dxl [ID %d] to |%d| ",dxl_id[i],data)
        else:
            rospy.loginfo("FAIL Writing acceleration of dxl [ID %d] to |%d| : %s  %s",dxl_id[i],ACCELERATION,packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            dxl_flag = False

def shutdown():
    global shutdown_flag
    shutdown_flag = True

    theta_f = INIT_POSITION_F + OFFSET
    theta_p = INIT_POSITION_P + OFFSET

    set_leg_position(theta_f, theta_p)

    result, error = packet_handler.write1ByteTxRx(port_num,ID_F,ADD_TORQUE_ENABLE,TORQUE_DISABLE)
    if (packet_handler.getTxRxResult(result) == COMM_SUCCESS):
        rospy.loginfo("Torque Disable of dxl [%d] : %s",ID_F,packet_handler.getTxRxResult(result))
    else:
        rospy.loginfo("Torque Disable of dxl [%d] : %s  %s",ID_F,packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))

    result, error = packet_handler.write1ByteTxRx(port_num,ID_P,ADD_TORQUE_ENABLE,TORQUE_DISABLE)
    if (packet_handler.getTxRxResult(result) == COMM_SUCCESS):
        rospy.loginfo("Torque Disable of dxl [%d] : %s",ID_P,packet_handler.getTxRxResult(result))
    else:
        rospy.loginfo("Torque Disable of dxl [%d] : %s  %s",ID_P,packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
        dxl_flag = False

    rospy.loginfo("SHUTDOWN: POWER OFF")

def set_leg_position(theta_f,theta_p):

    goal_position_f = MAX_GOAL_VALUE*(theta_f/360.0)
    goal_position_p = MAX_GOAL_VALUE*(theta_p/360.0)

    rospy.loginfo("I recive GoalPosition F : [%0f], GoalPosition P : [%0f]",goal_position_f,goal_position_p)

    if ((goal_position_f + goal_position_p) > (MAX_GOAL_VALUE - 100)):
        shutdown()
        rospy.loginfo("JOINT COLISION")
    else:
        
        packet_handler.write4ByteTxRx(port_num,ID_F,ADD_GOAL_POSITION,int(goal_position_f))
        packet_handler.write4ByteTxRx(port_num,ID_P,ADD_GOAL_POSITION,int(goal_position_p))
    
        count = 0
        
        while(1):
            present_position_f, _, _ = packet_handler.read4ByteTxRx(port_num,ID_F, ADD_PRESENT_POSTION)
            present_position_p, _, _ = packet_handler.read4ByteTxRx(port_num,ID_P, ADD_PRESENT_POSTION)

            rospy.loginfo("[ID:%d] GoalPos:%0f PresPos:%d [ID:%d] GoalPos:%0f  PresPos:%d ", ID_F,goal_position_f,present_position_f, ID_P,goal_position_p,present_position_p)

            count = count + 1
            
            c_ord = ''
            if (kb.kbhit()):
                c = kb.getch()
                c_ord = ord(c)
            if (c_ord == ESC_ASCII_VALUE):
                shutdown()
                rospy.loginfo("EXIT PROGRAM!!")
                break

            if (count == TIME_OUT or (abs(present_position_f-goal_position_f) <= MIN_ERROR and abs(present_position_p-goal_position_p) <= MIN_ERROR)): 
                if (count == TIME_OUT): rospy.loginfo("Couldnt reach position")
                break

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
        shutdown()
        rospy.loginfo("STOP WALKING!!")
        
    
    if(theta_f > 300): theta_f = theta_f-360
  
    if(theta_p > 400): theta_p = theta_p-360

    if(shutdown_flag == False and dxl_flag == True):
        rospy.loginfo("I recive Theta f : [%f]deg, Theta p : [%f]deg, Walk ? : [%d]",theta_f,theta_p,walk)

        theta_f = OFFSET+theta_f
        theta_p = OFFSET+(180-theta_p)

        set_leg_position(theta_f,theta_p)

def  main():
    PortHandler.openPort(port_num)
    PortHandler.setBaudRate(port_num,BAUDRATE)

    rospy.init_node('Leg_control', anonymous=True)
    rospy.Subscriber("Gate_control", motors_states, callback)

    init_dxl()

    rospy.spin()


if __name__ == '__main__':
    main()