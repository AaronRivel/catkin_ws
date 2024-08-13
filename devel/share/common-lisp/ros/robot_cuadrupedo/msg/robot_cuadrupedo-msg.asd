
(cl:in-package :asdf)

(defsystem "robot_cuadrupedo-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "motors_states" :depends-on ("_package_motors_states"))
    (:file "_package_motors_states" :depends-on ("_package"))
    (:file "robot_state" :depends-on ("_package_robot_state"))
    (:file "_package_robot_state" :depends-on ("_package"))
  ))