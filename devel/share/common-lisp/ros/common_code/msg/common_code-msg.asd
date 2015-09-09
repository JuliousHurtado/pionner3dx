
(cl:in-package :asdf)

(defsystem "common_code-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "msg_detection" :depends-on ("_package_msg_detection"))
    (:file "_package_msg_detection" :depends-on ("_package"))
    (:file "Camino" :depends-on ("_package_Camino"))
    (:file "_package_Camino" :depends-on ("_package"))
    (:file "Pan_tilt" :depends-on ("_package_Pan_tilt"))
    (:file "_package_Pan_tilt" :depends-on ("_package"))
    (:file "Punto" :depends-on ("_package_Punto"))
    (:file "_package_Punto" :depends-on ("_package"))
  ))