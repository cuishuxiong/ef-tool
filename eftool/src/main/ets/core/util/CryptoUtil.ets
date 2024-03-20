import crypto from '@ohos.security.cryptoFramework';
import { OutDTO } from '../base/OutDTO';
import { StrAndUintUtil } from './StrAndUintUtil';
import { buffer, util } from '@kit.ArkTS';

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

  /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param key   给定秘钥规格密钥
   * @param iv   iv偏移量字符串
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   * @returns
   */
  static async encodeCBC(str: string, key: string, iv: string, symAlgName: string, symEncryptName: string): Promise<OutDTO<string>> {
    //转换key
    let symKey = await CryptoUtil.convertKeyFromStr(key, symAlgName);
    // 初始化加解密操作环境
    let mode = crypto.CryptoMode.ENCRYPT_MODE;
    //创建加密器
    let cipher = crypto.createCipher(symEncryptName);
    //初始化加密
    await cipher.init(mode, symKey, CryptoUtil.genIvParamsSpec(iv));
    //封装加密所需数据
    let encode = new util.TextEncoder();
    //开始加密
    let updateOutput = await cipher.doFinal({ data: encode.encodeInto(str) });
    //转换字符串
    let result = StrAndUintUtil.unitArray2String(updateOutput.data);
    //返回
    return OutDTO.OKByDataRow<string>(symAlgName + '-CBC加密成功~', result);
  }

  /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param key   给定秘钥规格密钥
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   * @returns
   */
  static async encodeECB(str: string, key: string, symAlgName: string, symEncryptName: string): Promise<OutDTO<string>> {
    //转换key
    let symKey = await CryptoUtil.convertKeyFromStr(key, symAlgName);
    // 初始化加解密操作环境
    let mode = crypto.CryptoMode.ENCRYPT_MODE;
    //创建加密器
    let cipher = crypto.createCipher(symEncryptName);
    //初始化加密
    await cipher.init(mode, symKey, null);
    //封装加密所需数据
    let encode = new util.TextEncoder();
    //开始加密
    let updateOutput = await cipher.doFinal({ data: encode.encodeInto(str) });
    //转换字符串
    let result = StrAndUintUtil.unitArray2String(updateOutput.data);
    //返回
    return OutDTO.OKByDataRow<string>(symAlgName + '-ECB加密成功~', result);
  }

  /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey 给定秘钥规格密钥
   * @param iv  iv偏移量字符串
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   * @returns
   */
  static async decodeCBC(str: string, key: string, iv: string, symAlgName: string, symEncryptName: string): Promise<OutDTO<string>> {
    //转换密钥
    let symKey = await CryptoUtil.convertKeyFromStr(key, symAlgName);
    // 初始化加解密操作环境:开始解密
    let mode = crypto.CryptoMode.DECRYPT_MODE;
    //创建解密器
    let cipher = crypto.createCipher(symEncryptName);
    //初始化解密
    await cipher.init(mode, symKey, CryptoUtil.genIvParamsSpec(iv));
    //解密
    let updateOutput = await cipher.doFinal({ data: StrAndUintUtil.stringToByteArray(str) });
    let decode = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    return OutDTO.OKByDataRow(symAlgName + '-CBC解密成功~', decode.decodeWithStream(updateOutput.data));
  }


  /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param key  给定秘钥规格密钥
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   */
  static async decodeECB(str: string, sm4Key: string, symAlgName: string, symEncryptName: string): Promise<OutDTO<string>> {
    //转换密钥
    let symKey = await CryptoUtil.convertKeyFromStr(sm4Key, symAlgName);
    // 初始化加解密操作环境:开始解密
    let mode = crypto.CryptoMode.DECRYPT_MODE;
    //创建解密器
    let cipher = crypto.createCipher(symEncryptName);
    //初始化解密
    await cipher.init(mode, symKey, null);
    //解密
    let updateOutput = await cipher.doFinal({ data: StrAndUintUtil.stringToByteArray(str) });
    let decode = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    return OutDTO.OKByDataRow(symAlgName + '-ECB解密成功~', decode.decodeWithStream(updateOutput.data));
  }

  /**
   * 非对称加密
   * @param encodeStr  待加密的字符串
   * @param pubKey  给定秘钥规格公钥
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   */
  static async encodeAsym(str: string, pubKey: string, symAlgName: string, symEncryptName: string): Promise<OutDTO<string>> {
    //将公钥转换
    let pubPair = await CryptoUtil.convertPubKeyFromStr(pubKey, symAlgName);
    //生成加密器
    let encoder = crypto.createCipher(symEncryptName);
    //初始化加密环境
    await encoder.init(crypto.CryptoMode.ENCRYPT_MODE, pubPair.pubKey, null);
    //封装加密所需数据
    let encode = new util.TextEncoder();
    //开始加密
    let updateOutput = await encoder.doFinal({ data: encode.encodeInto(str) });
    //转换字符串
    let result = StrAndUintUtil.unitArray2String(updateOutput.data);
    return OutDTO.OKByDataRow(symAlgName + '加密成功~', result);
  }

  /**
   * 非对称解密
   * @param decodeStr  待解密的字符串
   * @param priKey    给定秘钥规格私钥
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   */
  static async decodeAsym(str: string, priKey: string, symAlgName: string, symEncryptName: string): Promise<OutDTO<string>> {
    //将私钥转换
    let priPair = await CryptoUtil.convertPriKeyFromStr(priKey, symAlgName);
    //生成解密器
    let encoder = crypto.createCipher(symEncryptName);
    //初始化解密环境
    await encoder.init(crypto.CryptoMode.DECRYPT_MODE, priPair.priKey, null);
    //封装加密所需数据
    let updateOutput = await encoder.doFinal({ data: StrAndUintUtil.stringToByteArray(str) });
    let decode = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    return OutDTO.OKByDataRow(symAlgName + '解密成功~', decode.decodeWithStream(updateOutput.data));
  }

  /**
   * 签名
   * @param str  需要签名的字符串
   * @param priKey  给定秘钥规格私钥
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   * @returns OutDTO<string> 签名对象
   */
  static async sign(str: string, priKey: string, symAlgName: string, symEncryptName: string): Promise<OutDTO<string>> {
    //将私钥转换
    let priPair = await CryptoUtil.convertPriKeyFromStr(priKey, symAlgName);
    //创建签名器
    let signer = crypto.createSign(symEncryptName);
    //初始化签名器
    await signer.init(priPair.priKey);
    let encode = new util.TextEncoder();
    //签名的字符串
    let input: crypto.DataBlob = { data: encode.encodeInto(str) };
    await signer.update(input);
    let sign = await signer.sign(input);
    let signStr = StrAndUintUtil.unitArray2String(sign.data);
    return OutDTO.OKByDataRow(symAlgName + '签名成功~', signStr);
  }

  /**
   * 验签
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  给定秘钥规格公钥
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
  static async verify(signStr: string, verifyStr: string, pubKey: string, symAlgName: string, symEncryptName: string): Promise<OutDTO<string>> {
    //将公钥转换
    let pubPair = await CryptoUtil.convertPubKeyFromStr(pubKey, symAlgName);
    //验签器
    let verifyer = crypto.createVerify(symEncryptName);
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

  /**
   * 摘要
   * @param str 带摘要的字符串
   * @param symAlgName 秘钥规格
   * @returns 摘要后的字符串
   */
  static async digest(str: string, symAlgName: string): Promise<OutDTO<string>> {
    //摘要对象
    let md = crypto.createMd(symAlgName);
    //字符串转换的字节流对象
    let messageData = new Uint8Array(buffer.from(str, 'utf-8').buffer);
    let updateLength = 200; // 默认以200字节为单位进行分段update
    for (let i = 0; i < messageData.length; i += updateLength) {
      let updateMessage = messageData.subarray(i, i + updateLength);
      let updateMessageBlob: crypto.DataBlob = { data: updateMessage };
      await md.update(updateMessageBlob);
    }
    let mdOutput = await md.digest();
    return OutDTO.OKByDataRow<string>(symAlgName + '摘要数据成功！', StrAndUintUtil.unitArray2String(mdOutput.data));
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