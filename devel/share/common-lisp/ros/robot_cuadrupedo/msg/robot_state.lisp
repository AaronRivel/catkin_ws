; Auto-generated. Do not edit!


(cl:in-package robot_cuadrupedo-msg)


;//! \htmlinclude robot_state.msg.html

(cl:defclass <robot_state> (roslisp-msg-protocol:ros-message)
  ((rc
    :reader rc
    :initarg :rc
    :type robot_cuadrupedo_msgs-msg:robot_velocity
    :initform (cl:make-instance 'robot_cuadrupedo_msgs-msg:robot_velocity)))
)

(cl:defclass robot_state (<robot_state>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <robot_state>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'robot_state)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name robot_cuadrupedo-msg:<robot_state> is deprecated: use robot_cuadrupedo-msg:robot_state instead.")))

(cl:ensure-generic-function 'rc-val :lambda-list '(m))
(cl:defmethod rc-val ((m <robot_state>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robot_cuadrupedo-msg:rc-val is deprecated.  Use robot_cuadrupedo-msg:rc instead.")
  (rc m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <robot_state>) ostream)
  "Serializes a message object of type '<robot_state>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'rc) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <robot_state>) istream)
  "Deserializes a message object of type '<robot_state>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'rc) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<robot_state>)))
  "Returns string type for a message object of type '<robot_state>"
  "robot_cuadrupedo/robot_state")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'robot_state)))
  "Returns string type for a message object of type 'robot_state"
  "robot_cuadrupedo/robot_state")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<robot_state>)))
  "Returns md5sum for a message object of type '<robot_state>"
  "4aab73bea9dabf128c8c483534d2bbfe")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'robot_state)))
  "Returns md5sum for a message object of type 'robot_state"
  "4aab73bea9dabf128c8c483534d2bbfe")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<robot_state>)))
  "Returns full string definition for message of type '<robot_state>"
  (cl:format cl:nil "robot_cuadrupedo_msgs/robot_velocity rc~%================================================================================~%MSG: robot_cuadrupedo_msgs/robot_velocity~%bool walk~%float64 velocity~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'robot_state)))
  "Returns full string definition for message of type 'robot_state"
  (cl:format cl:nil "robot_cuadrupedo_msgs/robot_velocity rc~%================================================================================~%MSG: robot_cuadrupedo_msgs/robot_velocity~%bool walk~%float64 velocity~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <robot_state>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'rc))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <robot_state>))
  "Converts a ROS message object to a list"
  (cl:list 'robot_state
    (cl:cons ':rc (rc msg))
))
