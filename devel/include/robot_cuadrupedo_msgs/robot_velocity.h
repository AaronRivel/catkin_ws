// Generated by gencpp from file robot_cuadrupedo_msgs/robot_velocity.msg
// DO NOT EDIT!


#ifndef ROBOT_CUADRUPEDO_MSGS_MESSAGE_ROBOT_VELOCITY_H
#define ROBOT_CUADRUPEDO_MSGS_MESSAGE_ROBOT_VELOCITY_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace robot_cuadrupedo_msgs
{
template <class ContainerAllocator>
struct robot_velocity_
{
  typedef robot_velocity_<ContainerAllocator> Type;

  robot_velocity_()
    : walk(false)
    , velocity(0.0)  {
    }
  robot_velocity_(const ContainerAllocator& _alloc)
    : walk(false)
    , velocity(0.0)  {
  (void)_alloc;
    }



   typedef uint8_t _walk_type;
  _walk_type walk;

   typedef double _velocity_type;
  _velocity_type velocity;





  typedef boost::shared_ptr< ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator> const> ConstPtr;

}; // struct robot_velocity_

typedef ::robot_cuadrupedo_msgs::robot_velocity_<std::allocator<void> > robot_velocity;

typedef boost::shared_ptr< ::robot_cuadrupedo_msgs::robot_velocity > robot_velocityPtr;
typedef boost::shared_ptr< ::robot_cuadrupedo_msgs::robot_velocity const> robot_velocityConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator1> & lhs, const ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator2> & rhs)
{
  return lhs.walk == rhs.walk &&
    lhs.velocity == rhs.velocity;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator1> & lhs, const ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace robot_cuadrupedo_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator> >
{
  static const char* value()
  {
    return "8bed2b6d4486708eb51d1d25b9ec31fb";
  }

  static const char* value(const ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x8bed2b6d4486708eULL;
  static const uint64_t static_value2 = 0xb51d1d25b9ec31fbULL;
};

template<class ContainerAllocator>
struct DataType< ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator> >
{
  static const char* value()
  {
    return "robot_cuadrupedo_msgs/robot_velocity";
  }

  static const char* value(const ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator> >
{
  static const char* value()
  {
    return "bool walk\n"
"float64 velocity\n"
;
  }

  static const char* value(const ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.walk);
      stream.next(m.velocity);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct robot_velocity_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::robot_cuadrupedo_msgs::robot_velocity_<ContainerAllocator>& v)
  {
    s << indent << "walk: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.walk);
    s << indent << "velocity: ";
    Printer<double>::stream(s, indent + "  ", v.velocity);
  }
};

} // namespace message_operations
} // namespace ros

#endif // ROBOT_CUADRUPEDO_MSGS_MESSAGE_ROBOT_VELOCITY_H