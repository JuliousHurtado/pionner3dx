; Auto-generated. Do not edit!


(cl:in-package common_code-msg)


;//! \htmlinclude Pan_tilt.msg.html

(cl:defclass <Pan_tilt> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (pan
    :reader pan
    :initarg :pan
    :type cl:fixnum
    :initform 0)
   (tilt
    :reader tilt
    :initarg :tilt
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Pan_tilt (<Pan_tilt>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Pan_tilt>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Pan_tilt)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name common_code-msg:<Pan_tilt> is deprecated: use common_code-msg:Pan_tilt instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Pan_tilt>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader common_code-msg:header-val is deprecated.  Use common_code-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'pan-val :lambda-list '(m))
(cl:defmethod pan-val ((m <Pan_tilt>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader common_code-msg:pan-val is deprecated.  Use common_code-msg:pan instead.")
  (pan m))

(cl:ensure-generic-function 'tilt-val :lambda-list '(m))
(cl:defmethod tilt-val ((m <Pan_tilt>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader common_code-msg:tilt-val is deprecated.  Use common_code-msg:tilt instead.")
  (tilt m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Pan_tilt>) ostream)
  "Serializes a message object of type '<Pan_tilt>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'pan)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'tilt)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Pan_tilt>) istream)
  "Deserializes a message object of type '<Pan_tilt>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pan) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'tilt) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Pan_tilt>)))
  "Returns string type for a message object of type '<Pan_tilt>"
  "common_code/Pan_tilt")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Pan_tilt)))
  "Returns string type for a message object of type 'Pan_tilt"
  "common_code/Pan_tilt")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Pan_tilt>)))
  "Returns md5sum for a message object of type '<Pan_tilt>"
  "31595efae5e994e135d1ca761663bf39")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Pan_tilt)))
  "Returns md5sum for a message object of type 'Pan_tilt"
  "31595efae5e994e135d1ca761663bf39")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Pan_tilt>)))
  "Returns full string definition for message of type '<Pan_tilt>"
  (cl:format cl:nil "Header header~%int16 pan~%int16 tilt~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Pan_tilt)))
  "Returns full string definition for message of type 'Pan_tilt"
  (cl:format cl:nil "Header header~%int16 pan~%int16 tilt~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Pan_tilt>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     2
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Pan_tilt>))
  "Converts a ROS message object to a list"
  (cl:list 'Pan_tilt
    (cl:cons ':header (header msg))
    (cl:cons ':pan (pan msg))
    (cl:cons ':tilt (tilt msg))
))
