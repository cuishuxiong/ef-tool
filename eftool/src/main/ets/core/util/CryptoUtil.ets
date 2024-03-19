import crypto from '@ohos.security.cryptoFramework';
import { OutDTO } from '../base/OutDTO';
import { RandomUtil } from './RandomUtil';
import { StrAndUintUtil } from './StrAndUintUtil';

/**
 * @Author csx
 * @DateTime 2024/3/19 21:42
 * @TODO CryptoUtil  加解密工具类
 */
export class CryptoUtil {
  /**
   * 将非对称加密字符串pubKey转换为symKey对象
   * @param publicKey字符串key
   * @param symAlgName 秘钥规格
   * @returns
   */
  static async convertPubKeyFromStr(publicKey: string, symAlgName: string) {
    let symKeyBlob: crypto.DataBlob = { data: StrAndUintUtil.stringToByteArray(publicKey) };
    let aesGenerator = crypto.createAsyKeyGenerator(symAlgName);
    let symKey = await aesGenerator.convertKey(symKeyBlob, null);
    return symKey;
  }

  /**
   * 将非对称加密字符串priKey转换为symKey对象
   * @param privateKey字符串key
   * @param symAlgName 秘钥规格
   * @returns
   */
  static async convertPriKeyFromStr(privateKey: string, symAlgName: string) {
    let symKeyBlob: crypto.DataBlob = { data: StrAndUintUtil.stringToByteArray(privateKey) };
    let aesGenerator = crypto.createAsyKeyGenerator(symAlgName);
    let symKey = await aesGenerator.convertKey(null, symKeyBlob);
    return symKey;
  }

  /**
   * 将对称加密字符串AESKey转换为symKey对象
   * @param aesKey字符串key
   * @param symAlgName 秘钥规格
   * @returns
   */
  static async convertKeyFromStr(aesKey: string, symAlgName: string) {
    let symKeyBlob: crypto.DataBlob = { data: StrAndUintUtil.stringToByteArray(aesKey) };
    let aesGenerator = crypto.createSymKeyGenerator(symAlgName);
    let symKey = await aesGenerator.convertKey(symKeyBlob);
    return symKey;
  }

  /**
   * 根据传入的iv字符串转换iv对象
   * @param ivStr
   * @returns
   */
  static genIvParamsSpec(ivStr: string): crypto.IvParamsSpec {
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
   * 生成对称密钥
   * @param symAlgName 秘钥规格
   * @returns 指定秘钥规格的对称密钥
   */
  static async generateSymKey(symAlgName: string): Promise<OutDTO<string>> {
    // 创建对称密钥生成器
    let symKeyGenerator = crypto.createSymKeyGenerator(symAlgName);
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseSymKey = await symKeyGenerator.generateSymKey();
    //转换成可以读懂的字符串
    let key = StrAndUintUtil.unitArray2String(promiseSymKey.getEncoded().data);
    // 获取对称密钥的二进制数据
    return OutDTO.OKByDataRow<string>('生成' + symAlgName + '密钥成功~', key);
  }

  /**
   * 生成非对称密钥
   * @param symAlgName 秘钥规格
   * @returns 指定秘钥规格的非对称公私
   */
  static async generateCryptoKey(symAlgName: string): Promise<OutDTO<CryptoKey>> {
    // 创建非对称密钥生成器
    let rsaGenerator = crypto.createAsyKeyGenerator(symAlgName);
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseKeyPair = await rsaGenerator.generateKeyPair();
    // 转换成可以读懂的公私钥字符串
    let pubKey = StrAndUintUtil.unitArray2String(promiseKeyPair.pubKey.getEncoded().data);
    let priKey = StrAndUintUtil.unitArray2String(promiseKeyPair.priKey.getEncoded().data);
    return OutDTO.OKByDataRow<CryptoKey>('生成' + symAlgName + '公私钥成功~', new CryptoKey(pubKey, priKey));
  }
}

/**
 * 非对称密钥对象
 */
export class CryptoKey {
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