#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from quadruped_robot.common_libs import *

class RobotController:
    def __init__(self,name = None,time = None):
        self.LEG_NAME = None
        self.tm = time

        if name:
            rospy.init_node(name, anonymous=True)

            namespace = rospy.get_namespace()

            self.LEG_F = rospy.get_param(namespace + 'LEG_F')
            self.LEG_P = rospy.get_param(namespace + 'LEG_P')
            self.LEG_NAME = rospy.get_param(namespace + 'LEG_NAME')

            if self.LEG_F == '' or self.LEG_P == '' or self.LEG_NAME == '':
                rospy.loginfo("the launch file must have an id for frontal and posterior motor, and a leg indetifier")

            self.Kp = rospy.get_param(namespace + 'Kp')
            self.Kd = rospy.get_param(namespace + 'Kd')
            self.Ki = rospy.get_param(namespace + 'Ki')

            if self.Kp < 0:
                rospy.loginfo("Kp gain must be grater than 0 [%s], kp = %d",self.LEG_NAME, self.Kp)

        self.walk_flag = False

        self.q_dot = np.zeros(5)

        self.tf = 3600
        self.t = 0 
        self.toggle_flag = False

        self.way = 1
        self.gate([5,2],1,'elipse',self.tf)
        self.e_int = np.array([0,0,0])
        self.e = np.array([0,0,0])

        self.lf,self.lp, self.ld1, self.ld2 = 7,7,7,7
        self.lt = 14

        self.kinematics_limits = 15.5

    def get_current_time(self):
        return self.t, self.tf 
    
    def margin_error(self, margin = 0.3):
        return all(abs(e) < margin for e in self.e) and self.t >= self.tf
    
    def check_direction(self,direction):
        if not (direction == -1 or direction == 1):
            rospy.loginfo("way must be 1 or -1 [%s], way = %d, setting default way = 1",self.LEG_NAME, direction)
            direction = 1

        flag = True if self.way != direction else False
        self.way = direction
        return flag
        
    def find_spl_index(self,xx):
        _SPL_index = 0

        while True:
            if _SPL_index + 1 >= self.POINTS:
                _SPL_index = 0
            
            if self.l[_SPL_index] <= xx <= self.l[_SPL_index + 1]:
                return _SPL_index
            
            if xx > self.l[len(self.l) - 1]:
                return len(self.l) - 2 
            
            _SPL_index += 1

    def set_total_time(self, _tf):
        if _tf == 0:
            rospy.loginfo("tf can not be equal to zero [%s], tf = %d",self.LEG_NAME, _tf)
            self.walk_flag = False

        else:

            if not self.toggle_flag:
                _mapp = self.t / self.tf if self.tf != 0 else 0
            else:
                _mapp = 1 - (self.t / self.tf) if self.tf != 0 else 0

            self.tf = _tf

            if self.tm != None:
                self.tm.config(_mapp * _tf)      

    def DHParameters(self, q):
        theta_p = q[2] + q[3] - np.pi
        return [[theta_p, 0, -self.lp, 0],
                [0, 0, 0, 0],
                [q[2], 0, -self.lf, 0],
                [q[3], 0, self.ld1, 0],
                [0, 0, self.lt/2, 0]]

    def MatrixT(self, q):
        q0 = q[2]
        q1 = q[3]

        C0 = np.cos(q0)
        S0 = np.sin(q0)
        C1 = np.cos(q1)
        S1 = np.sin(q1)
        C01_PI = np.cos(q0 + q1 - np.pi)
        S01_PI = np.sin(q0 + q1 - np.pi)

        T = []
        for i in range(len(q)):
            T.append(np.identity(4))

        T[0] = np.array([[C01_PI, -S01_PI, 0, -7 * C01_PI],
                        [S01_PI, C01_PI, 0, -7 * S01_PI],
                        [0, 0, 1, 0],
                        [0, 0, 0, 1]])

        T[1] = np.identity(4)

        T[2] = np.array([[C0, -S0, 0, -7 * C0],
                        [S0, C0, 0, -7 * S0],
                        [0, 0, 1, 0],
                        [0, 0, 0, 1]])

        T[3] = np.array([[-S0 * S1 + C0 * C1, -S0 * C1 - S1 * C0, 0, -7 * S0 * S1 + 7 * C0 * C1 - 7 * C0],
                        [S0 * C1 + S1 * C0, -S0 * S1 + C0 * C1, 0, 7 * S0 * C1 - 7 * S0 + 7 * S1 * C0],
                        [0, 0, 1, 0],
                        [0, 0, 0, 1]])

        T[4] = np.array([[-S0 * S1 + C0 * C1, -S0 * C1 - S1 * C0, 0, -14 * S0 * S1 + 14 * C0 * C1 - 7 * C0],
                        [S0 * C1 + S1 * C0, -S0 * S1 + C0 * C1, 0, 14 * S0 * C1 - 7 * S0 + 14 * S1 * C0],
                        [0, 0, 1, 0],
                        [0, 0, 0, 1]])
        
        return T, T

    def jacobian(self,q):
        q0 = q[2]
        q1 = q[3]

        C0 = np.cos(q0)
        S0 = np.sin(q0)
        C1 = np.cos(q1)
        S1 = np.sin(q1)

        Pe = np.array([-14 * S0 * S1 + 14 * C0 * C1 - 7 * C0,
                    14 * S0 * C1 - 7 * S0 + 14 * S1 * C0,
                    0])
        
        zk = np.array([[0, 0, 1],
                    [0, 0, 1]])

        Pk = np.array([[0, 0, 0],
                    [-7 * C0, -7 * S0, 0]])
        
        J = np.zeros((6,len(q)))

        for k in range(1,3):
            J[:,k+1] = np.concatenate((np.cross(zk[k-1] , (Pe-Pk[k-1])), zk[k-1]))
        return J , Pe
    
    def _jacobian(self,q):

        q0 = q[2] #theta f
        q1 = q[3]

        C0 = np.cos(q0)
        S0 = np.sin(q0)
        C1 = np.cos(q1)
        S1 = np.sin(q1)

        theta_p = q0 + q1 - np.pi

        Cf = np.cos(q0)
        Sf = np.sin(q0)
        Cd1 = np.cos(q0)
        Sd1 = np.sin(q0)
        Cp = np.cos(theta_p)
        Sp = np.sin(theta_p)
        Cd2 = np.cos(np.pi - (q0))
        Sd2 = np.sin(np.pi - (q0))

        f = self.lf
        p = self.lp
        d = self.ld1

        J11 = f*Sd1*((f*Cd2*Sf / (d*Cd1*Sd2 - d*Cd2*Sd1)) - (f*Cf*Sd2/(d*Cd1*Sd2 - d*Cd2*Sd1))) - f*Sf
        J12 = -f*Sd1*((p*Cd2*Sp / (d*Cd1*Sd2 - d*Cd2*Sd1)) - (p*Cp*Sd2/(d*Cd1*Sd2 - d*Cd2*Sd1)))
        J21 = f*Cf + f*Cd1*((f*Cd2*Sf / (d*Cd1*Sd2 - d*Cd2*Sd1)) - (f*Cf*Sd2/(d*Cd1*Sd2 - d*Cd2*Sd1)))
        J22 = -f*Cd1*((p*Cd2*Sp / (d*Cd1*Sd2 - d*Cd2*Sd1)) - (p*Cp*Sd2/(d*Cd1*Sd2 - d*Cd2*Sd1))) 

        J = np.array([[J11,J12],
                     [J21,J22]])

        Pe = np.array([-14 * S0 * S1 + 14 * C0 * C1 - 7 * C0,
                    14 * S0 * C1 - 7 * S0 + 14 * S1 * C0,
                    0])
        return J,Pe

    def f(self,t,q,dt):
        self.t = t
        J , Pe = self.jacobian(q)

        if self.limits(Pe):
            u = np.zeros(5)
            self.q_dot = np.zeros(5)

        else:
            R,Rv=self.Ref(t)

            #Rv = np.array([Rv[0],R[1]])

            # Position error (Proportional term)
            self.e = R - Pe
            #e = np.array([e[0],e[1]])
            # Velocity error (Derivative term)

            e_dot = Rv - np.dot(J[:3, :], self.q_dot)
            #e_dot = Rv - np.dot(J, self.q_dot)

            self.e_int = self.e_int + self.e*dt

            # Control input (PID control + feedforward velocity)
            u = np.dot(np.linalg.pinv(J[:3, :]), self.Kp * self.e + self.Kd * e_dot + self.Ki * self.e_int + Rv)
            #u = np.dot(np.linalg.inv(J), self.Kp * e + self.Kd * e_dot + self.Ki * self.e_int + Rv)
            u = u if np.linalg.norm(u)<20 else 20*u/np.linalg.norm(u)
            self.q_dot = u

        return u

    def inverse_kinematic(self,t):
        self.t = t
        R, _ = self.Ref(t)
        rp = R[:2]

        lf, lp, ld, lt, delta = [self.lf,self.lp,self.ld1,self.lt,0]

        S1 = (rp[0]**2 +rp[1]**2 + lf**2 -lt**2)/(2*lf)
        theta_f = 2*np.arctan((rp[1] - np.sqrt(rp[1]**2 + rp[0]**2 - S1**2))/(rp[0] + S1)) 

        theta_d1 = np.arctan2(rp[1] - lf*np.sin(theta_f), rp[0] - lf*np.cos(theta_f)) -  delta 

        f = lf*np.array([np.cos(theta_f ),np.sin(theta_f )])
        d1 = ld*np.array([np.cos(theta_d1),np.sin(theta_d1)])
        t = lt*np.array([np.cos(theta_d1 - delta),np.sin(theta_d1 - delta)])

        rd = f + d1

        S3 = (rd[0]**2 + rd[1]**2 + lp**2 -ld**2)/(2*lp)
        theta_p = 2*np.arctan((rd[1] + np.sqrt(rd[1]**2 + rd[0]**2 - S3**2))/(rd[0] + S3)) 


        S2 = (rd[0]**2 +rd[1]**2 + ld**2 -lp**2)/(2*ld) 
        theta_d2 = 2*np.arctan((rd[1] - np.sqrt(rd[1]**2 + rd[0]**2  - S2**2))/(rd[0] + S2))

        p = lp*np.array([np.cos(theta_p ),np.sin(theta_p)])
        d2 = ld*np.array([np.cos(theta_d2),np.sin(theta_d2)])

        return theta_f + np.pi, theta_p + np.pi

    def rk4(self,y0, t, h):

        k1 = self.f(t, y0,h)
        k2 = self.f(t + 0.5*h, y0 + 0.5*k1*h,h)
        k3 = self.f(t + 0.5*h, y0 + 0.5*k2*h,h)
        k4 = self.f(t + h, y0 + k3*h,h)
        y1 = y0 + h*(k1 + 2*k2 + 2*k3 + k4)/6

        return y1, (k1 + 2*k2 + 2*k3 + k4)/6

    def SPL_Coef(self,x,y):
        self.l = x
        n=len(x)-1
        A=np.zeros([4*n,4*n])
        b=np.zeros(4*n)
        
        for i in range (n):
            A[ i , i*4 : 4*(i+1) ]=np.array([x[ i ]**3,x[ i ]**2,x[ i ],1])
            b[ i ]=y[ i ]
            A[ i+n , 4*i : (i+1)*4 ]=np.array([x[ i+1 ]**3,x[ i+1 ]**2,x[ i+1 ], 1 ])
            b[ i+n ]=y[ i+1 ]
            
        for i in range (n-1):
            A[ i+2*n , i*4 : 4*(i+2) ]=np.array([3*x[ i+1 ]**2,2*x[ i+1 ],1,0,-3*x[ i+1 ]**2,-2*x[ i+1 ],-1,0])
            A[ 3*n-1+i , i*4 : 4*(i+2) ]=np.array([6*x[ i+1 ],2,0,0,-6*x[ i+1 ],-2,0,0])
        
        A[4*n-2,0:3]=np.array([3*x[0]**2, 2*x[0], 1])
        
        A[4*n-1,4*n-4:4*n-1]=np.array([3*x[n]**2, 2*x[n], 1])
        
        q = np.linalg.solve(A,b)
        C=[]#coeficientes 
        for k in range(len(x)-1):
            C.append(q[4*k:4*k+4])
        return C   

    def limits(self,ref):
        if self.kinematics_limits > np.linalg.norm(ref):
            rospy.loginfo('Kinematic limits exceeded [%s], norm = %d',self.LEG_NAME, np.linalg.norm(ref))
            rospy.loginfo("ref = [%d, %d, %d]",ref[0], ref[1], ref[2])
            self.walk_flag = False
            return True
        else:
            return False

    def spline_control(self,C, xx):
        _SPL_index = self.find_spl_index(xx)
        yy = (C[_SPL_index][0]*xx**3 + C[_SPL_index][1]*xx**2 + C[_SPL_index][2]*xx + C[_SPL_index][3])
        vy = (3*C[_SPL_index][0]*xx**2 + 2*C[_SPL_index][1]*xx + C[_SPL_index][2])

        return yy, vy

    def Ref(self,t):
        if t > self.tf + 1:
            rospy.loginfo("t can not be grater than tf [%s], t = %f  tf = %f",self.LEG_NAME, t, self.tf)
            t = self.tf
        if t < 0:
            rospy.loginfo("t only take positive values [%s], t = %d",self.LEG_NAME, t)
            t = 1

        x, vx = self.spline_control(self.C_x, t)
        y, vy = self.spline_control(self.C_y, t)

        ref = np.array([x,y,0])
        
        if self.limits(ref):
            vel_ref = np.array([0, 0, 0])
        else:
            vel_ref = np.array([vx, vy, 0])

        return ref, vel_ref

    def gate(self,parameters,_way, _path,_cm_s):
        a = parameters[0]
        b = parameters[1]

        self.toggle_flag = self.check_direction(_way)
        self.path = _path

        if _path == 'elipse':
            if _way == -1:
                ls = np.linspace(np.pi,0, 3)
            else:
                ls = np.linspace(0,np.pi,3)
                
            x = -np.cos(ls)*a
            y = np.sin(ls)*b - 15

            _tf = a*2/_cm_s
            self.POINTS = len(x)
            l = np.linspace(0,_tf,len(x))
            self.C_x = self.SPL_Coef(l, x)
            self.C_y = self.SPL_Coef(l, y)

            self.set_total_time(_tf)

        elif _path == 'middle':
            if _way == -1:
                ls = np.linspace(0,a, 3)
            else:
                ls = np.linspace(a,0, 3)

            x = ls
            y = np.zeros((3)) -15

            _tf = a/_cm_s
            self.POINTS = len(x)
            l = np.linspace(0,_tf,len(x))
            self.C_x = self.SPL_Coef(l, x)
            self.C_y = self.SPL_Coef(l, y)

            self.set_total_time(_tf)

        elif _path == 'kin_limit':
            if _way == -1:
                ls = np.linspace(-a,0, 3)
            else:
                ls = np.linspace(0,-a, 3)

            x = ls
            y = np.zeros((3)) -15

            _tf = a/_cm_s
            self.POINTS = len(x)
            l = np.linspace(0,_tf,len(x))
            self.C_x = self.SPL_Coef(l, x)
            self.C_y = self.SPL_Coef(l, y)

            self.set_total_time(_tf)

        elif _path == 'run_kin_lim':
            if _way == -1:
                x = np.array([-5,5, 0,-5])
                y = np.array([0,0,2,0]) -15

            else:
                x = np.array([-5, 0, 5,-5])
                y = np.array([0,2,0,0]) - 15

            _tf = 20/_cm_s
            l = np.linspace(0,_tf,len(x))
            self.POINTS = len(x)
            self.C_x = self.SPL_Coef(l, x)
            self.C_y = self.SPL_Coef(l, y)

            self.set_total_time(_tf)

        elif _path == 'run_middle':
            if _way == -1:
                x = np.array([0, 5, 0, -5,0])
                y = np.array([0,0,2,0,0]) - 15
            else:
                x = np.array([0, -5, 0, 5,0])
                y = np.array([0,0,2,0,0]) - 15

            _tf = 20/_cm_s
            self.POINTS = len(x)
            l = np.linspace(0,_tf,len(x))
            self.C_x = self.SPL_Coef(l, x)
            self.C_y = self.SPL_Coef(l, y)

            self.set_total_time(_tf)
        
        elif _path == 'run_kin_lim_extended':
            if _way == -1:
                x = np.array([-6, 6, 6, -6,-6])
                y = np.array([0,0,3,3,0]) -15

            else:
                x = np.array([-6, -6, 6, 6,-6])
                y = np.array([0,3,3,0,0]) - 15

            _tf = 24/_cm_s
            self.POINTS = len(x)
            l = np.linspace(0,_tf,len(x))
            self.C_x = self.SPL_Coef(l, x)
            self.C_y = self.SPL_Coef(l, y)

            self.set_total_time(_tf)

        elif _path == 'run_middle_extended':
            if _way == -1:
                x = np.array([0, 6, 6, -6,-6,0])
                y = np.array([0,0,3,3,0,0]) - 15
            else:
                x = np.array([0,-6,-6, 6,6,0])
                y = np.array([0,0,3,3,0,0]) - 15

            _tf = 24/_cm_s
            self.POINTS = len(x)
            l = np.linspace(0,_tf,len(x))
            self.C_x = self.SPL_Coef(l, x)
            self.C_y = self.SPL_Coef(l, y)

            self.set_total_time(_tf)

        elif _path == 'wait':
            return

        else:
            rospy.loginfo("There is no a gate path named %s [%s]",self.LEG_NAME, _path)
            self.walk_flag = False
        self.t = 0
    def animation(self,t,q0,ax,esc):
        q = np.array([0,0,q0[0],q0[1],0])
        R,_ = self.Ref(t)

        T , c_c= self.MatrixT(q)
        
        ax.clear()

        ax.plot3D(R[0],R[1],R[2],'xr')


        ax.plot3D([c_c[1][0,3],c_c[0][0,3]],[c_c[1][1,3],c_c[0][1,3]],[c_c[1][2,3],c_c[0][2,3]],'--k')
        ax.plot3D([c_c[0][0,3],c_c[3][0,3]],[c_c[0][1,3],c_c[3][1,3]],[c_c[0][2,3],c_c[3][2,3]],'--k')
        ax.plot3D([c_c[1][0,3],c_c[2][0,3]],[c_c[1][1,3],c_c[2][1,3]],[c_c[1][2,3],c_c[2][2,3]],'--k')
        ax.plot3D([c_c[2][0,3],c_c[3][0,3]],[c_c[2][1,3],c_c[3][1,3]],[c_c[2][2,3],c_c[3][2,3]],'--k')
        ax.plot3D([c_c[3][0,3],c_c[4][0,3]],[c_c[3][1,3],c_c[4][1,3]],[c_c[3][2,3],c_c[4][2,3]],'--k')


        for k in range(len(q)):
            ax.plot3D([T[k][0,3], T[k][0,3]+esc*T[k][0,0]],
                    [T[k][1,3], T[k][1,3]+esc*T[k][1,0]],
                    [T[k][2,3], T[k][2,3]+esc*T[k][2,0]],'-r')
            ax.plot3D([T[k][0,3], T[k][0,3]+esc*T[k][0,1]],
                    [T[k][1,3], T[k][1,3]+esc*T[k][1,1]],
                    [T[k][2,3], T[k][2,3]+esc*T[k][2,1]],'-g')
            ax.plot3D([T[k][0,3], T[k][0,3]+esc*T[k][0,2]],
                    [T[k][1,3], T[k][1,3]+esc*T[k][1,2]],
                    [T[k][2,3], T[k][2,3]+esc*T[k][2,2]],'-b')


        ax.set_xlim([-20,20])
        ax.set_ylim([-20,10])
        ax.set_zlim([-2,2])
        ax.set_aspect('equal', 'box')

