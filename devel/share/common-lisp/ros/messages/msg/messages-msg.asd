
(cl:in-package :asdf)

(defsystem "messages-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Orientacion" :depends-on ("_package_Orientacion"))
    (:file "_package_Orientacion" :depends-on ("_package"))
    (:file "Camino" :depends-on ("_package_Camino"))
    (:file "_package_Camino" :depends-on ("_package"))
    (:file "Pan_tilt_mess" :depends-on ("_package_Pan_tilt_mess"))
    (:file "_package_Pan_tilt_mess" :depends-on ("_package"))
    (:file "Punto" :depends-on ("_package_Punto"))
    (:file "_package_Punto" :depends-on ("_package"))
  ))