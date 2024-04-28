import { OutDTO } from '../../base/OutDTO';
import { CryptoUtil } from '../../util/CryptoUtil';


/**
 * @Author csx
 * @DateTime 2024/3/18 10:07:03
 * @TODO DES
 */
export class DES {
  /**
   * 生成3DES的对称密钥
   * @returns 3DES密钥
   */
  static async generate3DESKey(): Promise<OutDTO<string>> {
    // 获取对称密钥的二进制数据
    return CryptoUtil.generateSymKey('3DES192');
  }

  /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param desKey   3DES密钥
   * @returns
   */
  static async encodeECB(str: string, desKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.encodeECB(str,desKey,'3DES192','3DES192|ECB|PKCS7');
  }

  /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param aesKey   3DES密钥
   * @param iv   iv偏移量字符串
   * @returns
   */
  static async encodeCBC(str: string, desKey: string, iv: string): Promise<OutDTO<string>> {
    return CryptoUtil.encodeCBC(str, desKey, iv, '3DES192', '3DES192|CBC|PKCS7');
  }


  /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param desKey  3DES密钥
   */
  static async decodeECB(str: string, desKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.decodeECB(str,desKey,'3DES192','3DES192|ECB|PKCS7');
  }

  /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey 3DES密钥
   * @param iv  iv偏移量字符串
   * @returns
   */
  static async decodeCBC(str: string, desKey: string, iv: string): Promise<OutDTO<string>> {
    return CryptoUtil.decodeCBC(str, desKey, iv, '3DES192', '3DES192|CBC|PKCS7');
  }
}