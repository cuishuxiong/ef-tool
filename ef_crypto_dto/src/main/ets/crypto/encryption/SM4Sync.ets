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
import { CryptoSyncUtil } from '../util/CryptoSyncUtil';
import { buffer } from '@kit.ArkTS';

/**
 * @Author csx
 * @DateTime 2024/3/18 10:15:03
 * @TODO SM4Sync SM4同步操作类
 */
export class SM4Sync {
  /**
   * 生成SM4的对称密钥
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns SM4密钥
   */
  static generateSM4Key(resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.generateSymKey('SM4_128', resultCoding);
  }


  /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param sm4Key   SM4密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns
   */
  static encodeECB(str: string, sm4Key: string, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.encodeECB(str, sm4Key, 'SM4_128', 'SM4_128|ECB|PKCS7', 128, keyCoding, resultCoding);
  }


  /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param sm4Key  SM4密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   */
  static decodeECB(str: string, sm4Key: string, keyCoding: buffer.BufferEncoding,
    dataCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.decodeECB(str, sm4Key, 'SM4_128', 'SM4_128|ECB|PKCS7', 128, keyCoding, dataCoding);
  }

  /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param aesKey   SM4密钥
   * @param iv   iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
  static encodeCBC(str: string, sm4Key: string, iv: string,
    keyCoding: buffer.BufferEncoding, resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.encodeCBC(str, sm4Key, iv, 'SM4_128', 'SM4_128|CBC|PKCS7', 128, keyCoding, resultCoding);
  }

  /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey SM4密钥
   * @param iv  iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns
   */
  static decodeCBC(str: string, sm4Key: string, iv: string,
    keyCoding: buffer.BufferEncoding, dataCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.decodeCBC(str, sm4Key, iv, 'SM4_128', 'SM4_128|CBC|PKCS7', 128, keyCoding, dataCoding);
  }
}