#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from quadruped_robot.common_libs import plt, rospy, multi_leg_control, leg_state
from quadruped_robot.common_tools import set_period_ref, get_period
from matplotlib.widgets import Slider, CheckButtons

LEGS_SECUENCE = ['LEG_1', 'LEG_3', 'LEG_4']
index = 0

def leg_4(datain):
    
    if(datain.leg_pos == 'POSTERIOR_INIT'):
        msg.L4.walk_flag = True
    T, _= get_period()
    msg.T = T

    pub.publish(msg)

def leg_3(datain):
    if(datain.leg_pos == 'POSTERIOR_INIT'):
        msg.L3.walk_flag = True
    T, _= get_period()
    msg.T = T

    pub.publish(msg)
    
def leg_1(datain):
    if(datain.leg_pos == 'POSTERIOR_INIT'):
        msg.L1.walk_flag = True
    T, _= get_period()
    msg.T = T

    pub.publish(msg)

rospy.init_node('gate_control', anonymous=True)

pub = rospy.Publisher('legs_control', multi_leg_control, queue_size = 10)
msg = multi_leg_control()

rospy.Subscriber('/leg_4/currently_motors_state', leg_state, leg_4)
rospy.Subscriber('/leg_1/currently_motors_state', leg_state, leg_1)
rospy.Subscriber('/leg_3/currently_motors_state', leg_state, leg_3)

def main():

    def button_update(label):
        butons_state = buttons.get_status()

        msg.L1.walk_flag = butons_state[0]
        msg.L3.walk_flag = butons_state[1]
        msg.L4.walk_flag = butons_state[2]

        T, _= get_period()
        msg.T = T

        pub.publish(msg)

    def slider_update(val):
        set_period_ref(t_slider.val)
        msg.T = t_slider.val
        pub.publish(msg)

    manager = plt.get_current_fig_manager()
    manager.window.setGeometry(800, 800, 500, 300)

    slider_ax = plt.axes([0.05,0.15,0.60,0.10])
    buttons_ax = plt.axes([0.75,0.05,0.20,0.80])

    T, _ = get_period()

    buttons = CheckButtons(buttons_ax, ["LEG_1", "LEG_3", "LEG_4"], [False, False, False])

    for i, label in enumerate(buttons.labels):
        label.set_fontsize(12)                    
        label.set_color("darkblue")               

    for i, line in enumerate(buttons.lines):
        line[0].set_color("blue")                
        line[1].set_color("green")              
        line[0].set_linewidth(2)                 
        line[1].set_linewidth(2)                 

    buttons.on_clicked(button_update)
    
    t_slider = Slider(
        ax=slider_ax,
        label='T',
        valmin=2,
        valmax=40,
        valinit= T,)
    t_slider.on_changed(slider_update)

    plt.show()

if __name__ == '__main__' :
    main()

