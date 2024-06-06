# the minimum version of CMake.
cmake_minimum_required(VERSION 3.4.1)
project(ef-tool)

# 设置make文件所在的路径
set(NATIVERENDER_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR})

# 设置lib所在的路径
set(LIBRARY_DIR "${NATIVERENDER_ROOT_PATH}/../../../libs/${OHOS_ARCH}")


if(DEFINED PACKAGE_FIND_FILE)
    include(${PACKAGE_FIND_FILE})
endif()

# 引入头文件
include_directories(
    ${NATIVERENDER_ROOT_PATH}
    ${NATIVERENDER_ROOT_PATH}/include
)

find_library(
    # Sets the name of the path variable.
    hilog-lib
    # Specifies the name of the NDK library that
    # you want CMake to locate.
    hilog_ndk.z
)

# 添加当前项目为库
add_library(efndk SHARED napi_init.cpp)
# 添加openssl的libssl库
add_library(libssl SHARED IMPORTED)
# 添加openssl的libcrypto库
add_library(libcrypto SHARED IMPORTED)

#设置libssl库链接路径
set_target_properties(libssl
    PROPERTIES
    IMPORTED_LOCATION ${LIBRARY_DIR}/libssl.so)

#设置libcrypto库链接路径
set_target_properties(libcrypto
    PROPERTIES
    IMPORTED_LOCATION ${LIBRARY_DIR}/libcrypto.so)

#设置当前项目libssl库引用链接
target_link_libraries(efndk PUBLIC libace_napi.z.so libssl)
#设置当前项目libcrypto库引用链接
target_link_libraries(efndk PUBLIC libace_napi.z.so libcrypto)

target_link_libraries(efndk PUBLIC ${hilog-lib} libace_napi.z.so libc++.a)