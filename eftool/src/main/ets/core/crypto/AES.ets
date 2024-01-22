import crypto from '@ohos.security.cryptoFramework';

/**
 * @Author csx
 * @DateTime 2024/1/18 21:25
 * @TODO AES
 */

export class AES {
  private static globalCipher;
  private static globalGcmParams;
  private static symAlgName;

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

  private static unit8ArrayToString(array) {
    let arrayString = '';
    for (let i = 0; i < array.length; i++) {
      arrayString += String.fromCharCode(array[i]);
    }
    return arrayString;
  }

  private  static genGcmParamsSpec() {
    let arr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // 12 bytes
    let dataIv = new Uint8Array(arr);
    let ivBlob = { data: dataIv };

    arr = [0, 0, 0, 0, 0, 0, 0, 0]; // 8 bytes
    let dataAad = new Uint8Array(arr);
    let aadBlob = { data: dataAad };

    arr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // 16 bytes
    let dataTag = new Uint8Array(arr);
    let tagBlob = { data: dataTag }; // GCM的authTag在加密时从doFinal结果中获取，在解密时填入init函数的params参数中

    let gcmParamsSpec = { iv: ivBlob, aad: aadBlob, authTag: tagBlob, algName: "GcmParamsSpec" };
    return gcmParamsSpec;
  }

  /**
   * 可理解的字符串转成字节流
   * @param str
   * @returns
   */
  private  static stringToUnit8Array(str) {
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
   * 生成AES的对称密钥
   * @returns AES密钥
   */
  static async generateAesKey(symAlgName: string): Promise<string> {
    this.symAlgName = symAlgName;
    // 创建对称密钥生成器
    let symKeyGenerator = crypto.createSymKeyGenerator(symAlgName);
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseSymKey = await symKeyGenerator.generateSymKey();
    // 构造参数
    this.globalGcmParams = this.genGcmParamsSpec();
    // 生成加解密生成器
    let cipherAlgName = 'AES128|GCM|PKCS7';
    //生成加解密生成器
    this.globalCipher = crypto.createCipher(cipherAlgName);
    // 获取对称密钥的二进制数据
    return this.unit8ArrayToShowStr(promiseSymKey.getEncoded().data);
  }

  /**
   * 加密
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @returns
   */
  static async encode(str: string, aesKey: string): Promise<string> {
    //组装convertKey所需数据
    let data = { data: this.stringToByteArray(aesKey) };
    // 创建对称密钥生成器
    let symKeyGenerator = crypto.createSymKeyGenerator(this.symAlgName);
    //转换密钥
    let symKey = await symKeyGenerator.convertKey(data);
    // 初始化加解密操作环境:开始加密
    let mode = crypto.CryptoMode.ENCRYPT_MODE;
    //初始化加密
    await this.globalCipher.init(mode, symKey, this.globalGcmParams);
    //封装加密所需数据
    let plainText = { data: this.stringToUnit8Array(str) };
    //开始加密
    let updateOutput = await this.globalCipher.update(plainText);
    let encodeStr = updateOutput;
    encodeStr = Array.from(encodeStr.data);
    //拼接
    let finalOutput = await this.globalCipher.doFinal(null);
    if (finalOutput != null) {
      this.globalGcmParams.authTag = finalOutput;
      finalOutput = Array.from(finalOutput.data);
      encodeStr = encodeStr.concat(finalOutput);
    }
    encodeStr = new Uint8Array(encodeStr);
    let finalStr = this.unit8ArrayToShowStr(encodeStr);
    return finalStr;
  }


  /**
   * 解密
   * @param str  加密的字符串
   * @param aesKey  AES密钥
   */
  static async decode(str: string, aesKey: string) {
    //组装convertKey所需数据
    let data = { data: this.stringToByteArray(aesKey) };
    // 创建对称密钥生成器
    let symKeyGenerator = crypto.createSymKeyGenerator(this.symAlgName);
    //转换密钥
    let symKey = await symKeyGenerator.convertKey(data);
    // 初始化加解密操作环境:开始解密
    let mode = crypto.CryptoMode.DECRYPT_MODE;
    //初始化加密
    await this.globalCipher.init(mode, symKey, this.globalGcmParams);
    //拼接需要解密的数据
    let decodeObj = { data: this.stringToByteArray(str) };
    //解密
    let updateOutput = await this.globalCipher.update(decodeObj);
    //判断是否完成
    // let finalOutput = await this.globalCipher.doFinal(null);
    // if (finalOutput != null) {
    //   let fin = this.unit8ArrayToString(finalOutput.data);
    // }
    let decodeStr = this.unit8ArrayToString(updateOutput.data)
    // Array.from(updateOutput.data, byte => String.fromCharCode(byte)).join(''); // 将 Uint8Array 转换为字符串

    return decodeStr;
  }
}