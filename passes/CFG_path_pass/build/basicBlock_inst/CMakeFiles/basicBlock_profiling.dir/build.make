# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.20

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/bin/cmake

# The command to remove a file.
RM = /usr/local/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/yifan/AFL-EDGE/passes/CFG_path_pass

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/yifan/AFL-EDGE/passes/CFG_path_pass/build

# Include any dependencies generated for this target.
include basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/compiler_depend.make

# Include the progress variables for this target.
include basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/progress.make

# Include the compile flags for this target's objects.
include basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/flags.make

basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/basicBlock_profiling.cpp.o: basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/flags.make
basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/basicBlock_profiling.cpp.o: ../basicBlock_inst/basicBlock_profiling.cpp
basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/basicBlock_profiling.cpp.o: basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/yifan/AFL-EDGE/passes/CFG_path_pass/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/basicBlock_profiling.cpp.o"
	cd /home/yifan/AFL-EDGE/passes/CFG_path_pass/build/basicBlock_inst && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/basicBlock_profiling.cpp.o -MF CMakeFiles/basicBlock_profiling.dir/basicBlock_profiling.cpp.o.d -o CMakeFiles/basicBlock_profiling.dir/basicBlock_profiling.cpp.o -c /home/yifan/AFL-EDGE/passes/CFG_path_pass/basicBlock_inst/basicBlock_profiling.cpp

basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/basicBlock_profiling.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/basicBlock_profiling.dir/basicBlock_profiling.cpp.i"
	cd /home/yifan/AFL-EDGE/passes/CFG_path_pass/build/basicBlock_inst && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/yifan/AFL-EDGE/passes/CFG_path_pass/basicBlock_inst/basicBlock_profiling.cpp > CMakeFiles/basicBlock_profiling.dir/basicBlock_profiling.cpp.i

basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/basicBlock_profiling.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/basicBlock_profiling.dir/basicBlock_profiling.cpp.s"
	cd /home/yifan/AFL-EDGE/passes/CFG_path_pass/build/basicBlock_inst && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/yifan/AFL-EDGE/passes/CFG_path_pass/basicBlock_inst/basicBlock_profiling.cpp -o CMakeFiles/basicBlock_profiling.dir/basicBlock_profiling.cpp.s

# Object files for target basicBlock_profiling
basicBlock_profiling_OBJECTS = \
"CMakeFiles/basicBlock_profiling.dir/basicBlock_profiling.cpp.o"

# External object files for target basicBlock_profiling
basicBlock_profiling_EXTERNAL_OBJECTS =

basicBlock_inst/libbasicBlock_profiling.so: basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/basicBlock_profiling.cpp.o
basicBlock_inst/libbasicBlock_profiling.so: basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/build.make
basicBlock_inst/libbasicBlock_profiling.so: basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/yifan/AFL-EDGE/passes/CFG_path_pass/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared module libbasicBlock_profiling.so"
	cd /home/yifan/AFL-EDGE/passes/CFG_path_pass/build/basicBlock_inst && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/basicBlock_profiling.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/build: basicBlock_inst/libbasicBlock_profiling.so
.PHONY : basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/build

basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/clean:
	cd /home/yifan/AFL-EDGE/passes/CFG_path_pass/build/basicBlock_inst && $(CMAKE_COMMAND) -P CMakeFiles/basicBlock_profiling.dir/cmake_clean.cmake
.PHONY : basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/clean

basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/depend:
	cd /home/yifan/AFL-EDGE/passes/CFG_path_pass/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/yifan/AFL-EDGE/passes/CFG_path_pass /home/yifan/AFL-EDGE/passes/CFG_path_pass/basicBlock_inst /home/yifan/AFL-EDGE/passes/CFG_path_pass/build /home/yifan/AFL-EDGE/passes/CFG_path_pass/build/basicBlock_inst /home/yifan/AFL-EDGE/passes/CFG_path_pass/build/basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : basicBlock_inst/CMakeFiles/basicBlock_profiling.dir/depend

