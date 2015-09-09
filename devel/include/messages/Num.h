// Generated by gencpp from file messages/Num.msg
// DO NOT EDIT!


#ifndef MESSAGES_MESSAGE_NUM_H
#define MESSAGES_MESSAGE_NUM_H


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
struct Num_
{
  typedef Num_<ContainerAllocator> Type;

  Num_()
    : header()
    , num(0)  {
    }
  Num_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , num(0)  {
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef int32_t _num_type;
  _num_type num;




  typedef boost::shared_ptr< ::messages::Num_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::messages::Num_<ContainerAllocator> const> ConstPtr;

}; // struct Num_

typedef ::messages::Num_<std::allocator<void> > Num;

typedef boost::shared_ptr< ::messages::Num > NumPtr;
typedef boost::shared_ptr< ::messages::Num const> NumConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::messages::Num_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::messages::Num_<ContainerAllocator> >::stream(s, "", v);
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
struct IsFixedSize< ::messages::Num_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::messages::Num_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::messages::Num_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::messages::Num_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::messages::Num_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::messages::Num_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::messages::Num_<ContainerAllocator> >
{
  static const char* value()
  {
    return "aeeda2956bdcc9d4f37a4aa337a4c7c0";
  }

  static const char* value(const ::messages::Num_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xaeeda2956bdcc9d4ULL;
  static const uint64_t static_value2 = 0xf37a4aa337a4c7c0ULL;
};

template<class ContainerAllocator>
struct DataType< ::messages::Num_<ContainerAllocator> >
{
  static const char* value()
  {
    return "messages/Num";
  }

  static const char* value(const ::messages::Num_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::messages::Num_<ContainerAllocator> >
{
  static const char* value()
  {
    return "Header header\n\
int32 num\n\
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

  static const char* value(const ::messages::Num_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::messages::Num_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.num);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER;
  }; // struct Num_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::messages::Num_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::messages::Num_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "num: ";
    Printer<int32_t>::stream(s, indent + "  ", v.num);
  }
};

} // namespace message_operations
} // namespace ros

#endif // MESSAGES_MESSAGE_NUM_H
