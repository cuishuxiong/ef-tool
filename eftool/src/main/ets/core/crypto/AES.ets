import crypto from '@ohos.security.cryptoFramework';
import { OutDTO } from '../base/OutDTO';
import { StringBuilder } from '../base/StringBuilder';
import { buffer, util } from '@kit.ArkTS';
import { StrAndUintUtil } from '../util/StrAndUintUtil';


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
  private static genGcmParamsSpec() {
    let arr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // 12 bytes
    let dataIv = new Uint8Array(arr);
    let ivBlob: crypto.DataBlob = { data: dataIv };
    arr = [0, 0, 0, 0, 0, 0, 0, 0]; // 8 bytes
    let dataAad = new Uint8Array(arr);
    let aadBlob: crypto.DataBlob = { data: dataAad };
    arr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // 16 bytes
    let dataTag = new Uint8Array(arr);
    let tagBlob: crypto.DataBlob = {
      data: dataTag
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
  static async generateAesKey(): Promise<OutDTO<string>> {
    // 创建对称密钥生成器
    let symKeyGenerator = crypto.createSymKeyGenerator('AES256');
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseSymKey = await symKeyGenerator.generateSymKey();
    //转换成可以读懂的字符串
    let key = StrAndUintUtil.unitArray2String(promiseSymKey.getEncoded().data);
    // 获取对称密钥的二进制数据
    return OutDTO.OKByDataRow<string>('生成AES密钥成功~', key);
  }

  /**
   * 将字符串AESKey转换为symKey对象
   * @param aesKey字符串key
   * @returns
   */
  static async convertKeyFromStr(aesKey: string) {
    let symKeyBlob: crypto.DataBlob = { data: StrAndUintUtil.stringToByteArray(aesKey) };
    let aesGenerator = crypto.createSymKeyGenerator('AES256');
    let symKey = await aesGenerator.convertKey(symKeyBlob);
    return symKey;
  }

  /**
   * 加密
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @returns
   */
  static async encode(str: string, aesKey: string): Promise<OutDTO<string>> {
    //转换key
    let symKey = await AES.convertKeyFromStr(aesKey);
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
    return OutDTO.OKByDataRow<string>('AES加密成功~', result);
  }

  /**
   * 解密
   * @param str  加密的字符串
   * @param aesKey  AES密钥
   */
  static async decode(str: string, aesKey: string): Promise<OutDTO<string>> {
    //转换密钥
    let symKey = await await AES.convertKeyFromStr(aesKey);
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
}