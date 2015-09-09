
(cl:in-package :asdf)

(defsystem "messages-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Camino" :depends-on ("_package_Camino"))
    (:file "_package_Camino" :depends-on ("_package"))
    (:file "Pan_tilt" :depends-on ("_package_Pan_tilt"))
    (:file "_package_Pan_tilt" :depends-on ("_package"))
    (:file "Num" :depends-on ("_package_Num"))
    (:file "_package_Num" :depends-on ("_package"))
    (:file "Punto" :depends-on ("_package_Punto"))
    (:file "_package_Punto" :depends-on ("_package"))
  ))