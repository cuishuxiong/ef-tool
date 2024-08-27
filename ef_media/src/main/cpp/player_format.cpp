/*
 Copyright 2024 csx - @yunkss/ef_media

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */
 
//
// Created on 2024/8/27.
//
// Node APIs are not fully supported. To solve the compilation error of the interface cannot be found,
// please include "napi/native_api.h".

#include "ffmpeg/armeabi-v7a/include/libavformat/avformat.h"
#include <js_native_api.h>
#include <js_native_api_types.h>
static napi_value getVersion(napi_env env) {
     napi_value version ;
     napi_create_int32(env,  avformat_version(), &version);
     return  version;
}