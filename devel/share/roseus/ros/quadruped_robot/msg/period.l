;; Auto-generated. Do not edit!


(when (boundp 'quadruped_robot::period)
  (if (not (find-package "QUADRUPED_ROBOT"))
    (make-package "QUADRUPED_ROBOT"))
  (shadow 'period (find-package "QUADRUPED_ROBOT")))
(unless (find-package "QUADRUPED_ROBOT::PERIOD")
  (make-package "QUADRUPED_ROBOT::PERIOD"))

(in-package "ROS")
;;//! \htmlinclude period.msg.html


(defclass quadruped_robot::period
  :super ros::object
  :slots (_T ))

(defmethod quadruped_robot::period
  (:init
   (&key
    ((:T __T) 0.0)
    )
   (send-super :init)
   (setq _T (float __T))
   self)
  (:T
   (&optional __T)
   (if __T (setq _T __T)) _T)
  (:serialization-length
   ()
   (+
    ;; float64 _T
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _T
       (sys::poke _T (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _T
     (setq _T (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get quadruped_robot::period :md5sum-) "df792c00269de90b579eb8eab6fc9c54")
(setf (get quadruped_robot::period :datatype-) "quadruped_robot/period")
(setf (get quadruped_robot::period :definition-)
      "float64 T
")



(provide :quadruped_robot/period "df792c00269de90b579eb8eab6fc9c54")


