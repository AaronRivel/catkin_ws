;; Auto-generated. Do not edit!


(when (boundp 'quadruped_robot::time_state)
  (if (not (find-package "QUADRUPED_ROBOT"))
    (make-package "QUADRUPED_ROBOT"))
  (shadow 'time_state (find-package "QUADRUPED_ROBOT")))
(unless (find-package "QUADRUPED_ROBOT::TIME_STATE")
  (make-package "QUADRUPED_ROBOT::TIME_STATE"))

(in-package "ROS")
;;//! \htmlinclude time_state.msg.html


(defclass quadruped_robot::time_state
  :super ros::object
  :slots (_t _q0 _q1 _q0_dot _q1_dot ))

(defmethod quadruped_robot::time_state
  (:init
   (&key
    ((:t __t) 0.0)
    ((:q0 __q0) 0.0)
    ((:q1 __q1) 0.0)
    ((:q0_dot __q0_dot) 0.0)
    ((:q1_dot __q1_dot) 0.0)
    )
   (send-super :init)
   (setq _t (float __t))
   (setq _q0 (float __q0))
   (setq _q1 (float __q1))
   (setq _q0_dot (float __q0_dot))
   (setq _q1_dot (float __q1_dot))
   self)
  (:t
   (&optional __t)
   (if __t (setq _t __t)) _t)
  (:q0
   (&optional __q0)
   (if __q0 (setq _q0 __q0)) _q0)
  (:q1
   (&optional __q1)
   (if __q1 (setq _q1 __q1)) _q1)
  (:q0_dot
   (&optional __q0_dot)
   (if __q0_dot (setq _q0_dot __q0_dot)) _q0_dot)
  (:q1_dot
   (&optional __q1_dot)
   (if __q1_dot (setq _q1_dot __q1_dot)) _q1_dot)
  (:serialization-length
   ()
   (+
    ;; float64 _t
    8
    ;; float64 _q0
    8
    ;; float64 _q1
    8
    ;; float64 _q0_dot
    8
    ;; float64 _q1_dot
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _t
       (sys::poke _t (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _q0
       (sys::poke _q0 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _q1
       (sys::poke _q1 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _q0_dot
       (sys::poke _q0_dot (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _q1_dot
       (sys::poke _q1_dot (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _t
     (setq _t (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _q0
     (setq _q0 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _q1
     (setq _q1 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _q0_dot
     (setq _q0_dot (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _q1_dot
     (setq _q1_dot (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get quadruped_robot::time_state :md5sum-) "fdf95eab8e31bbe478f129be831ec16a")
(setf (get quadruped_robot::time_state :datatype-) "quadruped_robot/time_state")
(setf (get quadruped_robot::time_state :definition-)
      "float64 t
float64 q0
float64 q1
float64 q0_dot
float64 q1_dot

")



(provide :quadruped_robot/time_state "fdf95eab8e31bbe478f129be831ec16a")


