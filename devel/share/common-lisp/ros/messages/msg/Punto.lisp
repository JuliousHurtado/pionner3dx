; Auto-generated. Do not edit!


(cl:in-package messages-msg)


;//! \htmlinclude Punto.msg.html

(cl:defclass <Punto> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (x
    :reader x
    :initarg :x
    :type cl:integer
    :initform 0)
   (y
    :reader y
    :initarg :y
    :type cl:integer
    :initform 0)
   (angulo_pan
    :reader angulo_pan
    :initarg :angulo_pan
    :type cl:integer
    :initform 0)
   (angulo_tilt
    :reader angulo_tilt
    :initarg :angulo_tilt
    :type cl:integer
    :initform 0)
   (tiempo
    :reader tiempo
    :initarg :tiempo
    :type cl:real
    :initform 0))
)

(cl:defclass Punto (<Punto>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Punto>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Punto)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name messages-msg:<Punto> is deprecated: use messages-msg:Punto instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Punto>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages-msg:header-val is deprecated.  Use messages-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <Punto>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages-msg:x-val is deprecated.  Use messages-msg:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <Punto>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages-msg:y-val is deprecated.  Use messages-msg:y instead.")
  (y m))

(cl:ensure-generic-function 'angulo_pan-val :lambda-list '(m))
(cl:defmethod angulo_pan-val ((m <Punto>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages-msg:angulo_pan-val is deprecated.  Use messages-msg:angulo_pan instead.")
  (angulo_pan m))

(cl:ensure-generic-function 'angulo_tilt-val :lambda-list '(m))
(cl:defmethod angulo_tilt-val ((m <Punto>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages-msg:angulo_tilt-val is deprecated.  Use messages-msg:angulo_tilt instead.")
  (angulo_tilt m))

(cl:ensure-generic-function 'tiempo-val :lambda-list '(m))
(cl:defmethod tiempo-val ((m <Punto>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages-msg:tiempo-val is deprecated.  Use messages-msg:tiempo instead.")
  (tiempo m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Punto>) ostream)
  "Serializes a message object of type '<Punto>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'x)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'y)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'angulo_pan)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'angulo_tilt)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'tiempo)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'tiempo) (cl:floor (cl:slot-value msg 'tiempo)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Punto>) istream)
  "Deserializes a message object of type '<Punto>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'x) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'y) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'angulo_pan) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'angulo_tilt) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'tiempo) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Punto>)))
  "Returns string type for a message object of type '<Punto>"
  "messages/Punto")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Punto)))
  "Returns string type for a message object of type 'Punto"
  "messages/Punto")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Punto>)))
  "Returns md5sum for a message object of type '<Punto>"
  "feca8e1b82456800d729e7700a801e9b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Punto)))
  "Returns md5sum for a message object of type 'Punto"
  "feca8e1b82456800d729e7700a801e9b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Punto>)))
  "Returns full string definition for message of type '<Punto>"
  (cl:format cl:nil "Header header~%int32 x~%int32 y~%int32 angulo_pan~%int32 angulo_tilt~%time tiempo~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Punto)))
  "Returns full string definition for message of type 'Punto"
  (cl:format cl:nil "Header header~%int32 x~%int32 y~%int32 angulo_pan~%int32 angulo_tilt~%time tiempo~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Punto>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Punto>))
  "Converts a ROS message object to a list"
  (cl:list 'Punto
    (cl:cons ':header (header msg))
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':angulo_pan (angulo_pan msg))
    (cl:cons ':angulo_tilt (angulo_tilt msg))
    (cl:cons ':tiempo (tiempo msg))
))
