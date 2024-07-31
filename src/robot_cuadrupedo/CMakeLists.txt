cmake_minimum_required(VERSION 3.0.2)
project(robot_cuadrupedo)

find_package(catkin REQUIRED COMPONENTS
  dynamixel_sdk
  dynamixel_workbench_toolbox
  roscpp
  rospy
  std_msgs
  message_generation
  robot_cuadrupedo_msgs
)


catkin_python_setup()

 add_message_files(
   FILES
   robot_state.msg
   motors_states.msg

   )



 generate_messages(
   DEPENDENCIES
   std_msgs
   robot_cuadrupedo_msgs
 )


catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES robot_cuadrupedo
  CATKIN_DEPENDS dynamixel_sdk dynamixel_workbench_toolbox roscpp rospy std_msgs message_runtime 
#  DEPENDS system_lib
)


include_directories(
# include
  ${catkin_INCLUDE_DIRS}
)


add_executable(RC_lecture src/RC_lecture.cpp)
target_link_libraries(RC_lecture ${catkin_LIBRARIES})
add_dependencies(RC_lecture robot_cuadrupedo_generate_messages_cpp)

add_executable(leg1_control src/leg1_control.cpp)
target_link_libraries(leg1_control ${catkin_LIBRARIES})
add_dependencies(leg1_control robot_cuadrupedo_generate_messages_cpp)

add_executable(leg2_control src/leg2_control.cpp)
target_link_libraries(leg2_control ${catkin_LIBRARIES})
add_dependencies(leg2_control robot_cuadrupedo_generate_messages_cpp)

add_executable(leg3_control src/leg3_control.cpp)
target_link_libraries(leg3_control ${catkin_LIBRARIES})
add_dependencies(leg3_control robot_cuadrupedo_generate_messages_cpp)

add_executable(leg4_control src/leg4_control.cpp)
target_link_libraries(leg4_control ${catkin_LIBRARIES})
add_dependencies(leg4_control robot_cuadrupedo_generate_messages_cpp)

add_executable(change_id src/change_id.cpp)
target_link_libraries(change_id ${catkin_LIBRARIES})
add_dependencies(change_id robot_cuadrupedo_generate_messages_cpp)

catkin_install_python(PROGRAMS scripts/gate_secuence.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
catkin_install_python(PROGRAMS scripts/animation.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

catkin_install_python(PROGRAMS scripts/leg_control.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

