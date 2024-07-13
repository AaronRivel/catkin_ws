;; Auto-generated. Do not edit!


(when (boundp 'robot_cuadrupedo_msgs::legs_control)
  (if (not (find-package "ROBOT_CUADRUPEDO_MSGS"))
    (make-package "ROBOT_CUADRUPEDO_MSGS"))
  (shadow 'legs_control (find-package "ROBOT_CUADRUPEDO_MSGS")))
(unless (find-package "ROBOT_CUADRUPEDO_MSGS::LEGS_CONTROL")
  (make-package "ROBOT_CUADRUPEDO_MSGS::LEGS_CONTROL"))

(in-package "ROS")
;;//! \htmlinclude legs_control.msg.html


(defclass robot_cuadrupedo_msgs::legs_control
  :super ros::object
  :slots (_frontal_motor _posterior_motor _walk _goal_position_feedback ))

(defmethod robot_cuadrupedo_msgs::legs_control
  (:init
   (&key
    ((:frontal_motor __frontal_motor) 0.0)
    ((:posterior_motor __posterior_motor) 0.0)
    ((:walk __walk) nil)
    ((:goal_position_feedback __goal_position_feedback) nil)
    )
   (send-super :init)
   (setq _frontal_motor (float __frontal_motor))
   (setq _posterior_motor (float __posterior_motor))
   (setq _walk __walk)
   (setq _goal_position_feedback __goal_position_feedback)
   self)
  (:frontal_motor
   (&optional __frontal_motor)
   (if __frontal_motor (setq _frontal_motor __frontal_motor)) _frontal_motor)
  (:posterior_motor
   (&optional __posterior_motor)
   (if __posterior_motor (setq _posterior_motor __posterior_motor)) _posterior_motor)
  (:walk
   (&optional (__walk :null))
   (if (not (eq __walk :null)) (setq _walk __walk)) _walk)
  (:goal_position_feedback
   (&optional (__goal_position_feedback :null))
   (if (not (eq __goal_position_feedback :null)) (setq _goal_position_feedback __goal_position_feedback)) _goal_position_feedback)
  (:serialization-length
   ()
   (+
    ;; float64 _frontal_motor
    8
    ;; float64 _posterior_motor
    8
    ;; bool _walk
    1
    ;; bool _goal_position_feedback
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _frontal_motor
       (sys::poke _frontal_motor (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _posterior_motor
       (sys::poke _posterior_motor (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; bool _walk
       (if _walk (write-byte -1 s) (write-byte 0 s))
     ;; bool _goal_position_feedback
       (if _goal_position_feedback (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _frontal_motor
     (setq _frontal_motor (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _posterior_motor
     (setq _posterior_motor (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; bool _walk
     (setq _walk (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _goal_position_feedback
     (setq _goal_position_feedback (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get robot_cuadrupedo_msgs::legs_control :md5sum-) "97a124f2ec231fd19890257578b60ad2")
(setf (get robot_cuadrupedo_msgs::legs_control :datatype-) "robot_cuadrupedo_msgs/legs_control")
(setf (get robot_cuadrupedo_msgs::legs_control :definition-)
      "float64 frontal_motor
float64 posterior_motor
bool walk
bool goal_position_feedback
")



(provide :robot_cuadrupedo_msgs/legs_control "97a124f2ec231fd19890257578b60ad2")


