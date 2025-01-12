#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from quadruped_robot.common_libs import plt, rospy, multi_leg_control, leg_state
from matplotlib.widgets import Slider, CheckButtons

tf = 0
way = 1
walk_flag = False

index = 0
feedback = [False,True,False,False]
enable_control = False
position = [['middle'   ,'wait'  ,'wait'  ,'kin_limit'  ,'wait'     ,'elipse'],
            ['kin_limit','wait'  ,'elipse','middle'     ,'wait'     ,'wait'],
            ['middle'   ,'wait'  ,'wait'  ,'kin_limit'  ,'elipse'   ,'wait'],
            ['kin_limit','elipse','wait'  ,'middle'     ,'wait'     ,'wait']]

rospy.init_node('gate_control', anonymous=True)

pub = rospy.Publisher('legs_control', multi_leg_control, queue_size = 10)
msg = multi_leg_control()

def change_position():
    global feedback,index
    feedback[0] = False
    feedback[1] = True
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
    msg.tf = tf
    msg.L1.gate = position[0][index]
    msg.L3.gate = position[2][index]
    msg.L4.gate = position[3][index]

    
    pub.publish(msg)

def leg_4(datain):
    global feedback
    feedback[3] = datain.finish

    if(feedback[0] and feedback[1] and feedback[2] and feedback[3]): change_position()

def leg_1(datain):
    global feedback
    feedback[0] = datain.finish

    if(feedback[0] and feedback[1] and feedback[2] and feedback[3]): change_position()


def leg_3(datain):
    global feedback

    feedback[2] = datain.finish
    if(feedback[0] and feedback[1] and feedback[2] and feedback[3]):change_position()

rospy.Subscriber('/leg_4/currently_motors_state', leg_state, leg_4)
rospy.Subscriber('/leg_1/currently_motors_state', leg_state, leg_1)
rospy.Subscriber('/leg_3/currently_motors_state', leg_state, leg_3)



def main():
    '''
    def button_update(label):

        switch = buttons.get_status()
        
        if switch: 
            enable_control = True
        else:
            enable_control = False
    '''
    def slider_update(val):
        global walk_flag, way, tf

        if t_slider.val == 0:
            walk_flag = False
        else:
            walk_flag = True
            tf = 10/t_slider.val
            if val < 0:
                way = -1
                tf = tf*(-1)
            else:
                way = 1
                tf = tf

        msg.walk_flag = walk_flag
        msg.way = way
        msg.tf = tf
        msg.L1.gate = position[0][index]
        msg.L3.gate = position[2][index]
        msg.L4.gate = position[3][index]
        
        pub.publish(msg)

    manager = plt.get_current_fig_manager()
    manager.window.setGeometry(800, 800, 500, 300)

    slider_ax = plt.axes([0.05,0.15,0.60,0.10])
    #buttons_ax = plt.axes([0.75,0.05,0.20,0.80])

    #buttons = CheckButtons(buttons_ax, "ACTIVE", False)     

    #buttons.on_clicked(button_update)
    
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

