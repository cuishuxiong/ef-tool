/**
 Copyright 2024 csx - @yunkss/ef_crypto

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import crypto from '@ohos.security.cryptoFramework';
import { StrAndUintUtil } from './StrAndUintUtil';
import { buffer, util } from '@kit.ArkTS';

/**
 * @Author csx
 * @DateTime 2024/7/4 00:12
 * @TODO CryptoSyncUtil  加解密工具类-同步
 */
export class CryptoSyncUtil {
  /**
   * 将非对称加密字符串pubKey转换为symKey对象
   * @param publicKey字符串key
   * @param symAlgName 秘钥规格
   * @param keyName 密钥长度
   * @param keyCoding 公钥的编码方式(utf8/hex/base64)
   * @returns
   */
  static convertPubKeyFromStr(publicKey: string, symAlgName: string, keyName: number,
    keyCoding: buffer.BufferEncoding) {
    let symKeyBlob: crypto.DataBlob = { data: StrAndUintUtil.strKey2Uint8Array(publicKey, keyName, keyCoding) };
    let aesGenerator = crypto.createAsyKeyGenerator(symAlgName);
    let symKey = aesGenerator.convertKeySync(symKeyBlob, null);
    return symKey;
  }

  /**
   * 将非对称加密pem格式字符串pubKey转换为symKey对象
   * @param publicKey字符串key-pem格式
   * @param symAlgName 秘钥规格
   * @returns
   */
  static convertPemPubKeyFromStr(publicKey: string, symAlgName: string) {
    let aesGenerator = crypto.createAsyKeyGenerator(symAlgName);
    let symKey = aesGenerator.convertPemKeySync(publicKey, null);
    return symKey;
  }

  /**
   * 将非对称加密字符串priKey转换为symKey对象
   * @param privateKey字符串key
   * @param symAlgName 秘钥规格
   * @param keyName 密钥长度
   * @param keyCoding 私钥的编码方式(utf8/hex/base64)
   * @returns
   */
  static convertPriKeyFromStr(privateKey: string, symAlgName: string, keyName: number,
    keyCoding: buffer.BufferEncoding) {
    let symKeyBlob: crypto.DataBlob = { data: StrAndUintUtil.strKey2Uint8Array(privateKey, keyName, keyCoding) };
    let aesGenerator = crypto.createAsyKeyGenerator(symAlgName);
    let symKey = aesGenerator.convertKeySync(null, symKeyBlob);
    return symKey;
  }

  /**
   * 将非对称加密pem格式字符串priKey转换为symKey对象
   * @param privateKey字符串key-pem格式
   * @param symAlgName 秘钥规格
   * @returns
   */
  static convertPemPriKeyFromStr(privateKey: string, symAlgName: string) {
    let aesGenerator = crypto.createAsyKeyGenerator(symAlgName);
    let symKey = aesGenerator.convertPemKeySync(null, privateKey);
    return symKey;
  }

  /**
   * 将对称加密字符串AESKey转换为symKey对象
   * @param aesKey字符串key
   * @param symAlgName 秘钥规格
   * @param keyName 密钥长度
   * @param keyCoding 秘钥的编码方式(utf8/hex/base64)
   * @returns
   */
  static convertKeyFromStr(aesKey: string, symAlgName: string, keyName: number, keyCoding: buffer.BufferEncoding) {
    let symKeyBlob: crypto.DataBlob = { data: StrAndUintUtil.strKey2Uint8Array(aesKey, keyName, keyCoding) };
    let aesGenerator = crypto.createSymKeyGenerator(symAlgName);
    let symKey = aesGenerator.convertKeySync(symKeyBlob);
    return symKey;
  }

  /**
   * 根据传入的iv字符串转换iv对象
   * @param ivStr
   * @param ivCoding 偏移量的编码方式(hex/base64)
   * @returns
   */
  static genIvParamsSpec(ivStr: string, ivCoding: buffer.BufferEncoding): crypto.IvParamsSpec {
    let ivBlob: crypto.DataBlob = { data: StrAndUintUtil.strKey2Uint8Array(ivStr, 128, ivCoding) };
    let ivParamsSpec: crypto.IvParamsSpec = {
      algName: "IvParamsSpec",
      iv: ivBlob
    };
    return ivParamsSpec;
  }

