/**
 Copyright 2024 csx - @yunkss/ef_rcp

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


import { EfRcpError } from './EfRcpError';


/**
 * @Author csx
 * @DateTime 2024/8/22 13:47:23
 * @TODO EfRcpResponse 统一的rcp请求响应对象
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_rcp
 */
export interface EfRcpResponse<E> {
  /**
   * 请求成功返回的数据
   */
  data?: E;

  /**
   * 请求失败返回的系统框架级错误信息 - 如连接超时,400，401，403，500等
   */
  error?: EfRcpError;
}