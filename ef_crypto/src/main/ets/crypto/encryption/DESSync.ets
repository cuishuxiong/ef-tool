import { CryptoSyncUtil } from '../util/CryptoSyncUtil';
import { buffer } from '@kit.ArkTS';


/**
 * @Author csx
 * @DateTime 2024/3/18 10:07:03
 * @TODO DESSync 3DES同步操作类
 */
export class DESSync {
  /**
   * 生成3DES的对称密钥
   * @param resultCoding 生成3DES秘钥的字符串格式(hex/base64)-默认不传为base64格式
   * @returns 3DES密钥
   */
  static generate3DESKey(resultCoding: buffer.BufferEncoding = 'base64'): string {
    // 获取对称密钥的二进制数据
    return CryptoSyncUtil.generateSymKey('3DES192', resultCoding);
  }

  /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param desKey   3DES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
  static encodeECB(str: string, desKey: string, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): string {
    return CryptoSyncUtil.encodeECB(str, desKey, '3DES192', '3DES192|ECB|PKCS7', 192, keyCoding, resultCoding);
  }

  /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param aesKey   3DES密钥
   * @param iv   iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
  static encodeCBC(str: string, desKey: string, iv: string,
    keyCoding: buffer.BufferEncoding, resultCoding: buffer.BufferEncoding = 'base64'): string {
    return CryptoSyncUtil.encodeCBC(str, desKey, iv, '3DES192', '3DES192|CBC|PKCS7', 192, keyCoding, resultCoding);
  }


  /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param desKey  3DES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   */
  static decodeECB(str: string, desKey: string, keyCoding: buffer.BufferEncoding,
    dataCoding: buffer.BufferEncoding = 'base64'): string {
    return CryptoSyncUtil.decodeECB(str, desKey, '3DES192', '3DES192|ECB|PKCS7', 192, keyCoding, dataCoding);
  }

  /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey 3DES密钥
   * @param iv  iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
  static decodeCBC(str: string, desKey: string, iv: string,
    keyCoding: buffer.BufferEncoding, dataCoding: buffer.BufferEncoding = 'base64'): string {
    return CryptoSyncUtil.decodeCBC(str, desKey, iv, '3DES192', '3DES192|CBC|PKCS7', 192, keyCoding, dataCoding);
  }
}