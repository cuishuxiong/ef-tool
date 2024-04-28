import crypto from '@ohos.security.cryptoFramework';
import { OutDTO } from '../../base/OutDTO';
import { util } from '@kit.ArkTS';
import { StrAndUintUtil } from '../../util/StrAndUintUtil';
import { RandomUtil } from '../../util/RandomUtil';
import { CryptoUtil } from '../../util/CryptoUtil';


/**
 * @Author csx
 * @DateTime 2024/3/18 10:39:03
 * @TODO AES
 */
export class AES {
  /**
   * gcm对象
   */
  private static gcmParams = AES.genGcmParamsSpec();

  /**
   * 生成GCM所需数据
   * @returns
   */
  private static genGcmParamsSpec(): crypto.GcmParamsSpec {
    // let arr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // 12 bytes
    // let dataIv = new Uint8Array(arr);
    let ivBlob: crypto.DataBlob = { data: RandomUtil.randomUnitBySize(12) };
    // arr = [0, 0, 0, 0, 0, 0, 0, 0]; // 8 bytes
    // let dataAad = new Uint8Array(arr);
    let aadBlob: crypto.DataBlob = { data: RandomUtil.randomUnitBySize(8) };
    // arr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // 16 bytes
    // let dataTag = new Uint8Array(arr);
    let tagBlob: crypto.DataBlob = {
      data: RandomUtil.randomUnitBySize(16)
    };
    // GCM的authTag在加密时从doFinal结果中获取，在解密时填入init函数的params参数中
    let gcmParamsSpec: crypto.GcmParamsSpec = {
      iv: ivBlob,
      aad: aadBlob,
      authTag: tagBlob,
      algName: "GcmParamsSpec"
    };
    return gcmParamsSpec;
  }

  /**
   * 生成AES的对称密钥
   * @returns AES密钥
   */
  static async generateAESKey(): Promise<OutDTO<string>> {
    return CryptoUtil.generateSymKey('AES256');
  }

  /**
   * 加密-GCM模式
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @returns
   */
  static async encodeGCM(str: string, aesKey: string): Promise<OutDTO<string>> {
    //转换key
    let symKey = await CryptoUtil.convertKeyFromStr(aesKey, 'AES256');
    // 初始化加解密操作环境
    let mode = crypto.CryptoMode.ENCRYPT_MODE;
    //创建加密器
    let cipher = crypto.createCipher('AES256|GCM|PKCS7');
    //初始化加密
    await cipher.init(mode, symKey, AES.gcmParams);
    //封装加密所需数据
    let encode = new util.TextEncoder();
    let a = encode.encodeInto(str);
    //开始加密
    let updateOutput = await cipher.update({ data: encode.encodeInto(str) });
    //拼接
    let finalOutput = await cipher.doFinal(null);
    if (finalOutput != null) {
      AES.gcmParams.authTag = finalOutput;
    }
    //转换字符串
    let result = StrAndUintUtil.unitArray2String(updateOutput.data);
    //返回
    return OutDTO.OKByDataRow<string>('AES-GCM加密成功~', result);
  }

  /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @param iv   iv偏移量字符串
   * @returns
   */
  static async encodeCBC(str: string, aesKey: string, iv: string): Promise<OutDTO<string>> {
    return CryptoUtil.encodeCBC(str, aesKey, iv, 'AES256', 'AES256|CBC|PKCS7');
  }

  /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @returns
   */
  static async encodeECB(str: string, aesKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.encodeECB(str, aesKey, 'AES256', 'AES256|ECB|PKCS7');
  }

  /**
   * 解密-GCM模式
   * @param str  加密的字符串
   * @param aesKey  AES密钥
   */
  static async decodeGCM(str: string, aesKey: string): Promise<OutDTO<string>> {
    //转换密钥
    let symKey = await await CryptoUtil.convertKeyFromStr(aesKey, 'AES256');
    // 初始化加解密操作环境:开始解密
    let mode = crypto.CryptoMode.DECRYPT_MODE;
    //创建解密器
    let cipher = crypto.createCipher('AES256|GCM|PKCS7');
    //初始化加密
    await cipher.init(mode, symKey, AES.gcmParams);
    //解密
    let updateOutput = await cipher.update({ data: StrAndUintUtil.stringToByteArray(str) });
    //判断是否完成
    let finalOutput = await cipher.doFinal(null);
    let decode = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    return OutDTO.OKByDataRow('AES解密成功~', decode.decodeWithStream(updateOutput.data));
  }

  /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey AES密钥
   * @param iv  iv偏移量字符串
   * @returns
   */
  static async decodeCBC(str: string, aesKey: string, iv: string): Promise<OutDTO<string>> {
    return CryptoUtil.decodeCBC(str, aesKey, iv, 'AES256', 'AES256|CBC|PKCS7');
  }

  /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param aesKey AES密钥
   * @returns
   */
  static async decodeECB(str: string, aesKey: string): Promise<OutDTO<string>> {
    return CryptoUtil.decodeECB(str, aesKey, 'AES256', 'AES256|ECB|PKCS7');
  }
}