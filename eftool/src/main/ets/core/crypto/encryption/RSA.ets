import { OutDTO } from '../../base/OutDTO';
import { CryptoKey, CryptoUtil } from '../../util/CryptoUtil';

/**
 * @Author csx
 * @DateTime 2024/3/18 10:48:03
 * @TODO RSA
 */

export class RSA {
  /**
   * 生成RSA的非对称密钥
   * @returns RSA密钥{publicKey:公钥,privateKey:私钥}
   */
  static async generateRSAKey(): Promise<OutDTO<CryptoKey>> {
    return CryptoUtil.generateCryptoKey('RSA1024');
  }

  /**
   * 加密
   * @param encodeStr  待加密的字符串
   * @param pubKey  RSA公钥
   */
  static async encodePKCS1(str: string, pubKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.encodeAsym(str, pubKey, 'RSA1024', 'RSA1024|PKCS1');
  }

  /**
   * 解密
   * @param decodeStr  待解密的字符串
   * @param priKey    RSA私钥
   */
  static async decodePKCS1(str: string, priKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.decodeAsym(str, priKey, 'RSA1024', 'RSA1024|PKCS1');
  }

  /**
   * 签名-PKCS1
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @returns OutDTO<string> 签名对象
   */
  static async signPKCS1(str: string, priKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.sign(str, priKey, 'RSA1024', 'RSA1024|PKCS1|SHA256');
  }

  /**
   * 验签-PKCS1
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  RSA公钥
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
  static async verifyPKCS1(signStr: string, verifyStr: string, pubKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.verify(signStr, verifyStr, pubKey, 'RSA1024', 'RSA1024|PKCS1|SHA256');
  }
}