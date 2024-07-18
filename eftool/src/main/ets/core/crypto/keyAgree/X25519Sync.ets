/**
 * @Author csx
 * @DateTime 2024/3/20 21:29
 * @TODO X25519Sync
 */
import { OutDTO } from '../../base/OutDTO';
import { DynamicSyncUtil } from '../../util/DynamicSyncUtil';
import { buffer } from '@kit.ArkTS';

export class X25519Sync {
  /**
   * X25519动态协商密钥,要求密钥长度为256位的非对称密钥
   * @param pubKey  符合非对称密钥的公钥字符串或Uint8Array字节流  【一般为外部传入】
   * @param priKey  符合非对称密钥的私钥字符串或Uint8Array字节流  【一般为本项目】
   * @param keyCoding key的编码方式
   * @param resultCoding  加密后数据的编码方式-不传默认为base64
   * @returns 256位共享密钥字符串
   */
  static x25519(pubKey: string | Uint8Array, priKey: string | Uint8Array, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return DynamicSyncUtil.dynamicKey(pubKey, priKey, 'X25519', 256, keyCoding, resultCoding);
  }
}