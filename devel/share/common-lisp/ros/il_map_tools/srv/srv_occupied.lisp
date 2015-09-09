; Auto-generated. Do not edit!


(cl:in-package il_map_tools-srv)


;//! \htmlinclude srv_occupied-request.msg.html

(cl:defclass <srv_occupied-request> (roslisp-msg-protocol:ros-message)
  ((pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose)))
)

(cl:defclass srv_occupied-request (<srv_occupied-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <srv_occupied-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'srv_occupied-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name il_map_tools-srv:<srv_occupied-request> is deprecated: use il_map_tools-srv:srv_occupied-request instead.")))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <srv_occupied-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader il_map_tools-srv:pose-val is deprecated.  Use il_map_tools-srv:pose instead.")
  (pose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <srv_occupied-request>) ostream)
  "Serializes a message object of type '<srv_occupied-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <srv_occupied-request>) istream)
  "Deserializes a message object of type '<srv_occupied-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<srv_occupied-request>)))
  "Returns string type for a service object of type '<srv_occupied-request>"
  "il_map_tools/srv_occupiedRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'srv_occupied-request)))
  "Returns string type for a service object of type 'srv_occupied-request"
  "il_map_tools/srv_occupiedRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<srv_occupied-request>)))
  "Returns md5sum for a message object of type '<srv_occupied-request>"
  "5c8af5f97a4667b1e2ca25d4017d3de1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'srv_occupied-request)))
  "Returns md5sum for a message object of type 'srv_occupied-request"
  "5c8af5f97a4667b1e2ca25d4017d3de1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<srv_occupied-request>)))
  "Returns full string definition for message of type '<srv_occupied-request>"
  (cl:format cl:nil "geometry_msgs/Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'srv_occupied-request)))
  "Returns full string definition for message of type 'srv_occupied-request"
  (cl:format cl:nil "geometry_msgs/Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <srv_occupied-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <srv_occupied-request>))
  "Converts a ROS message object to a list"
  (cl:list 'srv_occupied-request
    (cl:cons ':pose (pose msg))
))
;//! \htmlinclude srv_occupied-response.msg.html

(cl:defclass <srv_occupied-response> (roslisp-msg-protocol:ros-message)
  ((occupied
    :reader occupied
    :initarg :occupied
    :type cl:fixnum
    :initform 0))
)

(cl:defclass srv_occupied-response (<srv_occupied-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <srv_occupied-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'srv_occupied-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name il_map_tools-srv:<srv_occupied-response> is deprecated: use il_map_tools-srv:srv_occupied-response instead.")))

(cl:ensure-generic-function 'occupied-val :lambda-list '(m))
(cl:defmethod occupied-val ((m <srv_occupied-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader il_map_tools-srv:occupied-val is deprecated.  Use il_map_tools-srv:occupied instead.")
  (occupied m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <srv_occupied-response>) ostream)
  "Serializes a message object of type '<srv_occupied-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'occupied)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <srv_occupied-response>) istream)
  "Deserializes a message object of type '<srv_occupied-response>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'occupied)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<srv_occupied-response>)))
  "Returns string type for a service object of type '<srv_occupied-response>"
  "il_map_tools/srv_occupiedResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'srv_occupied-response)))
  "Returns string type for a service object of type 'srv_occupied-response"
  "il_map_tools/srv_occupiedResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<srv_occupied-response>)))
  "Returns md5sum for a message object of type '<srv_occupied-response>"
  "5c8af5f97a4667b1e2ca25d4017d3de1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'srv_occupied-response)))
  "Returns md5sum for a message object of type 'srv_occupied-response"
  "5c8af5f97a4667b1e2ca25d4017d3de1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<srv_occupied-response>)))
  "Returns full string definition for message of type '<srv_occupied-response>"
  (cl:format cl:nil "uint8 occupied~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'srv_occupied-response)))
  "Returns full string definition for message of type 'srv_occupied-response"
  (cl:format cl:nil "uint8 occupied~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <srv_occupied-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <srv_occupied-response>))
  "Converts a ROS message object to a list"
  (cl:list 'srv_occupied-response
    (cl:cons ':occupied (occupied msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'srv_occupied)))
  'srv_occupied-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'srv_occupied)))
  'srv_occupied-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'srv_occupied)))
  "Returns string type for a service object of type '<srv_occupied>"
  "il_map_tools/srv_occupied")