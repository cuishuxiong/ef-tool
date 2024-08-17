/**
 Copyright 2024 csx - @yunkss/ef_core

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

/**
 * @Author csx
 * @DateTime 2024/6/6 00:19
 * @TODO Base64Util  base64工具类
 */
import { buffer, util } from '@kit.ArkTS';

export class Base64Util {
  /**
   * 将Uint8Array转化为字符串-异步
   * @param array Uint8Array数组
   * @returns 转码后的字符串
   */
  static encodeToStr(array: Uint8Array, options?: util.Type): Promise<string> {
    let base64 = new util.Base64Helper();
    return base64.encodeToString(array, options);
  }

  /**
   * 将字符串转换为Uint8Array数组-异步
   * @param array 待转换的字符串
   * @returns 转码后的Uint8Array数组
   */
  static decode(str: string, options?: util.Type): Promise<Uint8Array> {
    let base64 = new util.Base64Helper();
    return base64.decode(str, options);
  }

  /**
   * 将Uint8Array转化为字符串-同步
   * @param array Uint8Array数组
   * @returns 转码后的字符串
   */
  static encodeToStrSync(array: Uint8Array, options?: util.Type): string {
    let base64 = new util.Base64Helper();
    let result = base64.encodeToStringSync(array, options);
    return result;
  }

  /**
   * 将字符串转换为Uint8Array数组-同步
   * @param string  待转换的字符串
   * @returns 转码后的Uint8Array数组
   */
  static decodeSync(str: string, options?: util.Type): Uint8Array {
    let base64 = new util.Base64Helper();
    let result = base64.decodeSync(str, options);
    return result;
  }

  /**
   * hex格式字符串转base64
   * @param hexStr  16进制字符串
   * @param options
   * @returns
   */
  static encodeHexStr2base64(hexStr: string, options?: util.Type): string {
    return Base64Util.encodeToStrSync(new Uint8Array(buffer.from(hexStr).buffer), options);
  }
}