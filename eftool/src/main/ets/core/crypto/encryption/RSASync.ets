import { OutDTO } from '../../base/OutDTO';
import { CryptoKey, CryptoUtil } from '../../util/CryptoUtil';
import { buffer, util } from '@kit.ArkTS';
import { StrAndUintUtil } from '../../util/StrAndUintUtil';
import { Base64Util } from '../../util/Base64Util';

/**
 * @Author csx
 * @DateTime 2024/3/18 10:48:03
 * @TODO RSA
 */

export class RSASync {
  /**
   * 生成RSA的非对称密钥
   * @returns RSA密钥{publicKey:公钥,privateKey:私钥}
   */
  static async generateRSAKey(): Promise<OutDTO<CryptoKey>> {
    return CryptoUtil.generateCryptoKey('RSA1024');
  }

  /**
   * 生成2048位RSA的非对称密钥
   * @returns 2048位RSA密钥{publicKey:2048位公钥,privateKey:2048位私钥}
   */
  static async generate2048RSAKey(): Promise<OutDTO<CryptoKey>> {
    return CryptoUtil.generateCryptoKey('RSA2048');
  }

  /**
   * 加密
   * @param encodeStr  待加密的字符串
   * @param pubKey  RSA公钥
   */
  static async encodePKCS1(str: string, pubKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.encodeAsym(str, pubKey, 'RSA1024', 'RSA1024|PKCS1', 1024);
  }

  /**
   * 加密-分段
   * @param encodeStr  待加密的字符串
   * @param pubKey  RSA公钥
   */
  static async encodePKCS1Segment(str: string, pubKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.encodeAsymSegment(str, pubKey, 'RSA1024', 'RSA1024|PKCS1', 1024);
  }

  /**
   * 2048位加密
   * @param encodeStr  待加密的字符串
   * @param pubKey  2048位RSA公钥
   */
  static async encode2048PKCS1(str: string, pubKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.encodeAsym(str, pubKey, 'RSA2048', 'RSA2048|PKCS1', 2048);
  }

  /**
   * 2048位加密-分段
   * @param encodeStr  待加密的字符串
   * @param pubKey  2048位RSA公钥
   */
  static async encode2048PKCS1Segment(str: string, pubKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.encodeAsymSegment(str, pubKey, 'RSA2048', 'RSA2048|PKCS1', 2048);
  }

  /**
   * 解密
   * @param decodeStr  待解密的字符串
   * @param priKey    RSA私钥
   */
  static async decodePKCS1(str: string, priKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.decodeAsym(str, priKey, 'RSA1024', 'RSA1024|PKCS1', 1024);
  }

  /**
   * 解密-分段
   * @param decodeStr  待解密的字符串
   * @param priKey    RSA私钥
   */
  static async decodePKCS1Segment(str: string, priKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.decodeAsymSegment(str, priKey, 'RSA1024', 'RSA1024|PKCS1', 1024);
  }

  /**
   * 2048位解密
   * @param decodeStr  待解密的字符串
   * @param priKey    2048位RSA私钥
   */
  static async decode2048PKCS1(str: string, priKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.decodeAsym(str, priKey, 'RSA2048', 'RSA2048|PKCS1', 2048);
  }

  /**
   * 2048位解密-分段
   * @param decodeStr  待解密的字符串
   * @param priKey    2048位RSA私钥
   */
  static async decode2048PKCS1Segment(str: string, priKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.decodeAsymSegment(str, priKey, 'RSA2048', 'RSA2048|PKCS1', 2048);
  }

  /**
   * 签名-PKCS1
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @returns OutDTO<string> 签名对象
   */
  static async signPKCS1(str: string, priKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.sign(str, priKey, 'RSA1024', 'RSA1024|PKCS1|SHA256', 1024);
  }

  /**
   * 2048位签名-PKCS1
   * @param str  需要签名的字符串
   * @param priKey  2048位私钥
   * @returns OutDTO<string> 签名对象
   */
  static async sign2048PKCS1(str: string, priKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.sign(str, priKey, 'RSA2048', 'RSA2048|PKCS1|SHA256', 2048);
  }

  /**
   * 2048位验签-PKCS1
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  2048位RSA公钥
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
  static async verify2048PKCS1(signStr: string, verifyStr: string, pubKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.verify(signStr, verifyStr, pubKey, 'RSA2048', 'RSA2048|PKCS1|SHA256', 2048);
  }

  /**
   * 验签-PKCS1
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  RSA公钥
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
  static async verifyPKCS1(signStr: string, verifyStr: string, pubKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.verify(signStr, verifyStr, pubKey, 'RSA1024', 'RSA1024|PKCS1|SHA256', 1024);
  }

  /**
   * 将pem文件中的数据转换成公钥字符串支持1024/2048字节
   * @param pemData pem数据以-----BEGIN开头,以-----END结尾
   * @returns
   */
  static pemToStrKey(pemData: string): string {
    // 移除PEM格式的头部和尾部，获取Base64编码的数据
    const base64Data = pemData.replace(/-----BEGIN .*?-----|-----END .*?-----|\s/g, '');
    let options = util.Type.BASIC;
    if (/\r\n/.test(base64Data)) {
      options = util.Type.MIME;
    }
    //转码
    let arr = Base64Util.decodeSync(base64Data, options);
    //返回字符串
    let result = StrAndUintUtil.unitArray2String(arr);
    return result;
  }
}