# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/champion/catkin_ws/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/champion/catkin_ws/build

# Include any dependencies generated for this target.
include sogp/CMakeFiles/sogp.dir/depend.make

# Include the progress variables for this target.
include sogp/CMakeFiles/sogp.dir/progress.make

# Include the compile flags for this target's objects.
include sogp/CMakeFiles/sogp.dir/flags.make

sogp/CMakeFiles/sogp.dir/src/SOGP.cc.o: sogp/CMakeFiles/sogp.dir/flags.make
sogp/CMakeFiles/sogp.dir/src/SOGP.cc.o: /home/champion/catkin_ws/src/sogp/src/SOGP.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /home/champion/catkin_ws/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object sogp/CMakeFiles/sogp.dir/src/SOGP.cc.o"
	cd /home/champion/catkin_ws/build/sogp && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/sogp.dir/src/SOGP.cc.o -c /home/champion/catkin_ws/src/sogp/src/SOGP.cc

sogp/CMakeFiles/sogp.dir/src/SOGP.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/sogp.dir/src/SOGP.cc.i"
	cd /home/champion/catkin_ws/build/sogp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/champion/catkin_ws/src/sogp/src/SOGP.cc > CMakeFiles/sogp.dir/src/SOGP.cc.i

sogp/CMakeFiles/sogp.dir/src/SOGP.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/sogp.dir/src/SOGP.cc.s"
	cd /home/champion/catkin_ws/build/sogp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/champion/catkin_ws/src/sogp/src/SOGP.cc -o CMakeFiles/sogp.dir/src/SOGP.cc.s

sogp/CMakeFiles/sogp.dir/src/SOGP.cc.o.requires:
.PHONY : sogp/CMakeFiles/sogp.dir/src/SOGP.cc.o.requires

sogp/CMakeFiles/sogp.dir/src/SOGP.cc.o.provides: sogp/CMakeFiles/sogp.dir/src/SOGP.cc.o.requires
	$(MAKE) -f sogp/CMakeFiles/sogp.dir/build.make sogp/CMakeFiles/sogp.dir/src/SOGP.cc.o.provides.build
.PHONY : sogp/CMakeFiles/sogp.dir/src/SOGP.cc.o.provides

sogp/CMakeFiles/sogp.dir/src/SOGP.cc.o.provides.build: sogp/CMakeFiles/sogp.dir/src/SOGP.cc.o

sogp/CMakeFiles/sogp.dir/src/SOGP_aux.cc.o: sogp/CMakeFiles/sogp.dir/flags.make
sogp/CMakeFiles/sogp.dir/src/SOGP_aux.cc.o: /home/champion/catkin_ws/src/sogp/src/SOGP_aux.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /home/champion/catkin_ws/build/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object sogp/CMakeFiles/sogp.dir/src/SOGP_aux.cc.o"
	cd /home/champion/catkin_ws/build/sogp && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/sogp.dir/src/SOGP_aux.cc.o -c /home/champion/catkin_ws/src/sogp/src/SOGP_aux.cc

sogp/CMakeFiles/sogp.dir/src/SOGP_aux.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/sogp.dir/src/SOGP_aux.cc.i"
	cd /home/champion/catkin_ws/build/sogp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/champion/catkin_ws/src/sogp/src/SOGP_aux.cc > CMakeFiles/sogp.dir/src/SOGP_aux.cc.i

sogp/CMakeFiles/sogp.dir/src/SOGP_aux.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/sogp.dir/src/SOGP_aux.cc.s"
	cd /home/champion/catkin_ws/build/sogp && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/champion/catkin_ws/src/sogp/src/SOGP_aux.cc -o CMakeFiles/sogp.dir/src/SOGP_aux.cc.s

sogp/CMakeFiles/sogp.dir/src/SOGP_aux.cc.o.requires:
.PHONY : sogp/CMakeFiles/sogp.dir/src/SOGP_aux.cc.o.requires

sogp/CMakeFiles/sogp.dir/src/SOGP_aux.cc.o.provides: sogp/CMakeFiles/sogp.dir/src/SOGP_aux.cc.o.requires
	$(MAKE) -f sogp/CMakeFiles/sogp.dir/build.make sogp/CMakeFiles/sogp.dir/src/SOGP_aux.cc.o.provides.build
.PHONY : sogp/CMakeFiles/sogp.dir/src/SOGP_aux.cc.o.provides

sogp/CMakeFiles/sogp.dir/src/SOGP_aux.cc.o.provides.build: sogp/CMakeFiles/sogp.dir/src/SOGP_aux.cc.o

# Object files for target sogp
sogp_OBJECTS = \
"CMakeFiles/sogp.dir/src/SOGP.cc.o" \
"CMakeFiles/sogp.dir/src/SOGP_aux.cc.o"

# External object files for target sogp
sogp_EXTERNAL_OBJECTS =

/home/champion/catkin_ws/devel/lib/libsogp.so: sogp/CMakeFiles/sogp.dir/src/SOGP.cc.o
/home/champion/catkin_ws/devel/lib/libsogp.so: sogp/CMakeFiles/sogp.dir/src/SOGP_aux.cc.o
/home/champion/catkin_ws/devel/lib/libsogp.so: sogp/CMakeFiles/sogp.dir/build.make
/home/champion/catkin_ws/devel/lib/libsogp.so: sogp/CMakeFiles/sogp.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX shared library /home/champion/catkin_ws/devel/lib/libsogp.so"
	cd /home/champion/catkin_ws/build/sogp && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/sogp.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
sogp/CMakeFiles/sogp.dir/build: /home/champion/catkin_ws/devel/lib/libsogp.so
.PHONY : sogp/CMakeFiles/sogp.dir/build

sogp/CMakeFiles/sogp.dir/requires: sogp/CMakeFiles/sogp.dir/src/SOGP.cc.o.requires
sogp/CMakeFiles/sogp.dir/requires: sogp/CMakeFiles/sogp.dir/src/SOGP_aux.cc.o.requires
.PHONY : sogp/CMakeFiles/sogp.dir/requires

sogp/CMakeFiles/sogp.dir/clean:
	cd /home/champion/catkin_ws/build/sogp && $(CMAKE_COMMAND) -P CMakeFiles/sogp.dir/cmake_clean.cmake
.PHONY : sogp/CMakeFiles/sogp.dir/clean

sogp/CMakeFiles/sogp.dir/depend:
	cd /home/champion/catkin_ws/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/champion/catkin_ws/src /home/champion/catkin_ws/src/sogp /home/champion/catkin_ws/build /home/champion/catkin_ws/build/sogp /home/champion/catkin_ws/build/sogp/CMakeFiles/sogp.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : sogp/CMakeFiles/sogp.dir/depend

