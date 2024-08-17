/**
 Copyright 2024 csx - @yunkss/ef_crypto_dto

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

import { OutDTO } from '@yunkss/ef_core';
import { CryptoUtil } from '../util/CryptoUtil';

/**
 * @Author csx
 * @DateTime 2024/3/18 10:15:03
 * @TODO SM4
 */
export class SM4 {
  /**
   * 生成SM4的对称密钥
   * @returns SM4密钥
   */
  static async generateSM4Key(): Promise<OutDTO<string>> {
    return CryptoUtil.generateSymKey('SM4_128');
  }


  /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param sm4Key   SM4密钥
   * @returns
   */
  static async encodeECB(str: string, sm4Key: string): Promise<OutDTO<string>> {
    return CryptoUtil.encodeECB(str, sm4Key, 'SM4_128', 'SM4_128|ECB|PKCS7',128);
  }


  /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param sm4Key  SM4密钥
   */
  static async decodeECB(str: string, sm4Key: string): Promise<OutDTO<string>> {
    return CryptoUtil.decodeECB(str, sm4Key, 'SM4_128', 'SM4_128|ECB|PKCS7',128);
  }

  /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param aesKey   SM4密钥
   * @param iv   iv偏移量字符串
   * @returns
   */
  static async encodeCBC(str: string, sm4Key: string, iv: string): Promise<OutDTO<string>> {
    return CryptoUtil.encodeCBC(str, sm4Key, iv, 'SM4_128', 'SM4_128|CBC|PKCS7',128);
  }

  /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey SM4密钥
   * @param iv  iv偏移量字符串
   * @returns
   */
  static async decodeCBC(str: string, sm4Key: string, iv: string): Promise<OutDTO<string>> {
    return CryptoUtil.decodeCBC(str, sm4Key, iv, 'SM4_128', 'SM4_128|CBC|PKCS7',128);
  }
}