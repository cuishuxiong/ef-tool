import crypto from '@ohos.security.cryptoFramework';
import { OutDTO } from '../base/OutDTO';
import { StringBuilder } from '../base/StringBuilder';
import { StrAndUintUtil } from '../util/StrAndUintUtil';
import { util } from '@kit.ArkTS';
import { RandomUtil } from '../util/RandomUtil';

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
    // 创建对称密钥生成器
    let symKeyGenerator = crypto.createSymKeyGenerator('SM4_128');
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseSymKey = await symKeyGenerator.generateSymKey();
    //转换成可以读懂的字符串
    let key = StrAndUintUtil.unitArray2String(promiseSymKey.getEncoded().data);
    // 获取对称密钥的二进制数据
    return OutDTO.OKByDataRow<string>('生成SM4密钥成功~', key);
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
   * 将字符串SM4Key转换为symKey对象
   * @param sm4Key字符串key
   * @returns
   */
  static async convertKeyFromStr(sm4Key: string) {
    let symKeyBlob: crypto.DataBlob = { data: StrAndUintUtil.stringToByteArray(sm4Key) };
    let aesGenerator = crypto.createSymKeyGenerator('SM4_128');
    let symKey = await aesGenerator.convertKey(symKeyBlob);
    return symKey;
  }

  /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param sm4Key   SM4密钥
   * @returns
   */
  static async encodeECB(str: string, sm4Key: string): Promise<OutDTO<string>> {
    //转换key
    let symKey = await SM4.convertKeyFromStr(sm4Key);
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
    let symKey = await SM4.convertKeyFromStr(sm4Key);
    // 初始化加解密操作环境
    let mode = crypto.CryptoMode.ENCRYPT_MODE;
    //创建加密器
    let cipher = crypto.createCipher('SM4_128|CBC|PKCS7');
    //初始化加密
    await cipher.init(mode, symKey, SM4.genIvParamsSpec(iv));
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
    let symKey = await await SM4.convertKeyFromStr(sm4Key);
    // 初始化加解密操作环境:开始解密
    let mode = crypto.CryptoMode.DECRYPT_MODE;
    //创建解密器
    let cipher = crypto.createCipher('SM4_128|ECB|PKCS7');
    //初始化解密
    await cipher.init(mode, symKey, null);
    //解密
    let updateOutput = await cipher.doFinal({ data: StrAndUintUtil.stringToByteArray(str) });
    let decode = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    return OutDTO.OKByDataRow('AES解密成功~', decode.decodeWithStream(updateOutput.data));
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
    let symKey = await await SM4.convertKeyFromStr(sm4Key);
    // 初始化加解密操作环境:开始解密
    let mode = crypto.CryptoMode.DECRYPT_MODE;
    //创建解密器
    let cipher = crypto.createCipher('SM4_128|CBC|PKCS7');
    //初始化解密
    await cipher.init(mode, symKey, SM4.genIvParamsSpec(iv));
    //解密
    let updateOutput = await cipher.doFinal({ data: StrAndUintUtil.stringToByteArray(str) });
    let decode = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    return OutDTO.OKByDataRow('SM4-CBC解密成功~', decode.decodeWithStream(updateOutput.data));
  }

}