from quadruped_robot.common_libs import rospy, write_dxl, write_dxlResponse, read_dxl, read_dxlResponse, definitions, th
from quadruped_robot.common_tools import DynamixelControllerProtocol1, DynamixelControllerProtocol2

DXL_2 = DynamixelControllerProtocol2()
DXL_1 = DynamixelControllerProtocol1()

service_lock = th.Lock()

shutdown_flag = False

def write_callback(req):
    with service_lock:
        if req.protocol_version == 1:
            DXL = DXL_1
        if req.protocol_version == 2:
            DXL = DXL_2

        action  = req.action
        f = req.motor_f
        p = req.motor_p
        data_f = req.data_f
        data_p = req.data_p

        if action == 'open_port':
            DXL.open_port()
            result = True
            return write_dxlResponse(result)
        
        if action == 'close_port':
            DXL.close_port()
            result = True
            return write_dxlResponse(result)

        if action == 'torque_on':
            result_1, result_2 = DXL.torque_on(f,p)
            if(result_1 == definitions.COMM_SUCCESS and result_2 == definitions.COMM_SUCCESS):
                result = True
            else:
                result = False

            return write_dxlResponse(result)
        
        if action == 'torque_off':
            result_1, result_2 = DXL.torque_off(f,p)
            if(result_1 == definitions.COMM_SUCCESS and result_2 == definitions.COMM_SUCCESS):
                result = True
            else:
                result = False
                
            return write_dxlResponse(result)
        
        if action == 'goal_velocity':
            result_1, result_2 = DXL.goal_velocity(data_f, data_p, f,p)
            if(result_1 == definitions.COMM_SUCCESS and result_2 == definitions.COMM_SUCCESS):
                result = True
            else:
                result = False
                
            return write_dxlResponse(result)
        
        if action == 'goal_position':
            result_1, result_2 = DXL.goal_position(data_f, data_p, f,p)
            if(result_1 == definitions.COMM_SUCCESS and result_2 == definitions.COMM_SUCCESS):
                result = True
            else:
                result = False
                
            return write_dxlResponse(result)
        
        if (action == 'init_dynamixel'):
            result_1 = DXL.init_dynamixel([f,p])
            if(result_1 ):
                result = True
            else:
                result = False
                
            return write_dxlResponse(result)
        
        if (action == 'shutdown'):
            result_1 = DXL.shutdown(f,p)
            if(result_1):
                result = True
            else:
                result = False
                
            return write_dxlResponse(result)
        
        if (action == 'shutdown_all'):
            global shutdown_flag
            shutdown_flag = True
            LEG_1_F = rospy.get_param('/leg_1/LEG_F')
            LEG_1_P = rospy.get_param('/leg_1/LEG_P')
            #LEG_2_F = rospy.get_param('/leg_2/LEG_F')
            #LEG_2_P = rospy.get_param('/leg_2/LEG_P')
            LEG_4_F = rospy.get_param('/leg_4/LEG_F')
            LEG_4_P = rospy.get_param('/leg_4/LEG_P')
            LEG_3_F = rospy.get_param('/leg_3/LEG_F')
            LEG_3_P = rospy.get_param('/leg_3/LEG_P')
            r1 = DXL.shutdown(LEG_1_F,LEG_1_P)
            #r2 = DXL.shutdown(LEG_2_F,LEG_2_P)
            r3 = DXL.shutdown(LEG_4_F,LEG_4_P)
            r4 = DXL.shutdown(LEG_3_F,LEG_3_P)
            result = all([r1,
                        r3,
                        r4])
                    
            return write_dxlResponse(result)
        
        result = False
        return write_dxlResponse(result)
    
def read_callback(req):
    with service_lock:
        if req.protocol_version == 1:
            DXL = DXL_1
        if req.protocol_version == 2:
            DXL = DXL_2

        action  = req.action
        p = req.motor_p
        f = req.motor_f

        if action == 'read_position':
            result_1, result_2 = DXL.read_pos(f,p)
            return read_dxlResponse(result_1, result_2)
        
        if (action == 'shutdown_flag'):
            global shutdown_flag
            result = shutdown_flag
            return read_dxlResponse(result,0)

def main():

    rospy.init_node('service_controler')
    rospy.loginfo("Initializing services")

    DXL_1.open_port()
    DXL_2.open_port()

    write_dxl_service = rospy.Service('/write_dxl', write_dxl, write_callback)
    read_dxl_service = rospy.Service('/read_dxl', read_dxl, read_callback)

    rospy.spin()

if __name__ == "__main__":
    main()