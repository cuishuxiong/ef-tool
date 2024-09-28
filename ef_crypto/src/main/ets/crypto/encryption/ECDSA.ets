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

/**
 * @Author csx
 * @DateTime 2024/3/20 20:05
 * @TODO ECDSA
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_crypto
 */

import { CryptoKey, CryptoUtil } from '../util/CryptoUtil';

export class ECDSA {
  /**
   * 生成ECDSA的非对称密钥
   * @returns ECDSA密钥{publicKey:公钥,privateKey:私钥}
   */
  static async generateECDSAKey(): Promise<CryptoKey> {
    return CryptoUtil.generateCryptoKey('ECC256');
  }


  /**
   * 签名
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @returns string> 签名对象
   */
  static async sign(str: string, priKey: string): Promise<string> {
    return CryptoUtil.sign(str, priKey, 'ECC256', 'ECC256|SHA256', 256);
  }

  /**
   * 验签
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  公钥
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
  static async verify(signStr: string, verifyStr: string, pubKey: string): Promise<string> {
    return CryptoUtil.verify(signStr, verifyStr, pubKey, 'ECC256', 'ECC256|SHA256', 256);
  }
}