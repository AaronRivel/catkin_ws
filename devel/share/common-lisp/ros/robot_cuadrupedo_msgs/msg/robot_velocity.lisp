; Auto-generated. Do not edit!


(cl:in-package robot_cuadrupedo_msgs-msg)


;//! \htmlinclude robot_velocity.msg.html

(cl:defclass <robot_velocity> (roslisp-msg-protocol:ros-message)
  ((walk
    :reader walk
    :initarg :walk
    :type cl:boolean
    :initform cl:nil)
   (velocity
    :reader velocity
    :initarg :velocity
    :type cl:float
    :initform 0.0))
)

(cl:defclass robot_velocity (<robot_velocity>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <robot_velocity>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'robot_velocity)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name robot_cuadrupedo_msgs-msg:<robot_velocity> is deprecated: use robot_cuadrupedo_msgs-msg:robot_velocity instead.")))

(cl:ensure-generic-function 'walk-val :lambda-list '(m))
(cl:defmethod walk-val ((m <robot_velocity>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robot_cuadrupedo_msgs-msg:walk-val is deprecated.  Use robot_cuadrupedo_msgs-msg:walk instead.")
  (walk m))

(cl:ensure-generic-function 'velocity-val :lambda-list '(m))
(cl:defmethod velocity-val ((m <robot_velocity>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robot_cuadrupedo_msgs-msg:velocity-val is deprecated.  Use robot_cuadrupedo_msgs-msg:velocity instead.")
  (velocity m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <robot_velocity>) ostream)
  "Serializes a message object of type '<robot_velocity>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'walk) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'velocity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <robot_velocity>) istream)
  "Deserializes a message object of type '<robot_velocity>"
    (cl:setf (cl:slot-value msg 'walk) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'velocity) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<robot_velocity>)))
  "Returns string type for a message object of type '<robot_velocity>"
  "robot_cuadrupedo_msgs/robot_velocity")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'robot_velocity)))
  "Returns string type for a message object of type 'robot_velocity"
  "robot_cuadrupedo_msgs/robot_velocity")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<robot_velocity>)))
  "Returns md5sum for a message object of type '<robot_velocity>"
  "8bed2b6d4486708eb51d1d25b9ec31fb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'robot_velocity)))
  "Returns md5sum for a message object of type 'robot_velocity"
  "8bed2b6d4486708eb51d1d25b9ec31fb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<robot_velocity>)))
  "Returns full string definition for message of type '<robot_velocity>"
  (cl:format cl:nil "bool walk~%float64 velocity~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'robot_velocity)))
  "Returns full string definition for message of type 'robot_velocity"
  (cl:format cl:nil "bool walk~%float64 velocity~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <robot_velocity>))
  (cl:+ 0
     1
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <robot_velocity>))
  "Converts a ROS message object to a list"
  (cl:list 'robot_velocity
    (cl:cons ':walk (walk msg))
    (cl:cons ':velocity (velocity msg))
))
