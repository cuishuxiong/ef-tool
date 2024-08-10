/**
 * @Author csx
 * @DateTime 2024/3/20 21:29
 * @TODO X25519
 */

import { DynamicUtil } from '../util/DynamicUtil';

export class X25519 {
  /**
   * X25519动态协商密钥,要求密钥长度为256位的非对称密钥
   * @param pubKey  符合非对称密钥的公钥字符串或Uint8Array字节流  【一般为外部传入】
   * @param priKey  符合非对称密钥的私钥字符串或Uint8Array字节流  【一般为本项目】
   * @returns 256位共享密钥字符串
   */
  static async x25519(pubKey: string | Uint8Array, priKey: string | Uint8Array): Promise<string> {
    return DynamicUtil.dynamicKey(pubKey, priKey, 'X25519', 256);
  }
}