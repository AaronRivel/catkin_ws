#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from quadruped_robot.common_libs import *

class RobotController:
    def __init__(self,name = None):
        if name:

            rospy.init_node(name, anonymous=True)

            namespace = rospy.get_namespace()

            self.LEG_F = rospy.get_param(namespace + 'LEG_F')
            self.LEG_P = rospy.get_param(namespace + 'LEG_P')
            self.LEG_NAME = rospy.get_param(namespace + 'LEG_NAME')

            self.Kp = rospy.get_param(namespace + 'Kp')
            self.Kd = rospy.get_param(namespace + 'Kd')
            self.Ki = rospy.get_param(namespace + 'Ki')


        self.walk_flag = False

        self.q_dot = np.zeros(5)

        self.tf = 3600
        self.t = 0
        self.t0 = 0
        self.tmapp = 0
        self.toggle_flag = False

        self.path = 'wait'
        self.SPL_index = 0
        self.POINTS = 3
        self.l = np.linspace(0,self.tf,self.POINTS)
        self.way = 1
        self.gate(2,5,1,'elipse')
        self.e_int = 0

    def set_period_ref(self, _tf):
        if not self.toggle_flag:
            mapp = self.t / self.tf if self.tf != 0 else 0
            self.tf = _tf
            self.SPL_index = 0
            self.t = mapp * _tf
            self.t0 = 0
        else:

            mapp = 1 - (self.t / self.tf) if self.tf != 0 else 0
            self.tf = _tf
            self.t0 = 0
            self.SPL_index = 0
            self.t = mapp * _tf


    def DHParameters(self, q):
        theta_p = q[3] + q[2] - np.pi
        return [[theta_p, 0, -7, 0],
                [0, 0, 0, 0],
                [q[2], 0, -7, 0],
                [q[3], 0, 7, 0],
                [0, 0, 7, 0]]

    def MatrixT(self, q):
        DH = self.DHParameters(q)
        T = [np.identity(4) for _ in q]
        for i, params in enumerate(DH):
            Rz = np.array([[np.cos(params[0]), -np.sin(params[0]), 0, 0],
                           [np.sin(params[0]), np.cos(params[0]), 0, 0],
                           [0, 0, 1, 0],
                           [0, 0, 0, 1]])
            Tz = np.array([[1, 0, 0, 0],
                           [0, 1, 0, 0],
                           [0, 0, 1, params[1]],
                           [0, 0, 0, 1]])
            Tx = np.array([[1, 0, 0, params[2]],
                           [0, 1, 0, 0],
                           [0, 0, 1, 0],
                           [0, 0, 0, 1]])
            Rx = np.array([[1, 0, 0, 0],
                           [0, np.cos(params[3]), -np.sin(params[3]), 0],
                           [0, np.sin(params[3]), np.cos(params[3]), 0],
                           [0, 0, 0, 1]])
            T[i] = np.dot(np.dot(Rz, Tz), np.dot(Tx, Rx))
    
        T_array = []
        T_array.append(T[0])
        T_array.append(T[1])
        for i in range (1,len(q)-1):
            T_array.append(np.dot(T_array[i],T[i+1]))
        
        return T_array, T_array

    def jacobian(self,q):
        T, _= self.MatrixT(q)
        Pe = T[len(q)-1][:3,3]

        J = np.zeros((6,len(q)))

        for k in range(len(q)):
            if(k in (1,2)):
                zk = T[k][:3,2]
                Pk = T[k][:3,3]
                
                J[:,k+1] = np.concatenate((np.cross(zk , (Pe-Pk)), zk))
        return J , Pe
    
    def f(self,t,q,dt):

        J , Pe = self.jacobian(q)
        R,Rv=self.Ref(t)
        '''
        Kp = 10
        e=R-Pe
        u=np.dot(np.linalg.pinv( J[:3,:]),Kp*e + Rv)

        Kp = 10 / 15  /  20 / 30 / 15/15
        Kd = 0.1 / 0.5 / 0.8 / 1.5 / 1/1.5
        Ki =     /     /     /    / 10/10
        '''


        # Position error (Proportional term)
        e = R - Pe

        # Velocity error (Derivative term)

        e_dot = Rv - np.dot(J[:3, :], self.q_dot)

        self.e_int = self.e_int + e*dt

        # Control input (PD control + feedforward velocity)
        u = np.dot(np.linalg.pinv(J[:3, :]), self.Kp * e + self.Kd * e_dot + self.Ki * self.e_int + Rv)
        #u = u if np.linalg.norm(u)<20 else 20*u/np.linalg.norm(u)
        return u

    def rk4(self,y0, t, h):

        k1 = self.f(t, y0,h)
        k2 = self.f(t + 0.5*h, y0 + 0.5*k1*h,h)
        k3 = self.f(t + 0.5*h, y0 + 0.5*k2*h,h)
        k4 = self.f(t + h, y0 + k3*h,h)
        y1 = y0 + h*(k1 + 2*k2 + 2*k3 + k4)/6

        return y1, (k1 + 2*k2 + 2*k3 + k4)/6

    def SPL_Coef(self,x,y):
        
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

    def spline_control(self,C, xx):

        while(not(self.l[self.SPL_index] <= xx and self.l[self.SPL_index + 1] > xx)):
            self.SPL_index += 1 
            if self.SPL_index + 1 > self.POINTS - 1:
                self.SPL_index = 0
                break

        yy = (C[self.SPL_index][0]*xx**3 + C[self.SPL_index][1]*xx**2 + C[self.SPL_index][2]*xx + C[self.SPL_index][3])
        vy = (3*C[self.SPL_index][0]*xx**2 + 2*C[self.SPL_index][1]*xx + C[self.SPL_index][2])

        return yy, vy


    def Ref(self,t):

        x, vx = self.spline_control(self.C_x, t)
        y, vy = self.spline_control(self.C_y, t)

        ref = np.array([x,y,0])
        vel_ref = np.array([vx, vy, 0])

        return ref, vel_ref

    def gate(self,a,b,way, _path):
        self.l = np.linspace(0,self.tf,self.POINTS)
        self.way = way
        self.path = _path
        
        if _path == '': self.path = 'wait'

        if(_path == 'elipse'):
            ls = np.linspace(0,np.pi,self.POINTS)
            if(way == -1):
                ls = np.linspace(np.pi,0, self.POINTS)
                

            x = -np.cos(ls)*b
            y = np.sin(ls)*a - 15

            self.C_x = self.SPL_Coef(self.l, x)
            self.C_y = self.SPL_Coef(self.l, y)

        if (_path == 'middle'):
            ls = np.linspace(b,0, self.POINTS)
            if way == -1:
                ls = np.linspace(0,b, self.POINTS)

            x = ls
            y = np.zeros((self.POINTS)) -15

            self.C_x = self.SPL_Coef(self.l, x)
            self.C_y = self.SPL_Coef(self.l, y)


        if (_path == 'kin_limit'):
            ls = np.linspace(0,-b, self.POINTS)
            if way == -1:
                ls = np.linspace(-b,0, self.POINTS)

            x = ls
            y = np.zeros((self.POINTS)) -15

            self.C_x = self.SPL_Coef(self.l, x)
            self.C_y = self.SPL_Coef(self.l, y)

    def animation(self,t,q0,ax,esc):
        q = np.array([0,0,q0[0],q0[1],0])
        R,_ = self.Ref(t)

        T , c_c= self.MatrixT(q)
        
        ax.clear()

        ax.plot3D(R[0],R[1],R[2],'xm')
        #ax.plot3D(R0[0],R0[1],R0[2],'xk')


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


