#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from quadruped_robot.common_libs import *

port_num =  PortHandler(constants.DEVICE_NAME)
packet_handler = PacketHandler(constants.PROTOCOL_VERSION)

T = 40

def open_port():
    PortHandler.openPort(port_num)
    PortHandler.setBaudRate(port_num,constants.BAUDRATE)

def close_port():
    rospy.loginfo("Closing port and node")
    PortHandler.closePort(port_num)
    rospy.signal_shutdown("Fail initializing dynamixels")
    return

def torque_off(motor_f,motor_p):
    packet_handler.write1ByteTxRx(port_num,motor_f,constants.ADD_TORQUE_ENABLE,constants.TORQUE_DISABLE)
    packet_handler.write1ByteTxRx(port_num,motor_p,constants.ADD_TORQUE_ENABLE,constants.TORQUE_DISABLE)

def torque_on(motor_f, motor_p):
    packet_handler.write1ByteTxRx(port_num,motor_f,constants.ADD_TORQUE_ENABLE,constants.TORQUE_ENABLE)
    packet_handler.write1ByteTxRx(port_num,motor_p,constants.ADD_TORQUE_ENABLE,constants.TORQUE_ENABLE)


def goal_velocity(U_f, U_p,motor_f,motor_p):
    packet_handler.write4ByteTxRx(port_num,motor_f,constants.ADD_GOAL_VEL,int(U_f))
    packet_handler.write4ByteTxRx(port_num,motor_p,constants.ADD_GOAL_VEL,int(U_p))

def read_pos(motor_f, motror_p):
    present_position_f, _, _ = packet_handler.read4ByteTxRx(port_num,motor_f, constants.ADD_PRESENT_POSTION)
    present_position_p, _, _ = packet_handler.read4ByteTxRx(port_num,motror_p, constants.ADD_PRESENT_POSTION)

    return present_position_f,present_position_p

