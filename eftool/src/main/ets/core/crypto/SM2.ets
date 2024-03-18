import { OutDTO } from '../base/OutDTO';
import { StringBuilder } from '../base/StringBuilder';
import crypto from '@ohos.security.cryptoFramework';

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
  static async generateSM2Key(): Promise<OutDTO<SM2Key>> {
    // 创建非对称密钥生成器
    let rsaGenerator = crypto.createAsyKeyGenerator('SM2_256');
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
    return OutDTO.OKByDataRow<SM2Key>('生成SM2公私钥成功~', new SM2Key(pubSb.toString(), priSb.toString()));
  }
}


/**
 * RSA密钥对象
 */
class SM2Key {
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