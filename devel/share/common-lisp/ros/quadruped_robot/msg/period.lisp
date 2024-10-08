; Auto-generated. Do not edit!


(cl:in-package quadruped_robot-msg)


;//! \htmlinclude period.msg.html

(cl:defclass <period> (roslisp-msg-protocol:ros-message)
  ((T
    :reader T
    :initarg :T
    :type cl:float
    :initform 0.0))
)

(cl:defclass period (<period>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <period>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'period)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name quadruped_robot-msg:<period> is deprecated: use quadruped_robot-msg:period instead.")))

(cl:ensure-generic-function 'T-val :lambda-list '(m))
(cl:defmethod T-val ((m <period>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-msg:T-val is deprecated.  Use quadruped_robot-msg:T instead.")
  (T m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <period>) ostream)
  "Serializes a message object of type '<period>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'T))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <period>) istream)
  "Deserializes a message object of type '<period>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'T) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<period>)))
  "Returns string type for a message object of type '<period>"
  "quadruped_robot/period")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'period)))
  "Returns string type for a message object of type 'period"
  "quadruped_robot/period")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<period>)))
  "Returns md5sum for a message object of type '<period>"
  "df792c00269de90b579eb8eab6fc9c54")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'period)))
  "Returns md5sum for a message object of type 'period"
  "df792c00269de90b579eb8eab6fc9c54")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<period>)))
  "Returns full string definition for message of type '<period>"
  (cl:format cl:nil "float64 T~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'period)))
  "Returns full string definition for message of type 'period"
  (cl:format cl:nil "float64 T~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <period>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <period>))
  "Converts a ROS message object to a list"
  (cl:list 'period
    (cl:cons ':T (T msg))
))