class DynamixelController:
    def __init__(self):
        self.port_handler = PortHandler(constants.DEVICE_NAME)
        self.packet_handler = PacketHandler(constants.PROTOCOL_VERSION)

    def open_port(self):
        if not self.port_handler.is_open:
            rospy.loginfo("Port open")
            self.port_handler.openPort()
            self.port_handler.setBaudRate(constants.BAUDRATE)
        else:
            rospy.loginfo("Port already open")

    def close_port(self):
        if self.port_handler.is_open:
            rospy.loginfo("Closing port and node")
            self.port_handler.closePort()
        else:
            rospy.loginfo("Port already closed")

    def torque_off(self, motor_f, motor_p):
        result_1, _ = self.packet_handler.write1ByteTxRx(self.port_handler, motor_f, constants.ADD_TORQUE_ENABLE, constants.TORQUE_DISABLE)
        result_2, _ = self.packet_handler.write1ByteTxRx(self.port_handler, motor_p, constants.ADD_TORQUE_ENABLE, constants.TORQUE_DISABLE)
        return result_1, result_2

    def torque_on(self, motor_f, motor_p):
        result_1, _ = self.packet_handler.write1ByteTxRx(self.port_handler, motor_f, constants.ADD_TORQUE_ENABLE, constants.TORQUE_ENABLE)
        result_2, _ = self.packet_handler.write1ByteTxRx(self.port_handler, motor_p, constants.ADD_TORQUE_ENABLE, constants.TORQUE_ENABLE)
        return result_1, result_2

    def goal_velocity(self, U_f, U_p, motor_f, motor_p):
        result_1, _ = self.packet_handler.write4ByteTxRx(self.port_handler, motor_f, constants.ADD_GOAL_VEL, int(U_f))
        result_2, _ = self.packet_handler.write4ByteTxRx(self.port_handler, motor_p, constants.ADD_GOAL_VEL, int(U_p))
        return result_1, result_2

    def read_pos(self, motor_f, motor_p):
        present_position_f, _, _ = self.packet_handler.read4ByteTxRx(self.port_handler, motor_f, constants.ADD_PRESENT_POSTION)
        present_position_p, _, _ = self.packet_handler.read4ByteTxRx(self.port_handler, motor_p, constants.ADD_PRESENT_POSTION)
        return present_position_f, present_position_p
    def init_dynamixel(self,dxl_id):

        rospy.loginfo("--------Initializing dinamixels %d and %d----------", dxl_id[0], dxl_id[1])

        for i in range(len(dxl_id)):

            rospy.loginfo("------- Dynamixel %d ---------", dxl_id[i])

            result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[i],constants.ADD_BAUDRATE,6)#6 -> 4M # 3 -> 1,000,000 bauds
            data,_,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[i],constants.ADD_BAUDRATE)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("[ID %d] buad rate: |%d|",dxl_id[i],data)
            else:
                rospy.loginfo("FAIL [ID %d] baud rate: |%d| %s  %s",dxl_id[i],data,self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False


            result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[i],constants.ADD_TORQUE_ENABLE, constants.TORQUE_DISABLE)
            data, _ ,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[i],constants.ADD_TORQUE_ENABLE)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Torque of dxl [ID %d] : |%d|",dxl_id[i],data)
            else:
                rospy.loginfo("FAIL Torque disable of dxl [ID %d] : %s  %s",dxl_id[i],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False
            
            result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[0],constants.ADD_DRIVE_MODE, constants.CCW)
            data, _ ,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[0],constants.ADD_DRIVE_MODE)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Drive mode of dxl [ID %d] : |%d|",dxl_id[0],data)
            else:
                rospy.loginfo("FAIL Drive mode of dxl [ID %d] : %s  %s",dxl_id[0],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False
            
            result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[1],constants.ADD_DRIVE_MODE, constants.CW)
            data, _ ,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[1],constants.ADD_DRIVE_MODE)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Drive mode of dxl [ID %d] : |%d|",dxl_id[1],data)
            else:
                rospy.loginfo("FAIL Drive mode of dxl [ID %d] : %s  %s",dxl_id[1],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False
            
            result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[i],constants.ADD_OPERATING_MODE, 1)
            data, _ ,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[i],constants.ADD_OPERATING_MODE)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Operating mode set of dxl |%d| set to |%d|",dxl_id[i],data)
            else:
                rospy.loginfo("FAIL setting operating mode of dxl |%d|  %s  %s",dxl_id[i],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False

            result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[i],constants.ADD_PROTOCOL_TYPE,constants.PROTOCOL_VERSION)
            data, _, _ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[i],constants.ADD_PROTOCOL_TYPE)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Protocol version |%0.1f| to dxl [ID %d]",data,dxl_id[i])
            else:
                rospy.loginfo("FAIL Writing protocol version |%0.1f| to dxl [ID %d] : %s  %s",constants.PROTOCOL_VERSION,dxl_id[i],self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False
            
            result, error = self.packet_handler.write1ByteTxRx(self.port_handler,dxl_id[i],constants.ADD_TORQUE_ENABLE, constants.TORQUE_ENABLE)
            data, _ ,_ = self.packet_handler.read1ByteTxRx(self.port_handler,dxl_id[i],constants.ADD_TORQUE_ENABLE)
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

            result, error = self.packet_handler.write4ByteTxRx(self.port_handler,dxl_id[i],constants.ADD_VELOCITY,constants.VELOCITY)
            data, _, _ = self.packet_handler.read4ByteTxRx(self.port_handler,dxl_id[i],constants.ADD_VELOCITY)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Velocity of dxl [ID %d] to |%d| ",dxl_id[i],data)
            else:
                rospy.loginfo("FAIL Writing velocity of dxl [ID %d] to |%d| : %s  %s",dxl_id[i],constants.VELOCITY,self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False

            result, error = self.packet_handler.write4ByteTxRx(self.port_handler,dxl_id[i],constants.ADD_ACCELERATION,constants.ACCELERATION)
            data, _, _ = self.packet_handler.read4ByteTxRx(self.port_handler,dxl_id[i],constants.ADD_ACCELERATION)
            if (result == definitions.COMM_SUCCESS):
                rospy.loginfo("Acceleration of dxl [ID %d] to |%d| ",dxl_id[i],data)
            else:
                rospy.loginfo("FAIL Writing acceleration of dxl [ID %d] to |%d| : %s  %s",dxl_id[i],constants.ACCELERATION,self.packet_handler.getTxRxResult(result),self.packet_handler.getRxPacketError(error))
                return False
        return True

    def _init_dynamixel(self, dxl_id):
        rospy.loginfo("--------Initializing Dynamixels %d and %d----------", dxl_id[0], dxl_id[1])
        for i in range(len(dxl_id)):
            rospy.loginfo("------- Dynamixel %d ---------", dxl_id[i])
            if not self._configure_dynamixel(dxl_id[i]):
                return False
        return True

    def _configure_dynamixel(self, dxl_id):
        settings = [
            (constants.ADD_BAUDRATE, 6),
            (constants.ADD_TORQUE_ENABLE, constants.TORQUE_DISABLE),
            (constants.ADD_DRIVE_MODE, constants.CCW if dxl_id == 0 else constants.CW),
            (constants.ADD_OPERATING_MODE, 1),
            (constants.ADD_PROTOCOL_TYPE, constants.PROTOCOL_VERSION),
            (constants.ADD_TORQUE_ENABLE, constants.TORQUE_ENABLE),
            (constants.ADD_VELOCITY, constants.VELOCITY),
            (constants.ADD_ACCELERATION, constants.ACCELERATION)
        ]

        for address, value in settings:
            result, error = self.packet_handler.write1ByteTxRx(self.port_handler, dxl_id, address, value)
            if result != definitions.COMM_SUCCESS:
                rospy.loginfo("FAIL setting %s for dxl [ID %d]: %s", address, dxl_id, self.packet_handler.getTxRxResult(result))
                return False
        model, result, _ = self.packet_handler.ping(self.port_handler, dxl_id)
        if result == definitions.COMM_SUCCESS:
            rospy.loginfo("Ping dxl [ID %d] Model: %s", dxl_id, model)
        else:
            rospy.loginfo("FAIL Ping dxl [ID %d]", dxl_id)
            return False
        return True

    def shutdown(self, motor_f, motor_p):
        result_1, result_2 = self.goal_velocity(0, 0, motor_f, motor_p)
        result_3, result_4 = self.torque_off(motor_f, motor_p)
        return all(r == definitions.COMM_SUCCESS for r in [result_1, result_2, result_3, result_4])