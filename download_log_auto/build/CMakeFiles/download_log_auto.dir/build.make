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
CMAKE_SOURCE_DIR = /home/pi/getLog/download_log_auto

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/pi/getLog/download_log_auto/build

# Include any dependencies generated for this target.
include CMakeFiles/download_log_auto.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/download_log_auto.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/download_log_auto.dir/flags.make

CMakeFiles/download_log_auto.dir/download_log_auto.cpp.o: CMakeFiles/download_log_auto.dir/flags.make
CMakeFiles/download_log_auto.dir/download_log_auto.cpp.o: ../download_log_auto.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/getLog/download_log_auto/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/download_log_auto.dir/download_log_auto.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/download_log_auto.dir/download_log_auto.cpp.o -c /home/pi/getLog/download_log_auto/download_log_auto.cpp

CMakeFiles/download_log_auto.dir/download_log_auto.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/download_log_auto.dir/download_log_auto.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/getLog/download_log_auto/download_log_auto.cpp > CMakeFiles/download_log_auto.dir/download_log_auto.cpp.i

CMakeFiles/download_log_auto.dir/download_log_auto.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/download_log_auto.dir/download_log_auto.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/getLog/download_log_auto/download_log_auto.cpp -o CMakeFiles/download_log_auto.dir/download_log_auto.cpp.s

# Object files for target download_log_auto
download_log_auto_OBJECTS = \
"CMakeFiles/download_log_auto.dir/download_log_auto.cpp.o"

# External object files for target download_log_auto
download_log_auto_EXTERNAL_OBJECTS =

download_log_auto: CMakeFiles/download_log_auto.dir/download_log_auto.cpp.o
download_log_auto: CMakeFiles/download_log_auto.dir/build.make
download_log_auto: /usr/local/lib/libmavsdk_telemetry.so.0.45.0
download_log_auto: /usr/local/lib/libmavsdk_action.so.0.45.0
download_log_auto: /usr/local/lib/libmavsdk_log_files.so.0.45.0
download_log_auto: /usr/local/lib/libmavsdk.so.0.45.0
download_log_auto: CMakeFiles/download_log_auto.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/pi/getLog/download_log_auto/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable download_log_auto"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/download_log_auto.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/download_log_auto.dir/build: download_log_auto

.PHONY : CMakeFiles/download_log_auto.dir/build

CMakeFiles/download_log_auto.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/download_log_auto.dir/cmake_clean.cmake
.PHONY : CMakeFiles/download_log_auto.dir/clean

CMakeFiles/download_log_auto.dir/depend:
	cd /home/pi/getLog/download_log_auto/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pi/getLog/download_log_auto /home/pi/getLog/download_log_auto /home/pi/getLog/download_log_auto/build /home/pi/getLog/download_log_auto/build /home/pi/getLog/download_log_auto/build/CMakeFiles/download_log_auto.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/download_log_auto.dir/depend
