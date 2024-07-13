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

#define OFFSET 90
#define PI 3.14159265359

#define ADDR_XM430_TORQUE_ENABLE           64                  // Control table address is different in Dynamixel model
#define ADDR_XM430_GOAL_POSITION           116
#define ADDR_XM430_PRESENT_POSITION        132
#define ADDR_XM430_MOVING_STATUS            122

#define PROTOCOL_VERSION                2.0     

#define DXL_ID_F                          5                   // Dynamixel ID: 1
#define DXL_ID_P                          6                   // Dynamixel ID: 2

#define BAUDRATE                        1000000
#define DEVICENAME                      "/dev/ttyUSB0"      // Check which port is being used on your controller         
#define ESC_ASCII_VALUE                 0x1b

#define INIT_POSITION_F 10
#define INIT_POSITION_P 10

#define DXL_MAX_GOAL_VALUE 4095
#define MAX_ERROR 5
#define VELOCITY 400
#define ACCELERATION 150
  
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
    printf("I recive Theta f : [%f]deg, Theta p : [%f]deg, Walk ? : [%d]",theta_f,theta_p,walk);

    theta_f = OFFSET+theta_f;
    theta_p = OFFSET+(180-theta_p);

    float goal_position_f = DXL_MAX_GOAL_VALUE*(theta_f/360.0);
    float goal_position_p = DXL_MAX_GOAL_VALUE*(theta_p/360.0);

    printf("I recive GoalPosition F : [%0f], GoalPosition P : [%0f],",goal_position_f,goal_position_p);

    motor_control(goal_position_f,goal_position_p);
  }
  
}


int main(int argc, char **argv)
{
  init_port();
  
  init_dynamixel();

  ros::init(argc, argv, "Leg3_control");

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
    shutdown();
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
  float goal_position_f = DXL_MAX_GOAL_VALUE*((INIT_POSITION_F+OFFSET)/360.0);
  float goal_position_p = DXL_MAX_GOAL_VALUE*((INIT_POSITION_P+OFFSET)/360.0);
    
  move_leg(goal_position_f,goal_position_p);

  dxl_wb.torqueOff(DXL_ID_F,&l);
  printf("Dxl_f : Log [%s]\n",l);
  dxl_wb.torqueOff(DXL_ID_P,&l);
  printf("Dxl_p : Log [%s]\n",l);
}



















