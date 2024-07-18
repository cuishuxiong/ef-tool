import { OutDTO } from '../../base/OutDTO';
import { buffer, util } from '@kit.ArkTS';
import { StrAndUintUtil } from '../../util/StrAndUintUtil';
import { Base64Util } from '../../util/Base64Util';
import { CryptoKey, CryptoSyncUtil } from '../../util/CryptoSyncUtil';

/**
 * @Author csx
 * @DateTime 2024/3/18 10:48:03
 * @TODO RS 同步操作类
 */

export class RSASync {
  /**
   * 生成RSA的非对称密钥
   * @param resultCoding 生成RSA秘钥的字符串格式-默认不传为base64格式
   * @returns RSA密钥{publicKey:公钥,privateKey:私钥}
   */
  static generateRSAKey(resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<CryptoKey> {
    return CryptoSyncUtil.generateCryptoKey('RSA1024', resultCoding);
  }

  /**
   * 生成2048位RSA的非对称密钥
   * @param resultCoding 生成RSA秘钥的字符串格式-默认不传为base64格式
   * @returns 2048位RSA密钥{publicKey:2048位公钥,privateKey:2048位私钥}
   */
  static generate2048RSAKey(resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<CryptoKey> {
    return CryptoSyncUtil.generateCryptoKey('RSA2048', resultCoding);
  }

  /**
   * 加密
   * @param encodeStr  待加密的字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64)
   * @param resultCoding  返回结果编码方式(utf8/hex/base64)-默认不传为base64格式
   * @param pubKey  RSA公钥
   */
  static encodePKCS1(str: string, pubKey: string, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.encodeAsym(str, pubKey, 'RSA1024', 'RSA1024|PKCS1', 1024, keyCoding, resultCoding);
  }

  /**
   * 加密-分段
   * @param encodeStr  待加密的字符串
   * @param pubKey  RSA公钥
   */
  static encodePKCS1Segment(str: string, pubKey: string, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.encodeAsymSegment(str, pubKey, 'RSA1024', 'RSA1024|PKCS1', 1024, keyCoding, resultCoding);
  }

  /**
   * 2048位加密
   * @param encodeStr  待加密的字符串
   * @param pubKey  2048位RSA公钥
   */
  static encode2048PKCS1(str: string, pubKey: string, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.encodeAsym(str, pubKey, 'RSA2048', 'RSA2048|PKCS1', 2048, keyCoding, resultCoding);
  }

  /**
   * 2048位加密-分段
   * @param encodeStr  待加密的字符串
   * @param pubKey  2048位RSA公钥
   */
  static encode2048PKCS1Segment(str: string, pubKey: string, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.encodeAsymSegment(str, pubKey, 'RSA2048', 'RSA2048|PKCS1', 2048, keyCoding, resultCoding);
  }

  /**
   * 解密
   * @param decodeStr  待解密的字符串
   * @param priKey    RSA私钥
   */
  static decodePKCS1(str: string, priKey: string, keyCoding: buffer.BufferEncoding,
    dataCoding: buffer.BufferEncoding): OutDTO<string> {
    return CryptoSyncUtil.decodeAsym(str, priKey, 'RSA1024', 'RSA1024|PKCS1', 1024, keyCoding, dataCoding);
  }

  /**
   * 解密-分段
   * @param decodeStr  待解密的字符串
   * @param priKey    RSA私钥
   */
  static decodePKCS1Segment(str: string, priKey: string, keyCoding: buffer.BufferEncoding,
    dataCoding: buffer.BufferEncoding): OutDTO<string> {
    return CryptoSyncUtil.decodeAsymSegment(str, priKey, 'RSA1024', 'RSA1024|PKCS1', 1024, keyCoding, dataCoding);
  }

  /**
   * 2048位解密
   * @param decodeStr  待解密的字符串
   * @param priKey    2048位RSA私钥
   */
  static decode2048PKCS1(str: string, priKey: string, keyCoding: buffer.BufferEncoding,
    dataCoding: buffer.BufferEncoding): OutDTO<string> {
    return CryptoSyncUtil.decodeAsym(str, priKey, 'RSA2048', 'RSA2048|PKCS1', 2048, keyCoding, dataCoding);
  }

  /**
   * 2048位解密-分段
   * @param decodeStr  待解密的字符串
   * @param priKey    2048位RSA私钥
   */
  static decode2048PKCS1Segment(str: string, priKey: string, keyCoding: buffer.BufferEncoding,
    dataCoding: buffer.BufferEncoding): OutDTO<string> {
    return CryptoSyncUtil.decodeAsymSegment(str, priKey, 'RSA2048', 'RSA2048|PKCS1', 2048, keyCoding, dataCoding);
  }

  /**
   * 签名-PKCS1
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @returns OutDTO<string> 签名对象
   */
  static signPKCS1(str: string, priKey: string, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.sign(str, priKey, 'RSA1024', 'RSA1024|PKCS1|SHA256', 1024, keyCoding, resultCoding);
  }

  /**
   * 2048位签名-PKCS1
   * @param str  需要签名的字符串
   * @param priKey  2048位私钥
   * @returns OutDTO<string> 签名对象
   */
  static sign2048PKCS1(str: string, priKey: string, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.sign(str, priKey, 'RSA2048', 'RSA2048|PKCS1|SHA256', 2048, keyCoding, resultCoding);
  }

  /**
   * 2048位验签-PKCS1
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  2048位RSA公钥
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
  static verify2048PKCS1(signStr: string, verifyStr: string, pubKey: string, keyCoding: buffer.BufferEncoding,
    dataCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.verify(signStr, verifyStr, pubKey, 'RSA2048', 'RSA2048|PKCS1|SHA256', 2048, keyCoding,
      dataCoding);
  }

  /**
   * 验签-PKCS1
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  RSA公钥
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
  static verifyPKCS1(signStr: string, verifyStr: string, pubKey: string, keyCoding: buffer.BufferEncoding,
    dataCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.verify(signStr, verifyStr, pubKey, 'RSA1024', 'RSA1024|PKCS1|SHA256', 1024, keyCoding,
      dataCoding);
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