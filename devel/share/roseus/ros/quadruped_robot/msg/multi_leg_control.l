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
  :slots (_T _L1 _L2 _L3 _L4 ))

(defmethod quadruped_robot::multi_leg_control
  (:init
   (&key
    ((:T __T) 0.0)
    ((:L1 __L1) (instance quadruped_robot::leg_state :init))
    ((:L2 __L2) (instance quadruped_robot::leg_state :init))
    ((:L3 __L3) (instance quadruped_robot::leg_state :init))
    ((:L4 __L4) (instance quadruped_robot::leg_state :init))
    )
   (send-super :init)
   (setq _T (float __T))
   (setq _L1 __L1)
   (setq _L2 __L2)
   (setq _L3 __L3)
   (setq _L4 __L4)
   self)
  (:T
   (&optional __T)
   (if __T (setq _T __T)) _T)
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
    ;; float64 _T
    8
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
     ;; float64 _T
       (sys::poke _T (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
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
   ;; float64 _T
     (setq _T (sys::peek buf ptr- :double)) (incf ptr- 8)
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

(setf (get quadruped_robot::multi_leg_control :md5sum-) "06bad1c9b39c7b841c47d0fd74cc8b34")
(setf (get quadruped_robot::multi_leg_control :datatype-) "quadruped_robot/multi_leg_control")
(setf (get quadruped_robot::multi_leg_control :definition-)
      "float64 T
leg_state L1
leg_state L2
leg_state L3
leg_state L4
================================================================================
MSG: quadruped_robot/leg_state
float64 t
float64 q0
float64 q1
float64 q0_dot
float64 q1_dot
string leg_pos
bool walk_flag
")



(provide :quadruped_robot/multi_leg_control "06bad1c9b39c7b841c47d0fd74cc8b34")


