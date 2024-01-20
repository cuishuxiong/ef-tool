import crypto from '@ohos.security.cryptoFramework';

/**
 * @Author csx
 * @DateTime 2024/1/18 21:25
 * @TODO AES
 */

export class AES {
  private static globalCipher;
  private static globalGcmParams;
  private static globalCipherText;

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
    // 获取非对称密钥的二进制数据
    return this.unit8ArrayToShowStr(promiseSymKey.getEncoded().data);
  }

  /**
   *
   * @param str
   * @param aesKey
   * @param algName
   */
  static async encode(str: string, aesKey: string, algName: string) {
    //组装convertKey所需数据
    let data = { data: this.stringToByteArray(aesKey) };
    // 创建对称密钥生成器
    let symKeyGenerator = crypto.createSymKeyGenerator(algName);
    //转换密钥
    await symKeyGenerator.convertKey(data).then(symKey => {
      // 初始化加解密操作环境:开始加密
      let mode = crypto.CryptoMode.ENCRYPT_MODE;
      this.globalCipher.init(mode, symKey, this.globalGcmParams, (err,) => {
        //封装加密所需数据
        let plainText = { data: this.stringToUnit8Array(str) };
        //开始加密
        this.globalCipher.update(plainText).then((updateOutput) => {
          this.globalCipherText = updateOutput;
          console.error("============加密:" + updateOutput)
          this.globalCipher.doFinal(null, (err, finalOutput) => {
            if (finalOutput != null) {
              this.globalCipherText = Array.from(this.globalCipherText.data);
              finalOutput = Array.from(finalOutput.data);
              this.globalCipherText = this.globalCipherText.concat(finalOutput);
              this.globalGcmParams.authTag.data = finalOutput;
              this.globalCipherText = new Uint8Array(this.globalCipherText);
              this.globalCipherText = { data: this.globalCipherText };
              console.error("============最終加密数据:" + this.unit8ArrayToShowStr(this.globalCipherText.data))
            }
          });
        })

      });
    })


  }

  static async decode(aesKey: string, algName: string) {
    //组装convertKey所需数据
    let data = { data: this.stringToByteArray(aesKey) };
    // 创建对称密钥生成器
    let symKeyGenerator = crypto.createSymKeyGenerator(algName);
    //转换密钥
    await  symKeyGenerator.convertKey(data).then(symKey => {
      // 初始化加解密操作环境:开始解密
      let mode = crypto.CryptoMode.DECRYPT_MODE;
      this.globalCipher.init(mode, symKey, this.globalGcmParams, (err,) => {
        //解密
        // let decode = { data: this.unit8ArrayToShowStr(str) };
        this.globalCipher.update(this.globalCipherText).then((updateOutput) => {
          console.info('解密后的数据为: ' + this.unit8ArrayToShowStr(updateOutput.data));
          this.globalCipher.doFinal(null, (err, finalOutput) => {
            if (finalOutput == null) { // 使用finalOutput.data前，先判断结果是否为null
              console.info('GCM finalOutput is null');
            }
          });
        })
      });
    })
  }
}