class DynamixelControllerProtocol2:
    def __init__(self):
        self.port_handler = PortHandler(constantsXM.DEVICE_NAME)
        self.packet_handler = PacketHandler(constantsXM.PROTOCOL_VERSION)

    def open_port(self):
        if not self.port_handler.is_open:
            rospy.loginfo("Port open")
            self.port_handler.openPort()
            self.port_handler.setBaudRate(constantsXM.BAUDRATE)
        else:
            rospy.loginfo("Port already open")

    def close_port(self):
        if self.port_handler.is_open:
            rospy.loginfo("Closing port and node")
            self.port_handler.closePort()
        else:
            rospy.loginfo("Port already closed")

    def torque_off(self, motor_f, motor_p):
        result_1, _ = self.packet_handler.write1ByteTxRx(self.port_handler, motor_f, constantsXM.ADD_TORQUE_ENABLE, constantsXM.TORQUE_DISABLE)
        result_2, _ = self.packet_handler.write1ByteTxRx(self.port_handler, motor_p, constantsXM.ADD_TORQUE_ENABLE, constantsXM.TORQUE_DISABLE)
        return result_1, result_2

    def torque_on(self, motor_f, motor_p):
        result_1, _ = self.packet_handler.write1ByteTxRx(self.port_handler, motor_f, constantsXM.ADD_TORQUE_ENABLE, constantsXM.TORQUE_ENABLE)
        result_2, _ = self.packet_handler.write1ByteTxRx(self.port_handler, motor_p, constantsXM.ADD_TORQUE_ENABLE, constantsXM.TORQUE_ENABLE)
        return result_1, result_2

    def goal_velocity(self, U_f, U_p, motor_f, motor_p):
        result_1, _ = self.packet_handler.write4ByteTxRx(self.port_handler, motor_f, constantsXM.ADD_GOAL_VEL, int(U_f))
        result_2, _ = self.packet_handler.write4ByteTxRx(self.port_handler, motor_p, constantsXM.ADD_GOAL_VEL, int(U_p))
        return result_1, result_2

    def read_pos(self, motor_f, motor_p):
        present_position_f, _, _ = self.packet_handler.read4ByteTxRx(self.port_handler, motor_f, constantsXM.ADD_PRESENT_POSTION)
        present_position_p, _, _ = self.packet_handler.read4ByteTxRx(self.port_handler, motor_p, constantsXM.ADD_PRESENT_POSTION)
        return present_position_f, present_position_p
    
    def init_dynamixel(self,dxl_id):

        rospy.loginfo("--------Initializing dinamixels %d and %d----------", dxl_id[0], dxl_id[1])

        for i in range(len(dxl_id)):

            rospy.loginfo("------- Dynamixel %d ---------", dxl_id[i])

            result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[i],constantsXM.ADD_BAUDRATE,3)#6 -> 4M # 3 -> 1,000,000 bauds
            data,_,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[i],constantsXM.ADD_BAUDRATE)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("[ID %d] buad rate: |%d|",dxl_id[i],data)
            else:
                rospy.loginfo("FAIL [ID %d] baud rate: |%d| %s  %s",dxl_id[i],data,self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False


            result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[i],constantsXM.ADD_TORQUE_ENABLE, constantsXM.TORQUE_DISABLE)
            data, _ ,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[i],constantsXM.ADD_TORQUE_ENABLE)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Torque of dxl [ID %d] : |%d|",dxl_id[i],data)
            else:
                rospy.loginfo("FAIL Torque disable of dxl [ID %d] : %s  %s",dxl_id[i],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False
            
            if dxl_id[0] == 1 or dxl_id[0] == 5:
                result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[0],constantsXM.ADD_DRIVE_MODE, constantsXM.CW)
                data, _ ,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[0],constantsXM.ADD_DRIVE_MODE)
                if (result == definitions.COMM_SUCCESS):
                    rospy.loginfo("Drive mode of dxl [ID %d] : |%d|",dxl_id[0],data)
                else:
                    rospy.loginfo("FAIL Drive mode of dxl [ID %d] : %s  %s",dxl_id[0],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                    return False
                
                result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[1],constantsXM.ADD_DRIVE_MODE, constantsXM.CCW)
                data, _ ,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[1],constantsXM.ADD_DRIVE_MODE)
                if (result == definitions.COMM_SUCCESS):
                    rospy.loginfo("Drive mode of dxl [ID %d] : |%d|",dxl_id[1],data)
                else:
                    rospy.loginfo("FAIL Drive mode of dxl [ID %d] : %s  %s",dxl_id[1],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                    return False
            else:
                result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[0],constantsXM.ADD_DRIVE_MODE, constantsXM.CCW)
                data, _ ,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[0],constantsXM.ADD_DRIVE_MODE)
                if (result == definitions.COMM_SUCCESS):
                    rospy.loginfo("Drive mode of dxl [ID %d] : |%d|",dxl_id[0],data)
                else:
                    rospy.loginfo("FAIL Drive mode of dxl [ID %d] : %s  %s",dxl_id[0],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                    return False
                
                result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[1],constantsXM.ADD_DRIVE_MODE, constantsXM.CW)
                data, _ ,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[1],constantsXM.ADD_DRIVE_MODE)
                if (result == definitions.COMM_SUCCESS):
                    rospy.loginfo("Drive mode of dxl [ID %d] : |%d|",dxl_id[1],data)
                else:
                    rospy.loginfo("FAIL Drive mode of dxl [ID %d] : %s  %s",dxl_id[1],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                    return False
            
            result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[i],constantsXM.ADD_OPERATING_MODE, 1)
            data, _ ,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[i],constantsXM.ADD_OPERATING_MODE)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Operating mode set of dxl |%d| set to |%d|",dxl_id[i],data)
            else:
                rospy.loginfo("FAIL setting operating mode of dxl |%d|  %s  %s",dxl_id[i],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False

            result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[i],constantsXM.ADD_PROTOCOL_TYPE,constantsXM.PROTOCOL_VERSION)
            data, _, _ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[i],constantsXM.ADD_PROTOCOL_TYPE)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Protocol version |%0.1f| to dxl [ID %d]",data,dxl_id[i])
            else:
                rospy.loginfo("FAIL Writing protocol version |%0.1f| to dxl [ID %d] : %s  %s",constantsXM.PROTOCOL_VERSION,dxl_id[i],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False
            
            result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[i],constantsXM.ADD_TORQUE_ENABLE, constantsXM.TORQUE_ENABLE)
            data, _ ,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[i],constantsXM.ADD_TORQUE_ENABLE)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Torque of dxl [ID %d] : |%d|",dxl_id[i],data)
            else:
                rospy.loginfo("FAIL Torque Enable of dxl [ID %d] : %s  %s",dxl_id[i],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False


            model,result,error = self.packet_handler.ping(self.port_handler,dxl_id[i])
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Ping dxl [ID %d] Model: %s ",dxl_id[i],model)
            else:
                rospy.loginfo("FAIL Ping dxl [ID %d] Model: %s  %s  %s",dxl_id[i],model,self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False
        return True
    
    def shutdown(self, motor_f, motor_p):
        result_1, result_2 = self.goal_velocity(0, 0, motor_f, motor_p)
        result_3, result_4 = self.torque_off(motor_f, motor_p)
        return all(r == definitions.COMM_SUCCESS for r in [result_1, result_2, result_3, result_4])
    
    def goal_position(self,theta_f, theta_p, motor_f, motor_p):
        result_1, _ = self.packet_handler.write2ByteTxRx(self.port_handler, motor_f, constantsXM.ADD_GOAL_POSITION, int(theta_f))
        result_2, _ = self.packet_handler.write2ByteTxRx(self.port_handler, motor_p, constantsXM.ADD_GOAL_POSITION, int(theta_p))
        return result_1, result_2
    
class DynamixelControllerProtocol1:

    def __init__(self):
        self.port_handler = PortHandler(constantsAX.DEVICE_NAME)
        self.packet_handler = PacketHandler(constantsAX.PROTOCOL_VERSION)
    
    def open_port(self):
        if not self.port_handler.is_open:
            rospy.loginfo("Port open")
            self.port_handler.openPort()
            self.port_handler.setBaudRate(constantsAX.BAUDRATE)
        else:
            rospy.loginfo("Port already open")

    def close_port(self):
        if self.port_handler.is_open:
            rospy.loginfo("Closing port and node")
            self.port_handler.closePort()
        else:
            rospy.loginfo("Port already closed")

    def torque_off(self, motor_f, motor_p):
        result_1, _ = self.packet_handler.write1ByteTxRx(self.port_handler, motor_f, constantsAX.ADD_TORQUE_ENABLE, constantsAX.TORQUE_DISABLE)
        result_2, _ = self.packet_handler.write1ByteTxRx(self.port_handler, motor_p, constantsAX.ADD_TORQUE_ENABLE, constantsAX.TORQUE_DISABLE)
        return result_1, result_2

    def torque_on(self, motor_f, motor_p):
        result_1, _ = self.packet_handler.write1ByteTxRx(self.port_handler, motor_f, constantsAX.ADD_TORQUE_ENABLE, constantsAX.TORQUE_ENABLE)
        result_2, _ = self.packet_handler.write1ByteTxRx(self.port_handler, motor_p, constantsAX.ADD_TORQUE_ENABLE, constantsAX.TORQUE_ENABLE)
        return result_1, result_2

    def read_pos(self, motor_f, motor_p):
        present_position_f, _, _ = self.packet_handler.read2ByteTxRx(self.port_handler, motor_f, constantsAX.ADD_PRESENT_POSTION)
        present_position_p, _, _ = self.packet_handler.read2ByteTxRx(self.port_handler, motor_p, constantsAX.ADD_PRESENT_POSTION)
        return present_position_f, present_position_p
    
    def goal_velocity(self, U_f, U_p, motor_f, motor_p):
        result_1, _ = self.packet_handler.write2ByteTxRx(self.port_handler, motor_f, constantsAX.ADD_GOAL_VEL, int(U_f))
        result_2, _ = self.packet_handler.write2ByteTxRx(self.port_handler, motor_p, constantsAX.ADD_GOAL_VEL, int(U_p))
        return result_1, result_2

    def init_dynamixel(self,dxl_id):

        rospy.loginfo("--------Initializing dinamixels %d and %d----------", dxl_id[0], dxl_id[1])

        for i in range(len(dxl_id)):

            rospy.loginfo("------- Dynamixel %d ---------", dxl_id[i])

            result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[i],constantsAX.ADD_BAUDRATE,1)
            data,_,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[i],constantsAX.ADD_BAUDRATE)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("[ID %d] buad rate: |%d|",dxl_id[i],data)
            else:
                rospy.loginfo("FAIL [ID %d] baud rate: |%d| %s  %s",dxl_id[i],data,self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False


            result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[i],constantsAX.ADD_TORQUE_ENABLE, constantsAX.TORQUE_DISABLE)
            data, _ ,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[i],constantsAX.ADD_TORQUE_ENABLE)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Torque of dxl [ID %d] : |%d|",dxl_id[i],data)
            else:
                rospy.loginfo("FAIL Torque disable of dxl [ID %d] : %s  %s",dxl_id[i],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False

            result, error = self.packet_handler.write2ByteTxRx(self.port_handler,dxl_id[i],constantsAX.ADD_CW_LIM, 0)
            data, _ ,_ = self.packet_handler.read2ByteTxRx(self.port_handler,dxl_id[i],constantsAX.ADD_CW_LIM)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("CW limit of dxl [ID %d] : |%d|",dxl_id[i],data)
            else:
                rospy.loginfo("FAIL CW limit 0 of dxl [ID %d] : %s  %s",dxl_id[i],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False
            
            result, error = self.packet_handler.write2ByteTxRx(self.port_handler,dxl_id[i],constantsAX.ADD_CCW_LIM, 1023)
            data, _ ,_ = self.packet_handler.read2ByteTxRx(self.port_handler,dxl_id[i],constantsAX.ADD_CCW_LIM)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("CCW limit of dxl [ID %d] : |%d|",dxl_id[i],data)
            else:
                rospy.loginfo("FAIL CCW limit 0 of dxl [ID %d] : %s  %s",dxl_id[i],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False

            result, error = self.packet_handler.write2ByteTxRx(self.port_handler,dxl_id[i],constantsAX.ADD_GOAL_VEL, 0)
            data, _ ,_ = self.packet_handler.read2ByteTxRx(self.port_handler,dxl_id[i],constantsAX.ADD_GOAL_VEL)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Goal vel of dxl [ID %d] : |%d|",dxl_id[i],data)
            else:
                rospy.loginfo("FAIL goal vel of dxl [ID %d] : %s  %s",dxl_id[i],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False
            
            result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[i],constantsAX.ADD_TORQUE_ENABLE, constantsAX.TORQUE_ENABLE)
            data, _ ,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[i],constantsAX.ADD_TORQUE_ENABLE)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Torque of dxl [ID %d] : |%d|",dxl_id[i],data)
            else:
                rospy.loginfo("FAIL Torque Enable of dxl [ID %d] : %s  %s",dxl_id[i],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False
            
            result, error = self.packet_handler.write2ByteTxRx(self.port_handler,dxl_id[i],constantsAX.ADD_PUNCH, 2)
            data, _ ,_ = self.packet_handler.read2ByteTxRx(self.port_handler,dxl_id[i],constantsAX.ADD_PUNCH)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Punch of dxl [ID %d] : |%d|",dxl_id[i],data)
            else:
                rospy.loginfo("FAIL change Punch of dxl [ID %d] : %s  %s",dxl_id[i],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False

            model,result,error = self.packet_handler.ping(self.port_handler,dxl_id[i])
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Ping dxl [ID %d] Model: %s ",dxl_id[i],model)
            else:
                rospy.loginfo("FAIL Ping dxl [ID %d] Model: %s  %s  %s",dxl_id[i],model,self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False

        return True
    
    def shutdown(self, motor_f, motor_p):
        result_1, result_2 = self.goal_velocity(0, 0, motor_f, motor_p)
        result_3, result_4 = self.torque_off(motor_f, motor_p)
        return all(r == definitions.COMM_SUCCESS for r in [result_1, result_2, result_3, result_4])

    def goal_position(self,theta_f, theta_p, motor_f, motor_p):
        result_1, _ = self.packet_handler.write2ByteTxRx(self.port_handler, motor_f, constantsAX.ADD_GOAL_POSITION, int(theta_f))
        result_2, _ = self.packet_handler.write2ByteTxRx(self.port_handler, motor_p, constantsAX.ADD_GOAL_POSITION, int(theta_p))
        return result_1, result_2
