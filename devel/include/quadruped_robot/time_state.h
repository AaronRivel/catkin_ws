// Generated by gencpp from file quadruped_robot/time_state.msg
// DO NOT EDIT!


#ifndef QUADRUPED_ROBOT_MESSAGE_TIME_STATE_H
#define QUADRUPED_ROBOT_MESSAGE_TIME_STATE_H


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
struct time_state_
{
  typedef time_state_<ContainerAllocator> Type;

  time_state_()
    : t(0.0)
    , q0(0.0)
    , q1(0.0)
    , q0_dot(0.0)
    , q1_dot(0.0)  {
    }
  time_state_(const ContainerAllocator& _alloc)
    : t(0.0)
    , q0(0.0)
    , q1(0.0)
    , q0_dot(0.0)
    , q1_dot(0.0)  {
  (void)_alloc;
    }



   typedef double _t_type;
  _t_type t;

   typedef double _q0_type;
  _q0_type q0;

   typedef double _q1_type;
  _q1_type q1;

   typedef double _q0_dot_type;
  _q0_dot_type q0_dot;

   typedef double _q1_dot_type;
  _q1_dot_type q1_dot;





  typedef boost::shared_ptr< ::quadruped_robot::time_state_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::quadruped_robot::time_state_<ContainerAllocator> const> ConstPtr;

}; // struct time_state_

typedef ::quadruped_robot::time_state_<std::allocator<void> > time_state;

typedef boost::shared_ptr< ::quadruped_robot::time_state > time_statePtr;
typedef boost::shared_ptr< ::quadruped_robot::time_state const> time_stateConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::quadruped_robot::time_state_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::quadruped_robot::time_state_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::quadruped_robot::time_state_<ContainerAllocator1> & lhs, const ::quadruped_robot::time_state_<ContainerAllocator2> & rhs)
{
  return lhs.t == rhs.t &&
    lhs.q0 == rhs.q0 &&
    lhs.q1 == rhs.q1 &&
    lhs.q0_dot == rhs.q0_dot &&
    lhs.q1_dot == rhs.q1_dot;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::quadruped_robot::time_state_<ContainerAllocator1> & lhs, const ::quadruped_robot::time_state_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace quadruped_robot

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::quadruped_robot::time_state_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::quadruped_robot::time_state_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::quadruped_robot::time_state_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::quadruped_robot::time_state_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::quadruped_robot::time_state_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::quadruped_robot::time_state_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::quadruped_robot::time_state_<ContainerAllocator> >
{
  static const char* value()
  {
    return "fdf95eab8e31bbe478f129be831ec16a";
  }

  static const char* value(const ::quadruped_robot::time_state_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xfdf95eab8e31bbe4ULL;
  static const uint64_t static_value2 = 0x78f129be831ec16aULL;
};

template<class ContainerAllocator>
struct DataType< ::quadruped_robot::time_state_<ContainerAllocator> >
{
  static const char* value()
  {
    return "quadruped_robot/time_state";
  }

  static const char* value(const ::quadruped_robot::time_state_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::quadruped_robot::time_state_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float64 t\n"
"float64 q0\n"
"float64 q1\n"
"float64 q0_dot\n"
"float64 q1_dot\n"
;
  }

  static const char* value(const ::quadruped_robot::time_state_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::quadruped_robot::time_state_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.t);
      stream.next(m.q0);
      stream.next(m.q1);
      stream.next(m.q0_dot);
      stream.next(m.q1_dot);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct time_state_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::quadruped_robot::time_state_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::quadruped_robot::time_state_<ContainerAllocator>& v)
  {
    s << indent << "t: ";
    Printer<double>::stream(s, indent + "  ", v.t);
    s << indent << "q0: ";
    Printer<double>::stream(s, indent + "  ", v.q0);
    s << indent << "q1: ";
    Printer<double>::stream(s, indent + "  ", v.q1);
    s << indent << "q0_dot: ";
    Printer<double>::stream(s, indent + "  ", v.q0_dot);
    s << indent << "q1_dot: ";
    Printer<double>::stream(s, indent + "  ", v.q1_dot);
  }
};

} // namespace message_operations
} // namespace ros

#endif // QUADRUPED_ROBOT_MESSAGE_TIME_STATE_H