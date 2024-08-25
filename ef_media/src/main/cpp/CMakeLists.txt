# the minimum version of CMake.
cmake_minimum_required(VERSION 3.5.0)
project(ef_media)

set(NATIVERENDER_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR})

if(DEFINED PACKAGE_FIND_FILE)
    include(${PACKAGE_FIND_FILE})
endif()

#链接头连接
include_directories(${NATIVERENDER_ROOT_PATH}
                    ${NATIVERENDER_ROOT_PATH}/ffmpeg/${OHOS_ARCH}/include)
add_library(ef_media SHARED napi_init.cpp)

target_link_libraries(ef_media PUBLIC libace_napi.z.so)


target_include_directories(ef_media PRIVATE ${NATIVERENDER_ROOT_PATH}/ffmpeg/${OHOS_ARCH}/include)

#添加库avcodec
add_library(avcodec_ffmpeg SHARED IMPORTED)
#链接库avcodec
set_target_properties(avcodec_ffmpeg PROPERTIES IMPORTED_LOCATION ${NATIVERENDER_ROOT_PATH}/ffmpeg/${OHOS_ARCH}/lib/libavcodec.so)

#添加库avdevice
add_library(avdevice_ffmpeg SHARED IMPORTED)
#链接库avdevice
set_target_properties(avdevice_ffmpeg PROPERTIES IMPORTED_LOCATION ${NATIVERENDER_ROOT_PATH}/ffmpeg/${OHOS_ARCH}/lib/libavdevice.so)

#添加库avfilter
add_library(avfilter_ffmpeg SHARED IMPORTED)
#链接库avfilter
set_target_properties(avfilter_ffmpeg PROPERTIES IMPORTED_LOCATION ${NATIVERENDER_ROOT_PATH}/ffmpeg/${OHOS_ARCH}/lib/libavfilter.so)

#添加库avformat
add_library(avformat_ffmpeg SHARED IMPORTED)
#链接库avformat
set_target_properties(avformat_ffmpeg PROPERTIES IMPORTED_LOCATION ${NATIVERENDER_ROOT_PATH}/ffmpeg/${OHOS_ARCH}/lib/libavformat.so)

#添加库avutil
add_library(avutil_ffmpeg SHARED IMPORTED)
#链接库avutil
set_target_properties(avutil_ffmpeg PROPERTIES IMPORTED_LOCATION ${NATIVERENDER_ROOT_PATH}/ffmpeg/${OHOS_ARCH}/lib/libavutil.so)

#添加库swresample
add_library(swresample_ffmpeg SHARED IMPORTED)
#链接库swresample
set_target_properties(swresample_ffmpeg PROPERTIES IMPORTED_LOCATION ${NATIVERENDER_ROOT_PATH}/ffmpeg/${OHOS_ARCH}/lib/libswresample.so)

#添加库swscale
add_library(swscale_ffmpeg SHARED IMPORTED)
#链接库swscale
set_target_properties(swscale_ffmpeg PROPERTIES IMPORTED_LOCATION ${NATIVERENDER_ROOT_PATH}/ffmpeg/${OHOS_ARCH}/lib/libswscale.so)


#引入
target_link_libraries(ef_media PUBLIC avcodec_ffmpeg avdevice_ffmpeg avfilter_ffmpeg avformat_ffmpeg avutil_ffmpeg swresample_ffmpeg swscale_ffmpeg)
