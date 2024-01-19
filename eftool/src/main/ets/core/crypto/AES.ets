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
   *字节流转成可理解的字符串
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
   * 生成AES的对称密钥
   * @returns
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
  static genKeyMaterialBlob() {
    let arr = [
      0xba, 0x3d, 0xc2, 0x71, 0x21, 0x1e, 0x30, 0x56,
      0xad, 0x47, 0xfc, 0x5a, 0x46, 0x39, 0xee, 0x7c,
      0xba, 0x3b, 0xc2, 0x71, 0xab, 0xa0, 0x30, 0x72];    // keyLen = 192 (24 bytes)
    let keyMaterial = new Uint8Array(arr);
    return {data : keyMaterial};
  }
  /**
   *
   * @param str
   */
  static  encode(str: string, aesKey: string) {

    // 创建对称密钥生成器
    let symKeyGenerator = crypto.createSymKeyGenerator("3DES192");
     symKeyGenerator.convertKey(this.genKeyMaterialBlob()).then(symKey => {
      // 初始化加解密操作环境:开始加密
      let mode = crypto.CryptoMode.ENCRYPT_MODE;
      AES.globalCipher.init(mode, symKey, AES.globalGcmParams, (err,) => {
        console.error("============:" + err)
        let plainText = { data: AES.stringToUnit8Array(str) };
        AES.globalCipher.update(plainText).then((err1, updateOutput) => {
          AES.globalCipherText = updateOutput;
          console.error("============:" + err1)
          console.error("============加密:" + updateOutput)
          AES.globalCipher.doFinal(null, (err, finalOutput) => {
            if (finalOutput != null) {
              AES.globalCipherText = Array.from(AES.globalCipherText.data);
              finalOutput = Array.from(finalOutput.data);
              AES.globalCipherText = AES.globalCipherText.concat(finalOutput);
              AES.globalCipherText = new Uint8Array(AES.globalCipherText);
              AES.globalCipherText = { data: AES.globalCipherText };
              console.error("============最終加密数据:" + AES.globalCipherText)
            }
          });
        })

      }); // init
    })


  }


  //
  // static testAesGcm() {
  //   return new Promise((resolve, reject) => {
  //     setTimeout(() => {
  //       resolve('testAesGcm');
  //     }, 10)
  //   }).then(() => {
  //     // 生成对称密钥生成器
  //     let symAlgName = 'AES128';
  //     let symKeyGenerator = crypto.createSymKeyGenerator(symAlgName);
  //     if (symKeyGenerator == null) {
  //       console.error('createSymKeyGenerator failed');
  //       return;
  //     }
  //     console.info(`symKeyGenerator algName: ${symKeyGenerator.algName}`);
  //     // 通过密钥生成器随机生成128位长度的对称密钥
  //     let promiseSymKey = symKeyGenerator.generateSymKey();
  //     // 构造参数
  //     globalGcmParams = this.genGcmParamsSpec();
  //
  //     // 生成加解密生成器
  //     let cipherAlgName = 'AES128|GCM|PKCS7';
  //     try {
  //       globalCipher = crypto.createCipher(cipherAlgName);
  //       console.info(`cipher algName: ${globalCipher.algName}`);
  //     } catch (error) {
  //       console.error(`createCipher failed, ${error.code}, ${error.message}`);
  //       return;
  //     }
  //     return promiseSymKey;
  //   })
  //     .then(key => {
  //       let encodedKey = key.getEncoded();
  //       console.info('key hex:' + this.unit8ArrayToShowStr(encodedKey.data));
  //       globalKey = key;
  //       return key;
  //     })
  //     .then(key => {
  //       console.error("key:--------------" + JSON.stringify(key))
  //       // 初始化加解密操作环境:开始加密
  //       let mode = crypto.CryptoMode.ENCRYPT_MODE;
  //       let promiseInit = globalCipher.init(mode, key, globalGcmParams); // init
  //       return promiseInit;
  //     })
  //     .then(() => {
  //       let plainText = { data: this.stringToUnit8Array('this  is  csx  test !') };
  //       let promiseUpdate = globalCipher.update(plainText); // update
  //       return promiseUpdate;
  //     })
  //     .then(updateOutput => {
  //       globalCipherText = updateOutput;
  //       console.error("加密数据为:" + this.unit8ArrayToShowStr(globalCipherText.data))
  //       let promiseFinal = globalCipher.doFinal(null); // doFinal
  //       return promiseFinal;
  //     })
  //     .then(authTag => {
  //       // GCM模式需要从doFinal的输出中取出加密后的认证信息并填入globalGcmParams，在解密时传入init()
  //       globalGcmParams.authTag = authTag;
  //       return;
  //     })
  //     .then(() => {
  //       // 初始化加解密操作环境:开始解密
  //       let mode = crypto.CryptoMode.DECRYPT_MODE;
  //       let promiseInit = globalCipher.init(mode, globalKey, globalGcmParams); // init
  //       return promiseInit;
  //     })
  //     .then(() => {
  //       let promiseUpdate = globalCipher.update(globalCipherText); // update
  //       return promiseUpdate;
  //     })
  //     .then(updateOutput => {
  //       console.info('解密数据为==========: ' + this.unit8ArrayToString(updateOutput.data));
  //       let promiseFinal = globalCipher.doFinal(null); // doFinal
  //       return promiseFinal;
  //     })
  //     .then(finalOutput => {
  //       if (finalOutput == null) { // 使用finalOutput.data前，先判断结果是否为null
  //         console.info('GCM finalOutput is null');
  //       }
  //     })
  //     .catch(error => {
  //       console.error(`catch error, ${error.code}, ${error.message}`);
  //     })
  // }

}