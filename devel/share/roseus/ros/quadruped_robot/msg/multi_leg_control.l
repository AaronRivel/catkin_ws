;; Auto-generated. Do not edit!


(when (boundp 'quadruped_robot::multi_leg_control)
  (if (not (find-package "QUADRUPED_ROBOT"))
    (make-package "QUADRUPED_ROBOT"))
  (shadow 'multi_leg_control (find-package "QUADRUPED_ROBOT")))
(unless (find-package "QUADRUPED_ROBOT::MULTI_LEG_CONTROL")
  (make-package "QUADRUPED_ROBOT::MULTI_LEG_CONTROL"))

(in-package "ROS")
;;//! \htmlinclude multi_leg_control.msg.html


(defclass quadruped_robot::multi_leg_control
  :super ros::object
  :slots (_cm_s _way _walk_flag _L1 _L2 _L3 _L4 ))

(defmethod quadruped_robot::multi_leg_control
  (:init
   (&key
    ((:cm_s __cm_s) 0.0)
    ((:way __way) 0)
    ((:walk_flag __walk_flag) nil)
    ((:L1 __L1) (instance quadruped_robot::leg_state :init))
    ((:L2 __L2) (instance quadruped_robot::leg_state :init))
    ((:L3 __L3) (instance quadruped_robot::leg_state :init))
    ((:L4 __L4) (instance quadruped_robot::leg_state :init))
    )
   (send-super :init)
   (setq _cm_s (float __cm_s))
   (setq _way (round __way))
   (setq _walk_flag __walk_flag)
   (setq _L1 __L1)
   (setq _L2 __L2)
   (setq _L3 __L3)
   (setq _L4 __L4)
   self)
  (:cm_s
   (&optional __cm_s)
   (if __cm_s (setq _cm_s __cm_s)) _cm_s)
  (:way
   (&optional __way)
   (if __way (setq _way __way)) _way)
  (:walk_flag
   (&optional (__walk_flag :null))
   (if (not (eq __walk_flag :null)) (setq _walk_flag __walk_flag)) _walk_flag)
  (:L1
   (&rest __L1)
   (if (keywordp (car __L1))
       (send* _L1 __L1)
     (progn
       (if __L1 (setq _L1 (car __L1)))
       _L1)))
  (:L2
   (&rest __L2)
   (if (keywordp (car __L2))
       (send* _L2 __L2)
     (progn
       (if __L2 (setq _L2 (car __L2)))
       _L2)))
  (:L3
   (&rest __L3)
   (if (keywordp (car __L3))
       (send* _L3 __L3)
     (progn
       (if __L3 (setq _L3 (car __L3)))
       _L3)))
  (:L4
   (&rest __L4)
   (if (keywordp (car __L4))
       (send* _L4 __L4)
     (progn
       (if __L4 (setq _L4 (car __L4)))
       _L4)))
  (:serialization-length
   ()
   (+
    ;; float64 _cm_s
    8
    ;; int64 _way
    8
    ;; bool _walk_flag
    1
    ;; quadruped_robot/leg_state _L1
    (send _L1 :serialization-length)
    ;; quadruped_robot/leg_state _L2
    (send _L2 :serialization-length)
    ;; quadruped_robot/leg_state _L3
    (send _L3 :serialization-length)
    ;; quadruped_robot/leg_state _L4
    (send _L4 :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _cm_s
       (sys::poke _cm_s (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int64 _way
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _way (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _way) (= (length (_way . bv)) 2)) ;; bignum
              (write-long (ash (elt (_way . bv) 0) 0) s)
              (write-long (ash (elt (_way . bv) 1) -1) s))
             ((and (class _way) (= (length (_way . bv)) 1)) ;; big1
              (write-long (elt (_way . bv) 0) s)
              (write-long (if (>= _way 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _way s)(write-long (if (>= _way 0) 0 #xffffffff) s)))
     ;; bool _walk_flag
       (if _walk_flag (write-byte -1 s) (write-byte 0 s))
     ;; quadruped_robot/leg_state _L1
       (send _L1 :serialize s)
     ;; quadruped_robot/leg_state _L2
       (send _L2 :serialize s)
     ;; quadruped_robot/leg_state _L3
       (send _L3 :serialize s)
     ;; quadruped_robot/leg_state _L4
       (send _L4 :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _cm_s
     (setq _cm_s (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int64 _way
#+(or :alpha :irix6 :x86_64)
      (setf _way (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _way (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; bool _walk_flag
     (setq _walk_flag (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; quadruped_robot/leg_state _L1
     (send _L1 :deserialize buf ptr-) (incf ptr- (send _L1 :serialization-length))
   ;; quadruped_robot/leg_state _L2
     (send _L2 :deserialize buf ptr-) (incf ptr- (send _L2 :serialization-length))
   ;; quadruped_robot/leg_state _L3
     (send _L3 :deserialize buf ptr-) (incf ptr- (send _L3 :serialization-length))
   ;; quadruped_robot/leg_state _L4
     (send _L4 :deserialize buf ptr-) (incf ptr- (send _L4 :serialization-length))
   ;;
   self)
  )

(setf (get quadruped_robot::multi_leg_control :md5sum-) "2042bad48628ce2ee3747e89f60d7c02")
(setf (get quadruped_robot::multi_leg_control :datatype-) "quadruped_robot/multi_leg_control")
(setf (get quadruped_robot::multi_leg_control :definition-)
      "float64 cm_s
int64 way
bool walk_flag
leg_state L1
leg_state L2
leg_state L3
leg_state L4
================================================================================
MSG: quadruped_robot/leg_state
float64 t
float64 q0
float64 q1
string path
bool finish
")



(provide :quadruped_robot/multi_leg_control "2042bad48628ce2ee3747e89f60d7c02")


