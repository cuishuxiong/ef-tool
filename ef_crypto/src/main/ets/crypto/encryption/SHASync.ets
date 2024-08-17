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


import { CryptoSyncUtil } from '../util/CryptoSyncUtil';
import { buffer } from '@kit.ArkTS';
import { DynamicSyncUtil } from '../util/DynamicSyncUtil';

/**
 * @Author csx
 * @DateTime 2024/3/20 21:43
 * @TODO SHA
 */
export class SHASync {
  /**
   * SHA1摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
  static digestSHA1(str: string, resultCoding: buffer.BufferEncoding = 'base64'): string {
    return CryptoSyncUtil.digest(str, 'SHA1', resultCoding);
  }

  /**
   * SHA224摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
  static digestSHA224(str: string, resultCoding: buffer.BufferEncoding = 'base64'): string {
    return CryptoSyncUtil.digest(str, 'SHA224', resultCoding);
  }

  /**
   * SHA256摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
  static digest(str: string, resultCoding: buffer.BufferEncoding = 'base64'): string {
    return CryptoSyncUtil.digest(str, 'SHA256', resultCoding);
  }

  /**
   * SHA384摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
  static digestSHA384(str: string, resultCoding: buffer.BufferEncoding = 'base64'): string {
    return CryptoSyncUtil.digest(str, 'SHA384', resultCoding);
  }

  /**
   * SHA512摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
  static digestSHA512(str: string, resultCoding: buffer.BufferEncoding = 'base64'): string {
    return CryptoSyncUtil.digest(str, 'SHA512', resultCoding);
  }

  /**
   * 消息认证码计算
   * @param str  计算字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns
   */
  static hmac(str: string, resultCoding: buffer.BufferEncoding = 'base64'): string {
    return DynamicSyncUtil.hmac(str, 'SHA256', resultCoding);
  }
}