  /**
   * 生成对称密钥-指定密钥生成格式(默认base64)
   * @param symAlgName 秘钥规格
   * @param resultCoding 生成对称秘钥的编码方式(hex/base64)
   * @returns 指定秘钥规格的对称密钥
   */
  static generateSymKey(symAlgName: string, resultCoding: buffer.BufferEncoding): string {
    // 创建对称密钥生成器
    let symKeyGenerator = crypto.createSymKeyGenerator(symAlgName);
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseSymKey = symKeyGenerator.generateSymKeySync();
    // 获取对称密钥的二进制数据
    return StrAndUintUtil.unitArray2StrCoding(promiseSymKey.getEncoded().data, resultCoding);
  }

  /**
   * 生成非对称密钥
   * @param symAlgName 秘钥规格
   * @returns 指定秘钥规格的非对称公私
   * @param resultCoding 生成非对称秘钥的编码方式(hex/base64)
   */
  static generateCryptoKey(symAlgName: string, resultCoding: buffer.BufferEncoding): CryptoKey {
    // 创建非对称密钥生成器
    let rsaGenerator = crypto.createAsyKeyGenerator(symAlgName);
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseKeyPair = rsaGenerator.generateKeyPairSync();
    // 转换成可以读懂的公私钥字符串
    let pubKey = StrAndUintUtil.unitArray2StrCoding(promiseKeyPair.pubKey.getEncoded().data, resultCoding);
    let priKey = StrAndUintUtil.unitArray2StrCoding(promiseKeyPair.priKey.getEncoded().data, resultCoding);
    return new CryptoKey(pubKey, priKey);
  }

  /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param key   给定秘钥规格密钥
   * @param iv   iv偏移量字符串
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   * @param keyName  密钥长度
   * @param keyCoding  密钥编码方式(utf8/hex/base64)
   * @param resultCoding  返回结果编码方式(hex/base64)
   * @returns
   */
  static encodeCBC(str: string, key: string, iv: string, symAlgName: string, symEncryptName: string,
    keyName: number, keyCoding: buffer.BufferEncoding, resultCoding: buffer.BufferEncoding): string {
    //转换key
    let symKey = CryptoSyncUtil.convertKeyFromStr(key, symAlgName, keyName, keyCoding);
    // 初始化加解密操作环境
    let mode = crypto.CryptoMode.ENCRYPT_MODE;
    //创建加密器
    let cipher = crypto.createCipher(symEncryptName);
    //初始化加密
    cipher.initSync(mode, symKey, CryptoSyncUtil.genIvParamsSpec(iv, keyCoding));
    //封装加密所需数据
    let encode = new util.TextEncoder();
    //开始加密
    let updateOutput = cipher.doFinalSync({ data: encode.encodeInto(str) });
    //转换字符串
    return StrAndUintUtil.unitArray2StrCoding(updateOutput.data, resultCoding);
  }

  /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param key   给定秘钥规格密钥
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   * @param keyName  密钥长度
   * @param keyCoding  密钥编码方式(utf8/hex/base64)
   * @param resultCoding  返回结果编码方式(hex/base64)
   * @returns
   */
  static encodeECB(str: string, key: string, symAlgName: string, symEncryptName: string,
    keyName: number, keyCoding: buffer.BufferEncoding, resultCoding: buffer.BufferEncoding): string {
    //转换key
    let symKey = CryptoSyncUtil.convertKeyFromStr(key, symAlgName, keyName, keyCoding);
    // 初始化加解密操作环境
    let mode = crypto.CryptoMode.ENCRYPT_MODE;
    //创建加密器
    let cipher = crypto.createCipher(symEncryptName);
    //初始化加密
    cipher.initSync(mode, symKey, null);
    //封装加密所需数据
    let encode = new util.TextEncoder();
    //开始加密
    let updateOutput = cipher.doFinalSync({ data: encode.encodeInto(str) });
    //转换字符串
    return StrAndUintUtil.unitArray2StrCoding(updateOutput.data, resultCoding);
  }

