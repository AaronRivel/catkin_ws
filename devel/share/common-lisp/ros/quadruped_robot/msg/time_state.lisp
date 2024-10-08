; Auto-generated. Do not edit!


(cl:in-package quadruped_robot-msg)


;//! \htmlinclude time_state.msg.html

(cl:defclass <time_state> (roslisp-msg-protocol:ros-message)
  ((t
    :reader t
    :initarg :t
    :type cl:float
    :initform 0.0)
   (q0
    :reader q0
    :initarg :q0
    :type cl:float
    :initform 0.0)
   (q1
    :reader q1
    :initarg :q1
    :type cl:float
    :initform 0.0)
   (q0_dot
    :reader q0_dot
    :initarg :q0_dot
    :type cl:float
    :initform 0.0)
   (q1_dot
    :reader q1_dot
    :initarg :q1_dot
    :type cl:float
    :initform 0.0))
)

(cl:defclass time_state (<time_state>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <time_state>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'time_state)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name quadruped_robot-msg:<time_state> is deprecated: use quadruped_robot-msg:time_state instead.")))

(cl:ensure-generic-function 't-val :lambda-list '(m))
(cl:defmethod t-val ((m <time_state>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-msg:t-val is deprecated.  Use quadruped_robot-msg:t instead.")
  (t m))

(cl:ensure-generic-function 'q0-val :lambda-list '(m))
(cl:defmethod q0-val ((m <time_state>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-msg:q0-val is deprecated.  Use quadruped_robot-msg:q0 instead.")
  (q0 m))

(cl:ensure-generic-function 'q1-val :lambda-list '(m))
(cl:defmethod q1-val ((m <time_state>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-msg:q1-val is deprecated.  Use quadruped_robot-msg:q1 instead.")
  (q1 m))

(cl:ensure-generic-function 'q0_dot-val :lambda-list '(m))
(cl:defmethod q0_dot-val ((m <time_state>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-msg:q0_dot-val is deprecated.  Use quadruped_robot-msg:q0_dot instead.")
  (q0_dot m))

(cl:ensure-generic-function 'q1_dot-val :lambda-list '(m))
(cl:defmethod q1_dot-val ((m <time_state>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-msg:q1_dot-val is deprecated.  Use quadruped_robot-msg:q1_dot instead.")
  (q1_dot m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <time_state>) ostream)
  "Serializes a message object of type '<time_state>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 't))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'q0))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'q1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'q0_dot))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'q1_dot))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <time_state>) istream)
  "Deserializes a message object of type '<time_state>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 't) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'q0) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'q1) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'q0_dot) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'q1_dot) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<time_state>)))
  "Returns string type for a message object of type '<time_state>"
  "quadruped_robot/time_state")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'time_state)))
  "Returns string type for a message object of type 'time_state"
  "quadruped_robot/time_state")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<time_state>)))
  "Returns md5sum for a message object of type '<time_state>"
  "fdf95eab8e31bbe478f129be831ec16a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'time_state)))
  "Returns md5sum for a message object of type 'time_state"
  "fdf95eab8e31bbe478f129be831ec16a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<time_state>)))
  "Returns full string definition for message of type '<time_state>"
  (cl:format cl:nil "float64 t~%float64 q0~%float64 q1~%float64 q0_dot~%float64 q1_dot~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'time_state)))
  "Returns full string definition for message of type 'time_state"
  (cl:format cl:nil "float64 t~%float64 q0~%float64 q1~%float64 q0_dot~%float64 q1_dot~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <time_state>))
  (cl:+ 0
     8
     8
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <time_state>))
  "Converts a ROS message object to a list"
  (cl:list 'time_state
    (cl:cons ':t (t msg))
    (cl:cons ':q0 (q0 msg))
    (cl:cons ':q1 (q1 msg))
    (cl:cons ':q0_dot (q0_dot msg))
    (cl:cons ':q1_dot (q1_dot msg))
))
