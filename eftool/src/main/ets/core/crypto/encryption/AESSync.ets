import crypto from '@ohos.security.cryptoFramework';
import { OutDTO } from '../../base/OutDTO';
import { buffer, util } from '@kit.ArkTS';
import { StrAndUintUtil } from '../../util/StrAndUintUtil';
import { RandomUtil } from '../../util/RandomUtil';
import { CryptoSyncUtil } from '../../util/CryptoSyncUtil';


/**
 * @Author csx
 * @DateTime 2024/3/18 10:39:03
 * @TODO AES 同步类
 */
export class AESSync {
  /**
   * gcm对象
   */
  private static gcmParams = AESSync.genGcmParamsSpec();

  /**
   * 生成GCM所需数据
   * @returns
   */
  private static genGcmParamsSpec(): crypto.GcmParamsSpec {
    let ivBlob: crypto.DataBlob = { data: RandomUtil.randomUnitBySize(12) };
    let aadBlob: crypto.DataBlob = { data: RandomUtil.randomUnitBySize(8) };
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
   * 生成AES的对称密钥-默认base64
   * @param resultCoding 生成AES秘钥的字符串格式-默认不传为base64格式
   * @returns AES密钥
   */
  static generateAESKey(resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.generateSymKey('AES256', resultCoding);
  }

  /**
   * 生成AES的对称密钥-128位-默认base64
   * @param resultCoding 生成AES秘钥的字符串格式-默认不传为base64格式
   * @returns AES密钥-128位
   */
  static generateAESKey128(resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.generateSymKey('AES128', resultCoding);
  }

  /**
   * 生成AES的对称密钥-192位-默认base64
   * @param resultCoding 生成AES秘钥的字符串格式-默认不传为base64格式
   * @returns AES密钥-192位
   */
  static generateAESKey192(resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.generateSymKey('AES192', resultCoding);
  }

  /**
   * 加密-GCM模式
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @param keyCoding key的编码方式
   * @param resultCoding  加密后数据的编码方式-不传默认为base64
   * @returns
   */
  static encodeGCM(str: string, aesKey: string, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    //转换key
    let symKey = CryptoSyncUtil.convertKeyFromStr(aesKey, 'AES256', 256, keyCoding);
    // 初始化加解密操作环境
    let mode = crypto.CryptoMode.ENCRYPT_MODE;
    //创建加密器
    let cipher = crypto.createCipher('AES256|GCM|PKCS7');
    //初始化加密
    cipher.initSync(mode, symKey, AESSync.gcmParams);
    //封装加密所需数据
    let encode = new util.TextEncoder();
    //开始加密
    let updateOutput = cipher.updateSync({ data: encode.encodeInto(str) });
    //拼接
    let finalOutput = cipher.doFinalSync(null);
    if (finalOutput != null) {
      AESSync.gcmParams.authTag = finalOutput;
    }
    //转换字符串
    let result = StrAndUintUtil.unitArray2StrCoding(updateOutput.data, resultCoding);
    //返回
    return OutDTO.OKByDataRow<string>('AES-GCM加密成功~', result);
  }

  /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @param iv   iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式-不传默认为base64
   * @returns
   */
  static encodeCBC(str: string, aesKey: string, iv: string,
    keyCoding: buffer.BufferEncoding, resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.encodeCBC(str, aesKey, iv, 'AES256', 'AES256|CBC|PKCS7', 256, keyCoding, resultCoding);
  }

  /**
   * 加密-CBC模式-128位
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @param iv   iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式-不传默认为base64
   * @returns
   */
  static encodeCBC128(str: string, aesKey: string, iv: string,
    keyCoding: buffer.BufferEncoding, resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.encodeCBC(str, aesKey, iv, 'AES128', 'AES128|CBC|PKCS7', 128, keyCoding, resultCoding);
  }

  /**
   * 加密-CBC模式-192位
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @param iv   iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式-不传默认为base64
   * @returns
   */
  static encodeCBC192(str: string, aesKey: string, iv: string,
    keyCoding: buffer.BufferEncoding, resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.encodeCBC(str, aesKey, iv, 'AES192', 'AES192|CBC|PKCS7', 192, keyCoding, resultCoding);
  }

  /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式-不传默认为base64
   * @returns
   */
  static encodeECB(str: string, aesKey: string, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.encodeECB(str, aesKey, 'AES256', 'AES256|ECB|PKCS7', 256, keyCoding, resultCoding);
  }

  /**
   * 加密-ECB模式-128位
   * @param str  待加密的字符串
   * @param aesKey   AES密钥-128位
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式-不传默认为base64
   * @returns
   */
  static encodeECB128(str: string, aesKey: string, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.encodeECB(str, aesKey, 'AES128', 'AES128|ECB|PKCS7', 128, keyCoding, resultCoding);
  }

  /**
   * 加密-ECB模式-192位
   * @param str  待加密的字符串
   * @param aesKey   AES密钥-192位
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式-不传默认为base64
   * @returns
   */
  static encodeECB192(str: string, aesKey: string, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.encodeECB(str, aesKey, 'AES192', 'AES192|ECB|PKCS7', 192, keyCoding, resultCoding);
  }


  /**
   * 解密-GCM模式
   * @param str  加密的字符串
   * @param aesKey  AES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   */
  static decodeGCM(str: string, aesKey: string, keyCoding: buffer.BufferEncoding,
    dataCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    //转换密钥
    let symKey = CryptoSyncUtil.convertKeyFromStr(aesKey, 'AES256', 256, keyCoding);
    // 初始化加解密操作环境:开始解密
    let mode = crypto.CryptoMode.DECRYPT_MODE;
    //创建解密器
    let cipher = crypto.createCipher('AES256|GCM|PKCS7');
    //初始化加密
    cipher.initSync(mode, symKey, AESSync.gcmParams);
    //解密
    let updateOutput = cipher.updateSync({ data: StrAndUintUtil.strContent2Uint8Array(str, dataCoding) });
    //判断是否完成
    let finalOutput = cipher.doFinalSync(null);
    let decode = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    return OutDTO.OKByDataRow('AES解密成功~', decode.decodeWithStream(updateOutput.data));
  }

  /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey AES密钥
   * @param iv  iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
  static decodeCBC(str: string, aesKey: string, iv: string,
    keyCoding: buffer.BufferEncoding, dataCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.decodeCBC(str, aesKey, iv, 'AES256', 'AES256|CBC|PKCS7', 256, keyCoding, dataCoding);
  }

  /**
   * 解密-CBC模式-128位
   * @param str  加密的字符串
   * @param aesKey AES密钥
   * @param iv  iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
  static decodeCBC128(str: string, aesKey: string, iv: string,
    keyCoding: buffer.BufferEncoding, dataCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.decodeCBC(str, aesKey, iv, 'AES128', 'AES128|CBC|PKCS7', 128, keyCoding, dataCoding);
  }

  /**
   * 解密-CBC模式-192位
   * @param str  加密的字符串
   * @param aesKey AES密钥
   * @param iv  iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
  static decodeCBC192(str: string, aesKey: string, iv: string,
    keyCoding: buffer.BufferEncoding, dataCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.decodeCBC(str, aesKey, iv, 'AES192', 'AES192|CBC|PKCS7', 192, keyCoding, dataCoding);
  }

  /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param aesKey AES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
  static decodeECB(str: string, aesKey: string, keyCoding: buffer.BufferEncoding,
    dataCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.decodeECB(str, aesKey, 'AES256', 'AES256|ECB|PKCS7', 256, keyCoding, dataCoding);
  }

  /**
   * 解密-ECB模式-128位
   * @param str  加密的字符串
   * @param aesKey AES密钥-128位
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
  static decodeECB128(str: string, aesKey: string, keyCoding: buffer.BufferEncoding,
    dataCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.decodeECB(str, aesKey, 'AES128', 'AES128|ECB|PKCS7', 128, keyCoding, dataCoding);
  }

  /**
   * 解密-ECB模式-192位
   * @param str  加密的字符串
   * @param aesKey AES密钥-192位
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
  static decodeECB192(str: string, aesKey: string, keyCoding: buffer.BufferEncoding,
    dataCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.decodeECB(str, aesKey, 'AES192', 'AES192|ECB|PKCS7', 192, keyCoding, dataCoding);
  }
}