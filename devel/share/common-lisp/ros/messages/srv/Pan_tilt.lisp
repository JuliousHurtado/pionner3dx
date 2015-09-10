; Auto-generated. Do not edit!


(cl:in-package messages-srv)


;//! \htmlinclude Pan_tilt-request.msg.html

(cl:defclass <Pan_tilt-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Pan_tilt-request (<Pan_tilt-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Pan_tilt-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Pan_tilt-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name messages-srv:<Pan_tilt-request> is deprecated: use messages-srv:Pan_tilt-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Pan_tilt-request>) ostream)
  "Serializes a message object of type '<Pan_tilt-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Pan_tilt-request>) istream)
  "Deserializes a message object of type '<Pan_tilt-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Pan_tilt-request>)))
  "Returns string type for a service object of type '<Pan_tilt-request>"
  "messages/Pan_tiltRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Pan_tilt-request)))
  "Returns string type for a service object of type 'Pan_tilt-request"
  "messages/Pan_tiltRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Pan_tilt-request>)))
  "Returns md5sum for a message object of type '<Pan_tilt-request>"
  "da61f3d6b381bd4af7a066f22fdfa441")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Pan_tilt-request)))
  "Returns md5sum for a message object of type 'Pan_tilt-request"
  "da61f3d6b381bd4af7a066f22fdfa441")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Pan_tilt-request>)))
  "Returns full string definition for message of type '<Pan_tilt-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Pan_tilt-request)))
  "Returns full string definition for message of type 'Pan_tilt-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Pan_tilt-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Pan_tilt-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Pan_tilt-request
))
;//! \htmlinclude Pan_tilt-response.msg.html

(cl:defclass <Pan_tilt-response> (roslisp-msg-protocol:ros-message)
  ((pan
    :reader pan
    :initarg :pan
    :type cl:float
    :initform 0.0)
   (tilt
    :reader tilt
    :initarg :tilt
    :type cl:float
    :initform 0.0))
)

(cl:defclass Pan_tilt-response (<Pan_tilt-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Pan_tilt-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Pan_tilt-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name messages-srv:<Pan_tilt-response> is deprecated: use messages-srv:Pan_tilt-response instead.")))

(cl:ensure-generic-function 'pan-val :lambda-list '(m))
(cl:defmethod pan-val ((m <Pan_tilt-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages-srv:pan-val is deprecated.  Use messages-srv:pan instead.")
  (pan m))

(cl:ensure-generic-function 'tilt-val :lambda-list '(m))
(cl:defmethod tilt-val ((m <Pan_tilt-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages-srv:tilt-val is deprecated.  Use messages-srv:tilt instead.")
  (tilt m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Pan_tilt-response>) ostream)
  "Serializes a message object of type '<Pan_tilt-response>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'pan))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'tilt))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Pan_tilt-response>) istream)
  "Deserializes a message object of type '<Pan_tilt-response>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pan) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tilt) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Pan_tilt-response>)))
  "Returns string type for a service object of type '<Pan_tilt-response>"
  "messages/Pan_tiltResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Pan_tilt-response)))
  "Returns string type for a service object of type 'Pan_tilt-response"
  "messages/Pan_tiltResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Pan_tilt-response>)))
  "Returns md5sum for a message object of type '<Pan_tilt-response>"
  "da61f3d6b381bd4af7a066f22fdfa441")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Pan_tilt-response)))
  "Returns md5sum for a message object of type 'Pan_tilt-response"
  "da61f3d6b381bd4af7a066f22fdfa441")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Pan_tilt-response>)))
  "Returns full string definition for message of type '<Pan_tilt-response>"
  (cl:format cl:nil "float64 pan~%float64 tilt~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Pan_tilt-response)))
  "Returns full string definition for message of type 'Pan_tilt-response"
  (cl:format cl:nil "float64 pan~%float64 tilt~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Pan_tilt-response>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Pan_tilt-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Pan_tilt-response
    (cl:cons ':pan (pan msg))
    (cl:cons ':tilt (tilt msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Pan_tilt)))
  'Pan_tilt-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Pan_tilt)))
  'Pan_tilt-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Pan_tilt)))
  "Returns string type for a service object of type '<Pan_tilt>"
  "messages/Pan_tilt")