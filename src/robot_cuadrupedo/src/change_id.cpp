#include "ros/ros.h"
#include "dynamixel_sdk/dynamixel_sdk.h"
#include "dynamixel_workbench_toolbox/dynamixel_workbench.h"
#include <unistd.h>
#include <fcntl.h>
#include <termios.h>
#include <stdlib.h>
#include <stdio.h>
#include <cstdlib>
#include <iostream>
using namespace std;

DynamixelWorkbench dxl_wb;

#define ADDR_XM430_TORQUE_ENABLE           64   
#define ADDR_XM430_CHANGE_ID          7               

#define PROTOCOL_VERSION                2.0   
#define BAUDRATE                        1000000
#define DEVICENAME                      "/dev/ttyUSB0" 

const char *l;
const int dynamixel_nomber = 2;
uint8_t dxl_id[dynamixel_nomber]= {4,7};
uint8_t new_dxl_id[dynamixel_nomber] = {4,7};


int main(){
  dxl_wb.init(DEVICENAME,BAUDRATE,&l);
  printf("Log : %s\n",l);

  for (int i = 0;i<dynamixel_nomber;i++){

    dxl_wb.ping(dxl_id[i], &l);
    printf("ID : %d\n",dxl_id[i]);
    printf("Log : %s\n",l);

    /*dxl_wb.changeID(dxl_id[i],new_dxl_id[i],&l);
    printf("Log : %s\n",l);*/

    dxl_wb.ledOn(dxl_id[i],&l);
    printf("Log : %s\n",l);

    dxl_wb.changeProtocolVersion(dxl_id[i], PROTOCOL_VERSION, &l);
    printf("Log : %s\n",l);
    printf("Protocol version : %f\n\n",dxl_wb.getProtocolVersion());
    /*
    dxl_wb.torqueOff(dxl_id[i],&l);
    printf("Log : %s\n",l);

    dxl_wb.changeProtocolVersion(dxl_id[i], PROTOCOL_VERSION, &l);
    printf("Log : %s\n",l);
    printf("Protocol version : %f\n\n",dxl_wb.getProtocolVersion());

    dxl_wb.torqueOn(dxl_id[i],&l);
    printf("Log : %s\n",l);
    */

   /* dxl_wb.goalPosition(dxl_id[i],0,&l);
    printf("Log : %s\n",l);
    */

    cin.ignore(cin.rdbuf()->in_avail()+1);

    dxl_wb.ledOff(dxl_id[i],&l);
    printf("Log : %s\n",l);

    }
  
}

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


