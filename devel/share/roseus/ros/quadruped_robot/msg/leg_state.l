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
  :slots (_t _q0 _q1 _path _finish ))

(defmethod quadruped_robot::leg_state
  (:init
   (&key
    ((:t __t) 0.0)
    ((:q0 __q0) 0.0)
    ((:q1 __q1) 0.0)
    ((:path __path) "")
    ((:finish __finish) nil)
    )
   (send-super :init)
   (setq _t (float __t))
   (setq _q0 (float __q0))
   (setq _q1 (float __q1))
   (setq _path (string __path))
   (setq _finish __finish)
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
  (:path
   (&optional __path)
   (if __path (setq _path __path)) _path)
  (:finish
   (&optional (__finish :null))
   (if (not (eq __finish :null)) (setq _finish __finish)) _finish)
  (:serialization-length
   ()
   (+
    ;; float64 _t
    8
    ;; float64 _q0
    8
    ;; float64 _q1
    8
    ;; string _path
    4 (length _path)
    ;; bool _finish
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
     ;; string _path
       (write-long (length _path) s) (princ _path s)
     ;; bool _finish
       (if _finish (write-byte -1 s) (write-byte 0 s))
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
   ;; string _path
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _path (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _finish
     (setq _finish (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get quadruped_robot::leg_state :md5sum-) "65639cae4a56ecaed05a54ec9094a72f")
(setf (get quadruped_robot::leg_state :datatype-) "quadruped_robot/leg_state")
(setf (get quadruped_robot::leg_state :definition-)
      "float64 t
float64 q0
float64 q1
string path
bool finish
")



(provide :quadruped_robot/leg_state "65639cae4a56ecaed05a54ec9094a72f")


