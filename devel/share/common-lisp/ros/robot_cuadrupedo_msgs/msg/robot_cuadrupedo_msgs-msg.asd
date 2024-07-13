
(cl:in-package :asdf)

(defsystem "robot_cuadrupedo_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "legs_control" :depends-on ("_package_legs_control"))
    (:file "_package_legs_control" :depends-on ("_package"))
    (:file "robot_velocity" :depends-on ("_package_robot_velocity"))
    (:file "_package_robot_velocity" :depends-on ("_package"))
  ))