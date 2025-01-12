#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from quadruped_robot.common_libs import rospy, plt, leg_state, axes, multi_leg_control
from quadruped_robot.common_tools import RobotController


class ROSAnimationNode:
    def __init__(self):
        # Inicializar el nodo ROS
        rospy.init_node('animation_node', anonymous=True)

        # Suscribirse al tópico
        rospy.Subscriber('/leg_4/currently_motors_state', leg_state, self.leg_4)
        rospy.Subscriber('/leg_1/currently_motors_state', leg_state, self.leg_1)
        rospy.Subscriber('/leg_3/currently_motors_state', leg_state, self.leg_3)
        rospy.Subscriber('legs_control', multi_leg_control, self.period_callback)

        self.L4 = leg_state()
        self.L1 = leg_state()
        self.L3 = leg_state()

        # Variables de control
        self.running = True

        # Configurar la figura de matplotlib
        self.fig = plt.figure()
        # Conectar el evento de cierre de la ventana
        self.fig.canvas.mpl_connect('close_event', self.on_close)

        self.ax1 = self.fig.add_subplot(221,projection = '3d')
        #self.ax2 = self.fig.add_subplot(222,projection = '3d')
        self.ax3 = self.fig.add_subplot(223,projection = '3d')
        self.ax4 = self.fig.add_subplot(224,projection = '3d')

        self.ax1.view_init(elev=90, azim=-90, roll = 0)  # Ajustar elevación y azimut
        self.ax3.view_init(elev=90, azim=-90, roll = 0)  # Ajustar elevación y azimut
        self.ax4.view_init(elev=90, azim=-90, roll = 0)  # Ajustar elevación y azimut

        self.fig.subplots_adjust(left=0.0, right=1, top=1, bottom=0.0, wspace=0.0, hspace=0.0)


        self.esc = 2.0  # Factor de escala

        # Modo interactivo para la animación
        plt.ion()
        self.R1 = RobotController()
        self.R3 = RobotController()
        self.R4 = RobotController()
        


    def period_callback(self, datain):
        self.R1.tf = datain.tf
        self.R3.tf = datain.tf
        self.R4.tf = datain.tf
        self.R1.gate(2,5,datain.way, datain.L1.gate)
        self.R3.gate(2,5,datain.way, datain.L3.gate)
        self.R4.gate(2,5,datain.way, datain.L4.gate)

        

    def leg_4(self, datain):
        # Obtener los datos del mensaje
        if self.running:

            self.L4 = datain

    def leg_3(self, datain):
        # Obtener los datos del mensaje
        if self.running:

            self.L3 = datain

    def leg_1(self, datain):
        # Obtener los datos del mensaje
        if self.running:

            self.L1 = datain

    def on_close(self, event):
        """ Manejar el evento de cierre de la ventana """
        self.running = False
        rospy.signal_shutdown('Window closed')
        
    def run(self):
        while not rospy.is_shutdown() and self.running:
            # Actualizar la animación en el hilo principal
            self.R4.animation(self.L4.t, [self.L4.q0, self.L4.q1], self.ax4, self.esc)
            self.R1.animation(self.L1.t, [self.L1.q0, self.L1.q1], self.ax1, self.esc)
            #animation(self.L2.t, [self.L2.q0, self.L2.q1], self.ax2, self.esc)
            self.R3.animation(self.L3.t, [self.L3.q0, self.L3.q1], self.ax3, self.esc)
            
            # Actualizar la figura de matplotlib
            plt.draw()
            plt.pause(0.01)


def main():
    node = ROSAnimationNode()
    node.run()

if __name__ == '__main__':
    main()