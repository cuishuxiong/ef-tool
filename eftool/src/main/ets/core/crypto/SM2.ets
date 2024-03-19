import { OutDTO } from '../base/OutDTO';
import crypto from '@ohos.security.cryptoFramework';
import { StrAndUintUtil } from '../util/StrAndUintUtil';
import { util } from '@kit.ArkTS';
import { CryptoKey, CryptoUtil } from '../util/CryptoUtil';

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
    //将公钥转换
    let pubPair = await CryptoUtil.convertPubKeyFromStr(pubKey, 'SM2_256');
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
    let priPair = await CryptoUtil.convertPriKeyFromStr(priKey, 'SM2_256');
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
    let priPair = await CryptoUtil.convertPriKeyFromStr(priKey, 'SM2_256');
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
    let pubPair = await CryptoUtil.convertPubKeyFromStr(pubKey, 'SM2_256');
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