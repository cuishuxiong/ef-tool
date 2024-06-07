# the minimum version of CMake.
cmake_minimum_required(VERSION 3.4.1)
project(efndk)

# 设置make文件所在的路径
set(NATIVERENDER_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR})

# 设置lib所在的路径
set(LIBRARY_DIR "${NATIVERENDER_ROOT_PATH}/../../../libs/${OHOS_ARCH}")

#if(DEFINED PACKAGE_FIND_FILE)
#    include(${PACKAGE_FIND_FILE})
#endif()

# 引入头文件
include_directories(
    BEFORE
    ${NATIVERENDER_ROOT_PATH}
    ${NATIVERENDER_ROOT_PATH}/include
)

#find_library(
#    hilog-lib
#    hilog_ndk.z
#)


# 添加openssl的libssl库
add_library(ssl SHARED IMPORTED)
# 添加openssl的libcrypto库
add_library(crypto SHARED IMPORTED)
# 添加当前项目为库
add_library(efndk SHARED napi_init.cpp)


#设置libssl库链接路径
set_target_properties(ssl
    PROPERTIES
    IMPORTED_LOCATION ${LIBRARY_DIR}/libssl.so)

#设置libcrypto库链接路径
set_target_properties(crypto
    PROPERTIES
    IMPORTED_LOCATION ${LIBRARY_DIR}/libcrypto.so)

#设置当前项目库引用链接
target_link_libraries(efndk PUBLIC libace_napi.z.so libc++.a )
#target_link_libraries(efndk PUBLIC crypto)
#target_link_libraries(efndk PUBLIC ssl)
#target_link_libraries(efndk PUBLIC libace_napi.z.so libc++.a)
