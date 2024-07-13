#include "ros/ros.h"
#include "std_msgs/String.h"
#include "robot_cuadrupedo/motors_states.h"
#include "dynamixel_sdk/dynamixel_sdk.h"
#include "dynamixel_workbench_toolbox/dynamixel_workbench.h"
#include <unistd.h>
#include <fcntl.h>
#include <termios.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

DynamixelWorkbench dxl_wb;

#define OFFSET 60
#define PI 3.14159265359

#define ADDR_XM430_TORQUE_ENABLE           64                  // Control table address is different in Dynamixel model
#define ADDR_XM430_GOAL_POSITION           116
#define ADDR_XM430_PRESENT_POSITION        132
#define ADDR_XM430_MOVING_STATUS            122

#define PROTOCOL_VERSION                1.0     

#define DXL_ID_F                          3                  // Dynamixel ID: 1
#define DXL_ID_P                          8                   // Dynamixel ID: 2

#define BAUDRATE                        1000000
#define DEVICENAME                      "/dev/ttyUSB0"      // Check which port is being used on your controller         
#define ESC_ASCII_VALUE                 0x1b

#define INIT_POSITION_F 0
#define INIT_POSITION_P 0

#define DXL_MAX_GOAL_VALUE 1023
#define MAX_ERROR 5
#define VELOCITY 200
#define ACCELERATION 100
  
const char *dxl_error_f;                          // Dynamixel error
const char *dxl_error_p;                          // Dynamixel error
const char *l;
const char *item_name_moving_status = "Moving";
const char *item_name_present_position = "Present_Position";

int32_t dxl_present_position_f = 0;  
int32_t dxl_present_position_p = 0;   

int32_t dxl_moving_status_f = 0;
int32_t dxl_moving_status_p = 0;

bool flag = false;
bool shutdown_flag = false;
bool dxl_flag = true;

int getch()
{
  struct termios oldt, newt;
  int ch;
  tcgetattr(STDIN_FILENO, &oldt);
  newt = oldt;
  newt.c_lflag &= ~(ICANON | ECHO);
  tcsetattr(STDIN_FILENO, TCSANOW, &newt);
  ch = getchar();
  tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
  return ch;

}


int kbhit(void)
{
#ifdef __linux__
  struct termios oldt, newt;
  int ch;
  int oldf;

  tcgetattr(STDIN_FILENO, &oldt);
  newt = oldt;
  newt.c_lflag &= ~(ICANON | ECHO);
  tcsetattr(STDIN_FILENO, TCSANOW, &newt);
  oldf = fcntl(STDIN_FILENO, F_GETFL, 0);
  fcntl(STDIN_FILENO, F_SETFL, oldf | O_NONBLOCK);

  ch = getchar();

  tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
  fcntl(STDIN_FILENO, F_SETFL, oldf);

  if (ch != EOF)
  {
    ungetc(ch, stdin);
    return ch;
  }

  return 0;
#elif defined(_WIN32) || defined(_WIN64)
  return _kbhit();
#endif
}

void motor_control(float,float);
void init_port(void);
void move_leg(float,float);
void shutdown(void);
void init_dynamixel(void);


void Callback(const robot_cuadrupedo::motors_states::ConstPtr& data)
{
  float theta_f = data->leg1.frontal_motor;
  float theta_p = data->leg1.posterior_motor;
  bool walk = data->leg1.walk;
  
  if(walk == true and flag == true){
    flag = false;
    init_dynamixel();
  }
  else if (walk == false){
    flag = true;
    shutdown();
    printf("SHUTDOWN!!: POWER OFF");
  }
  
  if(theta_f > 300)theta_f = theta_f-360;
  
  if(theta_p > 400)theta_p = theta_p-360;

  if(shutdown_flag == false and dxl_flag == true){
    printf("I recive Theta f : [%f]deg, Theta p : [%f]deg, Walk ? : [%d]\n",theta_f,theta_p,walk);

    theta_f = 300-OFFSET-theta_f;
    theta_p = 300-(OFFSET+(180-theta_p));

    float goal_position_f = DXL_MAX_GOAL_VALUE*(theta_f/300.0);
    float goal_position_p = DXL_MAX_GOAL_VALUE*(theta_p/300.0);

    printf("I recive GoalPosition F : [%0f], GoalPosition P : [%0f]\n",goal_position_f,goal_position_p);

    motor_control(goal_position_f,goal_position_p);
  }
  
}


