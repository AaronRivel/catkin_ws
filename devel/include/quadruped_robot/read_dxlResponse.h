// Generated by gencpp from file quadruped_robot/read_dxlResponse.msg
// DO NOT EDIT!


#ifndef QUADRUPED_ROBOT_MESSAGE_READ_DXLRESPONSE_H
#define QUADRUPED_ROBOT_MESSAGE_READ_DXLRESPONSE_H


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
struct read_dxlResponse_
{
  typedef read_dxlResponse_<ContainerAllocator> Type;

  read_dxlResponse_()
    : result_1(0)
    , result_2(0)  {
    }
  read_dxlResponse_(const ContainerAllocator& _alloc)
    : result_1(0)
    , result_2(0)  {
  (void)_alloc;
    }



   typedef int64_t _result_1_type;
  _result_1_type result_1;

   typedef int64_t _result_2_type;
  _result_2_type result_2;





  typedef boost::shared_ptr< ::quadruped_robot::read_dxlResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::quadruped_robot::read_dxlResponse_<ContainerAllocator> const> ConstPtr;

}; // struct read_dxlResponse_

typedef ::quadruped_robot::read_dxlResponse_<std::allocator<void> > read_dxlResponse;

typedef boost::shared_ptr< ::quadruped_robot::read_dxlResponse > read_dxlResponsePtr;
typedef boost::shared_ptr< ::quadruped_robot::read_dxlResponse const> read_dxlResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::quadruped_robot::read_dxlResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::quadruped_robot::read_dxlResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::quadruped_robot::read_dxlResponse_<ContainerAllocator1> & lhs, const ::quadruped_robot::read_dxlResponse_<ContainerAllocator2> & rhs)
{
  return lhs.result_1 == rhs.result_1 &&
    lhs.result_2 == rhs.result_2;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::quadruped_robot::read_dxlResponse_<ContainerAllocator1> & lhs, const ::quadruped_robot::read_dxlResponse_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace quadruped_robot

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::quadruped_robot::read_dxlResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::quadruped_robot::read_dxlResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::quadruped_robot::read_dxlResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::quadruped_robot::read_dxlResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::quadruped_robot::read_dxlResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::quadruped_robot::read_dxlResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::quadruped_robot::read_dxlResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "576860b30f3ab6552ab3ffead7c691b3";
  }

  static const char* value(const ::quadruped_robot::read_dxlResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x576860b30f3ab655ULL;
  static const uint64_t static_value2 = 0x2ab3ffead7c691b3ULL;
};

template<class ContainerAllocator>
struct DataType< ::quadruped_robot::read_dxlResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "quadruped_robot/read_dxlResponse";
  }

  static const char* value(const ::quadruped_robot::read_dxlResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::quadruped_robot::read_dxlResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "int64 result_1\n"
"int64 result_2\n"
;
  }

  static const char* value(const ::quadruped_robot::read_dxlResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::quadruped_robot::read_dxlResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.result_1);
      stream.next(m.result_2);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct read_dxlResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::quadruped_robot::read_dxlResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::quadruped_robot::read_dxlResponse_<ContainerAllocator>& v)
  {
    s << indent << "result_1: ";
    Printer<int64_t>::stream(s, indent + "  ", v.result_1);
    s << indent << "result_2: ";
    Printer<int64_t>::stream(s, indent + "  ", v.result_2);
  }
};

} // namespace message_operations
} // namespace ros

#endif // QUADRUPED_ROBOT_MESSAGE_READ_DXLRESPONSE_H
