# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "il_map_tools: 0 messages, 1 services")

set(MSG_I_FLAGS "-Inav_msgs:/opt/ros/indigo/share/nav_msgs/cmake/../msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/indigo/share/geometry_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/indigo/share/actionlib_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(il_map_tools_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/champion/catkin_ws/src/il_map_tools/srv/srv_occupied.srv" NAME_WE)
add_custom_target(_il_map_tools_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "il_map_tools" "/home/champion/catkin_ws/src/il_map_tools/srv/srv_occupied.srv" "geometry_msgs/Quaternion:geometry_msgs/Point:geometry_msgs/Pose"
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(il_map_tools
  "/home/champion/catkin_ws/src/il_map_tools/srv/srv_occupied.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/il_map_tools
)

### Generating Module File
_generate_module_cpp(il_map_tools
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/il_map_tools
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(il_map_tools_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(il_map_tools_generate_messages il_map_tools_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/champion/catkin_ws/src/il_map_tools/srv/srv_occupied.srv" NAME_WE)
add_dependencies(il_map_tools_generate_messages_cpp _il_map_tools_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(il_map_tools_gencpp)
add_dependencies(il_map_tools_gencpp il_map_tools_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS il_map_tools_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(il_map_tools
  "/home/champion/catkin_ws/src/il_map_tools/srv/srv_occupied.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/il_map_tools
)

### Generating Module File
_generate_module_lisp(il_map_tools
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/il_map_tools
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(il_map_tools_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(il_map_tools_generate_messages il_map_tools_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/champion/catkin_ws/src/il_map_tools/srv/srv_occupied.srv" NAME_WE)
add_dependencies(il_map_tools_generate_messages_lisp _il_map_tools_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(il_map_tools_genlisp)
add_dependencies(il_map_tools_genlisp il_map_tools_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS il_map_tools_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(il_map_tools
  "/home/champion/catkin_ws/src/il_map_tools/srv/srv_occupied.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/il_map_tools
)

### Generating Module File
_generate_module_py(il_map_tools
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/il_map_tools
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(il_map_tools_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(il_map_tools_generate_messages il_map_tools_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/champion/catkin_ws/src/il_map_tools/srv/srv_occupied.srv" NAME_WE)
add_dependencies(il_map_tools_generate_messages_py _il_map_tools_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(il_map_tools_genpy)
add_dependencies(il_map_tools_genpy il_map_tools_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS il_map_tools_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/il_map_tools)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/il_map_tools
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(il_map_tools_generate_messages_cpp nav_msgs_generate_messages_cpp)
add_dependencies(il_map_tools_generate_messages_cpp std_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/il_map_tools)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/il_map_tools
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(il_map_tools_generate_messages_lisp nav_msgs_generate_messages_lisp)
add_dependencies(il_map_tools_generate_messages_lisp std_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/il_map_tools)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/il_map_tools\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/il_map_tools
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(il_map_tools_generate_messages_py nav_msgs_generate_messages_py)
add_dependencies(il_map_tools_generate_messages_py std_msgs_generate_messages_py)
