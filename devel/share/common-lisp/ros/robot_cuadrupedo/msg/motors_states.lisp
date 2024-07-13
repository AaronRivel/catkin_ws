; Auto-generated. Do not edit!


(cl:in-package robot_cuadrupedo-msg)


;//! \htmlinclude motors_states.msg.html

(cl:defclass <motors_states> (roslisp-msg-protocol:ros-message)
  ((leg1
    :reader leg1
    :initarg :leg1
    :type robot_cuadrupedo_msgs-msg:legs_control
    :initform (cl:make-instance 'robot_cuadrupedo_msgs-msg:legs_control))
   (leg2
    :reader leg2
    :initarg :leg2
    :type robot_cuadrupedo_msgs-msg:legs_control
    :initform (cl:make-instance 'robot_cuadrupedo_msgs-msg:legs_control))
   (leg3
    :reader leg3
    :initarg :leg3
    :type robot_cuadrupedo_msgs-msg:legs_control
    :initform (cl:make-instance 'robot_cuadrupedo_msgs-msg:legs_control))
   (leg4
    :reader leg4
    :initarg :leg4
    :type robot_cuadrupedo_msgs-msg:legs_control
    :initform (cl:make-instance 'robot_cuadrupedo_msgs-msg:legs_control)))
)

(cl:defclass motors_states (<motors_states>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <motors_states>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'motors_states)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name robot_cuadrupedo-msg:<motors_states> is deprecated: use robot_cuadrupedo-msg:motors_states instead.")))

(cl:ensure-generic-function 'leg1-val :lambda-list '(m))
(cl:defmethod leg1-val ((m <motors_states>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robot_cuadrupedo-msg:leg1-val is deprecated.  Use robot_cuadrupedo-msg:leg1 instead.")
  (leg1 m))

(cl:ensure-generic-function 'leg2-val :lambda-list '(m))
(cl:defmethod leg2-val ((m <motors_states>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robot_cuadrupedo-msg:leg2-val is deprecated.  Use robot_cuadrupedo-msg:leg2 instead.")
  (leg2 m))

(cl:ensure-generic-function 'leg3-val :lambda-list '(m))
(cl:defmethod leg3-val ((m <motors_states>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robot_cuadrupedo-msg:leg3-val is deprecated.  Use robot_cuadrupedo-msg:leg3 instead.")
  (leg3 m))

(cl:ensure-generic-function 'leg4-val :lambda-list '(m))
(cl:defmethod leg4-val ((m <motors_states>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robot_cuadrupedo-msg:leg4-val is deprecated.  Use robot_cuadrupedo-msg:leg4 instead.")
  (leg4 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <motors_states>) ostream)
  "Serializes a message object of type '<motors_states>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'leg1) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'leg2) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'leg3) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'leg4) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <motors_states>) istream)
  "Deserializes a message object of type '<motors_states>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'leg1) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'leg2) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'leg3) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'leg4) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<motors_states>)))
  "Returns string type for a message object of type '<motors_states>"
  "robot_cuadrupedo/motors_states")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'motors_states)))
  "Returns string type for a message object of type 'motors_states"
  "robot_cuadrupedo/motors_states")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<motors_states>)))
  "Returns md5sum for a message object of type '<motors_states>"
  "c6779dc7494c3c55386a9358df1a0c6a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'motors_states)))
  "Returns md5sum for a message object of type 'motors_states"
  "c6779dc7494c3c55386a9358df1a0c6a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<motors_states>)))
  "Returns full string definition for message of type '<motors_states>"
  (cl:format cl:nil "robot_cuadrupedo_msgs/legs_control leg1~%~%robot_cuadrupedo_msgs/legs_control leg2~%~%robot_cuadrupedo_msgs/legs_control leg3~%~%robot_cuadrupedo_msgs/legs_control leg4~%================================================================================~%MSG: robot_cuadrupedo_msgs/legs_control~%float64 frontal_motor~%float64 posterior_motor~%bool walk~%bool goal_position_feedback~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'motors_states)))
  "Returns full string definition for message of type 'motors_states"
  (cl:format cl:nil "robot_cuadrupedo_msgs/legs_control leg1~%~%robot_cuadrupedo_msgs/legs_control leg2~%~%robot_cuadrupedo_msgs/legs_control leg3~%~%robot_cuadrupedo_msgs/legs_control leg4~%================================================================================~%MSG: robot_cuadrupedo_msgs/legs_control~%float64 frontal_motor~%float64 posterior_motor~%bool walk~%bool goal_position_feedback~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <motors_states>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'leg1))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'leg2))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'leg3))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'leg4))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <motors_states>))
  "Converts a ROS message object to a list"
  (cl:list 'motors_states
    (cl:cons ':leg1 (leg1 msg))
    (cl:cons ':leg2 (leg2 msg))
    (cl:cons ':leg3 (leg3 msg))
    (cl:cons ':leg4 (leg4 msg))
))
