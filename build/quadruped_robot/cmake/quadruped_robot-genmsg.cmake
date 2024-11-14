# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "quadruped_robot: 3 messages, 2 services")

set(MSG_I_FLAGS "-Iquadruped_robot:/home/aaron/catkin_ws/src/quadruped_robot/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(quadruped_robot_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg" NAME_WE)
add_custom_target(_quadruped_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "quadruped_robot" "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg" ""
)

get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/period.msg" NAME_WE)
add_custom_target(_quadruped_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "quadruped_robot" "/home/aaron/catkin_ws/src/quadruped_robot/msg/period.msg" ""
)

get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/multi_leg_control.msg" NAME_WE)
add_custom_target(_quadruped_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "quadruped_robot" "/home/aaron/catkin_ws/src/quadruped_robot/msg/multi_leg_control.msg" "quadruped_robot/leg_state"
)

get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/srv/write_dxl.srv" NAME_WE)
add_custom_target(_quadruped_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "quadruped_robot" "/home/aaron/catkin_ws/src/quadruped_robot/srv/write_dxl.srv" ""
)

get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/srv/read_dxl.srv" NAME_WE)
add_custom_target(_quadruped_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "quadruped_robot" "/home/aaron/catkin_ws/src/quadruped_robot/srv/read_dxl.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/quadruped_robot
)
_generate_msg_cpp(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/period.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/quadruped_robot
)
_generate_msg_cpp(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/multi_leg_control.msg"
  "${MSG_I_FLAGS}"
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/quadruped_robot
)

### Generating Services
_generate_srv_cpp(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/srv/write_dxl.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/quadruped_robot
)
_generate_srv_cpp(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/srv/read_dxl.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/quadruped_robot
)

### Generating Module File
_generate_module_cpp(quadruped_robot
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/quadruped_robot
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(quadruped_robot_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(quadruped_robot_generate_messages quadruped_robot_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_cpp _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/period.msg" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_cpp _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/multi_leg_control.msg" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_cpp _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/srv/write_dxl.srv" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_cpp _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/srv/read_dxl.srv" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_cpp _quadruped_robot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(quadruped_robot_gencpp)
add_dependencies(quadruped_robot_gencpp quadruped_robot_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS quadruped_robot_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/quadruped_robot
)
_generate_msg_eus(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/period.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/quadruped_robot
)
_generate_msg_eus(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/multi_leg_control.msg"
  "${MSG_I_FLAGS}"
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/quadruped_robot
)

### Generating Services
_generate_srv_eus(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/srv/write_dxl.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/quadruped_robot
)
_generate_srv_eus(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/srv/read_dxl.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/quadruped_robot
)

### Generating Module File
_generate_module_eus(quadruped_robot
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/quadruped_robot
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(quadruped_robot_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(quadruped_robot_generate_messages quadruped_robot_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_eus _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/period.msg" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_eus _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/multi_leg_control.msg" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_eus _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/srv/write_dxl.srv" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_eus _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/srv/read_dxl.srv" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_eus _quadruped_robot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(quadruped_robot_geneus)
add_dependencies(quadruped_robot_geneus quadruped_robot_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS quadruped_robot_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/quadruped_robot
)
_generate_msg_lisp(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/period.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/quadruped_robot
)
_generate_msg_lisp(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/multi_leg_control.msg"
  "${MSG_I_FLAGS}"
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/quadruped_robot
)

### Generating Services
_generate_srv_lisp(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/srv/write_dxl.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/quadruped_robot
)
_generate_srv_lisp(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/srv/read_dxl.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/quadruped_robot
)

### Generating Module File
_generate_module_lisp(quadruped_robot
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/quadruped_robot
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(quadruped_robot_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(quadruped_robot_generate_messages quadruped_robot_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_lisp _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/period.msg" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_lisp _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/multi_leg_control.msg" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_lisp _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/srv/write_dxl.srv" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_lisp _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/srv/read_dxl.srv" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_lisp _quadruped_robot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(quadruped_robot_genlisp)
add_dependencies(quadruped_robot_genlisp quadruped_robot_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS quadruped_robot_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/quadruped_robot
)
_generate_msg_nodejs(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/period.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/quadruped_robot
)
_generate_msg_nodejs(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/multi_leg_control.msg"
  "${MSG_I_FLAGS}"
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/quadruped_robot
)

### Generating Services
_generate_srv_nodejs(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/srv/write_dxl.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/quadruped_robot
)
_generate_srv_nodejs(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/srv/read_dxl.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/quadruped_robot
)

### Generating Module File
_generate_module_nodejs(quadruped_robot
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/quadruped_robot
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(quadruped_robot_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(quadruped_robot_generate_messages quadruped_robot_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_nodejs _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/period.msg" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_nodejs _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/multi_leg_control.msg" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_nodejs _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/srv/write_dxl.srv" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_nodejs _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/srv/read_dxl.srv" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_nodejs _quadruped_robot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(quadruped_robot_gennodejs)
add_dependencies(quadruped_robot_gennodejs quadruped_robot_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS quadruped_robot_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/quadruped_robot
)
_generate_msg_py(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/period.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/quadruped_robot
)
_generate_msg_py(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/multi_leg_control.msg"
  "${MSG_I_FLAGS}"
  "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/quadruped_robot
)

### Generating Services
_generate_srv_py(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/srv/write_dxl.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/quadruped_robot
)
_generate_srv_py(quadruped_robot
  "/home/aaron/catkin_ws/src/quadruped_robot/srv/read_dxl.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/quadruped_robot
)

### Generating Module File
_generate_module_py(quadruped_robot
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/quadruped_robot
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(quadruped_robot_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(quadruped_robot_generate_messages quadruped_robot_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/leg_state.msg" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_py _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/period.msg" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_py _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/msg/multi_leg_control.msg" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_py _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/srv/write_dxl.srv" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_py _quadruped_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/catkin_ws/src/quadruped_robot/srv/read_dxl.srv" NAME_WE)
add_dependencies(quadruped_robot_generate_messages_py _quadruped_robot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(quadruped_robot_genpy)
add_dependencies(quadruped_robot_genpy quadruped_robot_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS quadruped_robot_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/quadruped_robot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/quadruped_robot
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(quadruped_robot_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/quadruped_robot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/quadruped_robot
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(quadruped_robot_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/quadruped_robot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/quadruped_robot
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(quadruped_robot_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/quadruped_robot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/quadruped_robot
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(quadruped_robot_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/quadruped_robot)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/quadruped_robot\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/quadruped_robot
    DESTINATION ${genpy_INSTALL_DIR}
    # skip all init files
    PATTERN "__init__.py" EXCLUDE
    PATTERN "__init__.pyc" EXCLUDE
  )
  # install init files which are not in the root folder of the generated code
  string(REGEX REPLACE "([][+.*()^])" "\\\\\\1" ESCAPED_PATH "${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/quadruped_robot")
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/quadruped_robot
    DESTINATION ${genpy_INSTALL_DIR}
    FILES_MATCHING
    REGEX "${ESCAPED_PATH}/.+/__init__.pyc?$"
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(quadruped_robot_generate_messages_py std_msgs_generate_messages_py)
endif()
