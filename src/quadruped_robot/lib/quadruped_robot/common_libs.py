#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import rospy 

from quadruped_robot.dynamixelxm430_w210_t import constants
from quadruped_robot.robotis_def import definitions

from quadruped_robot.msg import time_state
from quadruped_robot.msg import motor_state
from quadruped_robot.msg import period

from dynamixel_sdk.port_handler import PortHandler
from dynamixel_sdk.packet_handler import PacketHandler

import numpy as np
import time as tm
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D as axes

