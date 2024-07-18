import { OutDTO } from '../../base/OutDTO';
import { CryptoSyncUtil } from '../../util/CryptoSyncUtil';
import { buffer } from '@kit.ArkTS';

/**
 * @Author csx
 * @DateTime 2024/3/18 10:15:03
 * @TODO SM4Sync SM4同步操作类
 */
export class SM4Sync {
  /**
   * 生成SM4的对称密钥
   * @param resultCoding 生成SM4秘钥的字符串格式-默认不传为base64格式
   * @returns SM4密钥
   */
  static generateSM4Key(resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.generateSymKey('SM4_128', resultCoding);
  }


  /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param sm4Key   SM4密钥
   * @param keyCoding key的编码方式
   * @param resultCoding  加密后数据的编码方式-不传默认为base64
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
   * @param keyCoding key的编码方式
   * @param dataCoding  待解密的数据的编码方式-不传默认为base64
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
   * @param keyCoding key的编码方式
   * @param resultCoding  加密后数据的编码方式-不传默认为base64
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
   * @param keyCoding key的编码方式
   * @param dataCoding  待解密的数据的编码方式-不传默认为base64
   * @returns
   */
  static decodeCBC(str: string, sm4Key: string, iv: string,
    keyCoding: buffer.BufferEncoding, dataCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.decodeCBC(str, sm4Key, iv, 'SM4_128', 'SM4_128|CBC|PKCS7', 128, keyCoding, dataCoding);
  }
}