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


/**
 * @Author csx
 * @DateTime 2024/3/18 10:07:03
 * @TODO DES
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_crypto
 */
export class DES {
  /**
   * 生成3DES的对称密钥
   * @returns 3DES密钥
   */
  static async generate3DESKey(): Promise<string> {
    // 获取对称密钥的二进制数据
    return CryptoUtil.generateSymKey('3DES192');
  }

  /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param desKey   3DES密钥
   * @returns
   */
  static async encodeECB(str: string, desKey: string): Promise<string> {
    return CryptoUtil.encodeECB(str, desKey, '3DES192', '3DES192|ECB|PKCS7', 192);
  }

  /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param aesKey   3DES密钥
   * @param iv   iv偏移量字符串
   * @returns
   */
  static async encodeCBC(str: string, desKey: string, iv: string): Promise<string> {
    return CryptoUtil.encodeCBC(str, desKey, iv, '3DES192', '3DES192|CBC|PKCS7', 192);
  }


  /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param desKey  3DES密钥
   */
  static async decodeECB(str: string, desKey: string): Promise<string> {
    return CryptoUtil.decodeECB(str, desKey, '3DES192', '3DES192|ECB|PKCS7', 192);
  }

  /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey 3DES密钥
   * @param iv  iv偏移量字符串
   * @returns
   */
  static async decodeCBC(str: string, desKey: string, iv: string): Promise<string> {
    return CryptoUtil.decodeCBC(str, desKey, iv, '3DES192', '3DES192|CBC|PKCS7', 192);
  }
}