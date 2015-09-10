# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "messages: 3 messages, 2 services")

set(MSG_I_FLAGS "-Imessages:/home/champion/catkin_ws/src/messages/msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(messages_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/champion/catkin_ws/src/messages/msg/Pan_tilt_mess.msg" NAME_WE)
add_custom_target(_messages_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "messages" "/home/champion/catkin_ws/src/messages/msg/Pan_tilt_mess.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/champion/catkin_ws/src/messages/msg/Punto.msg" NAME_WE)
add_custom_target(_messages_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "messages" "/home/champion/catkin_ws/src/messages/msg/Punto.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/champion/catkin_ws/src/messages/srv/AddTwoInts.srv" NAME_WE)
add_custom_target(_messages_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "messages" "/home/champion/catkin_ws/src/messages/srv/AddTwoInts.srv" ""
)

get_filename_component(_filename "/home/champion/catkin_ws/src/messages/srv/Pan_tilt.srv" NAME_WE)
add_custom_target(_messages_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "messages" "/home/champion/catkin_ws/src/messages/srv/Pan_tilt.srv" ""
)

get_filename_component(_filename "/home/champion/catkin_ws/src/messages/msg/Camino.msg" NAME_WE)
add_custom_target(_messages_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "messages" "/home/champion/catkin_ws/src/messages/msg/Camino.msg" "messages/Punto:std_msgs/Header"
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(messages
  "/home/champion/catkin_ws/src/messages/msg/Pan_tilt_mess.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/messages
)
_generate_msg_cpp(messages
  "/home/champion/catkin_ws/src/messages/msg/Punto.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/messages
)
_generate_msg_cpp(messages
  "/home/champion/catkin_ws/src/messages/msg/Camino.msg"
  "${MSG_I_FLAGS}"
  "/home/champion/catkin_ws/src/messages/msg/Punto.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/messages
)

### Generating Services
_generate_srv_cpp(messages
  "/home/champion/catkin_ws/src/messages/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/messages
)
_generate_srv_cpp(messages
  "/home/champion/catkin_ws/src/messages/srv/Pan_tilt.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/messages
)

### Generating Module File
_generate_module_cpp(messages
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/messages
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(messages_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(messages_generate_messages messages_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/champion/catkin_ws/src/messages/msg/Pan_tilt_mess.msg" NAME_WE)
add_dependencies(messages_generate_messages_cpp _messages_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/messages/msg/Punto.msg" NAME_WE)
add_dependencies(messages_generate_messages_cpp _messages_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/messages/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(messages_generate_messages_cpp _messages_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/messages/srv/Pan_tilt.srv" NAME_WE)
add_dependencies(messages_generate_messages_cpp _messages_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/messages/msg/Camino.msg" NAME_WE)
add_dependencies(messages_generate_messages_cpp _messages_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(messages_gencpp)
add_dependencies(messages_gencpp messages_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS messages_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(messages
  "/home/champion/catkin_ws/src/messages/msg/Pan_tilt_mess.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/messages
)
_generate_msg_lisp(messages
  "/home/champion/catkin_ws/src/messages/msg/Punto.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/messages
)
_generate_msg_lisp(messages
  "/home/champion/catkin_ws/src/messages/msg/Camino.msg"
  "${MSG_I_FLAGS}"
  "/home/champion/catkin_ws/src/messages/msg/Punto.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/messages
)

### Generating Services
_generate_srv_lisp(messages
  "/home/champion/catkin_ws/src/messages/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/messages
)
_generate_srv_lisp(messages
  "/home/champion/catkin_ws/src/messages/srv/Pan_tilt.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/messages
)

### Generating Module File
_generate_module_lisp(messages
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/messages
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(messages_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(messages_generate_messages messages_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/champion/catkin_ws/src/messages/msg/Pan_tilt_mess.msg" NAME_WE)
add_dependencies(messages_generate_messages_lisp _messages_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/messages/msg/Punto.msg" NAME_WE)
add_dependencies(messages_generate_messages_lisp _messages_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/messages/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(messages_generate_messages_lisp _messages_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/messages/srv/Pan_tilt.srv" NAME_WE)
add_dependencies(messages_generate_messages_lisp _messages_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/messages/msg/Camino.msg" NAME_WE)
add_dependencies(messages_generate_messages_lisp _messages_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(messages_genlisp)
add_dependencies(messages_genlisp messages_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS messages_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(messages
  "/home/champion/catkin_ws/src/messages/msg/Pan_tilt_mess.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/messages
)
_generate_msg_py(messages
  "/home/champion/catkin_ws/src/messages/msg/Punto.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/messages
)
_generate_msg_py(messages
  "/home/champion/catkin_ws/src/messages/msg/Camino.msg"
  "${MSG_I_FLAGS}"
  "/home/champion/catkin_ws/src/messages/msg/Punto.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/messages
)

### Generating Services
_generate_srv_py(messages
  "/home/champion/catkin_ws/src/messages/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/messages
)
_generate_srv_py(messages
  "/home/champion/catkin_ws/src/messages/srv/Pan_tilt.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/messages
)

### Generating Module File
_generate_module_py(messages
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/messages
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(messages_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(messages_generate_messages messages_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/champion/catkin_ws/src/messages/msg/Pan_tilt_mess.msg" NAME_WE)
add_dependencies(messages_generate_messages_py _messages_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/messages/msg/Punto.msg" NAME_WE)
add_dependencies(messages_generate_messages_py _messages_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/messages/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(messages_generate_messages_py _messages_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/messages/srv/Pan_tilt.srv" NAME_WE)
add_dependencies(messages_generate_messages_py _messages_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/champion/catkin_ws/src/messages/msg/Camino.msg" NAME_WE)
add_dependencies(messages_generate_messages_py _messages_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(messages_genpy)
add_dependencies(messages_genpy messages_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS messages_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/messages)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/messages
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(messages_generate_messages_cpp std_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/messages)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/messages
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(messages_generate_messages_lisp std_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/messages)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/messages\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/messages
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(messages_generate_messages_py std_msgs_generate_messages_py)
