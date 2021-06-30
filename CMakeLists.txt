cmake_minimum_required(VERSION 3.15)

cmake_policy(SET CMP0048 NEW)
set(CMAKE_PROJECT_VERSION_MAJOR 1)
set(CMAKE_PROJECT_VERSION_MINOR 0)
set(CMAKE_PROJECT_VERSION_PATCH 0)
set(CMAKE_PROJECT_VERSION "${CMAKE_PROJECT_VERSION_MAJOR}.${CMAKE_PROJECT_VERSION_MINOR}.${CMAKE_PROJECT_VERSION_PATCH}")
PROJECT(ocl-test VERSION "${CMAKE_PROJECT_VERSION}")

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(CONAN_EXPERIMENTAL_INCLUDE "CONAN EXPERIMENT INCLUDE" ON)

enable_testing()

#############################################################################################
#conan

set(CONAN_SYSTEM_INCLUDES "On")
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup(NO_OUTPUT_DIRS)

find_package(OpenCL REQUIRED)
set(CONAN_LIBS ${CONAN_LIBS} ${OpenCL_LIBRARIES}) # LAPACK::LAPACK)

message(STATUS "LIBS = ${CONAN_LIBS}")
message(STATUS "CMAKE_BUILD_TYPE = ${CMAKE_BUILD_TYPE}")

# conan
#############################################################################################

get_filename_component(ROOT_PATH "${CMAKE_CURRENT_LIST_DIR}/" ABSOLUTE)

set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -s")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -s")

#set(BLA_VENDOR Intel10_64lp_seq)
#find_package(LAPACK REQUIRED)

add_executable(${PROJECT_NAME}
    main.cpp
)

target_link_libraries(
        ${PROJECT_NAME} PRIVATE
        ${CONAN_LIBS}
        ${OpenCL_LIBRARIES}
)

target_compile_definitions(${PROJECT_NAME} PRIVATE WITH_OPENCL=1)
