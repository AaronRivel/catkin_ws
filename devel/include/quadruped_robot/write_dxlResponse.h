// Generated by gencpp from file quadruped_robot/write_dxlResponse.msg
// DO NOT EDIT!


#ifndef QUADRUPED_ROBOT_MESSAGE_WRITE_DXLRESPONSE_H
#define QUADRUPED_ROBOT_MESSAGE_WRITE_DXLRESPONSE_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace quadruped_robot
{
template <class ContainerAllocator>
struct write_dxlResponse_
{
  typedef write_dxlResponse_<ContainerAllocator> Type;

  write_dxlResponse_()
    : result(false)  {
    }
  write_dxlResponse_(const ContainerAllocator& _alloc)
    : result(false)  {
  (void)_alloc;
    }



   typedef uint8_t _result_type;
  _result_type result;





  typedef boost::shared_ptr< ::quadruped_robot::write_dxlResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::quadruped_robot::write_dxlResponse_<ContainerAllocator> const> ConstPtr;

}; // struct write_dxlResponse_

typedef ::quadruped_robot::write_dxlResponse_<std::allocator<void> > write_dxlResponse;

typedef boost::shared_ptr< ::quadruped_robot::write_dxlResponse > write_dxlResponsePtr;
typedef boost::shared_ptr< ::quadruped_robot::write_dxlResponse const> write_dxlResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::quadruped_robot::write_dxlResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::quadruped_robot::write_dxlResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::quadruped_robot::write_dxlResponse_<ContainerAllocator1> & lhs, const ::quadruped_robot::write_dxlResponse_<ContainerAllocator2> & rhs)
{
  return lhs.result == rhs.result;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::quadruped_robot::write_dxlResponse_<ContainerAllocator1> & lhs, const ::quadruped_robot::write_dxlResponse_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace quadruped_robot

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::quadruped_robot::write_dxlResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::quadruped_robot::write_dxlResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::quadruped_robot::write_dxlResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::quadruped_robot::write_dxlResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::quadruped_robot::write_dxlResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::quadruped_robot::write_dxlResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::quadruped_robot::write_dxlResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "eb13ac1f1354ccecb7941ee8fa2192e8";
  }

  static const char* value(const ::quadruped_robot::write_dxlResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xeb13ac1f1354ccecULL;
  static const uint64_t static_value2 = 0xb7941ee8fa2192e8ULL;
};

template<class ContainerAllocator>
struct DataType< ::quadruped_robot::write_dxlResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "quadruped_robot/write_dxlResponse";
  }

  static const char* value(const ::quadruped_robot::write_dxlResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::quadruped_robot::write_dxlResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "bool result\n"
;
  }

  static const char* value(const ::quadruped_robot::write_dxlResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::quadruped_robot::write_dxlResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.result);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct write_dxlResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::quadruped_robot::write_dxlResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::quadruped_robot::write_dxlResponse_<ContainerAllocator>& v)
  {
    s << indent << "result: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.result);
  }
};

} // namespace message_operations
} // namespace ros

#endif // QUADRUPED_ROBOT_MESSAGE_WRITE_DXLRESPONSE_H
