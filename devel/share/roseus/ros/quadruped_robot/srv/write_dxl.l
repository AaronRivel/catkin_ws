;; Auto-generated. Do not edit!


(when (boundp 'quadruped_robot::write_dxl)
  (if (not (find-package "QUADRUPED_ROBOT"))
    (make-package "QUADRUPED_ROBOT"))
  (shadow 'write_dxl (find-package "QUADRUPED_ROBOT")))
(unless (find-package "QUADRUPED_ROBOT::WRITE_DXL")
  (make-package "QUADRUPED_ROBOT::WRITE_DXL"))
(unless (find-package "QUADRUPED_ROBOT::WRITE_DXLREQUEST")
  (make-package "QUADRUPED_ROBOT::WRITE_DXLREQUEST"))
(unless (find-package "QUADRUPED_ROBOT::WRITE_DXLRESPONSE")
  (make-package "QUADRUPED_ROBOT::WRITE_DXLRESPONSE"))

(in-package "ROS")





(defclass quadruped_robot::write_dxlRequest
  :super ros::object
  :slots (_action _motor_f _motor_p _data_f _data_p ))

(defmethod quadruped_robot::write_dxlRequest
  (:init
   (&key
    ((:action __action) "")
    ((:motor_f __motor_f) 0)
    ((:motor_p __motor_p) 0)
    ((:data_f __data_f) 0.0)
    ((:data_p __data_p) 0.0)
    )
   (send-super :init)
   (setq _action (string __action))
   (setq _motor_f (round __motor_f))
   (setq _motor_p (round __motor_p))
   (setq _data_f (float __data_f))
   (setq _data_p (float __data_p))
   self)
  (:action
   (&optional __action)
   (if __action (setq _action __action)) _action)
  (:motor_f
   (&optional __motor_f)
   (if __motor_f (setq _motor_f __motor_f)) _motor_f)
  (:motor_p
   (&optional __motor_p)
   (if __motor_p (setq _motor_p __motor_p)) _motor_p)
  (:data_f
   (&optional __data_f)
   (if __data_f (setq _data_f __data_f)) _data_f)
  (:data_p
   (&optional __data_p)
   (if __data_p (setq _data_p __data_p)) _data_p)
  (:serialization-length
   ()
   (+
    ;; string _action
    4 (length _action)
    ;; int64 _motor_f
    8
    ;; int64 _motor_p
    8
    ;; float64 _data_f
    8
    ;; float64 _data_p
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _action
       (write-long (length _action) s) (princ _action s)
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
     ;; float64 _data_f
       (sys::poke _data_f (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _data_p
       (sys::poke _data_p (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _action
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _action (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
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
   ;; float64 _data_f
     (setq _data_f (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _data_p
     (setq _data_p (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass quadruped_robot::write_dxlResponse
  :super ros::object
  :slots (_result ))

(defmethod quadruped_robot::write_dxlResponse
  (:init
   (&key
    ((:result __result) nil)
    )
   (send-super :init)
   (setq _result __result)
   self)
  (:result
   (&optional (__result :null))
   (if (not (eq __result :null)) (setq _result __result)) _result)
  (:serialization-length
   ()
   (+
    ;; bool _result
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _result
       (if _result (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _result
     (setq _result (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass quadruped_robot::write_dxl
  :super ros::object
  :slots ())

(setf (get quadruped_robot::write_dxl :md5sum-) "428ef13fdd260581844722fd7a6d6e35")
(setf (get quadruped_robot::write_dxl :datatype-) "quadruped_robot/write_dxl")
(setf (get quadruped_robot::write_dxl :request) quadruped_robot::write_dxlRequest)
(setf (get quadruped_robot::write_dxl :response) quadruped_robot::write_dxlResponse)

(defmethod quadruped_robot::write_dxlRequest
  (:response () (instance quadruped_robot::write_dxlResponse :init)))

(setf (get quadruped_robot::write_dxlRequest :md5sum-) "428ef13fdd260581844722fd7a6d6e35")
(setf (get quadruped_robot::write_dxlRequest :datatype-) "quadruped_robot/write_dxlRequest")
(setf (get quadruped_robot::write_dxlRequest :definition-)
      "string action
int64 motor_f
int64 motor_p
float64 data_f
float64 data_p
---
bool result
")

(setf (get quadruped_robot::write_dxlResponse :md5sum-) "428ef13fdd260581844722fd7a6d6e35")
(setf (get quadruped_robot::write_dxlResponse :datatype-) "quadruped_robot/write_dxlResponse")
(setf (get quadruped_robot::write_dxlResponse :definition-)
      "string action
int64 motor_f
int64 motor_p
float64 data_f
float64 data_p
---
bool result
")



(provide :quadruped_robot/write_dxl "428ef13fdd260581844722fd7a6d6e35")


