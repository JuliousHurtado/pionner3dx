; Auto-generated. Do not edit!


(cl:in-package il_map_tools-srv)


;//! \htmlinclude Pan_tilt-request.msg.html

(cl:defclass <Pan_tilt-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Pan_tilt-request (<Pan_tilt-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Pan_tilt-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Pan_tilt-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name il_map_tools-srv:<Pan_tilt-request> is deprecated: use il_map_tools-srv:Pan_tilt-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Pan_tilt-request>) ostream)
  "Serializes a message object of type '<Pan_tilt-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Pan_tilt-request>) istream)
  "Deserializes a message object of type '<Pan_tilt-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Pan_tilt-request>)))
  "Returns string type for a service object of type '<Pan_tilt-request>"
  "il_map_tools/Pan_tiltRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Pan_tilt-request)))
  "Returns string type for a service object of type 'Pan_tilt-request"
  "il_map_tools/Pan_tiltRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Pan_tilt-request>)))
  "Returns md5sum for a message object of type '<Pan_tilt-request>"
  "8758be18bed045a5f20b257314365f33")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Pan_tilt-request)))
  "Returns md5sum for a message object of type 'Pan_tilt-request"
  "8758be18bed045a5f20b257314365f33")
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
  ((angles
    :reader angles
    :initarg :angles
    :type (cl:vector cl:float)
   :initform (cl:make-array 2 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass Pan_tilt-response (<Pan_tilt-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Pan_tilt-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Pan_tilt-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name il_map_tools-srv:<Pan_tilt-response> is deprecated: use il_map_tools-srv:Pan_tilt-response instead.")))

(cl:ensure-generic-function 'angles-val :lambda-list '(m))
(cl:defmethod angles-val ((m <Pan_tilt-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader il_map_tools-srv:angles-val is deprecated.  Use il_map_tools-srv:angles instead.")
  (angles m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Pan_tilt-response>) ostream)
  "Serializes a message object of type '<Pan_tilt-response>"
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'angles))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Pan_tilt-response>) istream)
  "Deserializes a message object of type '<Pan_tilt-response>"
  (cl:setf (cl:slot-value msg 'angles) (cl:make-array 2))
  (cl:let ((vals (cl:slot-value msg 'angles)))
    (cl:dotimes (i 2)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Pan_tilt-response>)))
  "Returns string type for a service object of type '<Pan_tilt-response>"
  "il_map_tools/Pan_tiltResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Pan_tilt-response)))
  "Returns string type for a service object of type 'Pan_tilt-response"
  "il_map_tools/Pan_tiltResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Pan_tilt-response>)))
  "Returns md5sum for a message object of type '<Pan_tilt-response>"
  "8758be18bed045a5f20b257314365f33")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Pan_tilt-response)))
  "Returns md5sum for a message object of type 'Pan_tilt-response"
  "8758be18bed045a5f20b257314365f33")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Pan_tilt-response>)))
  "Returns full string definition for message of type '<Pan_tilt-response>"
  (cl:format cl:nil "float64[2] angles~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Pan_tilt-response)))
  "Returns full string definition for message of type 'Pan_tilt-response"
  (cl:format cl:nil "float64[2] angles~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Pan_tilt-response>))
  (cl:+ 0
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'angles) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Pan_tilt-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Pan_tilt-response
    (cl:cons ':angles (angles msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Pan_tilt)))
  'Pan_tilt-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Pan_tilt)))
  'Pan_tilt-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Pan_tilt)))
  "Returns string type for a service object of type '<Pan_tilt>"
  "il_map_tools/Pan_tilt")