  /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey 给定秘钥规格密钥
   * @param iv  iv偏移量字符串
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   * @param keyName  密钥长度
   * @param keyCoding  密钥编码方式(utf8/hex/base64)
   * @param dataCoding  入参字符串编码方式(hex/base64)
   * @returns
   */
  static decodeCBC(str: string, key: string, iv: string, symAlgName: string, symEncryptName: string,
    keyName: number, keyCoding: buffer.BufferEncoding, dataCoding: buffer.BufferEncoding): string {
    //转换密钥
    let symKey = CryptoSyncUtil.convertKeyFromStr(key, symAlgName, keyName, keyCoding);
    // 初始化加解密操作环境:开始解密
    let mode = crypto.CryptoMode.DECRYPT_MODE;
    //创建解密器
    let cipher = crypto.createCipher(symEncryptName);
    //初始化解密
    cipher.initSync(mode, symKey, CryptoSyncUtil.genIvParamsSpec(iv, keyCoding));
    //解密
    let updateOutput = cipher.doFinalSync({ data: StrAndUintUtil.strContent2Uint8Array(str, dataCoding) });
    return StrAndUintUtil.unitArray2StrCoding(updateOutput.data, 'utf8');
  }

  /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param key  给定秘钥规格密钥
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   * @param keyName  密钥长度
   * @param keyCoding  密钥编码方式(utf8/hex/base64)
   * @param dataCoding  入参字符串编码方式(hex/base64)
   */
  static decodeECB(str: string, sm4Key: string, symAlgName: string, symEncryptName: string,
    keyName: number, keyCoding: buffer.BufferEncoding, dataCoding: buffer.BufferEncoding): string {
    //转换密钥
    let symKey = CryptoSyncUtil.convertKeyFromStr(sm4Key, symAlgName, keyName, keyCoding);
    // 初始化加解密操作环境:开始解密
    let mode = crypto.CryptoMode.DECRYPT_MODE;
    //创建解密器
    let cipher = crypto.createCipher(symEncryptName);
    //初始化解密
    cipher.initSync(mode, symKey, null);
    //解密
    let updateOutput = cipher.doFinalSync({ data: StrAndUintUtil.strContent2Uint8Array(str, dataCoding) });
    return StrAndUintUtil.unitArray2StrCoding(updateOutput.data, 'utf8');
  }

  /**
   * 非对称加密
   * @param encodeStr  待加密的字符串
   * @param pubKey  给定秘钥规格公钥
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   * @param keyName  密钥长度
   * @param keyCoding  密钥编码方式(utf8/hex/base64)
   * @param resultCoding  返回结果编码方式(hex/base64)
   * @param isPem 是否为pem格式的key
   */
  static encodeAsym(str: string, pubKey: string, symAlgName: string, symEncryptName: string,
    keyName: number, keyCoding: buffer.BufferEncoding, resultCoding: buffer.BufferEncoding,
    isPem: boolean): string {
    //将公钥转换
    let pubPair = isPem ? CryptoSyncUtil.convertPemPubKeyFromStr(pubKey, symAlgName) :
    CryptoSyncUtil.convertPubKeyFromStr(pubKey, symAlgName, keyName, keyCoding);
    //生成加密器
    let encoder = crypto.createCipher(symEncryptName);
    //初始化加密环境
    encoder.initSync(crypto.CryptoMode.ENCRYPT_MODE, pubPair.pubKey, null);
    //封装加密所需数据
    let encode = new util.TextEncoder();
    //开始加密
    let updateOutput = encoder.doFinalSync({ data: encode.encodeInto(str) });
    //转换字符串
    return StrAndUintUtil.unitArray2StrCoding(updateOutput.data, resultCoding);
  }

