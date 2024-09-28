/**
 Copyright 2024 csx - @yunkss/ef_crypto

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

import { CryptoUtil } from '../util/CryptoUtil';
import { DynamicUtil } from '../util/DynamicUtil';

/**
 * @Author csx
 * @DateTime 2024/3/20 21:43
 * @TODO SHA
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_crypto
 */
export class SHA {
  /**
   * SHA1摘要
   * @param str 带摘要的字符串
   * @returns 摘要后的字符串
   */
  static async digestSHA1(str: string): Promise<string> {
    return CryptoUtil.digest(str, 'SHA1');
  }

  /**
   * SHA224摘要
   * @param str 带摘要的字符串
   * @returns 摘要后的字符串
   */
  static async digestSHA224(str: string): Promise<string> {
    return CryptoUtil.digest(str, 'SHA224');
  }

  /**
   * SHA256摘要
   * @param str 带摘要的字符串
   * @returns 摘要后的字符串
   */
  static async digest(str: string): Promise<string> {
    return CryptoUtil.digest(str, 'SHA256');
  }

  /**
   * SHA384摘要
   * @param str 带摘要的字符串
   * @returns 摘要后的字符串
   */
  static async digestSHA384(str: string): Promise<string> {
    return CryptoUtil.digest(str, 'SHA384');
  }

  /**
   * SHA512摘要
   * @param str 带摘要的字符串
   * @returns 摘要后的字符串
   */
  static async digestSHA512(str: string): Promise<string> {
    return CryptoUtil.digest(str, 'SHA512');
  }

  /**
   * 消息认证码计算
   * @param str  计算字符串
   * @returns
   */
  static async hmac(str: string): Promise<string> {
    return DynamicUtil.hmac(str, 'SHA256');
  }
}