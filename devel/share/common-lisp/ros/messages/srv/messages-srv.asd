
(cl:in-package :asdf)

(defsystem "messages-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "AddTwoInts" :depends-on ("_package_AddTwoInts"))
    (:file "_package_AddTwoInts" :depends-on ("_package"))
    (:file "Pan_tilt" :depends-on ("_package_Pan_tilt"))
    (:file "_package_Pan_tilt" :depends-on ("_package"))
  ))