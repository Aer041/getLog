# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


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
CMAKE_SOURCE_DIR = /home/pi/getLog/two_mavsdk

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/pi/getLog/two_mavsdk/build

# Include any dependencies generated for this target.
include CMakeFiles/two_mavsdk.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/two_mavsdk.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/two_mavsdk.dir/flags.make

CMakeFiles/two_mavsdk.dir/two_mavsdk.cpp.o: CMakeFiles/two_mavsdk.dir/flags.make
CMakeFiles/two_mavsdk.dir/two_mavsdk.cpp.o: ../two_mavsdk.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/getLog/two_mavsdk/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/two_mavsdk.dir/two_mavsdk.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/two_mavsdk.dir/two_mavsdk.cpp.o -c /home/pi/getLog/two_mavsdk/two_mavsdk.cpp

CMakeFiles/two_mavsdk.dir/two_mavsdk.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/two_mavsdk.dir/two_mavsdk.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/getLog/two_mavsdk/two_mavsdk.cpp > CMakeFiles/two_mavsdk.dir/two_mavsdk.cpp.i

CMakeFiles/two_mavsdk.dir/two_mavsdk.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/two_mavsdk.dir/two_mavsdk.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/getLog/two_mavsdk/two_mavsdk.cpp -o CMakeFiles/two_mavsdk.dir/two_mavsdk.cpp.s

# Object files for target two_mavsdk
two_mavsdk_OBJECTS = \
"CMakeFiles/two_mavsdk.dir/two_mavsdk.cpp.o"

# External object files for target two_mavsdk
two_mavsdk_EXTERNAL_OBJECTS =

two_mavsdk: CMakeFiles/two_mavsdk.dir/two_mavsdk.cpp.o
two_mavsdk: CMakeFiles/two_mavsdk.dir/build.make
two_mavsdk: /usr/local/lib/libmavsdk_telemetry.so.0.45.0
two_mavsdk: /usr/local/lib/libmavsdk_action.so.0.45.0
two_mavsdk: /usr/local/lib/libmavsdk_log_files.so.0.45.0
two_mavsdk: /usr/local/lib/libmavsdk.so.0.45.0
two_mavsdk: CMakeFiles/two_mavsdk.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/pi/getLog/two_mavsdk/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable two_mavsdk"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/two_mavsdk.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/two_mavsdk.dir/build: two_mavsdk

.PHONY : CMakeFiles/two_mavsdk.dir/build

CMakeFiles/two_mavsdk.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/two_mavsdk.dir/cmake_clean.cmake
.PHONY : CMakeFiles/two_mavsdk.dir/clean

CMakeFiles/two_mavsdk.dir/depend:
	cd /home/pi/getLog/two_mavsdk/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pi/getLog/two_mavsdk /home/pi/getLog/two_mavsdk /home/pi/getLog/two_mavsdk/build /home/pi/getLog/two_mavsdk/build /home/pi/getLog/two_mavsdk/build/CMakeFiles/two_mavsdk.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/two_mavsdk.dir/depend

