// Generated by gencpp from file robot_cuadrupedo/robot_state.msg
// DO NOT EDIT!


#ifndef ROBOT_CUADRUPEDO_MESSAGE_ROBOT_STATE_H
#define ROBOT_CUADRUPEDO_MESSAGE_ROBOT_STATE_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <robot_cuadrupedo_msgs/robot_velocity.h>

namespace robot_cuadrupedo
{
template <class ContainerAllocator>
struct robot_state_
{
  typedef robot_state_<ContainerAllocator> Type;

  robot_state_()
    : rc()  {
    }
  robot_state_(const ContainerAllocator& _alloc)
    : rc(_alloc)  {
  (void)_alloc;
    }



   typedef  ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator>  _rc_type;
  _rc_type rc;





  typedef boost::shared_ptr< ::robot_cuadrupedo::robot_state_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::robot_cuadrupedo::robot_state_<ContainerAllocator> const> ConstPtr;

}; // struct robot_state_

typedef ::robot_cuadrupedo::robot_state_<std::allocator<void> > robot_state;

typedef boost::shared_ptr< ::robot_cuadrupedo::robot_state > robot_statePtr;
typedef boost::shared_ptr< ::robot_cuadrupedo::robot_state const> robot_stateConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::robot_cuadrupedo::robot_state_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::robot_cuadrupedo::robot_state_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::robot_cuadrupedo::robot_state_<ContainerAllocator1> & lhs, const ::robot_cuadrupedo::robot_state_<ContainerAllocator2> & rhs)
{
  return lhs.rc == rhs.rc;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::robot_cuadrupedo::robot_state_<ContainerAllocator1> & lhs, const ::robot_cuadrupedo::robot_state_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace robot_cuadrupedo

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::robot_cuadrupedo::robot_state_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::robot_cuadrupedo::robot_state_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::robot_cuadrupedo::robot_state_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::robot_cuadrupedo::robot_state_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::robot_cuadrupedo::robot_state_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::robot_cuadrupedo::robot_state_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::robot_cuadrupedo::robot_state_<ContainerAllocator> >
{
  static const char* value()
  {
    return "4aab73bea9dabf128c8c483534d2bbfe";
  }

  static const char* value(const ::robot_cuadrupedo::robot_state_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x4aab73bea9dabf12ULL;
  static const uint64_t static_value2 = 0x8c8c483534d2bbfeULL;
};

template<class ContainerAllocator>
struct DataType< ::robot_cuadrupedo::robot_state_<ContainerAllocator> >
{
  static const char* value()
  {
    return "robot_cuadrupedo/robot_state";
  }

  static const char* value(const ::robot_cuadrupedo::robot_state_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::robot_cuadrupedo::robot_state_<ContainerAllocator> >
{
  static const char* value()
  {
    return "robot_cuadrupedo_msgs/robot_velocity rc\n"
"================================================================================\n"
"MSG: robot_cuadrupedo_msgs/robot_velocity\n"
"bool walk\n"
"float64 velocity\n"
;
  }

  static const char* value(const ::robot_cuadrupedo::robot_state_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::robot_cuadrupedo::robot_state_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.rc);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct robot_state_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::robot_cuadrupedo::robot_state_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::robot_cuadrupedo::robot_state_<ContainerAllocator>& v)
  {
    s << indent << "rc: ";
    s << std::endl;
    Printer< ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator> >::stream(s, indent + "  ", v.rc);
  }
};

} // namespace message_operations
} // namespace ros

#endif // ROBOT_CUADRUPEDO_MESSAGE_ROBOT_STATE_H
