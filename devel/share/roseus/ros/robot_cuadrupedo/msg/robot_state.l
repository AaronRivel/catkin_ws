;; Auto-generated. Do not edit!


(when (boundp 'robot_cuadrupedo::robot_state)
  (if (not (find-package "ROBOT_CUADRUPEDO"))
    (make-package "ROBOT_CUADRUPEDO"))
  (shadow 'robot_state (find-package "ROBOT_CUADRUPEDO")))
(unless (find-package "ROBOT_CUADRUPEDO::ROBOT_STATE")
  (make-package "ROBOT_CUADRUPEDO::ROBOT_STATE"))

(in-package "ROS")
;;//! \htmlinclude robot_state.msg.html
(if (not (find-package "ROBOT_CUADRUPEDO_MSGS"))
  (ros::roseus-add-msgs "robot_cuadrupedo_msgs"))


(defclass robot_cuadrupedo::robot_state
  :super ros::object
  :slots (_rc ))

(defmethod robot_cuadrupedo::robot_state
  (:init
   (&key
    ((:rc __rc) (instance robot_cuadrupedo_msgs::robot_velocity :init))
    )
   (send-super :init)
   (setq _rc __rc)
   self)
  (:rc
   (&rest __rc)
   (if (keywordp (car __rc))
       (send* _rc __rc)
     (progn
       (if __rc (setq _rc (car __rc)))
       _rc)))
  (:serialization-length
   ()
   (+
    ;; robot_cuadrupedo_msgs/robot_velocity _rc
    (send _rc :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; robot_cuadrupedo_msgs/robot_velocity _rc
       (send _rc :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; robot_cuadrupedo_msgs/robot_velocity _rc
     (send _rc :deserialize buf ptr-) (incf ptr- (send _rc :serialization-length))
   ;;
   self)
  )

(setf (get robot_cuadrupedo::robot_state :md5sum-) "4aab73bea9dabf128c8c483534d2bbfe")
(setf (get robot_cuadrupedo::robot_state :datatype-) "robot_cuadrupedo/robot_state")
(setf (get robot_cuadrupedo::robot_state :definition-)
      "robot_cuadrupedo_msgs/robot_velocity rc
================================================================================
MSG: robot_cuadrupedo_msgs/robot_velocity
bool walk
float64 velocity
")



(provide :robot_cuadrupedo/robot_state "4aab73bea9dabf128c8c483534d2bbfe")


