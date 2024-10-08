#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from quadruped_robot.common_libs import rospy, plt, time_state, axes, period
from quadruped_robot.common_tools import animation


class ROSAnimationNode:
    def __init__(self):
        # Inicializar el nodo ROS
        rospy.init_node('ros_animation_node', anonymous=True)

        # Suscribirse al tópico
        rospy.Subscriber('currently_motors_state', time_state, self.callback)
        
        rospy.suscriber('current_period', period, self.period_callback)

        self.t = 0
        self.q0 = 0
        self.q1 = 0

        # Configurar la figura de matplotlib
        self.fig = plt.figure()
        # Conectar el evento de cierre de la ventana
        self.fig.canvas.mpl_connect('close_event', self.on_close)

        # Variables de control
        self.running = True

        self.ax = self.fig.add_subplot(111,projection = '3d')
        #self.slider_ax = self.fig.add_axes([0.03,0.1,.5,0.05])
        self.esc = 2.0  # Factor de escala

        # Modo interactivo para la animación
        plt.ion()

    def period_callback(self, datain):
        set_period_ref(datain.T)
        
    def callback(self, datain):
        # Obtener los datos del mensaje
        if self.running:

            self.t = datain.t   # Tiempo
            self.q0 = datain.q0  # Primeros 2 valores para q0 (ajusta esto según tu necesidad)
            self.q1 = datain.q1

    def on_close(self, event):
        """ Manejar el evento de cierre de la ventana """
        self.running = False
        rospy.signal_shutdown('Window closed')
        
    def run(self):
        '''
        def update(val):
            set_period_ref(t_slider.val)

        t_slider = Slider(
            ax=self.slider_ax,
            label='T',
            valmin=1,
            valmax=40,
            valinit=20,)
        t_slider.on_changed(update)
        '''

        while not rospy.is_shutdown() and self.running:
            # Actualizar la animación en el hilo principal
            animation(self.t, [self.q0, self.q1], self.ax, self.esc)
            
            # Actualizar la figura de matplotlib
            plt.draw()
            plt.pause(0.1)


def main():
    node = ROSAnimationNode()
    node.run()

if __name__ == '__main__':
    main()