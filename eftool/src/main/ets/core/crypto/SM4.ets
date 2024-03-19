import crypto from '@ohos.security.cryptoFramework';
import { OutDTO } from '../base/OutDTO';
import { StrAndUintUtil } from '../util/StrAndUintUtil';
import { util } from '@kit.ArkTS';
import { CryptoUtil } from '../util/CryptoUtil';

/**
 * @Author csx
 * @DateTime 2024/3/18 10:15:03
 * @TODO SM4
 */
export class SM4 {
  /**
   * 生成SM4的对称密钥
   * @returns SM4密钥
   */
  static async generateSM4Key(): Promise<OutDTO<string>> {
    return CryptoUtil.generateSymKey('SM4_128');
  }


  /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param sm4Key   SM4密钥
   * @returns
   */
  static async encodeECB(str: string, sm4Key: string): Promise<OutDTO<string>> {
    //转换key
    let symKey = await CryptoUtil.convertKeyFromStr(sm4Key, 'SM4_128');
    // 初始化加解密操作环境
    let mode = crypto.CryptoMode.ENCRYPT_MODE;
    //创建加密器
    let cipher = crypto.createCipher('SM4_128|ECB|PKCS7');
    //初始化加密
    await cipher.init(mode, symKey, null);
    //封装加密所需数据
    let encode = new util.TextEncoder();
    //开始加密
    let updateOutput = await cipher.doFinal({ data: encode.encodeInto(str) });
    //转换字符串
    let result = StrAndUintUtil.unitArray2String(updateOutput.data);
    //返回
    return OutDTO.OKByDataRow<string>('SM4-ECB加密成功~', result);
  }

  /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param aesKey   SM4密钥
   * @param iv   iv偏移量字符串
   * @returns
   */
  static async encodeCBC(str: string, sm4Key: string, iv: string): Promise<OutDTO<string>> {
    //转换key
    let symKey = await CryptoUtil.convertKeyFromStr(sm4Key, 'SM4_128');
    // 初始化加解密操作环境
    let mode = crypto.CryptoMode.ENCRYPT_MODE;
    //创建加密器
    let cipher = crypto.createCipher('SM4_128|CBC|PKCS7');
    //初始化加密
    await cipher.init(mode, symKey, CryptoUtil.genIvParamsSpec(iv));
    //封装加密所需数据
    let encode = new util.TextEncoder();
    //开始加密
    let updateOutput = await cipher.doFinal({ data: encode.encodeInto(str) });
    //转换字符串
    let result = StrAndUintUtil.unitArray2String(updateOutput.data);
    //返回
    return OutDTO.OKByDataRow<string>('SM4-CMC加密成功~', result);
  }


  /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param sm4Key  SM4密钥
   */
  static async decodeECB(str: string, sm4Key: string): Promise<OutDTO<string>> {
    //转换密钥
    let symKey = await CryptoUtil.convertKeyFromStr(sm4Key, 'SM4_128');
    // 初始化加解密操作环境:开始解密
    let mode = crypto.CryptoMode.DECRYPT_MODE;
    //创建解密器
    let cipher = crypto.createCipher('SM4_128|ECB|PKCS7');
    //初始化解密
    await cipher.init(mode, symKey, null);
    //解密
    let updateOutput = await cipher.doFinal({ data: StrAndUintUtil.stringToByteArray(str) });
    let decode = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    return OutDTO.OKByDataRow('SM4-ECB解密成功~', decode.decodeWithStream(updateOutput.data));
  }

  /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey SM4密钥
   * @param iv  iv偏移量字符串
   * @returns
   */
  static async decodeCBC(str: string, sm4Key: string, iv: string): Promise<OutDTO<string>> {
    //转换密钥
    let symKey = await CryptoUtil.convertKeyFromStr(sm4Key, 'SM4_128');
    // 初始化加解密操作环境:开始解密
    let mode = crypto.CryptoMode.DECRYPT_MODE;
    //创建解密器
    let cipher = crypto.createCipher('SM4_128|CBC|PKCS7');
    //初始化解密
    await cipher.init(mode, symKey, CryptoUtil.genIvParamsSpec(iv));
    //解密
    let updateOutput = await cipher.doFinal({ data: StrAndUintUtil.stringToByteArray(str) });
    let decode = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    return OutDTO.OKByDataRow('SM4-CBC解密成功~', decode.decodeWithStream(updateOutput.data));
  }
}