  /**
   * 非对称分段加密
   * @param encodeStr  待加密的字符串
   * @param pubKey  给定秘钥规格公钥
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   * @param keyName  密钥长度
   * @param keyCoding  密钥编码方式(utf8/hex/base64)
   * @param resultCoding  返回结果编码方式(hex/base64)
   * @param isPem 是否为pem格式的key
   */
  static encodeAsymSegment(str: string, pubKey: string, symAlgName: string, symEncryptName: string,
    keyName: number, keyCoding: buffer.BufferEncoding, resultCoding: buffer.BufferEncoding,
    isPem: boolean): string {
    //将公钥转换
    let pubPair = isPem ? CryptoSyncUtil.convertPemPubKeyFromStr(pubKey, symAlgName) :
    CryptoSyncUtil.convertPubKeyFromStr(pubKey, symAlgName, keyName, keyCoding);
    //生成加密器
    let encoder = crypto.createCipher(symEncryptName);
    //初始化加密环境
    encoder.initSync(crypto.CryptoMode.ENCRYPT_MODE, pubPair.pubKey, null);
    //封装加密所需数据
    let encode = new util.TextEncoder();
    //定义分段字节
    let strSplitLen = symAlgName.indexOf('2048') >= 0 ? 128 : 64;
    //待分段加密的数据
    let strArray = encode.encodeInto(str);
    //分段后的待加密数据
    let cipherText = new Uint8Array();
    //执行循环分段加密
    for (let i = 0; i < strArray.length; i += strSplitLen) {
      //截取64位数据
      let updateMessage = strArray.subarray(i, i + strSplitLen);
      let updateMessageBlob: crypto.DataBlob = { data: updateMessage };
      // 将原文按64字符进行拆分，循环调用doFinalSync进行加密，使用1024bit密钥时，每次加密生成128字节长度的密文
      let updateOutput = encoder.doFinalSync(updateMessageBlob);
      let mergeText = new Uint8Array(cipherText.length + updateOutput.data.length);
      mergeText.set(cipherText);
      mergeText.set(updateOutput.data, cipherText.length);
      cipherText = mergeText;
    }
    //转换字符串
    return StrAndUintUtil.unitArray2StrCoding(cipherText, resultCoding);
  }

  /**
   * 非对称分段解密
   * @param str  待解密的字符串
   * @param priKey    给定秘钥规格私钥
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   * @param keyName  密钥长度
   * @param keyCoding  密钥编码方式(utf8/hex/base64)
   * @param dataCoding  入参字符串编码方式(hex/base64)
   * @param isPem 是否为pem格式的key
   */
  static decodeAsymSegment(str: string, priKey: string, symAlgName: string, symEncryptName: string,
    keyName: number, keyCoding: buffer.BufferEncoding, dataCoding: buffer.BufferEncoding,
    isPem: boolean): string {
    //将私钥转换
    let priPair = isPem ? CryptoSyncUtil.convertPemPriKeyFromStr(priKey, symAlgName) :
    CryptoSyncUtil.convertPriKeyFromStr(priKey, symAlgName, keyName, keyCoding);
    //生成解密器
    let encoder = crypto.createCipher(symEncryptName);
    //定义分段字节
    let strSplitLen = symAlgName.indexOf('2048') >= 0 ? 256 : 128;
    //初始化解密环境
    encoder.initSync(crypto.CryptoMode.DECRYPT_MODE, priPair.priKey, null);
    //分段加密后的数据
    let decryptText = new Uint8Array();
    //待解密的数据
    let strArray = StrAndUintUtil.strContent2Uint8Array(str, dataCoding);
    //开始循环解密
    for (let i = 0; i < strArray.length; i += strSplitLen) {
      let updateMessage = strArray.subarray(i, i + strSplitLen);
      let updateMessageBlob: crypto.DataBlob = { data: updateMessage };
      // 将密文按128字节进行拆分解密，得到原文后进行拼接
      let updateOutput = encoder.doFinalSync(updateMessageBlob);
      let mergeText = new Uint8Array(decryptText.length + updateOutput.data.length);
      mergeText.set(decryptText);
      mergeText.set(updateOutput.data, decryptText.length);
      decryptText = mergeText;
    }
    let decode = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    return decode.decodeWithStream(decryptText);
  }

  /**
   * 非对称解密
   * @param str  待解密的字符串
   * @param priKey    给定秘钥规格私钥
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   * @param keyName  密钥长度
   * @param keyCoding  密钥编码方式(utf8/hex/base64)
   * @param dataCoding  入参字符串编码方式(hex/base64)
   * @param isPem 是否为pem格式的key
   */
  static decodeAsym(str: string, priKey: string, symAlgName: string, symEncryptName: string,
    keyName: number, keyCoding: buffer.BufferEncoding, dataCoding: buffer.BufferEncoding,
    isPem: boolean): string {
    //将私钥转换
    let priPair = isPem ? CryptoSyncUtil.convertPemPriKeyFromStr(priKey, symAlgName) :
    CryptoSyncUtil.convertPriKeyFromStr(priKey, symAlgName, keyName, keyCoding);
    //生成解密器
    let encoder = crypto.createCipher(symEncryptName);
    //初始化解密环境
    encoder.initSync(crypto.CryptoMode.DECRYPT_MODE, priPair.priKey, null);
    //转码
    let cryptoArr = StrAndUintUtil.strContent2Uint8Array(str, dataCoding);
    //封装加密所需数据
    let updateOutput = encoder.doFinalSync({ data: cryptoArr });
    let decode = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    return decode.decodeWithStream(updateOutput.data);
  }

