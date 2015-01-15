########################################################################
# CMake build script for libcds.


########################################################################
#
# Project-wide settings

# Name of the project.
#
# CMake files in this project can refer to the root source directory
# as ${cds_SOURCE_DIR} and to the root binary directory as
# ${cds_BINARY_DIR}.


cmake_minimum_required(VERSION 2.8.7)
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(AppendCompilerFlags)

project(compress CXX)

# C++11 compiler Check
if(NOT CMAKE_CXX_COMPILER_VERSION) # work around for cmake versions smaller than 2.8.10
    execute_process(COMMAND ${CMAKE_CXX_COMPILER} -dumpversion OUTPUT_VARIABLE CMAKE_CXX_COMPILER_VERSION)
endif()
if(CMAKE_CXX_COMPILER MATCHES ".*clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
      set(CMAKE_COMPILER_IS_CLANGXX 1)
endif()
if( (CMAKE_COMPILER_IS_GNUCXX AND ${CMAKE_CXX_COMPILER_VERSION} VERSION_LESS 4.7) OR
    (CMAKE_COMPILER_IS_CLANGXX AND ${CMAKE_CXX_COMPILER_VERSION} VERSION_LESS 3.2))
  message(FATAL_ERROR "Your C++ compiler does not support C++11. Please install g++ 4.7 (or greater) or clang 3.2 (or greater)")
else()
  message(STATUS "Compiler is recent enough to support C++11.")
endif()

if( CMAKE_COMPILER_IS_GNUCXX )
    append_cxx_compiler_flags("-std=c++11 -Wall -Wextra  -DNDEBUG" "GCC" CMAKE_CXX_FLAGS)
    append_cxx_compiler_flags("-O3 -ffast-math -funroll-loops" "GCC" CMAKE_CXX_OPT_FLAGS)
    if ( CODE_COVERAGE )
        append_cxx_compiler_flags("-g -fprofile-arcs -ftest-coverage -lgcov" "GCC" CMAKE_CXX_FLAGS)
    endif()
else()
    append_cxx_compiler_flags("-std=c++11 -DNDEBUG" "CLANG" CMAKE_CXX_FLAGS)
    append_cxx_compiler_flags("-stdlib=libc++" "CLANG" CMAKE_CXX_FLAGS)
    append_cxx_compiler_flags("-O3 -ffast-math -funroll-loops" "CLANG" CMAKE_CXX_OPT_FLAGS)
endif()







# Where libcds .h files can be found.
include_directories(
  ${cds_SOURCE_DIR}/compression_toolkit
  ${cds_SOURCE_DIR})

add_library(compress 
 coding_policy.cpp
 compression_toolkit/coding_factory.cpp
 compression_toolkit/null_coding.cpp
 compression_toolkit/pfor_coding.cpp
 compression_toolkit/rice_coding.cpp
 compression_toolkit/rice_coding2.cpp
 compression_toolkit/s16_coding.cpp
 compression_toolkit/s9_coding.cpp
 compression_toolkit/unpack.cpp
 compression_toolkit/vbyte_coding.cpp
)
target_include_directories(compress PUBLIC compression_toolkit)
target_include_directories(compress PUBLIC .)
