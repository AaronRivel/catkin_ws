;; Auto-generated. Do not edit!


(when (boundp 'robot_cuadrupedo_msgs::robot_velocity)
  (if (not (find-package "ROBOT_CUADRUPEDO_MSGS"))
    (make-package "ROBOT_CUADRUPEDO_MSGS"))
  (shadow 'robot_velocity (find-package "ROBOT_CUADRUPEDO_MSGS")))
(unless (find-package "ROBOT_CUADRUPEDO_MSGS::ROBOT_VELOCITY")
  (make-package "ROBOT_CUADRUPEDO_MSGS::ROBOT_VELOCITY"))

(in-package "ROS")
;;//! \htmlinclude robot_velocity.msg.html


(defclass robot_cuadrupedo_msgs::robot_velocity
  :super ros::object
  :slots (_walk _velocity ))

(defmethod robot_cuadrupedo_msgs::robot_velocity
  (:init
   (&key
    ((:walk __walk) nil)
    ((:velocity __velocity) 0.0)
    )
   (send-super :init)
   (setq _walk __walk)
   (setq _velocity (float __velocity))
   self)
  (:walk
   (&optional (__walk :null))
   (if (not (eq __walk :null)) (setq _walk __walk)) _walk)
  (:velocity
   (&optional __velocity)
   (if __velocity (setq _velocity __velocity)) _velocity)
  (:serialization-length
   ()
   (+
    ;; bool _walk
    1
    ;; float64 _velocity
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _walk
       (if _walk (write-byte -1 s) (write-byte 0 s))
     ;; float64 _velocity
       (sys::poke _velocity (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _walk
     (setq _walk (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float64 _velocity
     (setq _velocity (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get robot_cuadrupedo_msgs::robot_velocity :md5sum-) "8bed2b6d4486708eb51d1d25b9ec31fb")
(setf (get robot_cuadrupedo_msgs::robot_velocity :datatype-) "robot_cuadrupedo_msgs/robot_velocity")
(setf (get robot_cuadrupedo_msgs::robot_velocity :definition-)
      "bool walk
float64 velocity
")



(provide :robot_cuadrupedo_msgs/robot_velocity "8bed2b6d4486708eb51d1d25b9ec31fb")


