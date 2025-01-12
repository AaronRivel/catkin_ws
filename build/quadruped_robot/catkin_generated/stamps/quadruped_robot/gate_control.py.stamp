#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from quadruped_robot.common_libs import plt, rospy, multi_leg_control, leg_state
from matplotlib.widgets import Slider, CheckButtons

tf = 0
way = 1
walk_flag = False

index = 0
feedback = [False,False,False,False]
enable_control = False
position = [['middle'   ,'wait'  ,'wait'  ,'kin_limit'  ,'wait'     ,'elipse'],
            ['kin_limit','wait'  ,'elipse','middle'     ,'wait'     ,'wait'],
            ['middle'   ,'wait'  ,'wait'  ,'kin_limit'  ,'elipse'   ,'wait'],
            ['kin_limit','elispe','wait'  ,'middle'     ,'wait'     ,'wait']]

def callback(datain):

    feedback[0] = datain.L1.finish
    feedback[2] = datain.L2.finish
    feedback[3] = datain.L3.finish

    if(feedback[0] and feedback[2] and feedback[3]):
        feedback = [False,False,False,False]
        
        if tf < 0:
            index -= 1
        else:
            index += 1

        if index >= len(position[0]) or index <= -len(position[0]):
            index = 0

        msg.walk_flag = walk_flag
        msg.way = way
        msg.tf = tf
        msg.L1.gate = position[0][index]
        msg.L3.gate = position[2][index]
        msg.L4.gate = position[3][index]
        
        pub.publish(msg)




rospy.init_node('gate_control', anonymous=True)

pub = rospy.Publisher('legs_control', multi_leg_control, queue_size = 10)
msg = multi_leg_control()



rospy.Subscriber('/leg_4/currently_leg_state', leg_state, callback)
rospy.Subscriber('/leg_1/currently_leg_state', leg_state, callback)
rospy.Subscriber('/leg_3/currently_leg_state', leg_state, callback)



def main():

    def button_update(label):

        switch = buttons.get_status()
        
        if switch: 
            enable_control = True
        else:
            enable_control = False

    def slider_update(val):
        

        if t_slider.val == 0:
            walk_flag = False
        else:
            walk_flag = True
            tf = 30/t_slider.val
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
    buttons_ax = plt.axes([0.75,0.05,0.20,0.80])

    buttons = CheckButtons(buttons_ax, "ACTIVE", False)     

    buttons.on_clicked(button_update)
    
    t_slider = Slider(
        ax=slider_ax,
        label='tf',
        valmin=-30,
        valmax=30,
        valinit= 0,)
    t_slider.on_changed(slider_update)

    plt.show()

if __name__ == '__main__' :
    main()

