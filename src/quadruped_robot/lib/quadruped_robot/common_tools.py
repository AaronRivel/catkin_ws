#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from quadruped_robot.common_libs import *

port_num =  PortHandler(constants.DEVICE_NAME)
packet_handler = PacketHandler(constants.PROTOCOL_VERSION)

T = 1
T0 = 1

q_dot = np.array([0            ,
               0            ,
               0     ,
               0 ,  
               0            ])



e_int = 0

Kp = 0
Kd = 0
Ki = 0

walking_flag = False
position = 'POSTERIOR_INIT'
avoid_flag = False

def get_end_efector_pos():
    global position
    return position

def set_PID(p,d,i):
    global Kp,Kd,Ki
    Kp = p
    Kd = d
    Ki = i

def get_walk_flag():
    global walking_flag
    return walking_flag

def set_walk_flag(flag):
    global walking_flag
    walking_flag = flag

def set_current_velocity(vel):
    global q_dot
    q_dot = vel

def get_current_velocity():
    global q_dot
    return q_dot

def open_port():
    if(not port_num.is_open):
        rospy.loginfo("Port open")
        PortHandler.openPort(port_num)
        PortHandler.setBaudRate(port_num,constants.BAUDRATE)
    else: 
        rospy.loginfo("Port already open")

def close_port():
    if(port_num.is_open):
        rospy.loginfo("Closing port and node")
        PortHandler.closePort(port_num)
    else:
        rospy.loginfo("Port already close")
        
def torque_off(motor_f,motor_p):
    result_1, _ = packet_handler.write1ByteTxRx(port_num,motor_f,constants.ADD_TORQUE_ENABLE,constants.TORQUE_DISABLE)
    result_2, _ = packet_handler.write1ByteTxRx(port_num,motor_p,constants.ADD_TORQUE_ENABLE,constants.TORQUE_DISABLE)
    return result_1, result_2

def torque_on(motor_f, motor_p):
    result_1, _ = packet_handler.write1ByteTxRx(port_num,motor_f,constants.ADD_TORQUE_ENABLE,constants.TORQUE_ENABLE)
    result_2, _ = packet_handler.write1ByteTxRx(port_num,motor_p,constants.ADD_TORQUE_ENABLE,constants.TORQUE_ENABLE)
    return result_1, result_2

def goal_velocity(U_f, U_p,motor_f,motor_p):
    result_1, _ = packet_handler.write4ByteTxRx(port_num,motor_f,constants.ADD_GOAL_VEL,int(U_f))
    result_2, _ = packet_handler.write4ByteTxRx(port_num,motor_p,constants.ADD_GOAL_VEL,int(U_p))
    return result_1, result_2

def read_pos(motor_f, motror_p):
    present_position_f, _, _ = packet_handler.read4ByteTxRx(port_num,motor_f, constants.ADD_PRESENT_POSTION)
    present_position_p, _, _ = packet_handler.read4ByteTxRx(port_num,motror_p, constants.ADD_PRESENT_POSTION)
    return present_position_f,present_position_p

