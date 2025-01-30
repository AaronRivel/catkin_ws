// Generated by gencpp from file quadruped_robot/write_dxl.msg
// DO NOT EDIT!


#ifndef QUADRUPED_ROBOT_MESSAGE_WRITE_DXL_H
#define QUADRUPED_ROBOT_MESSAGE_WRITE_DXL_H

#include <ros/service_traits.h>


#include <quadruped_robot/write_dxlRequest.h>
#include <quadruped_robot/write_dxlResponse.h>


namespace quadruped_robot
{

struct write_dxl
{

typedef write_dxlRequest Request;
typedef write_dxlResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct write_dxl
} // namespace quadruped_robot


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::quadruped_robot::write_dxl > {
  static const char* value()
  {
    return "81773e62f8a6ec0db8598e75c6beabae";
  }

  static const char* value(const ::quadruped_robot::write_dxl&) { return value(); }
};

template<>
struct DataType< ::quadruped_robot::write_dxl > {
  static const char* value()
  {
    return "quadruped_robot/write_dxl";
  }

  static const char* value(const ::quadruped_robot::write_dxl&) { return value(); }
};


// service_traits::MD5Sum< ::quadruped_robot::write_dxlRequest> should match
// service_traits::MD5Sum< ::quadruped_robot::write_dxl >
template<>
struct MD5Sum< ::quadruped_robot::write_dxlRequest>
{
  static const char* value()
  {
    return MD5Sum< ::quadruped_robot::write_dxl >::value();
  }
  static const char* value(const ::quadruped_robot::write_dxlRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::quadruped_robot::write_dxlRequest> should match
// service_traits::DataType< ::quadruped_robot::write_dxl >
template<>
struct DataType< ::quadruped_robot::write_dxlRequest>
{
  static const char* value()
  {
    return DataType< ::quadruped_robot::write_dxl >::value();
  }
  static const char* value(const ::quadruped_robot::write_dxlRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::quadruped_robot::write_dxlResponse> should match
// service_traits::MD5Sum< ::quadruped_robot::write_dxl >
template<>
struct MD5Sum< ::quadruped_robot::write_dxlResponse>
{
  static const char* value()
  {
    return MD5Sum< ::quadruped_robot::write_dxl >::value();
  }
  static const char* value(const ::quadruped_robot::write_dxlResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::quadruped_robot::write_dxlResponse> should match
// service_traits::DataType< ::quadruped_robot::write_dxl >
template<>
struct DataType< ::quadruped_robot::write_dxlResponse>
{
  static const char* value()
  {
    return DataType< ::quadruped_robot::write_dxl >::value();
  }
  static const char* value(const ::quadruped_robot::write_dxlResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // QUADRUPED_ROBOT_MESSAGE_WRITE_DXL_H
