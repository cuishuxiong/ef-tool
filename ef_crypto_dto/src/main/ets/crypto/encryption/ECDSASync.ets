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
import { CryptoKey, CryptoSyncUtil } from '../util/CryptoSyncUtil';
import { buffer } from '@kit.ArkTS';

/**
 * @Author csx
 * @DateTime 2024/3/20 20:05
 * @TODO ECDSASync   同步操作类
 */
export class ECDSASync {
  /**
   * 生成ECDSA的非对称密钥
   * @param resultCoding 生成ECDSA秘钥的字符串格式-默认不传为base64格式
   * @returns ECDSA密钥{publicKey:公钥,privateKey:私钥}
   */
  static generateECDSAKey(resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<CryptoKey> {
    return CryptoSyncUtil.generateCryptoKey('ECC256', resultCoding);
  }


  /**
   * 签名
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64) - 不传默认为base64
   * @returns OutDTO<string> 签名对象
   */
  static sign(str: string, priKey: string, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.sign(str, priKey, 'ECC256', 'ECC256|SHA256', 256, keyCoding, resultCoding,false);
  }

  /**
   * 验签
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
  static verify(signStr: string, verifyStr: string, pubKey: string, keyCoding: buffer.BufferEncoding,
    dataCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.verify(signStr, verifyStr, pubKey, 'ECC256', 'ECC256|SHA256', 256, keyCoding, dataCoding,false);
  }
}