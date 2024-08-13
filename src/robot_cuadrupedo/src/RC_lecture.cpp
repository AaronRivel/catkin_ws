#include "ros/ros.h"
#include "std_msgs/String.h"
#include "robot_cuadrupedo/robot_state.h"
#include <math.h>
#include <sstream>
#define PI 3.14159265359


int main(int argc, char **argv)
{
   
  ros::init(argc, argv, "Rc_lecture");
   
  ros::NodeHandle n;

  ros::Publisher pub = n.advertise<robot_cuadrupedo::robot_state>("RC_control", 1000);

  ros::Rate loop_rate(3);
   
  int count = 0;
  while (ros::ok())
  {
    robot_cuadrupedo::robot_state data;
    data.walk = true;
    data.velocity = abs(sin(count*PI/12)*1023);

    ROS_INFO("I send : Walk state [%d], Velocity [%f]", data.walk,data.velocity);

    pub.publish(data);

    ros::spinOnce();

    loop_rate.sleep();
    ++count;
  }


  return 0;
}