int main(int argc, char **argv)
{
  init_port();
  
  init_dynamixel();

  ros::init(argc, argv, "Leg1_control");

  ros::NodeHandle n;

  ros::Subscriber sub = n.subscribe("Gate_control", 1000, Callback);

  ros::spin();

  return 0;
}


void init_port(){

  dxl_wb.init(DEVICENAME, BAUDRATE, &l);
  printf("Log[%s]\n",l);

}


void init_dynamixel(){
  printf("Protocol version [%f]\n",dxl_wb.getProtocolVersion());

  if(!dxl_wb.ping(DXL_ID_F, &l))dxl_flag = false;
  printf("Dxl_f : Log [%s]\n",l);

  if(!dxl_wb.ping(DXL_ID_P, &l))dxl_flag = false;
  printf("Dxl_p : Log [%s]\n",l);

  if(!dxl_wb.jointMode(DXL_ID_F, VELOCITY, ACCELERATION, &l))dxl_flag = false;
  printf("Dxl_f : Log [%s]\n",l);
  
  if(!dxl_wb.jointMode(DXL_ID_P, VELOCITY, ACCELERATION, &l))dxl_flag = false;
  printf("Dxl_p : Log [%s]\n",l);

  dxl_wb.torqueOn(DXL_ID_F,&l);
  printf("Dxl_f : Log [%s]\n",l);
  dxl_wb.torqueOn(DXL_ID_P,&l);
  printf("Dxl_p : Log [%s]\n",l);
}

void motor_control(float goal_position_f,float goal_position_p){

  move_leg(goal_position_f,goal_position_p);

  if(kbhit() == ESC_ASCII_VALUE){
    shutdown();
    printf("SHUTDOWN!!: EXIT PROGRAM\n");
  }
  
}


void move_leg(float goal_position_f,float goal_position_p){

  if((goal_position_f+goal_position_p) > (DXL_MAX_GOAL_VALUE-100)){
    //shutdown();
    printf("SHUTDOWN!!: JOINT COLLISION\n");
  }
  int count = 0;
  do
  {
    if(count > 15){
      break;
      printf("Couldn't reach position\n");
    }
    dxl_wb.goalPosition(DXL_ID_F, (int32_t)goal_position_f);
    dxl_wb.goalPosition(DXL_ID_P, (int32_t)goal_position_p);

    dxl_wb.itemRead(DXL_ID_F,item_name_present_position , &dxl_present_position_f, &l );
    dxl_wb.itemRead(DXL_ID_P, item_name_present_position, &dxl_present_position_p, &l);

    printf("[ID:%d] GoalPos:%0f  PresPos:%d,[ID:%d] GoalPos:%0f  PresPos:%d\n", DXL_ID_F,goal_position_f,dxl_present_position_f, DXL_ID_P,goal_position_p,dxl_present_position_p);
 
    count++;
  }while(abs(dxl_present_position_f-goal_position_f)>MAX_ERROR or abs(dxl_present_position_p-goal_position_p)>MAX_ERROR );
}


void shutdown(){
  shutdown_flag = true;
  float goal_position_f = DXL_MAX_GOAL_VALUE*((300-(INIT_POSITION_F+OFFSET))/300.0);
  float goal_position_p = DXL_MAX_GOAL_VALUE*((300-(INIT_POSITION_P+OFFSET))/300.0);
    
  move_leg(goal_position_f,goal_position_p);

  dxl_wb.torqueOff(DXL_ID_F,&l);
  printf("Dxl_f : Log [%s]\n",l);
  dxl_wb.torqueOff(DXL_ID_P,&l);
  printf("Dxl_p : Log [%s]\n",l);
}