def init_dynamixel(dxl_id):

    for i in range(len(dxl_id)):
        result, error = packet_handler.write1ByteTxRx(port_num,dxl_id[i],constants.ADD_TORQUE_ENABLE, constants.TORQUE_DISABLE)
        data, _ ,_ = packet_handler.read1ByteTxRx(port_num,dxl_id[i],constants.ADD_TORQUE_ENABLE)
        if (result == definitions.COMM_SUCCESS):
            rospy.loginfo("Torque of dxl [ID %d] : |%d|",dxl_id[i],data)
        else:
            rospy.loginfo("FAIL Torque disable of dxl [ID %d] : %s  %s",dxl_id[i],packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            return False
        
        result, error = packet_handler.write1ByteTxRx(port_num,dxl_id[i],constants.ADD_OPERATING_MODE, 1)
        data, _ ,_ = packet_handler.read1ByteTxRx(port_num,dxl_id[i],constants.ADD_OPERATING_MODE)
        if (result == definitions.COMM_SUCCESS):
            rospy.loginfo("Operating mode set of dxl |%d| set to |%d|",dxl_id[i],data)
        else:
            rospy.loginfo("FAIL setting operating mode of dxl |%d|  %s  %s",dxl_id[i],packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            return False

        result, error = packet_handler.write1ByteTxRx(port_num,dxl_id[i],constants.ADD_PROTOCOL_TYPE,constants.PROTOCOL_VERSION)
        data, _, _ = packet_handler.read1ByteTxRx(port_num,dxl_id[i],constants.ADD_PROTOCOL_TYPE)
        if (result == definitions.COMM_SUCCESS):
            rospy.loginfo("Protocol version |%0.1f| to dxl [ID %d]",data,dxl_id[i])
        else:
            rospy.loginfo("FAIL Writing protocol version |%0.1f| to dxl [ID %d] : %s  %s",constants.PROTOCOL_VERSION,dxl_id[i],packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            return False
        
        result, error = packet_handler.write1ByteTxRx(port_num,dxl_id[i],constants.ADD_TORQUE_ENABLE, constants.TORQUE_ENABLE)
        data, _ ,_ = packet_handler.read1ByteTxRx(port_num,dxl_id[i],constants.ADD_TORQUE_ENABLE)
        if (result == definitions.COMM_SUCCESS):
            rospy.loginfo("Torque of dxl [ID %d] : |%d|",dxl_id[i],data)
        else:
            rospy.loginfo("FAIL Torque Enable of dxl [ID %d] : %s  %s",dxl_id[i],packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            return False

        result, error = packet_handler.write1ByteTxRx(port_num,dxl_id[i],constants.ADD_BAUDRATE,3) # 3 -> 1,000,000 bauds
        data,_,_ = packet_handler.read1ByteTxRx(port_num,dxl_id[i],constants.ADD_BAUDRATE)
        if (result == definitions.COMM_SUCCESS):
            rospy.loginfo("[ID %d] buad rate: |%d|",dxl_id[i],data)
        else:
            rospy.loginfo("FAIL [ID %d] baud rate: |%d| %s  %s",dxl_id[i],constants.BAUDRATE,packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            return False

        model,result,error = packet_handler.ping(port_num,dxl_id[i])
        if (result == definitions.COMM_SUCCESS):
            rospy.loginfo("Ping dxl [ID %d] Model: %s ",dxl_id[i],model)
        else:
            rospy.loginfo("FAIL Ping dxl [ID %d] Model: %s  %s  %s",dxl_id[i],model,packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            return False

        result, error = packet_handler.write4ByteTxRx(port_num,dxl_id[i],constants.ADD_VELOCITY,constants.VELOCITY)
        data, _, _ = packet_handler.read4ByteTxRx(port_num,dxl_id[i],constants.ADD_VELOCITY)
        if (result == definitions.COMM_SUCCESS):
            rospy.loginfo("Velocity of dxl [ID %d] to |%d| ",dxl_id[i],data)
        else:
            rospy.loginfo("FAIL Writing velocity of dxl [ID %d] to |%d| : %s  %s",dxl_id[i],constants.VELOCITY,packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            return False

        result, error = packet_handler.write4ByteTxRx(port_num,dxl_id[i],constants.ADD_ACCELERATION,constants.ACCELERATION)
        data, _, _ = packet_handler.read4ByteTxRx(port_num,dxl_id[i],constants.ADD_ACCELERATION)
        if (result == definitions.COMM_SUCCESS):
            rospy.loginfo("Acceleration of dxl [ID %d] to |%d| ",dxl_id[i],data)
        else:
            rospy.loginfo("FAIL Writing acceleration of dxl [ID %d] to |%d| : %s  %s",dxl_id[i],constants.ACCELERATION,packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            return False

def set_period_ref(period):
    global T
    T = period

def get_period():
    global T
    return T

def Ref(t):
    T = get_period()
    a = 5
    b = 2

    ref = np.array([a*np.sin((t*2*np.pi)/T)  , b*np.cos((t*2*np.pi)/T) - 15 , 0])
    vel_ref = np.array([np.pi*a*np.cos((t*2*np.pi)/T)*((2*np.pi)/T) ,  -np.pi*b*np.sin((t*2*np.pi)/T)*((2*np.pi)/T) , 0])
    return ref, vel_ref

def DHParameters(q):
    theta_p =  q[3] + q[2] - np.pi

    return [[theta_p ,  0, -7,  0],
            [0       ,  0,  0,  0],
            [q[2]    ,  0, -7,  0],
            [q[3]    ,  0,  7,  0],
            [0       ,  0,  7,  0]]

def MatrixT(q):
    DH =  DHParameters(q)
    T = []
    for i in range (len(q)):
        T.append(np.identity(4))
        
    for i in range (len(q)):
        
        Rz=np.array([[np.cos(DH[i][0]), -np.sin(DH[i][0]),0,0],
                    [np.sin(DH[i][0]),  np.cos(DH[i][0]),0,0],
                    [0,0,1,0],
                    [0,0,0,1]])
        Tz=np.array([[1,0,0,0],
                    [0,1,0,0],
                    [0,0,1,DH[i][1]],
                    [0,0,0,1]])
        Tx=np.array([[1,0,0,DH[i][2]],
                    [0,1,0,0],
                    [0,0,1,0],
                    [0,0,0,1]])
        Rx=np.array([[1,0,0,0],
                    [0,np.cos(DH[i][3]),-np.sin(DH[i][3]),0],
                    [0,np.sin(DH[i][3]), np.cos(DH[i][3]),0],
                    [0,0,0,1]])
        
        T[i]= np.dot(np.dot(Rz,Tz),np.dot(Tx,Rx))

    T_array = []
    T_array.append(T[0])
    T_array.append(T[1])
    for i in range (1,len(q)-1):
        T_array.append(np.dot(T_array[i],T[i+1]))

    return T_array, T_array


def jacobian(q):
    T, _= MatrixT(q)
    Pe = T[len(q)-1][:3,3]

    J = np.zeros((6,len(q)))

    for k in range(len(q)):
        if(k in (1,2)):
            zk = T[k][:3,2]
            Pk = T[k][:3,3]
            
            J[:,k+1] = np.concatenate((np.cross(zk , (Pe-Pk)), zk))
    return J , Pe

def f(t,q):
    J , Pe = jacobian(q)
    R,Rv=Ref(t)
    Kp=20
    e=R-Pe
    u=np.dot(np.linalg.pinv( J[:3,:]),Kp*e + Rv)
    u = u if np.linalg.norm(u)<20 else 20*u/np.linalg.norm(u)
    return u

def rk4(y0, t, h):

    k1 = f(t, y0)
    k2 = f(t + 0.5*h, y0 + 0.5*k1*h)
    k3 = f(t + 0.5*h, y0 + 0.5*k2*h)
    k4 = f(t + h, y0 + k3*h)
    y1 = y0 + h*(k1 + 2*k2 + 2*k3 + k4)/6

    return y1, (k1 + 2*k2 + 2*k3 + k4)/6

def animation(t,q0,ax,esc):

    q = np.array([0,0,q0[0],q0[1],0])
    R,_ = Ref(t)

    T , c_c= MatrixT(q)
    
    ax.clear()

    ax.plot3D(R[0],R[1],R[2],'xm')


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
    plt.title('t = {:.2f} s'.format(t))
    ax.set_aspect('equal', 'box')