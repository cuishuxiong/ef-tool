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
  private static globalCipherText;
  private static globalKey;

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
    // 获取非对称密钥的二进制数据
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
      finalOutput = Array.from(finalOutput.data);
      encodeStr = encodeStr.concat(finalOutput);
      this.globalGcmParams.authTag.data = finalOutput;
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
    let decodeObj = { data: this.stringToUnit8Array(str) };
    //解密
    let updateOutput = await this.globalCipher.update(decodeObj);
    let upd = this.unit8ArrayToShowStr(updateOutput.data);
    //判断是否完成
    let finalOutput = await this.globalCipher.doFinal(null);
    if (finalOutput != null) {
      let fin = this.unit8ArrayToShowStr(finalOutput.data);
    }
    let decodeStr = this.unit8ArrayToShowStr(updateOutput.data);

    return decodeStr;

    //转换密钥
    // await  symKeyGenerator.convertKey(data).then(symKey => {
    //   // 初始化加解密操作环境:开始解密
    //   let mode = crypto.CryptoMode.DECRYPT_MODE;
    //   this.globalCipher.init(mode, symKey, this.globalGcmParams, (err,) => {
    //     //解密
    //     // let decode = { data: this.unit8ArrayToShowStr(str) };
    //     this.globalCipher.update(str).then((updateOutput) => {
    //       console.info('解密后的数据为: ' + this.unit8ArrayToShowStr(updateOutput.data));
    //       this.globalCipher.doFinal(null, (err, finalOutput) => {
    //         if (finalOutput == null) { // 使用finalOutput.data前，先判断结果是否为null
    //           console.info('GCM finalOutput is null');
    //         }
    //       });
    //     })
    //   });
    // })
  }

  // AES GCM模式示例，自动生成密钥（promise写法）
  static testAesGcm() {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        resolve('testAesGcm');
      }, 10)
    }).then(() => {
      // 生成对称密钥生成器
      let symAlgName = 'AES128';
      let symKeyGenerator = crypto.createSymKeyGenerator(symAlgName);
      if (symKeyGenerator == null) {
        console.error('createSymKeyGenerator failed');
        return;
      }
      console.info(`symKeyGenerator algName: ${symKeyGenerator.algName}`);
      // 通过密钥生成器随机生成128位长度的对称密钥
      let promiseSymKey = symKeyGenerator.generateSymKey();
      // 构造参数
      this.globalGcmParams = this.genGcmParamsSpec();

      // 生成加解密生成器
      let cipherAlgName = 'AES128|GCM|PKCS7';
      try {
        this.globalCipher = crypto.createCipher(cipherAlgName);
        console.info(`cipher algName: ${this.globalCipher.algName}`);
      } catch (error) {
        console.error(`createCipher failed, ${error.code}, ${error.message}`);
        return;
      }
      return promiseSymKey;
    })
      .then(key => {
        let encodedKey = key.getEncoded();
        console.info('key hex:' + this.unit8ArrayToShowStr(encodedKey.data));
        this.globalKey = key;
        return key;
      })
      .then(key => {
        // 初始化加解密操作环境:开始加密
        let mode = crypto.CryptoMode.ENCRYPT_MODE;
        let promiseInit = this.globalCipher.init(mode, key, this.globalGcmParams); // init
        return promiseInit;
      })
      .then(() => {
        let plainText = { data: this.stringToUnit8Array('this is test!') };
        let promiseUpdate = this.globalCipher.update(plainText); // update
        return promiseUpdate;
      })
      .then(updateOutput => {
        this.globalCipherText = updateOutput;
        let promiseFinal = this.globalCipher.doFinal(null); // doFinal
        return promiseFinal;
      })
      .then(authTag => {
        // GCM模式需要从doFinal的输出中取出加密后的认证信息并填入globalGcmParams，在解密时传入init()
        this.globalGcmParams.authTag = authTag;
        return;
      })
      .then(() => {
        // 初始化加解密操作环境:开始解密
        let mode = crypto.CryptoMode.DECRYPT_MODE;
        let promiseInit = this.globalCipher.init(mode, this.globalKey, this.globalGcmParams); // init
        return promiseInit;
      })
      .then(() => {
        let promiseUpdate = this.globalCipher.update(this.globalCipherText); // update
        return promiseUpdate;
      })
      .then(updateOutput => {
        console.info('decrypt plainText: ' + this.unit8ArrayToShowStr(updateOutput.data));
        let promiseFinal = this.globalCipher.doFinal(null); // doFinal
        return promiseFinal;
      })
      .then(finalOutput => {
        if (finalOutput == null) { // 使用finalOutput.data前，先判断结果是否为null
          console.info('GCM finalOutput is null');
        }
      })
      .catch(error => {
        console.error(`catch error, ${error.code}, ${error.message}`);
      })
  }
}