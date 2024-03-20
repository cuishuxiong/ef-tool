import { OutDTO } from '../../base/OutDTO';
import crypto from '@ohos.security.cryptoFramework';
import { StrAndUintUtil } from '../../util/StrAndUintUtil';
import { util } from '@kit.ArkTS';
import { CryptoKey, CryptoUtil } from '../../util/CryptoUtil';

/**
 * @Author csx
 * @DateTime 2024/3/18 10:33:03
 * @TODO SM2
 */
export class SM2 {
  /**
   * 生成SM2的非对称密钥
   * @returns SM2密钥{publicKey:公钥,privateKey:私钥}
   */
  static async generateSM2Key(): Promise<OutDTO<CryptoKey>> {
    return CryptoUtil.generateCryptoKey('SM2_256');
  }


  /**
   * 加密
   * @param encodeStr  待加密的字符串
   * @param pubKey  SM2公钥
   */
  static async encode(str: string, pubKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.encodeAsym(str, pubKey, 'SM2_256', 'SM2_256|SM3');
  }

  /**
   * 解密
   * @param decodeStr  待解密的字符串
   * @param priKey    SM2私钥
   */
  static async decode(str: string, priKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.decodeAsym(str, priKey, 'SM2_256', 'SM2_256|SM3');
  }

  /**
   * 签名
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @returns OutDTO<string> 签名对象
   */
  static async sign(str: string, priKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.sign(str, priKey, 'SM2_256', 'SM2_256|SM3');
  }

  /**
   * 验签
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  SM2公钥
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
  static async verify(signStr: string, verifyStr: string, pubKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.verify(signStr, verifyStr, pubKey, 'SM2_256', 'SM2_256|SM3');
  }
}