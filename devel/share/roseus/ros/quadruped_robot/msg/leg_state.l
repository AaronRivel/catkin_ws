;; Auto-generated. Do not edit!


(when (boundp 'quadruped_robot::leg_state)
  (if (not (find-package "QUADRUPED_ROBOT"))
    (make-package "QUADRUPED_ROBOT"))
  (shadow 'leg_state (find-package "QUADRUPED_ROBOT")))
(unless (find-package "QUADRUPED_ROBOT::LEG_STATE")
  (make-package "QUADRUPED_ROBOT::LEG_STATE"))

(in-package "ROS")
;;//! \htmlinclude leg_state.msg.html


(defclass quadruped_robot::leg_state
  :super ros::object
  :slots (_t _q0 _q1 _q0_dot _q1_dot _leg_pos _walk_flag ))

(defmethod quadruped_robot::leg_state
  (:init
   (&key
    ((:t __t) 0.0)
    ((:q0 __q0) 0.0)
    ((:q1 __q1) 0.0)
    ((:q0_dot __q0_dot) 0.0)
    ((:q1_dot __q1_dot) 0.0)
    ((:leg_pos __leg_pos) "")
    ((:walk_flag __walk_flag) nil)
    )
   (send-super :init)
   (setq _t (float __t))
   (setq _q0 (float __q0))
   (setq _q1 (float __q1))
   (setq _q0_dot (float __q0_dot))
   (setq _q1_dot (float __q1_dot))
   (setq _leg_pos (string __leg_pos))
   (setq _walk_flag __walk_flag)
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
  (:leg_pos
   (&optional __leg_pos)
   (if __leg_pos (setq _leg_pos __leg_pos)) _leg_pos)
  (:walk_flag
   (&optional (__walk_flag :null))
   (if (not (eq __walk_flag :null)) (setq _walk_flag __walk_flag)) _walk_flag)
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
    ;; string _leg_pos
    4 (length _leg_pos)
    ;; bool _walk_flag
    1
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
     ;; string _leg_pos
       (write-long (length _leg_pos) s) (princ _leg_pos s)
     ;; bool _walk_flag
       (if _walk_flag (write-byte -1 s) (write-byte 0 s))
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
   ;; string _leg_pos
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _leg_pos (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _walk_flag
     (setq _walk_flag (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get quadruped_robot::leg_state :md5sum-) "6a35ebb7a3cd834a00c2b30f73e65f94")
(setf (get quadruped_robot::leg_state :datatype-) "quadruped_robot/leg_state")
(setf (get quadruped_robot::leg_state :definition-)
      "float64 t
float64 q0
float64 q1
float64 q0_dot
float64 q1_dot
string leg_pos
bool walk_flag
")



(provide :quadruped_robot/leg_state "6a35ebb7a3cd834a00c2b30f73e65f94")


