import crypto from '@ohos.security.cryptoFramework';
import { OutDTO } from '../base/OutDTO';
import { StrAndUintUtil } from '../util/StrAndUintUtil';
import { util } from '@kit.ArkTS';
import { RandomUtil } from '../util/RandomUtil';


/**
 * @Author csx
 * @DateTime 2024/3/18 10:07:03
 * @TODO DES
 */
export class DES {

  /**
   * 生成3DES的对称密钥
   * @returns 3DES密钥
   */
  static async generate3DESKey(): Promise<OutDTO<string>> {
    // 创建对称密钥生成器
    let symKeyGenerator = crypto.createSymKeyGenerator('3DES192');
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseSymKey = await symKeyGenerator.generateSymKey();
    //转换成可以读懂的字符串
    let key = StrAndUintUtil.unitArray2String(promiseSymKey.getEncoded().data);
    // 获取对称密钥的二进制数据
    return OutDTO.OKByDataRow<string>('生成3DES密钥成功~', key);
  }

  /**
   * 根据传入的iv字符串转换iv对象
   * @param ivStr
   * @returns
   */
  private static genIvParamsSpec(ivStr: string): crypto.IvParamsSpec {
    let ivBlob: crypto.DataBlob = { data: StrAndUintUtil.stringToByteArray(ivStr) };
    let ivParamsSpec: crypto.IvParamsSpec = {
      algName: "IvParamsSpec",
      iv: ivBlob
    };
    return ivParamsSpec;
  }

  /**
   * 生成CBC模式的iv
   * @returns iv字符串
   */
  static generateIV(): OutDTO<string> {
    return OutDTO.OKByDataRow<string>('获取iv成功~', RandomUtil.randomStrBySize(16));
  }


  /**
   * 将字符串3DESKey转换为symKey对象
   * @param 3DESKey字符串key
   * @returns
   */
  static async convertKeyFromStr(desKey: string) {
    let symKeyBlob: crypto.DataBlob = { data: StrAndUintUtil.stringToByteArray(desKey) };
    let aesGenerator = crypto.createSymKeyGenerator('3DES192');
    let symKey = await aesGenerator.convertKey(symKeyBlob);
    return symKey;
  }

  /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param desKey   3DES密钥
   * @returns
   */
  static async encodeECB(str: string, desKey: string): Promise<OutDTO<string>> {
    //转换key
    let symKey = await DES.convertKeyFromStr(desKey);
    // 初始化加解密操作环境
    let mode = crypto.CryptoMode.ENCRYPT_MODE;
    //创建加密器
    let cipher = crypto.createCipher('3DES192|ECB|PKCS7');
    //初始化加密
    await cipher.init(mode, symKey, null);
    //封装加密所需数据
    let encode = new util.TextEncoder();
    //开始加密
    let updateOutput = await cipher.doFinal({ data: encode.encodeInto(str) });
    //转换字符串
    let result = StrAndUintUtil.unitArray2String(updateOutput.data);
    //返回
    return OutDTO.OKByDataRow<string>('3DES-ECB加密成功~', result);
  }

  /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param aesKey   3DES密钥
   * @param iv   iv偏移量字符串
   * @returns
   */
  static async encodeCBC(str: string, desKey: string, iv: string): Promise<OutDTO<string>> {
    //转换key
    let symKey = await DES.convertKeyFromStr(desKey);
    // 初始化加解密操作环境
    let mode = crypto.CryptoMode.ENCRYPT_MODE;
    //创建加密器
    let cipher = crypto.createCipher('3DES192|CBC|PKCS7');
    //初始化加密
    await cipher.init(mode, symKey, DES.genIvParamsSpec(iv));
    //封装加密所需数据
    let encode = new util.TextEncoder();
    //开始加密
    let updateOutput = await cipher.doFinal({ data: encode.encodeInto(str) });
    //转换字符串
    let result = StrAndUintUtil.unitArray2String(updateOutput.data);
    //返回
    return OutDTO.OKByDataRow<string>('3DES-CMC加密成功~', result);
  }


  /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param desKey  3DES密钥
   */
  static async decodeECB(str: string, desKey: string): Promise<OutDTO<string>> {
    //转换密钥
    let symKey = await await DES.convertKeyFromStr(desKey);
    // 初始化加解密操作环境:开始解密
    let mode = crypto.CryptoMode.DECRYPT_MODE;
    //创建解密器
    let cipher = crypto.createCipher('3DES192|ECB|PKCS7');
    //初始化解密
    await cipher.init(mode, symKey, null);
    //解密
    let updateOutput = await cipher.doFinal({ data: StrAndUintUtil.stringToByteArray(str) });
    let decode = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    return OutDTO.OKByDataRow('3DES-ECB解密成功~', decode.decodeWithStream(updateOutput.data));
  }

  /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey 3DES密钥
   * @param iv  iv偏移量字符串
   * @returns
   */
  static async decodeCBC(str: string, desKey: string, iv: string): Promise<OutDTO<string>> {
    //转换密钥
    let symKey = await await DES.convertKeyFromStr(desKey);
    // 初始化加解密操作环境:开始解密
    let mode = crypto.CryptoMode.DECRYPT_MODE;
    //创建解密器
    let cipher = crypto.createCipher('3DES192|CBC|PKCS7');
    //初始化解密
    await cipher.init(mode, symKey, DES.genIvParamsSpec(iv));
    //解密
    let updateOutput = await cipher.doFinal({ data: StrAndUintUtil.stringToByteArray(str) });
    let decode = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    return OutDTO.OKByDataRow('3DES-CBC解密成功~', decode.decodeWithStream(updateOutput.data));
  }


}