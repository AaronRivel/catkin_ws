#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from quadruped_robot.common_libs import plt, rospy, period
from quadruped_robot.common_tools import set_period_ref, get_period
from matplotlib.widgets import Slider


def main():
    rospy.init_node('velocity_control', anonymous=True)

    pub = rospy.Publisher('current_period', period, queue_size = 10)
    msg = period()
    def update(val):
        msg.T = t_slider.val
        pub.publish(msg)

    fig = plt.figure()

    manager = plt.get_current_fig_manager()
    manager.window.setGeometry(800, 800, 100, 50)

    slider_ax = fig.add_subplot(111)

    t_slider = Slider(
        ax=slider_ax,
        label='T',
        valmin=1,
        valmax=40,
        valinit=20,)
    t_slider.on_changed(update)

    plt.show()

if __name__ == '__main__' :
    main()

