
(cl:in-package :asdf)

(defsystem "quadruped_robot-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "leg_state" :depends-on ("_package_leg_state"))
    (:file "_package_leg_state" :depends-on ("_package"))
    (:file "multi_leg_control" :depends-on ("_package_multi_leg_control"))
    (:file "_package_multi_leg_control" :depends-on ("_package"))
    (:file "period" :depends-on ("_package_period"))
    (:file "_package_period" :depends-on ("_package"))
  ))