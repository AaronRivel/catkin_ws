// Generated by gencpp from file robot_cuadrupedo_msgs/legs_control.msg
// DO NOT EDIT!


#ifndef ROBOT_CUADRUPEDO_MSGS_MESSAGE_LEGS_CONTROL_H
#define ROBOT_CUADRUPEDO_MSGS_MESSAGE_LEGS_CONTROL_H


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
struct legs_control_
{
  typedef legs_control_<ContainerAllocator> Type;

  legs_control_()
    : frontal_motor(0.0)
    , posterior_motor(0.0)
    , walk(false)
    , goal_position_feedback(false)
    , id_f(0)
    , id_p(0)  {
    }
  legs_control_(const ContainerAllocator& _alloc)
    : frontal_motor(0.0)
    , posterior_motor(0.0)
    , walk(false)
    , goal_position_feedback(false)
    , id_f(0)
    , id_p(0)  {
  (void)_alloc;
    }



   typedef double _frontal_motor_type;
  _frontal_motor_type frontal_motor;

   typedef double _posterior_motor_type;
  _posterior_motor_type posterior_motor;

   typedef uint8_t _walk_type;
  _walk_type walk;

   typedef uint8_t _goal_position_feedback_type;
  _goal_position_feedback_type goal_position_feedback;

   typedef int64_t _id_f_type;
  _id_f_type id_f;

   typedef int64_t _id_p_type;
  _id_p_type id_p;





  typedef boost::shared_ptr< ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator> const> ConstPtr;

}; // struct legs_control_

typedef ::robot_cuadrupedo_msgs::legs_control_<std::allocator<void> > legs_control;

typedef boost::shared_ptr< ::robot_cuadrupedo_msgs::legs_control > legs_controlPtr;
typedef boost::shared_ptr< ::robot_cuadrupedo_msgs::legs_control const> legs_controlConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator1> & lhs, const ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator2> & rhs)
{
  return lhs.frontal_motor == rhs.frontal_motor &&
    lhs.posterior_motor == rhs.posterior_motor &&
    lhs.walk == rhs.walk &&
    lhs.goal_position_feedback == rhs.goal_position_feedback &&
    lhs.id_f == rhs.id_f &&
    lhs.id_p == rhs.id_p;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator1> & lhs, const ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace robot_cuadrupedo_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator> >
{
  static const char* value()
  {
    return "889997f071d49233501da79c98b3e3ac";
  }

  static const char* value(const ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x889997f071d49233ULL;
  static const uint64_t static_value2 = 0x501da79c98b3e3acULL;
};

template<class ContainerAllocator>
struct DataType< ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator> >
{
  static const char* value()
  {
    return "robot_cuadrupedo_msgs/legs_control";
  }

  static const char* value(const ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float64 frontal_motor\n"
"float64 posterior_motor\n"
"bool walk\n"
"bool goal_position_feedback\n"
"int64 id_f\n"
"int64 id_p\n"
;
  }

  static const char* value(const ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.frontal_motor);
      stream.next(m.posterior_motor);
      stream.next(m.walk);
      stream.next(m.goal_position_feedback);
      stream.next(m.id_f);
      stream.next(m.id_p);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct legs_control_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::robot_cuadrupedo_msgs::legs_control_<ContainerAllocator>& v)
  {
    s << indent << "frontal_motor: ";
    Printer<double>::stream(s, indent + "  ", v.frontal_motor);
    s << indent << "posterior_motor: ";
    Printer<double>::stream(s, indent + "  ", v.posterior_motor);
    s << indent << "walk: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.walk);
    s << indent << "goal_position_feedback: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.goal_position_feedback);
    s << indent << "id_f: ";
    Printer<int64_t>::stream(s, indent + "  ", v.id_f);
    s << indent << "id_p: ";
    Printer<int64_t>::stream(s, indent + "  ", v.id_p);
  }
};

} // namespace message_operations
} // namespace ros

#endif // ROBOT_CUADRUPEDO_MSGS_MESSAGE_LEGS_CONTROL_H