def init_dynamixel(dxl_id):

    rospy.loginfo("--------Initializing dinamixels %d and %d----------", dxl_id[0], dxl_id[1])

    for i in range(len(dxl_id)):

        rospy.loginfo("------- Dynamixel %d ---------", dxl_id[i])

        result, error = packet_handler.write1ByteTxRx(port_num,dxl_id[i],constants.ADD_BAUDRATE,6)#6 -> 4M # 3 -> 1,000,000 bauds
        data,_,_ = packet_handler.read1ByteTxRx(port_num,dxl_id[i],constants.ADD_BAUDRATE)
        if (result == definitions.COMM_SUCCESS):
            rospy.loginfo("[ID %d] buad rate: |%d|",dxl_id[i],data)
        else:
            rospy.loginfo("FAIL [ID %d] baud rate: |%d| %s  %s",dxl_id[i],data,packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            return False


        result, error = packet_handler.write1ByteTxRx(port_num,dxl_id[i],constants.ADD_TORQUE_ENABLE, constants.TORQUE_DISABLE)
        data, _ ,_ = packet_handler.read1ByteTxRx(port_num,dxl_id[i],constants.ADD_TORQUE_ENABLE)
        if (result == definitions.COMM_SUCCESS):
            rospy.loginfo("Torque of dxl [ID %d] : |%d|",dxl_id[i],data)
        else:
            rospy.loginfo("FAIL Torque disable of dxl [ID %d] : %s  %s",dxl_id[i],packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            return False
        
        result, error = packet_handler.write1ByteTxRx(port_num,dxl_id[0],constants.ADD_DRIVE_MODE, constants.CCW)
        data, _ ,_ = packet_handler.read1ByteTxRx(port_num,dxl_id[0],constants.ADD_DRIVE_MODE)
        if (result == definitions.COMM_SUCCESS):
            rospy.loginfo("Drive mode of dxl [ID %d] : |%d|",dxl_id[0],data)
        else:
            rospy.loginfo("FAIL Drive mode of dxl [ID %d] : %s  %s",dxl_id[0],packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
            return False
        
        result, error = packet_handler.write1ByteTxRx(port_num,dxl_id[1],constants.ADD_DRIVE_MODE, constants.CW)
        data, _ ,_ = packet_handler.read1ByteTxRx(port_num,dxl_id[1],constants.ADD_DRIVE_MODE)
        if (result == definitions.COMM_SUCCESS):
            rospy.loginfo("Drive mode of dxl [ID %d] : |%d|",dxl_id[1],data)
        else:
            rospy.loginfo("FAIL Drive mode of dxl [ID %d] : %s  %s",dxl_id[1],packet_handler.getTxRxResult(result),packet_handler.getRxPacketError(error))
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
    return True

def shutdown(motor_f, motor_p):
    result_1, result_2 = goal_velocity(0,0,motor_f,motor_p)
    result_3, result_4 =torque_off(motor_f,motor_p)

    if result_4 == definitions.COMM_SUCCESS or result_3 == definitions.COMM_SUCCESS or result_2 == definitions.COMM_SUCCESS or result_1 == definitions.COMM_SUCCESS:
        return True
    else: 
        return False
    
def set_period_ref(period):
    global T, T0
    T0 = T
    T = period

def get_period():
    global T, T0
    return T,T0

def Ref0(t):
    T, T0= get_period()

    a = 5
    b = 2

    ref1 = np.array([a*np.sin((t*2*np.pi)/T - np.pi/2)  , b*np.cos((t*2*np.pi)/T -np.pi/2) - 15 , 0])
    vel_ref = np.array([np.pi*a*np.cos((t*2*np.pi)/T )*((2*np.pi)/T) ,  -np.pi*b*np.sin((t*2*np.pi)/T)*((2*np.pi)/T) , 0])
    #ref0 = np.array([a*np.sin((t*2*np.pi)/T0 - phi0 )  , b*np.cos((t*2*np.pi)/T0 - phi0) - 15 , 0])
    
    return ref1, vel_ref

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

def f(t,q,dt):
    global Kp, Kd, Ki

    J , Pe = jacobian(q)
    R,Rv=Ref(t)
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
    global q_dot
    e_dot = Rv - np.dot(J[:3, :], q_dot)

    global e_int
    e_int = e_int + e*dt

    # Control input (PD control + feedforward velocity)
    u = np.dot(np.linalg.pinv(J[:3, :]), Kp * e + Kd * e_dot + Ki * e_int + Rv)
    #u = u if np.linalg.norm(u)<20 else 20*u/np.linalg.norm(u)
    return u

def rk4(y0, t, h):

    k1 = f(t, y0,h)
    k2 = f(t + 0.5*h, y0 + 0.5*k1*h,h)
    k3 = f(t + 0.5*h, y0 + 0.5*k2*h,h)
    k4 = f(t + h, y0 + k3*h,h)
    y1 = y0 + h*(k1 + 2*k2 + 2*k3 + k4)/6

    return y1, (k1 + 2*k2 + 2*k3 + k4)/6

def animation(t,q0,ax,esc):

    q = np.array([0,0,q0[0],q0[1],0])
    R,_ = Ref(t)

    T , c_c= MatrixT(q)
    
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




POINTS = 30

def SPL_Coef(x,y):
        global C
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
        A[4*n-2,0:2]=np.array([6*x[0],2])
        A[4*n-1,4*n-4:4*n-2]=np.array([6*x[n],2])
        q = np.dot(np.linalg.inv(A),b)
        C=[]#coeficientes 
        for k in range(len(x)-1):
            C.append(q[4*k:4*k+4])
        return C   

def spline_control(C,xx):
    k = round(xx)
    if (k < len(C)):
        yy =(C[k][0]*np.power(xx,3)+C[k][1]*np.power(xx,2)+C[k][2]*xx+C[k][3])
        vy = (C[k][0]*3*np.power(xx,2)+C[k][1]*2*np.power(xx,1)+C[k][2]) 
    else:
        yy =(C[len(C)-1][0]*np.power(xx,3)+C[len(C)-1][1]*np.power(xx,2)+C[len(C)-1][2]*xx+C[len(C)-1][3])
        vy = (C[len(C)-1][0]*3*np.power(xx,2)+C[len(C)-1][1]*2*np.power(xx,1)+C[len(C)-1][2]) 
    return yy , vy


def Ref(t):
    global position
    t = t*T

    if(round(t) >= 0 and round(t) < POINTS):
        position = 'POSTERIOR_INIT'

    if(round(t) > POINTS*2):
        t = POINTS*2 + 1
        position = 'POSTERIOR_FINISH'

    if(round(t) >= POINTS and round(t) < POINTS*2):
        position = 'FRONTAL'

    x, vx = spline_control(C_x, t)
    y, vy = spline_control(C_y, t)

    ref = np.array([x,y,0])
    vel_ref = np.array([vx, vy, 0])

    return ref, vel_ref

def half_elipse(a,b):
    global C_x, C_y

    l = np.linspace(0,POINTS*2,POINTS*2)

    ls = np.linspace(-np.pi/2, np.pi/2,POINTS)

    x = np.zeros(POINTS*2)
    x = np.concatenate((a*np.sin(ls), np.linspace(a, -a, POINTS)))

    y = np.zeros(POINTS*2)
    y = np.concatenate((b*np.cos(ls) - 15,np.zeros(POINTS) -15 ))

    C_x = SPL_Coef(l, x)
    C_y = SPL_Coef(l, y)
