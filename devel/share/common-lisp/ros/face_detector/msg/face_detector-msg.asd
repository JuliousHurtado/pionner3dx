
(cl:in-package :asdf)

(defsystem "face_detector-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "msg_detection" :depends-on ("_package_msg_detection"))
    (:file "_package_msg_detection" :depends-on ("_package"))
  ))