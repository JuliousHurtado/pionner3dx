// Generated by gencpp from file messages/Punto.msg
// DO NOT EDIT!


#ifndef MESSAGES_MESSAGE_PUNTO_H
#define MESSAGES_MESSAGE_PUNTO_H


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
struct Punto_
{
  typedef Punto_<ContainerAllocator> Type;

  Punto_()
    : header()
    , x(0.0)
    , y(0.0)
    , angulo_pan(0.0)
    , angulo_tilt(0.0)
    , tiempo(0.0)  {
    }
  Punto_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , x(0.0)
    , y(0.0)
    , angulo_pan(0.0)
    , angulo_tilt(0.0)
    , tiempo(0.0)  {
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef double _x_type;
  _x_type x;

   typedef double _y_type;
  _y_type y;

   typedef double _angulo_pan_type;
  _angulo_pan_type angulo_pan;

   typedef double _angulo_tilt_type;
  _angulo_tilt_type angulo_tilt;

   typedef double _tiempo_type;
  _tiempo_type tiempo;




  typedef boost::shared_ptr< ::messages::Punto_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::messages::Punto_<ContainerAllocator> const> ConstPtr;

}; // struct Punto_

typedef ::messages::Punto_<std::allocator<void> > Punto;

typedef boost::shared_ptr< ::messages::Punto > PuntoPtr;
typedef boost::shared_ptr< ::messages::Punto const> PuntoConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::messages::Punto_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::messages::Punto_<ContainerAllocator> >::stream(s, "", v);
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
struct IsFixedSize< ::messages::Punto_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::messages::Punto_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::messages::Punto_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::messages::Punto_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::messages::Punto_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::messages::Punto_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::messages::Punto_<ContainerAllocator> >
{
  static const char* value()
  {
    return "3e2dde8e5483b601bd85a0bcfe1e9b50";
  }

  static const char* value(const ::messages::Punto_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x3e2dde8e5483b601ULL;
  static const uint64_t static_value2 = 0xbd85a0bcfe1e9b50ULL;
};

template<class ContainerAllocator>
struct DataType< ::messages::Punto_<ContainerAllocator> >
{
  static const char* value()
  {
    return "messages/Punto";
  }

  static const char* value(const ::messages::Punto_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::messages::Punto_<ContainerAllocator> >
{
  static const char* value()
  {
    return "Header header\n\
float64 x\n\
float64 y\n\
float64 angulo_pan\n\
float64 angulo_tilt\n\
float64 tiempo\n\
\n\
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

  static const char* value(const ::messages::Punto_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::messages::Punto_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.x);
      stream.next(m.y);
      stream.next(m.angulo_pan);
      stream.next(m.angulo_tilt);
      stream.next(m.tiempo);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER;
  }; // struct Punto_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::messages::Punto_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::messages::Punto_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "x: ";
    Printer<double>::stream(s, indent + "  ", v.x);
    s << indent << "y: ";
    Printer<double>::stream(s, indent + "  ", v.y);
    s << indent << "angulo_pan: ";
    Printer<double>::stream(s, indent + "  ", v.angulo_pan);
    s << indent << "angulo_tilt: ";
    Printer<double>::stream(s, indent + "  ", v.angulo_tilt);
    s << indent << "tiempo: ";
    Printer<double>::stream(s, indent + "  ", v.tiempo);
  }
};

} // namespace message_operations
} // namespace ros

#endif // MESSAGES_MESSAGE_PUNTO_H
