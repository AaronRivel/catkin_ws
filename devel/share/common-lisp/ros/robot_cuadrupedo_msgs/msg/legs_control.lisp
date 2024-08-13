; Auto-generated. Do not edit!


(cl:in-package robot_cuadrupedo_msgs-msg)


;//! \htmlinclude legs_control.msg.html

(cl:defclass <legs_control> (roslisp-msg-protocol:ros-message)
  ((frontal_motor
    :reader frontal_motor
    :initarg :frontal_motor
    :type cl:float
    :initform 0.0)
   (posterior_motor
    :reader posterior_motor
    :initarg :posterior_motor
    :type cl:float
    :initform 0.0)
   (walk
    :reader walk
    :initarg :walk
    :type cl:boolean
    :initform cl:nil)
   (goal_position_feedback
    :reader goal_position_feedback
    :initarg :goal_position_feedback
    :type cl:boolean
    :initform cl:nil)
   (id_f
    :reader id_f
    :initarg :id_f
    :type cl:integer
    :initform 0)
   (id_p
    :reader id_p
    :initarg :id_p
    :type cl:integer
    :initform 0))
)

(cl:defclass legs_control (<legs_control>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <legs_control>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'legs_control)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name robot_cuadrupedo_msgs-msg:<legs_control> is deprecated: use robot_cuadrupedo_msgs-msg:legs_control instead.")))

(cl:ensure-generic-function 'frontal_motor-val :lambda-list '(m))
(cl:defmethod frontal_motor-val ((m <legs_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robot_cuadrupedo_msgs-msg:frontal_motor-val is deprecated.  Use robot_cuadrupedo_msgs-msg:frontal_motor instead.")
  (frontal_motor m))

(cl:ensure-generic-function 'posterior_motor-val :lambda-list '(m))
(cl:defmethod posterior_motor-val ((m <legs_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robot_cuadrupedo_msgs-msg:posterior_motor-val is deprecated.  Use robot_cuadrupedo_msgs-msg:posterior_motor instead.")
  (posterior_motor m))

(cl:ensure-generic-function 'walk-val :lambda-list '(m))
(cl:defmethod walk-val ((m <legs_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robot_cuadrupedo_msgs-msg:walk-val is deprecated.  Use robot_cuadrupedo_msgs-msg:walk instead.")
  (walk m))

(cl:ensure-generic-function 'goal_position_feedback-val :lambda-list '(m))
(cl:defmethod goal_position_feedback-val ((m <legs_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robot_cuadrupedo_msgs-msg:goal_position_feedback-val is deprecated.  Use robot_cuadrupedo_msgs-msg:goal_position_feedback instead.")
  (goal_position_feedback m))

(cl:ensure-generic-function 'id_f-val :lambda-list '(m))
(cl:defmethod id_f-val ((m <legs_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robot_cuadrupedo_msgs-msg:id_f-val is deprecated.  Use robot_cuadrupedo_msgs-msg:id_f instead.")
  (id_f m))

(cl:ensure-generic-function 'id_p-val :lambda-list '(m))
(cl:defmethod id_p-val ((m <legs_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robot_cuadrupedo_msgs-msg:id_p-val is deprecated.  Use robot_cuadrupedo_msgs-msg:id_p instead.")
  (id_p m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <legs_control>) ostream)
  "Serializes a message object of type '<legs_control>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'frontal_motor))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'posterior_motor))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'walk) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'goal_position_feedback) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'id_f)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'id_p)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <legs_control>) istream)
  "Deserializes a message object of type '<legs_control>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'frontal_motor) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'posterior_motor) (roslisp-utils:decode-double-float-bits bits)))
    (cl:setf (cl:slot-value msg 'walk) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'goal_position_feedback) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id_f) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id_p) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<legs_control>)))
  "Returns string type for a message object of type '<legs_control>"
  "robot_cuadrupedo_msgs/legs_control")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'legs_control)))
  "Returns string type for a message object of type 'legs_control"
  "robot_cuadrupedo_msgs/legs_control")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<legs_control>)))
  "Returns md5sum for a message object of type '<legs_control>"
  "889997f071d49233501da79c98b3e3ac")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'legs_control)))
  "Returns md5sum for a message object of type 'legs_control"
  "889997f071d49233501da79c98b3e3ac")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<legs_control>)))
  "Returns full string definition for message of type '<legs_control>"
  (cl:format cl:nil "float64 frontal_motor~%float64 posterior_motor~%bool walk~%bool goal_position_feedback~%int64 id_f~%int64 id_p~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'legs_control)))
  "Returns full string definition for message of type 'legs_control"
  (cl:format cl:nil "float64 frontal_motor~%float64 posterior_motor~%bool walk~%bool goal_position_feedback~%int64 id_f~%int64 id_p~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <legs_control>))
  (cl:+ 0
     8
     8
     1
     1
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <legs_control>))
  "Converts a ROS message object to a list"
  (cl:list 'legs_control
    (cl:cons ':frontal_motor (frontal_motor msg))
    (cl:cons ':posterior_motor (posterior_motor msg))
    (cl:cons ':walk (walk msg))
    (cl:cons ':goal_position_feedback (goal_position_feedback msg))
    (cl:cons ':id_f (id_f msg))
    (cl:cons ':id_p (id_p msg))
))
