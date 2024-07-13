;; Auto-generated. Do not edit!


(when (boundp 'robot_cuadrupedo::motors_states)
  (if (not (find-package "ROBOT_CUADRUPEDO"))
    (make-package "ROBOT_CUADRUPEDO"))
  (shadow 'motors_states (find-package "ROBOT_CUADRUPEDO")))
(unless (find-package "ROBOT_CUADRUPEDO::MOTORS_STATES")
  (make-package "ROBOT_CUADRUPEDO::MOTORS_STATES"))

(in-package "ROS")
;;//! \htmlinclude motors_states.msg.html
(if (not (find-package "ROBOT_CUADRUPEDO_MSGS"))
  (ros::roseus-add-msgs "robot_cuadrupedo_msgs"))


(defclass robot_cuadrupedo::motors_states
  :super ros::object
  :slots (_leg1 _leg2 _leg3 _leg4 ))

(defmethod robot_cuadrupedo::motors_states
  (:init
   (&key
    ((:leg1 __leg1) (instance robot_cuadrupedo_msgs::legs_control :init))
    ((:leg2 __leg2) (instance robot_cuadrupedo_msgs::legs_control :init))
    ((:leg3 __leg3) (instance robot_cuadrupedo_msgs::legs_control :init))
    ((:leg4 __leg4) (instance robot_cuadrupedo_msgs::legs_control :init))
    )
   (send-super :init)
   (setq _leg1 __leg1)
   (setq _leg2 __leg2)
   (setq _leg3 __leg3)
   (setq _leg4 __leg4)
   self)
  (:leg1
   (&rest __leg1)
   (if (keywordp (car __leg1))
       (send* _leg1 __leg1)
     (progn
       (if __leg1 (setq _leg1 (car __leg1)))
       _leg1)))
  (:leg2
   (&rest __leg2)
   (if (keywordp (car __leg2))
       (send* _leg2 __leg2)
     (progn
       (if __leg2 (setq _leg2 (car __leg2)))
       _leg2)))
  (:leg3
   (&rest __leg3)
   (if (keywordp (car __leg3))
       (send* _leg3 __leg3)
     (progn
       (if __leg3 (setq _leg3 (car __leg3)))
       _leg3)))
  (:leg4
   (&rest __leg4)
   (if (keywordp (car __leg4))
       (send* _leg4 __leg4)
     (progn
       (if __leg4 (setq _leg4 (car __leg4)))
       _leg4)))
  (:serialization-length
   ()
   (+
    ;; robot_cuadrupedo_msgs/legs_control _leg1
    (send _leg1 :serialization-length)
    ;; robot_cuadrupedo_msgs/legs_control _leg2
    (send _leg2 :serialization-length)
    ;; robot_cuadrupedo_msgs/legs_control _leg3
    (send _leg3 :serialization-length)
    ;; robot_cuadrupedo_msgs/legs_control _leg4
    (send _leg4 :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; robot_cuadrupedo_msgs/legs_control _leg1
       (send _leg1 :serialize s)
     ;; robot_cuadrupedo_msgs/legs_control _leg2
       (send _leg2 :serialize s)
     ;; robot_cuadrupedo_msgs/legs_control _leg3
       (send _leg3 :serialize s)
     ;; robot_cuadrupedo_msgs/legs_control _leg4
       (send _leg4 :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; robot_cuadrupedo_msgs/legs_control _leg1
     (send _leg1 :deserialize buf ptr-) (incf ptr- (send _leg1 :serialization-length))
   ;; robot_cuadrupedo_msgs/legs_control _leg2
     (send _leg2 :deserialize buf ptr-) (incf ptr- (send _leg2 :serialization-length))
   ;; robot_cuadrupedo_msgs/legs_control _leg3
     (send _leg3 :deserialize buf ptr-) (incf ptr- (send _leg3 :serialization-length))
   ;; robot_cuadrupedo_msgs/legs_control _leg4
     (send _leg4 :deserialize buf ptr-) (incf ptr- (send _leg4 :serialization-length))
   ;;
   self)
  )

(setf (get robot_cuadrupedo::motors_states :md5sum-) "c6779dc7494c3c55386a9358df1a0c6a")
(setf (get robot_cuadrupedo::motors_states :datatype-) "robot_cuadrupedo/motors_states")
(setf (get robot_cuadrupedo::motors_states :definition-)
      "robot_cuadrupedo_msgs/legs_control leg1

robot_cuadrupedo_msgs/legs_control leg2

robot_cuadrupedo_msgs/legs_control leg3

robot_cuadrupedo_msgs/legs_control leg4
================================================================================
MSG: robot_cuadrupedo_msgs/legs_control
float64 frontal_motor
float64 posterior_motor
bool walk
bool goal_position_feedback
")



(provide :robot_cuadrupedo/motors_states "c6779dc7494c3c55386a9358df1a0c6a")


