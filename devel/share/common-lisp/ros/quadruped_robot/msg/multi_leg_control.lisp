; Auto-generated. Do not edit!


(cl:in-package quadruped_robot-msg)


;//! \htmlinclude multi_leg_control.msg.html

(cl:defclass <multi_leg_control> (roslisp-msg-protocol:ros-message)
  ((tf
    :reader tf
    :initarg :tf
    :type cl:float
    :initform 0.0)
   (way
    :reader way
    :initarg :way
    :type cl:integer
    :initform 0)
   (walk_flag
    :reader walk_flag
    :initarg :walk_flag
    :type cl:boolean
    :initform cl:nil)
   (L1
    :reader L1
    :initarg :L1
    :type quadruped_robot-msg:leg_state
    :initform (cl:make-instance 'quadruped_robot-msg:leg_state))
   (L2
    :reader L2
    :initarg :L2
    :type quadruped_robot-msg:leg_state
    :initform (cl:make-instance 'quadruped_robot-msg:leg_state))
   (L3
    :reader L3
    :initarg :L3
    :type quadruped_robot-msg:leg_state
    :initform (cl:make-instance 'quadruped_robot-msg:leg_state))
   (L4
    :reader L4
    :initarg :L4
    :type quadruped_robot-msg:leg_state
    :initform (cl:make-instance 'quadruped_robot-msg:leg_state)))
)

(cl:defclass multi_leg_control (<multi_leg_control>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <multi_leg_control>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'multi_leg_control)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name quadruped_robot-msg:<multi_leg_control> is deprecated: use quadruped_robot-msg:multi_leg_control instead.")))

(cl:ensure-generic-function 'tf-val :lambda-list '(m))
(cl:defmethod tf-val ((m <multi_leg_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-msg:tf-val is deprecated.  Use quadruped_robot-msg:tf instead.")
  (tf m))

(cl:ensure-generic-function 'way-val :lambda-list '(m))
(cl:defmethod way-val ((m <multi_leg_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-msg:way-val is deprecated.  Use quadruped_robot-msg:way instead.")
  (way m))

(cl:ensure-generic-function 'walk_flag-val :lambda-list '(m))
(cl:defmethod walk_flag-val ((m <multi_leg_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-msg:walk_flag-val is deprecated.  Use quadruped_robot-msg:walk_flag instead.")
  (walk_flag m))

(cl:ensure-generic-function 'L1-val :lambda-list '(m))
(cl:defmethod L1-val ((m <multi_leg_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-msg:L1-val is deprecated.  Use quadruped_robot-msg:L1 instead.")
  (L1 m))

(cl:ensure-generic-function 'L2-val :lambda-list '(m))
(cl:defmethod L2-val ((m <multi_leg_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-msg:L2-val is deprecated.  Use quadruped_robot-msg:L2 instead.")
  (L2 m))

(cl:ensure-generic-function 'L3-val :lambda-list '(m))
(cl:defmethod L3-val ((m <multi_leg_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-msg:L3-val is deprecated.  Use quadruped_robot-msg:L3 instead.")
  (L3 m))

(cl:ensure-generic-function 'L4-val :lambda-list '(m))
(cl:defmethod L4-val ((m <multi_leg_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-msg:L4-val is deprecated.  Use quadruped_robot-msg:L4 instead.")
  (L4 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <multi_leg_control>) ostream)
  "Serializes a message object of type '<multi_leg_control>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'tf))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'way)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'walk_flag) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'L1) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'L2) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'L3) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'L4) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <multi_leg_control>) istream)
  "Deserializes a message object of type '<multi_leg_control>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tf) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'way) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:slot-value msg 'walk_flag) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'L1) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'L2) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'L3) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'L4) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<multi_leg_control>)))
  "Returns string type for a message object of type '<multi_leg_control>"
  "quadruped_robot/multi_leg_control")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'multi_leg_control)))
  "Returns string type for a message object of type 'multi_leg_control"
  "quadruped_robot/multi_leg_control")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<multi_leg_control>)))
  "Returns md5sum for a message object of type '<multi_leg_control>"
  "77ad88901f4769ea15e1a5ba430126d8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'multi_leg_control)))
  "Returns md5sum for a message object of type 'multi_leg_control"
  "77ad88901f4769ea15e1a5ba430126d8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<multi_leg_control>)))
  "Returns full string definition for message of type '<multi_leg_control>"
  (cl:format cl:nil "float64 tf~%int64 way~%bool walk_flag~%leg_state L1~%leg_state L2~%leg_state L3~%leg_state L4~%================================================================================~%MSG: quadruped_robot/leg_state~%float64 t~%float64 q0~%float64 q1~%string gate~%bool finish~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'multi_leg_control)))
  "Returns full string definition for message of type 'multi_leg_control"
  (cl:format cl:nil "float64 tf~%int64 way~%bool walk_flag~%leg_state L1~%leg_state L2~%leg_state L3~%leg_state L4~%================================================================================~%MSG: quadruped_robot/leg_state~%float64 t~%float64 q0~%float64 q1~%string gate~%bool finish~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <multi_leg_control>))
  (cl:+ 0
     8
     8
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'L1))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'L2))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'L3))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'L4))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <multi_leg_control>))
  "Converts a ROS message object to a list"
  (cl:list 'multi_leg_control
    (cl:cons ':tf (tf msg))
    (cl:cons ':way (way msg))
    (cl:cons ':walk_flag (walk_flag msg))
    (cl:cons ':L1 (L1 msg))
    (cl:cons ':L2 (L2 msg))
    (cl:cons ':L3 (L3 msg))
    (cl:cons ':L4 (L4 msg))
))
