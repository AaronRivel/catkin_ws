#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from quadruped_robot.common_libs import plt, rospy, multi_leg_control, leg_state
from matplotlib.widgets import Slider

cm_s = 0
way = 1
walk_flag = False

index = 0
feedback = [False,False,False,False]

position = [['middle'   ,'wait'  ,'wait'  ,'kin_limit'  ,'wait'     ,'elipse'],
            ['kin_limit','wait'  ,'elipse','middle'     ,'wait'     ,'wait'],
            ['middle'   ,'wait'  ,'wait'  ,'kin_limit'  ,'elipse'   ,'wait'],
            ['kin_limit','elipse','wait'  ,'middle'     ,'wait'     ,'wait']]

'''
position = [['wait'   ,'wait'  ,'wait'  ,'wait'  ,'wait'     ,'wait'],
            ['wait','wait'  ,'wait','wait'     ,'wait'     ,'wait'],
            ['wait'   ,'wait'  ,'wait'  ,'wait'  ,'wait'   ,'wait'],
            ['kin_limit','elipse','wait'  ,'middle'     ,'wait'     ,'wait']]
'''
'''
position = [['kin_limit'   ,'wait'  ,'wait'  ,'wait'  ,'wait'     ,'wait'],
            ['kin_limit','wait'  ,'wait','wait'     ,'wait'     ,'wait'],
            ['kin_limit'   ,'wait'  ,'wait'  ,'wait'  ,'wait'   ,'wait'],
            ['kin_limit','wait','wait'  ,'wait'     ,'wait'     ,'wait']]
'''

rospy.init_node('gate_control', anonymous=True)

pub = rospy.Publisher('legs_control', multi_leg_control, queue_size = 10)
msg = multi_leg_control()

def change_position():
    global feedback,index
    feedback[0] = False
    feedback[1] = False
    feedback[2] = False
    feedback[3] = False

    
    if way < 0:
        index -= 1
    else:
        index += 1

    if index >= len(position[0]) or index <= -len(position[0]):
        index = 0

    msg.walk_flag = True
    msg.way = way
    msg.cm_s = cm_s
    msg.L1.path = position[0][index]
    msg.L2.path = position[1][index]
    msg.L3.path = position[2][index]
    msg.L4.path = position[3][index]

    
    pub.publish(msg)

def leg_4(datain):
    global feedback
    feedback[3] = datain.finish

    if(feedback[0] and feedback[1] and feedback[2] and feedback[3]): change_position()

def leg_2(datain):
    global feedback
    feedback[1] = datain.finish

    if(feedback[0] and feedback[1] and feedback[2] and feedback[3]): change_position()

def leg_1(datain):
    global feedback
    feedback[0] = datain.finish

    if(feedback[0] and feedback[1] and feedback[2] and feedback[3]): change_position()


def leg_3(datain):
    global feedback

    feedback[2] = datain.finish
    if(feedback[0] and feedback[1] and feedback[2] and feedback[3]):change_position()


rospy.Subscriber('/leg_1/currently_motors_state', leg_state, leg_1)
rospy.Subscriber('/leg_2/currently_motors_state', leg_state, leg_2)
rospy.Subscriber('/leg_3/currently_motors_state', leg_state, leg_3)
rospy.Subscriber('/leg_4/currently_motors_state', leg_state, leg_4)



def main():
    def slider_update(val):
        global walk_flag, way, cm_s

        if int(t_slider.val) == 0:
            walk_flag = False
        else:
            walk_flag = True
            cm_s = t_slider.val
            if val < 0:
                way = -1
                cm_s = cm_s*(-1)
            else:
                way = 1
                cm_s = cm_s

        msg.walk_flag = walk_flag
        msg.way = way
        msg.cm_s = cm_s
        msg.L1.path = position[0][index]
        msg.L2.path = position[1][index]
        msg.L3.path = position[2][index]
        msg.L4.path = position[3][index]
        
        pub.publish(msg)

    manager = plt.get_current_fig_manager()
    manager.window.setGeometry(800, 800, 500, 300)

    slider_ax = plt.axes([0.05,0.15,0.60,0.10])
    
    t_slider = Slider(
        ax=slider_ax,
        label='tf',
        valmin=-10,
        valmax=10,
        valinit= 0,)
    t_slider.on_changed(slider_update)

    plt.show()

if __name__ == '__main__' :
    main()

