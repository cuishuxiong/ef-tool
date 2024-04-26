import { OutDTO } from '../../base/OutDTO';
import { CryptoKey, CryptoUtil } from '../../util/CryptoUtil';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { ToastUtil } from '../../../ui/prompt/ToastUtil';

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

  static async convertECCSM2Key(pubKey: string) {
    if (pubKey.length != 130) {
      ToastUtil.showToast("SM2公钥长度不正确~");
      return;
    }

    let px = pubKey.substring(2,68);
    let py = pubKey.substring(68);


  }

  /**
   * 获取SM2公共加密参数
   * @returns
   */
  static genSM2CommonSpec(): cryptoFramework.ECCCommonParamsSpec {
    let fieldFp: cryptoFramework.ECFieldFp = {
      fieldType: "Fp",
      p: BigInt("0xFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFF")
    }

    let G: cryptoFramework.Point = {
      x: BigInt("0x32C4AE2C1F1981195F9904466A39C9948FE30BBFF2660BE1715A4589334C74C7"),
      y: BigInt("0xBC3736A2F4F6779C59BDCEE36B692153D0A9877CC62A474002DF32E52139F0A0")
    }

    let SM2CommonSpec: cryptoFramework.ECCCommonParamsSpec = {
      algName: "ECC",
      specType: cryptoFramework.AsyKeySpecType.COMMON_PARAMS_SPEC,
      field: fieldFp,
      a: BigInt("0xFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFC"),
      b: BigInt("0x28E9FA9E9D9F5E344D5A9E4BCF6509A7F39789F515AB8F92DDBCBD414D940E93"),
      g: G,
      n: BigInt("0xFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFF7203DF6B21C6052B53BBF40939D54123"),
      h: 1
    }
    return SM2CommonSpec;
  }
}