  /**
   * 签名
   * @param str  需要签名的字符串
   * @param priKey  给定秘钥规格私钥
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   * @param keyName  密钥长度
   * @param keyName  密钥长度
   * @param keyCoding  密钥编码方式(utf8/hex/base64)
   * @param resultCoding  返回结果编码方式(hex/base64)
   * @param isPem 是否为pem格式的key
   * @returns string 签名对象
   */
  static sign(str: string, priKey: string, symAlgName: string, symEncryptName: string,
    keyName: number, keyCoding: buffer.BufferEncoding, resultCoding: buffer.BufferEncoding,
    isPem: boolean): string {
    //将私钥转换
    let priPair = isPem ? CryptoSyncUtil.convertPemPriKeyFromStr(priKey, symAlgName) :
    CryptoSyncUtil.convertPriKeyFromStr(priKey, symAlgName, keyName, keyCoding);
    //创建签名器
    let signer = crypto.createSign(symEncryptName);
    //初始化签名器
    signer.initSync(priPair.priKey);
    let encode = new util.TextEncoder();
    //签名的字符串
    let input: crypto.DataBlob = { data: encode.encodeInto(str) };
    signer.updateSync(input);
    let sign = signer.signSync(input);
    return StrAndUintUtil.unitArray2StrCoding(sign.data, resultCoding);
  }

  /**
   * 验签
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  给定秘钥规格公钥
   * @param symAlgName 秘钥规格
   * @param symEncryptName  加密规格
   * @param keyName  密钥长度
   * @param keyCoding  密钥编码方式(utf8/hex/base64)
   * @param dataCoding  入参字符串编码方式(hex/base64)
   * @param isPem 是否为pem格式的key
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
  static verify(signStr: string, verifyStr: string, pubKey: string, symAlgName: string, symEncryptName: string,
    keyName: number, keyCoding: buffer.BufferEncoding, dataCoding: buffer.BufferEncoding,
    isPem: boolean): string {
    //将公钥转换
    let pubPair = isPem ? CryptoSyncUtil.convertPemPubKeyFromStr(pubKey, symAlgName) :
    CryptoSyncUtil.convertPubKeyFromStr(pubKey, symAlgName, keyName, keyCoding);
    //验签器
    let verifyer = crypto.createVerify(symEncryptName);
    //初始化验签器
    verifyer.initSync(pubPair.pubKey);
    let encode = new util.TextEncoder();
    //验签的字符串
    let verify: crypto.DataBlob = { data: encode.encodeInto(verifyStr) };
    verifyer.updateSync(verify);
    let sign: crypto.DataBlob = { data: StrAndUintUtil.strContent2Uint8Array(signStr, dataCoding) };
    let result = verifyer.verifySync(verify, sign);
    if (result) {
      return "验签成功,签名正确";
    } else {
      return "验签失败,签名不正确";
    }
  }

  /**
   * 摘要
   * @param str 带摘要的字符串
   * @param symAlgName 秘钥规格
   * @param resultCoding  返回结果编码方式(hex/base64)
   * @returns 摘要后的字符串
   */
  static digest(str: string, symAlgName: string, resultCoding: buffer.BufferEncoding): string {
    //摘要对象
    let md = crypto.createMd(symAlgName);
    //字符串转换的字节流对象
    let messageData = new Uint8Array(buffer.from(str, 'utf-8').buffer);
    let updateLength = 200; // 默认以200字节为单位进行分段update
    for (let i = 0; i < messageData.length; i += updateLength) {
      let updateMessage = messageData.subarray(i, i + updateLength);
      let updateMessageBlob: crypto.DataBlob = { data: updateMessage };
      md.updateSync(updateMessageBlob);
    }
    let mdOutput = md.digestSync();
    return StrAndUintUtil.unitArray2StrCoding(mdOutput.data, resultCoding);
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