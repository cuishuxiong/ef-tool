import crypto from "@ohos.security.cryptoFramework"
import { OutDTO } from '../base/OutDTO';

/**
 * @Author csx
 * @DateTime 2024/1/17 14:46:01
 * @TODO RSA
 */
export class RSA {

  /**
   * 生成AES的非对称密钥
   * @returns RSA密钥{publicKey:公钥,privateKey:私钥}
   */
  static async generateRsaKey(): Promise<OutDTO<RsaKey>> {
    // 创建非对称密钥生成器
    let rsaGenerator = crypto.createAsyKeyGenerator("RSA1024|PRIMES_2");
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseKeyPair = await rsaGenerator.generateKeyPair();
    // 获取非对称密钥的二进制数据
    //公钥二进制
    let publicKey = promiseKeyPair.pubKey.getEncoded().data;
    //私钥二进制
    let privateKey = promiseKeyPair.priKey.getEncoded().data;
    return OutDTO.OKByDataRow('生成公私钥成功~', {
      publicKey: this.unit8ArrayToShowStr(publicKey),
      privateKey: this.unit8ArrayToShowStr(privateKey)
    });
  }

  /**
   * 字节流转成可理解的字符串
   * @param unit8Array
   * @returns
   */
  private static unit8ArrayToShowStr(unit8Array) {
    return Array.prototype.map
      .call(unit8Array, (x) => ('00' + x.toString(16)).slice(-2))
      .join('');
  }


  /**
   * 可理解的字符串转成字节流
   * @param str
   * @returns
   */
  private static stringToUnit8Array(str) {
    let arr = [];
    for (let i = 0, j = str.length; i < j; ++i) {
      arr.push(str.charCodeAt(i));
    }
    return new Uint8Array(arr);
  }


  /**
   * 该方法适用于将密钥转换为convert时所需要的数组
   * @param str
   * @returns
   */
  private static stringToByteArray(str: string) {
    const hexString = str.match(/.{1,2}/g); // 将字符串按每两个字符分割为数组
    const byteArray: number[] = hexString.map(byte => parseInt(byte, 16)); // 将每个十六进制字节转换为整数
    return new Uint8Array(byteArray);
  }

  /**
   * 加密
   * @param encodeStr  待加密的字符串
   * @param pubKey  RSA公钥
   */
  static async encode(str: string, pubKey: string): Promise<OutDTO<string>> {
    //生成密钥器
    let asyKeyGenerator = crypto.createAsyKeyGenerator("RSA1024|PRIMES_2");
    let publicKey = { data: this.stringToByteArray(pubKey) };
    //将公钥转换
    let pubPair = await asyKeyGenerator.convertKey(publicKey, null);
    //生成加密器
    let encoder = crypto.createCipher("RSA1024|PKCS1");
    //初始化加密环境
    await encoder.init(crypto.CryptoMode.ENCRYPT_MODE, pubPair.pubKey, null);
    //转换加密字符串
    let input = { data: this.stringToUnit8Array(str) };
    //加密
    let output = await encoder.doFinal(input);
    if (output != null) {
      let encodeStr = this.unit8ArrayToShowStr(output.data);
      return OutDTO.OKByDataRow('加密成功~', encodeStr);
    } else {
      return OutDTO.Error("加密失败~");
    }
  }

  /**
   * 解密【目前不支持中文解密】
   * @param str  待解密的字符串
   * @param priKey  私钥
   */
  static async decode(str: string, priKey: string): Promise<OutDTO<string>> {
    let asyKeyGenerator = crypto.createAsyKeyGenerator("RSA1024|PRIMES_2");
    let privateKey = { data: this.stringToByteArray(priKey) };
    //将私钥转换
    let priPair = await asyKeyGenerator.convertKey(null, privateKey);
    //生成解密器
    let decoder = crypto.createCipher("RSA1024|PKCS1");
    //初始化加密环境
    await decoder.init(crypto.CryptoMode.DECRYPT_MODE, priPair.priKey, null);
    //转换加密字符串
    let input = { data: this.stringToByteArray(str) };
    //加密
    let output = await decoder.doFinal(input);
    if (output != null) {
      let decodeStr = Array.from(output.data, byte => String.fromCharCode(byte)).join(''); // 将 Uint8Array 转换为字符串
      return OutDTO.OKByDataRow('解密成功~', decodeStr);
    } else {
      return OutDTO.Error("解密失败~");
    }
  }


  /**
   * 签名
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @returns OutDTO<string> 签名对象
   */
  static async sign(str: string, priKey: string): Promise<OutDTO<string>> {
    let asyKeyGenerator = crypto.createAsyKeyGenerator("RSA1024|PRIMES_2");
    let privateKey = { data: this.stringToByteArray(priKey) };
    //将私钥转换
    let priPair = await asyKeyGenerator.convertKey(null, privateKey);
    //创建签名器
    let signer = crypto.createSign("RSA1024|PKCS1|SHA256");
    //初始化签名器
    await signer.init(priPair.priKey);
    //签名的字符串
    let input = { data: this.stringToByteArray(str) };
    await signer.update(input);
    let sign = await signer.sign(input);
    if (sign != null) {
      let signStr = this.unit8ArrayToShowStr(sign.data);
      return OutDTO.OKByDataRow('签名成功~', signStr);
    } else {
      return OutDTO.Error("签名失败~");
    }
  }

  /**
   * 验签
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  RSA公钥
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
  static async verify(signStr: string, verifyStr: string, pubKey: string): Promise<OutDTO> {
    let asyKeyGenerator = crypto.createAsyKeyGenerator("RSA1024|PRIMES_2");
    let publicKey = { data: this.stringToByteArray(pubKey) };
    //将公钥转换
    let pubPair = await asyKeyGenerator.convertKey(publicKey, null);
    //验签器
    let verifyer = crypto.createVerify("RSA1024|PKCS1|SHA256");
    //初始化验签器
    await verifyer.init(pubPair.pubKey);
    //验签的字符串
    let verify = { data: this.stringToByteArray(verifyStr) };
    let sign = { data: this.stringToByteArray(signStr) };
    await verifyer.update(verify);
    let result = await verifyer.verify(verify, sign);
    if (result) {
      return OutDTO.OK("验签成功,签名正确");
    } else {
      return OutDTO.Error("验签失败,签名不正确");
    }
  }
}


/**
 * RSA密钥对象
 */
class RsaKey {
  /**
   * 公钥
   */
  publicKey: string;
  /**
   * 私钥
   */
  privateKey: string;
}