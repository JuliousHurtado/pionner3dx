// Generated by gencpp from file messages/Orientacion.msg
// DO NOT EDIT!


#ifndef MESSAGES_MESSAGE_ORIENTACION_H
#define MESSAGES_MESSAGE_ORIENTACION_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Header.h>

namespace messages
{
template <class ContainerAllocator>
struct Orientacion_
{
  typedef Orientacion_<ContainerAllocator> Type;

  Orientacion_()
    : header()
    , x(0.0)
    , y(0.0)
    , z(0.0)
    , w(0.0)  {
    }
  Orientacion_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , x(0.0)
    , y(0.0)
    , z(0.0)
    , w(0.0)  {
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef double _x_type;
  _x_type x;

   typedef double _y_type;
  _y_type y;

   typedef double _z_type;
  _z_type z;

   typedef double _w_type;
  _w_type w;




  typedef boost::shared_ptr< ::messages::Orientacion_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::messages::Orientacion_<ContainerAllocator> const> ConstPtr;

}; // struct Orientacion_

typedef ::messages::Orientacion_<std::allocator<void> > Orientacion;

typedef boost::shared_ptr< ::messages::Orientacion > OrientacionPtr;
typedef boost::shared_ptr< ::messages::Orientacion const> OrientacionConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::messages::Orientacion_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::messages::Orientacion_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace messages

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': True}
// {'std_msgs': ['/opt/ros/indigo/share/std_msgs/cmake/../msg'], 'messages': ['/home/champion/catkin_ws/src/messages/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::messages::Orientacion_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::messages::Orientacion_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::messages::Orientacion_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::messages::Orientacion_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::messages::Orientacion_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::messages::Orientacion_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::messages::Orientacion_<ContainerAllocator> >
{
  static const char* value()
  {
    return "4b732bf4f836c3b6fbdd39c091837af6";
  }

  static const char* value(const ::messages::Orientacion_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x4b732bf4f836c3b6ULL;
  static const uint64_t static_value2 = 0xfbdd39c091837af6ULL;
};

template<class ContainerAllocator>
struct DataType< ::messages::Orientacion_<ContainerAllocator> >
{
  static const char* value()
  {
    return "messages/Orientacion";
  }

  static const char* value(const ::messages::Orientacion_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::messages::Orientacion_<ContainerAllocator> >
{
  static const char* value()
  {
    return "Header header\n\
float64 x\n\
float64 y\n\
float64 z\n\
float64 w\n\
================================================================================\n\
MSG: std_msgs/Header\n\
# Standard metadata for higher-level stamped data types.\n\
# This is generally used to communicate timestamped data \n\
# in a particular coordinate frame.\n\
# \n\
# sequence ID: consecutively increasing ID \n\
uint32 seq\n\
#Two-integer timestamp that is expressed as:\n\
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')\n\
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')\n\
# time-handling sugar is provided by the client library\n\
time stamp\n\
#Frame this data is associated with\n\
# 0: no frame\n\
# 1: global frame\n\
string frame_id\n\
";
  }

  static const char* value(const ::messages::Orientacion_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::messages::Orientacion_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.x);
      stream.next(m.y);
      stream.next(m.z);
      stream.next(m.w);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER;
  }; // struct Orientacion_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::messages::Orientacion_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::messages::Orientacion_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "x: ";
    Printer<double>::stream(s, indent + "  ", v.x);
    s << indent << "y: ";
    Printer<double>::stream(s, indent + "  ", v.y);
    s << indent << "z: ";
    Printer<double>::stream(s, indent + "  ", v.z);
    s << indent << "w: ";
    Printer<double>::stream(s, indent + "  ", v.w);
  }
};

} // namespace message_operations
} // namespace ros

#endif // MESSAGES_MESSAGE_ORIENTACION_H
