
(cl:in-package :asdf)

(defsystem "quadruped_robot-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "read_dxl" :depends-on ("_package_read_dxl"))
    (:file "_package_read_dxl" :depends-on ("_package"))
    (:file "write_dxl" :depends-on ("_package_write_dxl"))
    (:file "_package_write_dxl" :depends-on ("_package"))
  ))