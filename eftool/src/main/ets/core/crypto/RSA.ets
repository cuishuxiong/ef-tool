import { OutDTO } from '../base/OutDTO';
import crypto from '@ohos.security.cryptoFramework';
import { StrAndUintUtil } from '../util/StrAndUintUtil';
import { util } from '@kit.ArkTS';

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
    let rsaGenerator = crypto.createAsyKeyGenerator('RSA1024');
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseKeyPair = await rsaGenerator.generateKeyPair();
    // 转换成可以读懂的公私钥字符串
    let pubKey = StrAndUintUtil.unitArray2String(promiseKeyPair.pubKey.getEncoded().data);
    let priKey = StrAndUintUtil.unitArray2String(promiseKeyPair.priKey.getEncoded().data);
    return OutDTO.OKByDataRow<RSAKey>('生成RSA公私钥成功~', new RSAKey(pubKey, priKey));
  }

  /**
   * 将字符串pubKey转换为symKey对象
   * @param publicKey字符串key
   * @returns
   */
  static async convertPubKeyFromStr(publicKey: string) {
    let symKeyBlob: crypto.DataBlob = { data: StrAndUintUtil.stringToByteArray(publicKey) };
    let aesGenerator = crypto.createAsyKeyGenerator('RSA1024');
    let symKey = await aesGenerator.convertKey(symKeyBlob, null);
    return symKey;
  }

  /**
   * 将字符串priKey转换为symKey对象
   * @param privateKey字符串key
   * @returns
   */
  static async convertPriKeyFromStr(privateKey: string) {
    let symKeyBlob: crypto.DataBlob = { data: StrAndUintUtil.stringToByteArray(privateKey) };
    let aesGenerator = crypto.createAsyKeyGenerator('RSA1024');
    let symKey = await aesGenerator.convertKey(null, symKeyBlob);
    return symKey;
  }

  /**
   * 加密
   * @param encodeStr  待加密的字符串
   * @param pubKey  RSA公钥
   */
  static async encodePKCS1(str: string, pubKey: string): Promise<OutDTO<string>> {
    //将公钥转换
    let pubPair = await RSA.convertPubKeyFromStr(pubKey);
    //生成加密器
    let encoder = crypto.createCipher("RSA1024|PKCS1");
    //初始化加密环境
    await encoder.init(crypto.CryptoMode.ENCRYPT_MODE, pubPair.pubKey, null);
    //封装加密所需数据
    let encode = new util.TextEncoder();
    //开始加密
    let updateOutput = await encoder.doFinal({ data: encode.encodeInto(str) });
    //转换字符串
    let result = StrAndUintUtil.unitArray2String(updateOutput.data);
    return OutDTO.OKByDataRow('RSA-PKCS1加密成功~', result);
  }

  /**
   * 解密
   * @param decodeStr  待解密的字符串
   * @param priKey    RSA私钥
   */
  static async decodePKCS1(str: string, priKey: string): Promise<OutDTO<string>> {
    //将私钥转换
    let priPair = await RSA.convertPriKeyFromStr(priKey);
    //生成解密器
    let encoder = crypto.createCipher("RSA1024|PKCS1");
    //初始化解密环境
    await encoder.init(crypto.CryptoMode.DECRYPT_MODE, priPair.priKey, null);
    //封装加密所需数据
    let updateOutput = await encoder.doFinal({ data: StrAndUintUtil.stringToByteArray(str) });
    let decode = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    return OutDTO.OKByDataRow('RSA-PKCS1解密成功~', decode.decodeWithStream(updateOutput.data));
  }

  /**
   * 签名-PKCS1
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @returns OutDTO<string> 签名对象
   */
  static async signPKCS1(str: string, priKey: string): Promise<OutDTO<string>> {
    //将私钥转换
    let priPair = await RSA.convertPriKeyFromStr(priKey);
    //创建签名器
    let signer = crypto.createSign("RSA1024|PKCS1|SHA256");
    //初始化签名器
    await signer.init(priPair.priKey);
    let encode = new util.TextEncoder();
    //签名的字符串
    let input: crypto.DataBlob = { data: encode.encodeInto(str) };
    await signer.update(input);
    let sign = await signer.sign(input);
    let signStr = StrAndUintUtil.unitArray2String(sign.data);
    return OutDTO.OKByDataRow('RSA签名成功~', signStr);
  }

  /**
   * 验签-PKCS1
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  RSA公钥
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
  static async verifyPKCS1(signStr: string, verifyStr: string, pubKey: string): Promise<OutDTO<string>> {
    //将公钥转换
    let pubPair = await RSA.convertPubKeyFromStr(pubKey);
    //验签器
    let verifyer = crypto.createVerify("RSA1024|PKCS1|SHA256");
    //初始化验签器
    await verifyer.init(pubPair.pubKey);
    let encode = new util.TextEncoder();
    //验签的字符串
    let verify: crypto.DataBlob = { data: encode.encodeInto(verifyStr) };

    await verifyer.update(verify);
    let sign: crypto.DataBlob = { data: StrAndUintUtil.stringToByteArray(signStr) };
    let result = await verifyer.verify(verify, sign);
    if (result) {
      return OutDTO.OK("验签成功,签名正确");
    } else {
      return OutDTO.Error("验签失败,签名不正确");
    }
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