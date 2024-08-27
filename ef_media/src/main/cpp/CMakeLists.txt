# the minimum version of CMake.
cmake_minimum_required(VERSION 3.5.0)
project(efplayer)

set(NATIVERENDER_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR})

if(DEFINED PACKAGE_FIND_FILE)
    include(${PACKAGE_FIND_FILE})
endif()

#链接头连接
include_directories(${NATIVERENDER_ROOT_PATH}
                    ${NATIVERENDER_ROOT_PATH}include)
add_library(efplayer SHARED napi_init.cpp)

target_link_libraries(efplayer PUBLIC libace_napi.z.so)