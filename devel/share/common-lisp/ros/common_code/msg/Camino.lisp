; Auto-generated. Do not edit!


(cl:in-package common_code-msg)


;//! \htmlinclude Camino.msg.html

(cl:defclass <Camino> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (puntos
    :reader puntos
    :initarg :puntos
    :type (cl:vector common_code-msg:Punto)
   :initform (cl:make-array 0 :element-type 'common_code-msg:Punto :initial-element (cl:make-instance 'common_code-msg:Punto))))
)

(cl:defclass Camino (<Camino>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Camino>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Camino)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name common_code-msg:<Camino> is deprecated: use common_code-msg:Camino instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Camino>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader common_code-msg:header-val is deprecated.  Use common_code-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'puntos-val :lambda-list '(m))
(cl:defmethod puntos-val ((m <Camino>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader common_code-msg:puntos-val is deprecated.  Use common_code-msg:puntos instead.")
  (puntos m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Camino>) ostream)
  "Serializes a message object of type '<Camino>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'puntos))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'puntos))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Camino>) istream)
  "Deserializes a message object of type '<Camino>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'puntos) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'puntos)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'common_code-msg:Punto))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Camino>)))
  "Returns string type for a message object of type '<Camino>"
  "common_code/Camino")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Camino)))
  "Returns string type for a message object of type 'Camino"
  "common_code/Camino")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Camino>)))
  "Returns md5sum for a message object of type '<Camino>"
  "a18639cc1614ee5059ad5ac8d18d4085")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Camino)))
  "Returns md5sum for a message object of type 'Camino"
  "a18639cc1614ee5059ad5ac8d18d4085")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Camino>)))
  "Returns full string definition for message of type '<Camino>"
  (cl:format cl:nil "Header header~%Punto[] puntos~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: common_code/Punto~%Header header~%float64 x~%float64 y~%float64 angulo_pan~%float64 angulo_tilt~%float64 tiempo~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Camino)))
  "Returns full string definition for message of type 'Camino"
  (cl:format cl:nil "Header header~%Punto[] puntos~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: common_code/Punto~%Header header~%float64 x~%float64 y~%float64 angulo_pan~%float64 angulo_tilt~%float64 tiempo~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Camino>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'puntos) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Camino>))
  "Converts a ROS message object to a list"
  (cl:list 'Camino
    (cl:cons ':header (header msg))
    (cl:cons ':puntos (puntos msg))
))
