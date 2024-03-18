import { OutDTO } from '../base/OutDTO';
import crypto from '@ohos.security.cryptoFramework';
import { StringBuilder } from '../base/StringBuilder';

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
  static async generateRSAKey(): Promise<OutDTO<RSAKey>> {
    // 创建非对称密钥生成器
    let rsaGenerator = crypto.createAsyKeyGenerator('RSA1024|PRIMES_2');
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseKeyPair = await rsaGenerator.generateKeyPair();
    // 获取非对称密钥的二进制数据
    let pubSb = new StringBuilder();
    let priSb = new StringBuilder();
    //转换成可以读懂的公钥字符串
    promiseKeyPair.pubKey.getEncoded().data.forEach((value) => {
      pubSb.append(value.toString(16).slice(-2));
    });
    //转换成可以读懂的私钥字符串
    promiseKeyPair.priKey.getEncoded().data.forEach((value) => {
      priSb.append(value.toString(16).slice(-2));
    });
    return OutDTO.OKByDataRow<RSAKey>('生成RSA公私钥成功~', new RSAKey(pubSb.toString(), priSb.toString()));
  }
}

/**
 * RSA密钥对象
 */
class RSAKey {
  /**
   * 公钥
   */
  publicKey: string;
  /**
   * 私钥
   */
  privateKey: string;

  constructor(pubKey: string, priKey: string) {
    this.publicKey = pubKey;
    this.privateKey = priKey;
  }
}