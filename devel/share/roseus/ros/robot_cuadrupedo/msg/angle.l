;; Auto-generated. Do not edit!


(when (boundp 'robot_cuadrupedo::angle)
  (if (not (find-package "ROBOT_CUADRUPEDO"))
    (make-package "ROBOT_CUADRUPEDO"))
  (shadow 'angle (find-package "ROBOT_CUADRUPEDO")))
(unless (find-package "ROBOT_CUADRUPEDO::ANGLE")
  (make-package "ROBOT_CUADRUPEDO::ANGLE"))

(in-package "ROS")
;;//! \htmlinclude angle.msg.html


(defclass robot_cuadrupedo::angle
  :super ros::object
  :slots (_angle ))

(defmethod robot_cuadrupedo::angle
  (:init
   (&key
    ((:angle __angle) 0.0)
    )
   (send-super :init)
   (setq _angle (float __angle))
   self)
  (:angle
   (&optional __angle)
   (if __angle (setq _angle __angle)) _angle)
  (:serialization-length
   ()
   (+
    ;; float64 _angle
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _angle
       (sys::poke _angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _angle
     (setq _angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get robot_cuadrupedo::angle :md5sum-) "4edb55038e2b888976a0c0c56935341c")
(setf (get robot_cuadrupedo::angle :datatype-) "robot_cuadrupedo/angle")
(setf (get robot_cuadrupedo::angle :definition-)
      "float64 angle
")



(provide :robot_cuadrupedo/angle "4edb55038e2b888976a0c0c56935341c")


