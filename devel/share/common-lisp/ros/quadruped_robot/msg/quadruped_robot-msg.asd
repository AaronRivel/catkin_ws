
(cl:in-package :asdf)

(defsystem "quadruped_robot-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "motor_state" :depends-on ("_package_motor_state"))
    (:file "_package_motor_state" :depends-on ("_package"))
    (:file "period" :depends-on ("_package_period"))
    (:file "_package_period" :depends-on ("_package"))
    (:file "time_state" :depends-on ("_package_time_state"))
    (:file "_package_time_state" :depends-on ("_package"))
  ))