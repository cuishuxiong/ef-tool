import { OutDTO } from '../base/OutDTO';
import crypto from '@ohos.security.cryptoFramework';
import { StrAndUintUtil } from '../util/StrAndUintUtil';
import { util } from '@kit.ArkTS';

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
    // 转换成可以读懂的私钥字符串
    let pubKey = StrAndUintUtil.unitArray2String(promiseKeyPair.pubKey.getEncoded().data);
    let priKey = StrAndUintUtil.unitArray2String(promiseKeyPair.priKey.getEncoded().data);
    return OutDTO.OKByDataRow<SM2Key>('生成SM2公私钥成功~', new SM2Key(pubKey, priKey));
  }

  /**
   * 将字符串pubKey转换为symKey对象
   * @param publicKey字符串key
   * @returns
   */
  static async convertPubKeyFromStr(publicKey: string) {
    let symKeyBlob: crypto.DataBlob = { data: StrAndUintUtil.stringToByteArray(publicKey) };
    let aesGenerator = crypto.createAsyKeyGenerator('SM2_256');
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
    let aesGenerator = crypto.createAsyKeyGenerator('SM2_256');
    let symKey = await aesGenerator.convertKey(null, symKeyBlob);
    return symKey;
  }

  /**
   * 加密
   * @param encodeStr  待加密的字符串
   * @param pubKey  SM2公钥
   */
  static async encode(str: string, pubKey: string): Promise<OutDTO<string>> {
    //将公钥转换
    let pubPair = await SM2.convertPubKeyFromStr(pubKey);
    //生成加密器
    let encoder = crypto.createCipher("SM2_256|SM3");
    //初始化加密环境
    await encoder.init(crypto.CryptoMode.ENCRYPT_MODE, pubPair.pubKey, null);
    //封装加密所需数据
    let encode = new util.TextEncoder();
    //开始加密
    let updateOutput = await encoder.doFinal({ data: encode.encodeInto(str) });
    //转换字符串
    let result = StrAndUintUtil.unitArray2String(updateOutput.data);
    return OutDTO.OKByDataRow('SM2加密成功~', result);
  }

  /**
   * 解密
   * @param decodeStr  待解密的字符串
   * @param priKey    SM2私钥
   */
  static async decode(str: string, priKey: string): Promise<OutDTO<string>> {
    //将私钥转换
    let priPair = await SM2.convertPriKeyFromStr(priKey);
    //生成解密器
    let encoder = crypto.createCipher("SM2_256|SM3");
    //初始化解密环境
    await encoder.init(crypto.CryptoMode.DECRYPT_MODE, priPair.priKey, null);
    //封装加密所需数据
    let updateOutput = await encoder.doFinal({ data: StrAndUintUtil.stringToByteArray(str) });
    let decode = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    return OutDTO.OKByDataRow('SM2解密成功~', decode.decodeWithStream(updateOutput.data));
  }

  /**
   * 签名
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @returns OutDTO<string> 签名对象
   */
  static async sign(str: string, priKey: string): Promise<OutDTO<string>> {
    //将私钥转换
    let priPair = await SM2.convertPriKeyFromStr(priKey);
    //创建签名器
    let signer = crypto.createSign("SM2_256|SM3");
    //初始化签名器
    await signer.init(priPair.priKey);
    let encode = new util.TextEncoder();
    //签名的字符串
    let input: crypto.DataBlob = { data: encode.encodeInto(str) };
    await signer.update(input);
    let sign = await signer.sign(input);
    let signStr = StrAndUintUtil.unitArray2String(sign.data);
    return OutDTO.OKByDataRow('SM2签名成功~', signStr);
  }

  /**
   * 验签
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  SM2公钥
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
  static async verify(signStr: string, verifyStr: string, pubKey: string): Promise<OutDTO<string>> {
    //将公钥转换
    let pubPair = await SM2.convertPubKeyFromStr(pubKey);
    //验签器
    let verifyer = crypto.createVerify("SM2_256|SM3");
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