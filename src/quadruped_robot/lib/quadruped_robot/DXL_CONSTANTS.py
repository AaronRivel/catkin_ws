#!/usr/bin/env python3
# -*- coding: utf-8 -*-
class constantsXM:
    OFFSET = 90
    PI = 3.14159265359

    ADD_TORQUE_ENABLE = 64
    ADD_GOAL_POSITION = 116
    ADD_PRESENT_POSTION = 132
    ADD_MOVING_STATUS = 122
    ADD_PROTOCOL_TYPE = 13
    ADD_BAUDRATE = 8
    ADD_OPERATING_MODE = 11
    ADD_GOAL_VEL = 104
    ADD_DRIVE_MODE = 10

    PROTOCOL_VERSION = 2
    BAUDRATE = 1000000
    DEVICE_NAME = "/dev/ttyUSB0"

    MAX_POSITION = 4095
    MAX_ANGLE = 360
    MAX_VEL = 1023
    TORQUE_ENABLE = 1
    TORQUE_DISABLE = 0
    PROTECCION_LIMIT_F = -20
    PROTECCION_LIMIT_P = 200
    JOINT_LIMIT = 20
    CW = 0
    CCW = 1

    ESC_ASCII_VALUE = 27 #0x1b

class constantsAX:
    OFFSET = 90
    PI = 3.14159265359

    ADD_TORQUE_ENABLE = 24
    ADD_GOAL_POSITION = 30
    ADD_PRESENT_POSTION = 36
    ADD_MOVING_STATUS = 46
    ADD_GOAL_VEL = 32
    ADD_BAUDRATE = 4
    ADD_CW_LIM = 6
    ADD_CCW_LIM = 8
    ADD_PUNCH = 48

    PROTOCOL_VERSION = 1
    BAUDRATE = 1000000
    DEVICE_NAME = "/dev/ttyUSB0"

    MAX_POSITION = 1023
    MAX_ANGLE = 300
    TORQUE_ENABLE = 1
    TORQUE_DISABLE = 0
    PROTECCION_LIMIT_F = -10
    PROTECCION_LIMIT_P = 190
    JOINT_LIMIT = 30

    ESC_ASCII_VALUE = 27 #0x1b