/*#include "ros/ros.h"
#include "std_msgs/String.h"
#include "robot_cuadrupedo/motors_states.h"
#include "dynamixel_sdk/dynamixel_sdk.h"
#include <unistd.h>
#include <fcntl.h>
#include <termios.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#define DXL_ID_F                          3                   // Dynamixel ID: 1
#define DXL_ID_P                          4                   // Dynamixel ID: 2

#define OFFSET 60
#define PI 3.14159265359

#define ADDR_AX12A_TORQUE_ENABLE           24                  // Control table address is different in Dynamixel model
#define ADDR_AX12A_GOAL_POSITION           30
#define ADDR_AX12A_PRESENT_POSITION        36
#define ADDR_AX12A_MOVING_STATUS            46

#define PROTOCOL_VERSION                1.0     

#define BAUDRATE                        1000000
#define DEVICENAME                      "/dev/ttyUSB0"      // Check which port is being used on your controller

#define TORQUE_ENABLE                   1                   // Value for enabling the torque
#define TORQUE_DISABLE                  0                   // Value for disabling the torque
#define DXL_MINIMUM_POSITION_VALUE      0                 // Dynamixel will rotate between this value
#define DXL_MAXIMUM_POSITION_VALUE      300                // and this value (note that the Dynamixel would not move when the position value is out of movable range. Check e-manual about the range of the Dynamixel you use.)
#define DXL_MOVING_STATUS_THRESHOLD     3                  // Dynamixel moving status threshold
              
#define ESC_ASCII_VALUE                 0x1b

#define INIT_POSITION_F 45
#define INIT_POSITION_P 135

dynamixel::PortHandler *portHandler = dynamixel::PortHandler::getPortHandler(DEVICENAME);
dynamixel::PacketHandler *packetHandler = dynamixel::PacketHandler::getPacketHandler(PROTOCOL_VERSION);
int dxl_comm_result = COMM_TX_FAIL; 
uint8_t dxl_error_f = 0;                          // Dynamixel error
uint8_t dxl_error_p = 0;                          // Dynamixel error

uint16_t dxl_present_position_f = 0;  
uint16_t dxl_present_position_p = 0;   

uint8_t dxl_moving_status_f = 0;
uint8_t dxl_moving_status_p = 0;

bool flag = false;

int motor_control(float,float);
int init_port(void);
void move_leg(float,float);
void shutdown(void);

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

void Callback(const robot_cuadrupedo::motors_states::ConstPtr& data)
{
  float theta_f = data->leg2.frontal_motor;
  float theta_p = data->leg2.posterior_motor;
  bool walk = data->leg2.walk;
  
  if(walk == true and flag == true){
    flag = false;
    init_port();
  }
  else if (walk == false){
    flag = true;
    shutdown();
  }
  
  if(theta_f > 350)theta_f = theta_f-360;
  
  if(theta_p > 450)theta_p = theta_p-360;

  ROS_INFO("I recive Theta f : [%f]deg, Theta p : [%f]deg, Walk ? : [%d]",theta_f,theta_p,walk);

  theta_f = theta_f+OFFSET;
  theta_p = theta_p+OFFSET;
  float goal_position_f = 1024*(theta_f/360);
  float goal_position_p = 1024*(theta_p/360);

  ROS_INFO("I recive GoalPosition F : [%f], GoalPosition P : [%f],",goal_position_f,goal_position_p);

  motor_control(goal_position_f,goal_position_p);

}

int main(int argc, char **argv)
{
  init_port();

  ros::init(argc, argv, "Leg2_control");

  ros::NodeHandle n;

  ros::Subscriber sub = n.subscribe("Gate_control", 1000, Callback);

  ros::spin();

  return 0;
}
int init_port(){
  if (portHandler->openPort())
    {
      printf("Succeeded to open the port!\n");
    }
  else
    {
      printf("Failed to open the port!\n");
      printf("Press any key to terminate...\n");
      getch();
      return 0;
    }

  // Set port baudrate
  if (portHandler->setBaudRate(BAUDRATE))
  {
    printf("Succeeded to change the baudrate!\n");
  }
  else
  {
    printf("Failed to change the baudrate!\n");
    printf("Press any key to terminate...\n");
    getch();
    return 0;
  }
}

int motor_control(float goal_position_f,float goal_position_p){

  packetHandler->write1ByteTxRx(portHandler, DXL_ID_F, ADDR_AX12A_TORQUE_ENABLE, TORQUE_ENABLE, &dxl_error_f);
  packetHandler->write1ByteTxRx(portHandler, DXL_ID_P, ADDR_AX12A_TORQUE_ENABLE, TORQUE_ENABLE, &dxl_error_p);
  
  move_leg(goal_position_f,goal_position_p);

  if(kbhit() == ESC_ASCII_VALUE){
    shutdown();
  }
  
}

void move_leg(float goal_position_f,float goal_position_p){
  // Write goal position
  packetHandler->write2ByteTxRx(portHandler, DXL_ID_F, ADDR_AX12A_GOAL_POSITION, goal_position_f, &dxl_error_f);
  packetHandler->write2ByteTxRx(portHandler, DXL_ID_P, ADDR_AX12A_GOAL_POSITION, goal_position_p, &dxl_error_p);
     
  do
  {
    // Read present position
    packetHandler->read2ByteTxRx(portHandler, DXL_ID_F, ADDR_AX12A_PRESENT_POSITION, &dxl_present_position_f, &dxl_error_f);
    packetHandler->read2ByteTxRx(portHandler, DXL_ID_P, ADDR_AX12A_PRESENT_POSITION, &dxl_present_position_p, &dxl_error_p);

    printf("[ID:%03d] GoalPos:%03f  PresPos:%5.2d,[ID:%03d] GoalPos:%03f  PresPos:%5.2d\n", DXL_ID_F, goal_position_f, dxl_present_position_f, DXL_ID_P, goal_position_p, dxl_present_position_p);
    //printf("[ID:%03d] GoalPos:%03f  PresPos:%5.2d\n", DXL_ID_P, goal_position_p, dxl_present_position_p);

    packetHandler->read1ByteTxRx(portHandler, DXL_ID_F, ADDR_AX12A_MOVING_STATUS, &dxl_moving_status_f, &dxl_error_f);
    packetHandler->read1ByteTxRx(portHandler, DXL_ID_P, ADDR_AX12A_MOVING_STATUS, &dxl_moving_status_p, &dxl_error_p);

  }while(dxl_moving_status_f or dxl_moving_status_p);
}

void shutdown(){
    float goal_position_f = 1024*((INIT_POSITION_F+OFFSET)/360.0);
    float goal_position_p = 1024*((INIT_POSITION_P+OFFSET)/360.0);
      
    move_leg(goal_position_f,goal_position_p);

    packetHandler->write1ByteTxRx(portHandler, DXL_ID_F, ADDR_AX12A_TORQUE_ENABLE, TORQUE_DISABLE, &dxl_error_f);
    packetHandler->write1ByteTxRx(portHandler, DXL_ID_P, ADDR_AX12A_TORQUE_ENABLE, TORQUE_DISABLE, &dxl_error_p);


    // Close port
    portHandler->closePort();
}
*/