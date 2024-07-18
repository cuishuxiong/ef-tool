import { OutDTO } from '../../base/OutDTO';
import { DynamicSyncUtil } from '../../util/DynamicSyncUtil';
import { buffer } from '@kit.ArkTS';

/**
 * @Author csx
 * @DateTime 2024/3/20 20:21
 * @TODO ECDHSync  动态协商共享密钥-同步
 */
export class ECDHSync {
  /**
   * ecdh动态协商密钥,要求密钥长度为256位的非对称密钥
   * @param pubKey  符合256位的非对称密钥的公钥字符串或Uint8Array字节流  【一般为外部传入】
   * @param priKey  符合256位的非对称密钥的私钥字符串或Uint8Array字节流  【一般为本项目】
   * @param keyCoding key的编码方式
   * @param resultCoding  加密后数据的编码方式-不传默认为base64
   * @returns ECC256共享密钥
   */
  static ecdh(pubKey: string | Uint8Array, priKey: string | Uint8Array, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return DynamicSyncUtil.dynamicKey(pubKey, priKey, 'ECC256', 256, keyCoding, resultCoding);
  }
}