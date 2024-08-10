import { DynamicUtil } from '../util/DynamicUtil';


/**
 * @Author csx
 * @DateTime 2024/3/20 20:21
 * @TODO ECDH  动态协商共享密钥
 */
export class ECDH {
  /**
   * ecdh动态协商密钥,要求密钥长度为256位的非对称密钥
   * @param pubKey  符合256位的非对称密钥的公钥字符串或Uint8Array字节流  【一般为外部传入】
   * @param priKey  符合256位的非对称密钥的私钥字符串或Uint8Array字节流  【一般为本项目】
   * @returns ECC256共享密钥
   */
  static async ecdh(pubKey: string | Uint8Array, priKey: string | Uint8Array): Promise<string> {
    return DynamicUtil.dynamicKey(pubKey, priKey, 'ECC256',256);
  }
}