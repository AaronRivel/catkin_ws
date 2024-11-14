from quadruped_robot.common_libs import rospy, write_dxl, write_dxlResponse, read_dxl, read_dxlResponse, definitions
from quadruped_robot.common_tools import torque_on, torque_off, goal_velocity, read_pos, init_dynamixel, shutdown, open_port, close_port

def write_callback(req):

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
    
    result = False
    return write_dxlResponse(result)
    
def read_callback(req):
    action  = req.action
    p = req.motor_p
    f = req.motor_f

    if action == 'read_position':
        result_1, result_2 = read_pos(f,p)
        return read_dxlResponse(result_1, result_2)

def main():

    rospy.init_node('service_controler')
    rospy.loginfo("Initializing services")

    write_dxl_service = rospy.Service('/write_dxl', write_dxl, write_callback)
    read_dxl_service = rospy.Service('/read_dxl', read_dxl, read_callback)

    rospy.spin()

if __name__ == "__main__":
    main()