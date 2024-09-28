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

import { BusinessError } from '@kit.BasicServicesKit';
import { JSONObject } from '@yunkss/ef_json';


/**
 * @Author csx
 * @DateTime 2024/8/12 22:45
 * @TODO EfRcpError rcp统一异常
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_rcp
 */
export class EfRcpError implements BusinessError {
  /**
   * 编码
   */
  code: number;
  /**
   * 名称
   */
  name: string;
  /**
   * 消息
   */
  message: string;
  /**
   * 堆栈信息
   */
  stack?: string | undefined;

  constructor(code: number, name: string, message: string, stack?: string) {
    this.code = code;
    this.name = name;
    this.message = message;
    if (stack) {
      this.stack = stack;
    }
  }

  toString(): string {
    return JSONObject.toJSONString(this);
  }

  getCode(): number {
    return this.code;
  }

  getName(): string {
    return this.name;
  }

  getMessage(): string {
    return this.message;
  }
}