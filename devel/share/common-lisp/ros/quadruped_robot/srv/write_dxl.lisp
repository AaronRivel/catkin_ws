; Auto-generated. Do not edit!


(cl:in-package quadruped_robot-srv)


;//! \htmlinclude write_dxl-request.msg.html

(cl:defclass <write_dxl-request> (roslisp-msg-protocol:ros-message)
  ((action
    :reader action
    :initarg :action
    :type cl:string
    :initform "")
   (motor_f
    :reader motor_f
    :initarg :motor_f
    :type cl:integer
    :initform 0)
   (motor_p
    :reader motor_p
    :initarg :motor_p
    :type cl:integer
    :initform 0)
   (data_f
    :reader data_f
    :initarg :data_f
    :type cl:float
    :initform 0.0)
   (data_p
    :reader data_p
    :initarg :data_p
    :type cl:float
    :initform 0.0))
)

(cl:defclass write_dxl-request (<write_dxl-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <write_dxl-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'write_dxl-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name quadruped_robot-srv:<write_dxl-request> is deprecated: use quadruped_robot-srv:write_dxl-request instead.")))

(cl:ensure-generic-function 'action-val :lambda-list '(m))
(cl:defmethod action-val ((m <write_dxl-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-srv:action-val is deprecated.  Use quadruped_robot-srv:action instead.")
  (action m))

(cl:ensure-generic-function 'motor_f-val :lambda-list '(m))
(cl:defmethod motor_f-val ((m <write_dxl-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-srv:motor_f-val is deprecated.  Use quadruped_robot-srv:motor_f instead.")
  (motor_f m))

(cl:ensure-generic-function 'motor_p-val :lambda-list '(m))
(cl:defmethod motor_p-val ((m <write_dxl-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-srv:motor_p-val is deprecated.  Use quadruped_robot-srv:motor_p instead.")
  (motor_p m))

(cl:ensure-generic-function 'data_f-val :lambda-list '(m))
(cl:defmethod data_f-val ((m <write_dxl-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-srv:data_f-val is deprecated.  Use quadruped_robot-srv:data_f instead.")
  (data_f m))

(cl:ensure-generic-function 'data_p-val :lambda-list '(m))
(cl:defmethod data_p-val ((m <write_dxl-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-srv:data_p-val is deprecated.  Use quadruped_robot-srv:data_p instead.")
  (data_p m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <write_dxl-request>) ostream)
  "Serializes a message object of type '<write_dxl-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'action))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'action))
  (cl:let* ((signed (cl:slot-value msg 'motor_f)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'motor_p)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'data_f))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'data_p))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <write_dxl-request>) istream)
  "Deserializes a message object of type '<write_dxl-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'action) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'action) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'motor_f) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'motor_p) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'data_f) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'data_p) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<write_dxl-request>)))
  "Returns string type for a service object of type '<write_dxl-request>"
  "quadruped_robot/write_dxlRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'write_dxl-request)))
  "Returns string type for a service object of type 'write_dxl-request"
  "quadruped_robot/write_dxlRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<write_dxl-request>)))
  "Returns md5sum for a message object of type '<write_dxl-request>"
  "428ef13fdd260581844722fd7a6d6e35")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'write_dxl-request)))
  "Returns md5sum for a message object of type 'write_dxl-request"
  "428ef13fdd260581844722fd7a6d6e35")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<write_dxl-request>)))
  "Returns full string definition for message of type '<write_dxl-request>"
  (cl:format cl:nil "string action~%int64 motor_f~%int64 motor_p~%float64 data_f~%float64 data_p~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'write_dxl-request)))
  "Returns full string definition for message of type 'write_dxl-request"
  (cl:format cl:nil "string action~%int64 motor_f~%int64 motor_p~%float64 data_f~%float64 data_p~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <write_dxl-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'action))
     8
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <write_dxl-request>))
  "Converts a ROS message object to a list"
  (cl:list 'write_dxl-request
    (cl:cons ':action (action msg))
    (cl:cons ':motor_f (motor_f msg))
    (cl:cons ':motor_p (motor_p msg))
    (cl:cons ':data_f (data_f msg))
    (cl:cons ':data_p (data_p msg))
))
;//! \htmlinclude write_dxl-response.msg.html

(cl:defclass <write_dxl-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass write_dxl-response (<write_dxl-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <write_dxl-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'write_dxl-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name quadruped_robot-srv:<write_dxl-response> is deprecated: use quadruped_robot-srv:write_dxl-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <write_dxl-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-srv:result-val is deprecated.  Use quadruped_robot-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <write_dxl-response>) ostream)
  "Serializes a message object of type '<write_dxl-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'result) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <write_dxl-response>) istream)
  "Deserializes a message object of type '<write_dxl-response>"
    (cl:setf (cl:slot-value msg 'result) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<write_dxl-response>)))
  "Returns string type for a service object of type '<write_dxl-response>"
  "quadruped_robot/write_dxlResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'write_dxl-response)))
  "Returns string type for a service object of type 'write_dxl-response"
  "quadruped_robot/write_dxlResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<write_dxl-response>)))
  "Returns md5sum for a message object of type '<write_dxl-response>"
  "428ef13fdd260581844722fd7a6d6e35")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'write_dxl-response)))
  "Returns md5sum for a message object of type 'write_dxl-response"
  "428ef13fdd260581844722fd7a6d6e35")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<write_dxl-response>)))
  "Returns full string definition for message of type '<write_dxl-response>"
  (cl:format cl:nil "bool result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'write_dxl-response)))
  "Returns full string definition for message of type 'write_dxl-response"
  (cl:format cl:nil "bool result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <write_dxl-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <write_dxl-response>))
  "Converts a ROS message object to a list"
  (cl:list 'write_dxl-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'write_dxl)))
  'write_dxl-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'write_dxl)))
  'write_dxl-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'write_dxl)))
  "Returns string type for a service object of type '<write_dxl>"
  "quadruped_robot/write_dxl")