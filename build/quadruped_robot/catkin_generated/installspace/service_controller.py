from quadruped_robot.common_libs import rospy, write_dxl, write_dxlResponse, read_dxl, read_dxlResponse, definitions, th
from quadruped_robot.common_tools import torque_on, torque_off, goal_velocity, read_pos, init_dynamixel, shutdown, open_port, close_port

service_lock = th.Lock()

shutdown_flag = False

def write_callback(req):
    with service_lock:
        action  = req.action
        f = req.motor_f
        p = req.motor_p
        data_f = req.data_f
        data_p = req.data_p

        if action == 'open_port':
            open_port()
            result = True
            return write_dxlResponse(result)
        
        if action == 'close_port':
            close_port()
            result = True
            return write_dxlResponse(result)

        if action == 'torque_on':
            result_1, result_2 = torque_on(f,p)
            if(result_1 == definitions.COMM_SUCCESS and result_2 == definitions.COMM_SUCCESS):
                result = True
            else:
                result = False

            return write_dxlResponse(result)
        
        if action == 'torque_off':
            result_1, result_2 = torque_off(f,p)
            if(result_1 == definitions.COMM_SUCCESS and result_2 == definitions.COMM_SUCCESS):
                result = True
            else:
                result = False
                
            return write_dxlResponse(result)
        
        if action == 'goal_velocity':
            result_1, result_2 = goal_velocity(data_f, data_p, f,p)
            if(result_1 == definitions.COMM_SUCCESS and result_2 == definitions.COMM_SUCCESS):
                result = True
            else:
                result = False
                
            return write_dxlResponse(result)
        
        if (action == 'init_dynamixel'):
            result_1 = init_dynamixel([f,p])
            if(result_1 ):
                result = True
            else:
                result = False
                
            return write_dxlResponse(result)
        
        if (action == 'shutdown'):
            result_1 = shutdown(f,p)
            if(result_1):
                result = True
            else:
                result = False
                
            return write_dxlResponse(result)
        
        if (action == 'shutdown_all'):
            shutdown_flag = True
            LEG_1_F = rospy.get_param('/leg_1/LEG_F')
            LEG_1_P = rospy.get_param('/leg_1/LEG_P')
            LEG_4_F = rospy.get_param('/leg_4/LEG_F')
            LEG_4_P = rospy.get_param('/leg_4/LEG_P')
            LEG_3_F = rospy.get_param('/leg_3/LEG_F')
            LEG_3_P = rospy.get_param('/leg_3/LEG_P')
            
            result_1 = shutdown(LEG_1_F,LEG_1_P)
            result_1 = shutdown(LEG_4_F,LEG_4_P)
            result_1 = shutdown(LEG_3_F,LEG_3_P)
        
            if(result_1):
                result = True
            else:
                result = False
                    
            return write_dxlResponse(result)
        
        result = False
        return write_dxlResponse(result)
    
def read_callback(req):
    with service_lock:
        action  = req.action
        p = req.motor_p
        f = req.motor_f

        if action == 'read_position':
            result_1, result_2 = read_pos(f,p)
            return read_dxlResponse(result_1, result_2)
        
        if (action == 'shutdown_flag'):
            result = shutdown_flag
            return read_dxlResponse(result,0)

def main():

    rospy.init_node('service_controler')
    rospy.loginfo("Initializing services")

    open_port()

    write_dxl_service = rospy.Service('/write_dxl', write_dxl, write_callback)
    read_dxl_service = rospy.Service('/read_dxl', read_dxl, read_callback)

    rospy.spin()

if __name__ == "__main__":
    main()