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
INIT_PSOITION_F = 10
INIT_PSOITION_OP = 10

BAUDRATE = 1000000
DEVICE_NAME = "/dev/ttyUSB0".encode('utf-8')

MAX_GOAL_VALUE = 4095
MIN_ERROR = 5
VELOCITY = 400
ACELERATION = 150
TORQUE_ENABLE = 1
TORQUE_DISABLE = 0

ESC_ASCII_VALUE             = 0x1b

flag = False;
shutdown_flag = False;
dxl_flag = True;

port_num =  PortHandler(DEVICE_NAME)

def init_dxl():
    Protocol2PacketHandler.write1ByteTxOnly(port_num,ID_F,ADD_TORQUE_ENABLE,TORQUE_ENABLE)
    Protocol2PacketHandler.write1ByteTxOnly(port_num,ID_F,ADD_TORQUE_ENABLE,TORQUE_ENABLE)
def shotdawn():
    Protocol2PacketHandler.write1ByteTxOnly(port_num,ID_F,ADD_TORQUE_ENABLE,TORQUE_DISABLE)
    Protocol2PacketHandler.write1ByteTxOnly(port_num,ID_F,ADD_TORQUE_ENABLE,TORQUE_DISABLE)

def callback(datain):
    global flag

    theta_f = datain.leg1.theta_f
    theta_p = datain.leg1.theta_p
    walk = datain.leg1.walk
    if (walk == True and flag == True):
        flag = False
        init_dxl()
    elif (walk == False):
        flag = True
        shotdawn()
        print('!SHO¡')

def main():
    Protocol2PacketHandler()
    PortHandler.openPort(port_num)
    PortHandler.setBaudRate(port_num,BAUDRATE)

    Protocol2PacketHandler.write1ByteTxOnly(port_num,ID_F,ADD_TORQUE_ENABLE)
    Protocol2PacketHandler.write1ByteTxOnly(port_num,ID_P,ADD_TORQUE_ENABLE)

    rospy.init_node('Leg_control', anonymous=True)
    rospy.Subscriber("Gate_control", motors_states, callback)
    rospy.spin()

if __name__ == '__main__':
    main()