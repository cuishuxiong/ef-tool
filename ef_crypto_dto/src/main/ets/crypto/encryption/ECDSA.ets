/**
 * @Author csx
 * @DateTime 2024/3/20 20:05
 * @TODO ECDSA
 */
import { OutDTO } from '@yunkss/ef_core';
import { CryptoKey, CryptoUtil } from '../util/CryptoUtil';

export class ECDSA {
  /**
   * 生成ECDSA的非对称密钥
   * @returns ECDSA密钥{publicKey:公钥,privateKey:私钥}
   */
  static async generateECDSAKey(): Promise<OutDTO<CryptoKey>> {
    return CryptoUtil.generateCryptoKey('ECC256');
  }


  /**
   * 签名
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @returns OutDTO<string> 签名对象
   */
  static async sign(str: string, priKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.sign(str, priKey, 'ECC256', 'ECC256|SHA256', 256);
  }

  /**
   * 验签
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  公钥
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
  static async verify(signStr: string, verifyStr: string, pubKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.verify(signStr, verifyStr, pubKey, 'ECC256', 'ECC256|SHA256', 256);
  }
}