; Auto-generated. Do not edit!


(cl:in-package messages-msg)


;//! \htmlinclude Camino.msg.html

(cl:defclass <Camino> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (punto
    :reader punto
    :initarg :punto
    :type (cl:vector messages-msg:Punto)
   :initform (cl:make-array 0 :element-type 'messages-msg:Punto :initial-element (cl:make-instance 'messages-msg:Punto))))
)

(cl:defclass Camino (<Camino>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Camino>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Camino)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name messages-msg:<Camino> is deprecated: use messages-msg:Camino instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Camino>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages-msg:header-val is deprecated.  Use messages-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'punto-val :lambda-list '(m))
(cl:defmethod punto-val ((m <Camino>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages-msg:punto-val is deprecated.  Use messages-msg:punto instead.")
  (punto m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Camino>) ostream)
  "Serializes a message object of type '<Camino>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'punto))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'punto))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Camino>) istream)
  "Deserializes a message object of type '<Camino>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'punto) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'punto)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'messages-msg:Punto))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Camino>)))
  "Returns string type for a message object of type '<Camino>"
  "messages/Camino")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Camino)))
  "Returns string type for a message object of type 'Camino"
  "messages/Camino")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Camino>)))
  "Returns md5sum for a message object of type '<Camino>"
  "dedcd4aa3b4a3292b6e1222e047ea70f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Camino)))
  "Returns md5sum for a message object of type 'Camino"
  "dedcd4aa3b4a3292b6e1222e047ea70f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Camino>)))
  "Returns full string definition for message of type '<Camino>"
  (cl:format cl:nil "Header header~%Punto[] punto~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: messages/Punto~%Header header~%int32 x~%int32 y~%int32 angulo_pan~%int32 angulo_tilt~%time tiempo~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Camino)))
  "Returns full string definition for message of type 'Camino"
  (cl:format cl:nil "Header header~%Punto[] punto~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: messages/Punto~%Header header~%int32 x~%int32 y~%int32 angulo_pan~%int32 angulo_tilt~%time tiempo~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Camino>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'punto) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Camino>))
  "Converts a ROS message object to a list"
  (cl:list 'Camino
    (cl:cons ':header (header msg))
    (cl:cons ':punto (punto msg))
))
