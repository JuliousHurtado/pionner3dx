
(cl:in-package :asdf)

(defsystem "il_map_tools-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "srv_occupied" :depends-on ("_package_srv_occupied"))
    (:file "_package_srv_occupied" :depends-on ("_package"))
  ))