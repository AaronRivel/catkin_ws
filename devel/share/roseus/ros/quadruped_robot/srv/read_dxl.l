;; Auto-generated. Do not edit!


(when (boundp 'quadruped_robot::read_dxl)
  (if (not (find-package "QUADRUPED_ROBOT"))
    (make-package "QUADRUPED_ROBOT"))
  (shadow 'read_dxl (find-package "QUADRUPED_ROBOT")))
(unless (find-package "QUADRUPED_ROBOT::READ_DXL")
  (make-package "QUADRUPED_ROBOT::READ_DXL"))
(unless (find-package "QUADRUPED_ROBOT::READ_DXLREQUEST")
  (make-package "QUADRUPED_ROBOT::READ_DXLREQUEST"))
(unless (find-package "QUADRUPED_ROBOT::READ_DXLRESPONSE")
  (make-package "QUADRUPED_ROBOT::READ_DXLRESPONSE"))

(in-package "ROS")





(defclass quadruped_robot::read_dxlRequest
  :super ros::object
  :slots (_action _protocol_version _motor_f _motor_p ))

(defmethod quadruped_robot::read_dxlRequest
  (:init
   (&key
    ((:action __action) "")
    ((:protocol_version __protocol_version) 0)
    ((:motor_f __motor_f) 0)
    ((:motor_p __motor_p) 0)
    )
   (send-super :init)
   (setq _action (string __action))
   (setq _protocol_version (round __protocol_version))
   (setq _motor_f (round __motor_f))
   (setq _motor_p (round __motor_p))
   self)
  (:action
   (&optional __action)
   (if __action (setq _action __action)) _action)
  (:protocol_version
   (&optional __protocol_version)
   (if __protocol_version (setq _protocol_version __protocol_version)) _protocol_version)
  (:motor_f
   (&optional __motor_f)
   (if __motor_f (setq _motor_f __motor_f)) _motor_f)
  (:motor_p
   (&optional __motor_p)
   (if __motor_p (setq _motor_p __motor_p)) _motor_p)
  (:serialization-length
   ()
   (+
    ;; string _action
    4 (length _action)
    ;; int64 _protocol_version
    8
    ;; int64 _motor_f
    8
    ;; int64 _motor_p
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _action
       (write-long (length _action) s) (princ _action s)
     ;; int64 _protocol_version
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _protocol_version (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _protocol_version) (= (length (_protocol_version . bv)) 2)) ;; bignum
              (write-long (ash (elt (_protocol_version . bv) 0) 0) s)
              (write-long (ash (elt (_protocol_version . bv) 1) -1) s))
             ((and (class _protocol_version) (= (length (_protocol_version . bv)) 1)) ;; big1
              (write-long (elt (_protocol_version . bv) 0) s)
              (write-long (if (>= _protocol_version 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _protocol_version s)(write-long (if (>= _protocol_version 0) 0 #xffffffff) s)))
     ;; int64 _motor_f
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _motor_f (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _motor_f) (= (length (_motor_f . bv)) 2)) ;; bignum
              (write-long (ash (elt (_motor_f . bv) 0) 0) s)
              (write-long (ash (elt (_motor_f . bv) 1) -1) s))
             ((and (class _motor_f) (= (length (_motor_f . bv)) 1)) ;; big1
              (write-long (elt (_motor_f . bv) 0) s)
              (write-long (if (>= _motor_f 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _motor_f s)(write-long (if (>= _motor_f 0) 0 #xffffffff) s)))
     ;; int64 _motor_p
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _motor_p (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _motor_p) (= (length (_motor_p . bv)) 2)) ;; bignum
              (write-long (ash (elt (_motor_p . bv) 0) 0) s)
              (write-long (ash (elt (_motor_p . bv) 1) -1) s))
             ((and (class _motor_p) (= (length (_motor_p . bv)) 1)) ;; big1
              (write-long (elt (_motor_p . bv) 0) s)
              (write-long (if (>= _motor_p 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _motor_p s)(write-long (if (>= _motor_p 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _action
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _action (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int64 _protocol_version
#+(or :alpha :irix6 :x86_64)
      (setf _protocol_version (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _protocol_version (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _motor_f
#+(or :alpha :irix6 :x86_64)
      (setf _motor_f (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _motor_f (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _motor_p
#+(or :alpha :irix6 :x86_64)
      (setf _motor_p (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _motor_p (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(defclass quadruped_robot::read_dxlResponse
  :super ros::object
  :slots (_result_1 _result_2 ))

(defmethod quadruped_robot::read_dxlResponse
  (:init
   (&key
    ((:result_1 __result_1) 0)
    ((:result_2 __result_2) 0)
    )
   (send-super :init)
   (setq _result_1 (round __result_1))
   (setq _result_2 (round __result_2))
   self)
  (:result_1
   (&optional __result_1)
   (if __result_1 (setq _result_1 __result_1)) _result_1)
  (:result_2
   (&optional __result_2)
   (if __result_2 (setq _result_2 __result_2)) _result_2)
  (:serialization-length
   ()
   (+
    ;; int64 _result_1
    8
    ;; int64 _result_2
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _result_1
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _result_1 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _result_1) (= (length (_result_1 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_result_1 . bv) 0) 0) s)
              (write-long (ash (elt (_result_1 . bv) 1) -1) s))
             ((and (class _result_1) (= (length (_result_1 . bv)) 1)) ;; big1
              (write-long (elt (_result_1 . bv) 0) s)
              (write-long (if (>= _result_1 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _result_1 s)(write-long (if (>= _result_1 0) 0 #xffffffff) s)))
     ;; int64 _result_2
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _result_2 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _result_2) (= (length (_result_2 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_result_2 . bv) 0) 0) s)
              (write-long (ash (elt (_result_2 . bv) 1) -1) s))
             ((and (class _result_2) (= (length (_result_2 . bv)) 1)) ;; big1
              (write-long (elt (_result_2 . bv) 0) s)
              (write-long (if (>= _result_2 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _result_2 s)(write-long (if (>= _result_2 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _result_1
#+(or :alpha :irix6 :x86_64)
      (setf _result_1 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _result_1 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _result_2
#+(or :alpha :irix6 :x86_64)
      (setf _result_2 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _result_2 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(defclass quadruped_robot::read_dxl
  :super ros::object
  :slots ())

(setf (get quadruped_robot::read_dxl :md5sum-) "7620a6746ee96b998e0b60d728607979")
(setf (get quadruped_robot::read_dxl :datatype-) "quadruped_robot/read_dxl")
(setf (get quadruped_robot::read_dxl :request) quadruped_robot::read_dxlRequest)
(setf (get quadruped_robot::read_dxl :response) quadruped_robot::read_dxlResponse)

(defmethod quadruped_robot::read_dxlRequest
  (:response () (instance quadruped_robot::read_dxlResponse :init)))

(setf (get quadruped_robot::read_dxlRequest :md5sum-) "7620a6746ee96b998e0b60d728607979")
(setf (get quadruped_robot::read_dxlRequest :datatype-) "quadruped_robot/read_dxlRequest")
(setf (get quadruped_robot::read_dxlRequest :definition-)
      "string action
int64 protocol_version
int64 motor_f
int64 motor_p
---
int64 result_1
int64 result_2
")

(setf (get quadruped_robot::read_dxlResponse :md5sum-) "7620a6746ee96b998e0b60d728607979")
(setf (get quadruped_robot::read_dxlResponse :datatype-) "quadruped_robot/read_dxlResponse")
(setf (get quadruped_robot::read_dxlResponse :definition-)
      "string action
int64 protocol_version
int64 motor_f
int64 motor_p
---
int64 result_1
int64 result_2
")



(provide :quadruped_robot/read_dxl "7620a6746ee96b998e0b60d728607979")


