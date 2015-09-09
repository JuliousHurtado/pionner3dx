# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "common_code: 4 messages, 0 services")

set(MSG_I_FLAGS "-Icommon_code:/home/champion/catkin_ws/src/common_code/msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(common_code_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/champion/catkin_ws/src/common_code/msg/Punto.msg" NAME_WE)
add_custom_target(_common_code_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "common_code" "/home/champion/catkin_ws/src/common_code/msg/Punto.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/champion/catkin_ws/src/common_code/msg/Camino.msg" NAME_WE)
add_custom_target(_common_code_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "common_code" "/home/champion/catkin_ws/src/common_code/msg/Camino.msg" "common_code/Punto:std_msgs/Header"
)

get_filename_component(_filename "/home/champion/catkin_ws/src/common_code/msg/msg_detection.msg" NAME_WE)
add_custom_target(_common_code_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "common_code" "/home/champion/catkin_ws/src/common_code/msg/msg_detection.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/champion/catkin_ws/src/common_code/msg/Pan_tilt.msg" NAME_WE)
add_custom_target(_common_code_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "common_code" "/home/champion/catkin_ws/src/common_code/msg/Pan_tilt.msg" "std_msgs/Header"
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(common_code
  "/home/champion/catkin_ws/src/common_code/msg/Pan_tilt.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/common_code
)
_generate_msg_cpp(common_code
  "/home/champion/catkin_ws/src/common_code/msg/Camino.msg"
  "${MSG_I_FLAGS}"
  "/home/champion/catkin_ws/src/common_code/msg/Punto.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/common_code
)
_generate_msg_cpp(common_code
  "/home/champion/catkin_ws/src/common_code/msg/msg_detection.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/common_code
)
_generate_msg_cpp(common_code
  "/home/champion/catkin_ws/src/common_code/msg/Punto.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/common_code
)

### Generating Services

### Generating Module File
_generate_module_cpp(common_code
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/common_code
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(common_code_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(common_code_generate_messages common_code_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/champion/catkin_ws/src/common_code/msg/Punto.msg" NAME_WE)
add_dependencies(common_code_generate_messages_cpp _common_code_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/common_code/msg/Camino.msg" NAME_WE)
add_dependencies(common_code_generate_messages_cpp _common_code_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/common_code/msg/msg_detection.msg" NAME_WE)
add_dependencies(common_code_generate_messages_cpp _common_code_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/common_code/msg/Pan_tilt.msg" NAME_WE)
add_dependencies(common_code_generate_messages_cpp _common_code_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(common_code_gencpp)
add_dependencies(common_code_gencpp common_code_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS common_code_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(common_code
  "/home/champion/catkin_ws/src/common_code/msg/Pan_tilt.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/common_code
)
_generate_msg_lisp(common_code
  "/home/champion/catkin_ws/src/common_code/msg/Camino.msg"
  "${MSG_I_FLAGS}"
  "/home/champion/catkin_ws/src/common_code/msg/Punto.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/common_code
)
_generate_msg_lisp(common_code
  "/home/champion/catkin_ws/src/common_code/msg/msg_detection.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/common_code
)
_generate_msg_lisp(common_code
  "/home/champion/catkin_ws/src/common_code/msg/Punto.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/common_code
)

### Generating Services

### Generating Module File
_generate_module_lisp(common_code
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/common_code
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(common_code_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(common_code_generate_messages common_code_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/champion/catkin_ws/src/common_code/msg/Punto.msg" NAME_WE)
add_dependencies(common_code_generate_messages_lisp _common_code_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/common_code/msg/Camino.msg" NAME_WE)
add_dependencies(common_code_generate_messages_lisp _common_code_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/common_code/msg/msg_detection.msg" NAME_WE)
add_dependencies(common_code_generate_messages_lisp _common_code_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/common_code/msg/Pan_tilt.msg" NAME_WE)
add_dependencies(common_code_generate_messages_lisp _common_code_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(common_code_genlisp)
add_dependencies(common_code_genlisp common_code_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS common_code_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(common_code
  "/home/champion/catkin_ws/src/common_code/msg/Pan_tilt.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/common_code
)
_generate_msg_py(common_code
  "/home/champion/catkin_ws/src/common_code/msg/Camino.msg"
  "${MSG_I_FLAGS}"
  "/home/champion/catkin_ws/src/common_code/msg/Punto.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/common_code
)
_generate_msg_py(common_code
  "/home/champion/catkin_ws/src/common_code/msg/msg_detection.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/common_code
)
_generate_msg_py(common_code
  "/home/champion/catkin_ws/src/common_code/msg/Punto.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/common_code
)

### Generating Services

### Generating Module File
_generate_module_py(common_code
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/common_code
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(common_code_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(common_code_generate_messages common_code_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/champion/catkin_ws/src/common_code/msg/Punto.msg" NAME_WE)
add_dependencies(common_code_generate_messages_py _common_code_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/common_code/msg/Camino.msg" NAME_WE)
add_dependencies(common_code_generate_messages_py _common_code_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/common_code/msg/msg_detection.msg" NAME_WE)
add_dependencies(common_code_generate_messages_py _common_code_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/common_code/msg/Pan_tilt.msg" NAME_WE)
add_dependencies(common_code_generate_messages_py _common_code_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(common_code_genpy)
add_dependencies(common_code_genpy common_code_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS common_code_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/common_code)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/common_code
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(common_code_generate_messages_cpp std_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/common_code)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/common_code
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(common_code_generate_messages_lisp std_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/common_code)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/common_code\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/common_code
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(common_code_generate_messages_py std_msgs_generate_messages_py)
