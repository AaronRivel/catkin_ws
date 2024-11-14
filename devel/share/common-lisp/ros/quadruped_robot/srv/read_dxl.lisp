; Auto-generated. Do not edit!


(cl:in-package quadruped_robot-srv)


;//! \htmlinclude read_dxl-request.msg.html

(cl:defclass <read_dxl-request> (roslisp-msg-protocol:ros-message)
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
    :initform 0))
)

(cl:defclass read_dxl-request (<read_dxl-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <read_dxl-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'read_dxl-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name quadruped_robot-srv:<read_dxl-request> is deprecated: use quadruped_robot-srv:read_dxl-request instead.")))

(cl:ensure-generic-function 'action-val :lambda-list '(m))
(cl:defmethod action-val ((m <read_dxl-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-srv:action-val is deprecated.  Use quadruped_robot-srv:action instead.")
  (action m))

(cl:ensure-generic-function 'motor_f-val :lambda-list '(m))
(cl:defmethod motor_f-val ((m <read_dxl-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-srv:motor_f-val is deprecated.  Use quadruped_robot-srv:motor_f instead.")
  (motor_f m))

(cl:ensure-generic-function 'motor_p-val :lambda-list '(m))
(cl:defmethod motor_p-val ((m <read_dxl-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-srv:motor_p-val is deprecated.  Use quadruped_robot-srv:motor_p instead.")
  (motor_p m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <read_dxl-request>) ostream)
  "Serializes a message object of type '<read_dxl-request>"
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
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <read_dxl-request>) istream)
  "Deserializes a message object of type '<read_dxl-request>"
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
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<read_dxl-request>)))
  "Returns string type for a service object of type '<read_dxl-request>"
  "quadruped_robot/read_dxlRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'read_dxl-request)))
  "Returns string type for a service object of type 'read_dxl-request"
  "quadruped_robot/read_dxlRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<read_dxl-request>)))
  "Returns md5sum for a message object of type '<read_dxl-request>"
  "044408118166cb6346b6bae601023969")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'read_dxl-request)))
  "Returns md5sum for a message object of type 'read_dxl-request"
  "044408118166cb6346b6bae601023969")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<read_dxl-request>)))
  "Returns full string definition for message of type '<read_dxl-request>"
  (cl:format cl:nil "string action~%int64 motor_f~%int64 motor_p~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'read_dxl-request)))
  "Returns full string definition for message of type 'read_dxl-request"
  (cl:format cl:nil "string action~%int64 motor_f~%int64 motor_p~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <read_dxl-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'action))
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <read_dxl-request>))
  "Converts a ROS message object to a list"
  (cl:list 'read_dxl-request
    (cl:cons ':action (action msg))
    (cl:cons ':motor_f (motor_f msg))
    (cl:cons ':motor_p (motor_p msg))
))
;//! \htmlinclude read_dxl-response.msg.html

(cl:defclass <read_dxl-response> (roslisp-msg-protocol:ros-message)
  ((result_1
    :reader result_1
    :initarg :result_1
    :type cl:integer
    :initform 0)
   (result_2
    :reader result_2
    :initarg :result_2
    :type cl:integer
    :initform 0))
)

(cl:defclass read_dxl-response (<read_dxl-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <read_dxl-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'read_dxl-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name quadruped_robot-srv:<read_dxl-response> is deprecated: use quadruped_robot-srv:read_dxl-response instead.")))

(cl:ensure-generic-function 'result_1-val :lambda-list '(m))
(cl:defmethod result_1-val ((m <read_dxl-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-srv:result_1-val is deprecated.  Use quadruped_robot-srv:result_1 instead.")
  (result_1 m))

(cl:ensure-generic-function 'result_2-val :lambda-list '(m))
(cl:defmethod result_2-val ((m <read_dxl-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadruped_robot-srv:result_2-val is deprecated.  Use quadruped_robot-srv:result_2 instead.")
  (result_2 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <read_dxl-response>) ostream)
  "Serializes a message object of type '<read_dxl-response>"
  (cl:let* ((signed (cl:slot-value msg 'result_1)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'result_2)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <read_dxl-response>) istream)
  "Deserializes a message object of type '<read_dxl-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result_1) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result_2) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<read_dxl-response>)))
  "Returns string type for a service object of type '<read_dxl-response>"
  "quadruped_robot/read_dxlResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'read_dxl-response)))
  "Returns string type for a service object of type 'read_dxl-response"
  "quadruped_robot/read_dxlResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<read_dxl-response>)))
  "Returns md5sum for a message object of type '<read_dxl-response>"
  "044408118166cb6346b6bae601023969")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'read_dxl-response)))
  "Returns md5sum for a message object of type 'read_dxl-response"
  "044408118166cb6346b6bae601023969")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<read_dxl-response>)))
  "Returns full string definition for message of type '<read_dxl-response>"
  (cl:format cl:nil "int64 result_1~%int64 result_2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'read_dxl-response)))
  "Returns full string definition for message of type 'read_dxl-response"
  (cl:format cl:nil "int64 result_1~%int64 result_2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <read_dxl-response>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <read_dxl-response>))
  "Converts a ROS message object to a list"
  (cl:list 'read_dxl-response
    (cl:cons ':result_1 (result_1 msg))
    (cl:cons ':result_2 (result_2 msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'read_dxl)))
  'read_dxl-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'read_dxl)))
  'read_dxl-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'read_dxl)))
  "Returns string type for a service object of type '<read_dxl>"
  "quadruped_robot/read_dxl")