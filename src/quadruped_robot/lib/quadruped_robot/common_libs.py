#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import rospy 
import rosnode
import os

from quadruped_robot.srv import write_dxl, write_dxlResponse, read_dxl, read_dxlResponse

from quadruped_robot.dynamixelxm430_w210_t import constants
from quadruped_robot.robotis_def import definitions

from quadruped_robot.msg import leg_state
from quadruped_robot.msg import multi_leg_control

from dynamixel_sdk.port_handler import PortHandler
from dynamixel_sdk.packet_handler import PacketHandler

import numpy as np
import time as tm
import matplotlib.pyplot as plt
import threading as th
from mpl_toolkits.mplot3d import Axes3D as axes
