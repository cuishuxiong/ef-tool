/**
 * @Author csx
 * @DateTime 2024/6/28 21:54
 * @TODO Crypto
 */
import {
  RandomUtil,
  AESSync,
  UiConst,
  RSASync,
  RSA,
  SHASync,
  SM3Sync,
  SM2Sync,
  SM2Convert,
  SM4Sync,
  ECDHSync,
  DESSync
} from '@yunkss/eftool';
import { CryptoSyncUtil } from '@yunkss/eftool/src/main/ets/core/util/CryptoSyncUtil';

@Entry
@Component
struct Crypto {
  @State msg: string = '';
  scroller: Scroller = new Scroller()

  testRSA() {
    // let key1024 = RSASync.generateRSAKey();
    // let encode1024 = RSASync.encodePKCS1('测试RSA1024加密~~~', key1024.getDataRow().publicKey, 'base64');
    // let decode1024 = RSASync.decodePKCS1(encode1024.getDataRow(), key1024.getDataRow().privateKey, 'base64');
    // this.msg = decode1024.getDataRow();

    let key1024Hex = RSASync.generateRSAKey('hex');
    // let encode1024Hex = RSASync.encodePKCS1('测试RSA1024-HEX加密~~~', key1024Hex.getDataRow().publicKey, 'hex');
    // let decode1024Hex = RSASync.decodePKCS1(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex');
    // this.msg = decode1024Hex.getDataRow();

    // let encode1024Hex = RSASync.encodePKCS1('测试RSA1024-HEX加密~~~', key1024Hex.getDataRow().publicKey, 'hex', 'hex');
    // let decode1024Hex =
    //   RSASync.decodePKCS1(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex', 'hex');
    // this.msg = decode1024Hex.getDataRow();

    let pemPubKey = `-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDOKeI9M56EDZ7yLJB56lKWb180
eGfPrYiAG9IbjEEK8FfNvZuDrCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQC
HMy+lrOq3rpeDfFiiT7zwvXft2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1
eTXVu7hjXEqmrGXmgwIDAQAB
-----END PUBLIC KEY-----`;

    let pemPriKey = `-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDOKeI9M56EDZ7yLJB56lKWb180eGfPrYiAG9IbjEEK8FfNvZuD
rCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQCHMy+lrOq3rpeDfFiiT7zwvXf
t2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1eTXVu7hjXEqmrGXmgwIDAQAB
AoGAS/36S67kRi6zIPc2RgoOaS8iO7gKI+4GO5qFpuva6cpPwyGZ2j4vpnooLlgC
GqBe+Z7AhGzB90D45TQXlexwJ6xrXDN/9w0mCPItTfe5QxtvK2i0z9unoYXJcNwN
rSbbv1mBzJHybXcZgt9J2zFnsohAFPWGKVZrhDfyiecS0pkCQQD3WMY+hZVX5CLD
ojfUrfiSXDh+qd+aeo6dMYDYaOhW23oJ0OHNm6vYKZ+xiEf3OB0BduZofSWHALim
qVFF1bg1AkEA1WBGYd+/FHku+t17G6xRnWuDWI6A3ZyVuGv3wfRL5W8hKiJ1Urk3
ftllxQ4YVEIgaeET/0xSQ9H5KB2px+Gq1wJAGjJHxMVnHMjnuaqLmTXXtsCXpyqc
qQLD6fgdOk5aFSDnmvSJhbowCBPYevgBDzjdMZODMZvXhqXX6KbUGb5Z5QJBAJ+R
OdEjtA+peFqemtvdB8PDjRwCpZgU61pZU5S2DrPrYU/TKQ3N+RRhm1u76LHKKddE
POIkvzh8o+k+FaOmvU0CQBNhCHc2ufGNc88MZmTwxHpGom177f9p/YPiYcg5w3Ej
8xL+hatfA2Ls3Wg/P3gfm8raHbWzC3ge/JSk/LC/ygk=
-----END RSA PRIVATE KEY-----`;

    // let encodePem = RSASync.encodePKCS1('测试pem格式的1024位RSA加密~~', pemPubKey, 'base64', 'hex', true);
    // let decodePem = RSASync.decodePKCS1(encodePem.getDataRow(), pemPriKey, 'base64', 'hex', true);
    // this.msg = decodePem.getDataRow();

    // let encodePem = RSASync.encodePKCS1Segment('测试pem格式的1024位RSA加密测试pem格式的1024位RSA加密测试pem格式的1024位RSA加密测试pem格式的1024位RSA加密测试pem格式的1024位RSA加密测试pem格式的1024位RSA加密测试pem格式的1024位RSA加密测试pem格式的1024位RSA加密~~', pemPubKey, 'base64', 'hex', true);
    // let decodePem = RSASync.decodePKCS1Segment(encodePem.getDataRow(), pemPriKey, 'base64', 'hex', true);
    // this.msg = decodePem.getDataRow();

    let sign = RSASync.signPKCS1('待签名的RSA的pem格式的字符串~', pemPriKey, 'base64', 'base64', true);

    let verify =
      RSASync.verifyPKCS1(sign.getDataRow(), '待签名的RSA的pem格式的字符串~', pemPubKey, 'base64', 'base64', true);

    this.msg = verify.getMsg();


  }

  testAES() {

    let iv = RandomUtil.generateIV();
    // let key = AESSync.generateAESKey();
    // let encode = AESSync.encodeCBC('测试AES-CBC加密~~~~', key.getDataRow(), iv.getDataRow(), 'base64');
    // let decode = AESSync.decodeCBC(encode.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64');
    // this.msg = decode.getDataRow();

    // let ivHex = RandomUtil.generateIV('hex');
    // let keyHex = AESSync.generateAESKey('hex');
    // let encodeHex = AESSync.encodeCBC('测试AES-CBC加密~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
    // let decodeHex = AESSync.decodeCBC(encodeHex.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
    // this.msg = decodeHex.getDataRow();


    // let encodeBase64 = AESSync.encodeCBC('测试AES-CBC加密~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
    // let decodeBase64 = AESSync.decodeCBC(encodeBase64.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
    // this.msg = decodeBase64.getDataRow();

    // let encode2 = AESSync.encodeCBC("测试AES外部传入key/iv加密~~~", "TESTsdiloia20230ass3[2K8%fw68sw7",
    //   "ass3[2K8%fw68sw7", 'utf8');
    // let decode2 = AESSync.decodeCBC(encode2.getDataRow(), "TESTsdiloia20230ass3[2K8%fw68sw7", "ass3[2K8%fw68sw7", 'utf8');
    // this.msg = decode2.getDataRow();

    // let gcmEncode = AESSync.encodeGCM('测试AES-GCM加密~~~~', key.getDataRow(), 'base64');
    // let gcmDecode = AESSync.decodeGCM(gcmEncode.getDataRow(), key.getDataRow(), 'base64');
    // this.msg = gcmDecode.getDataRow();


    // let ecbEncode = AESSync.encodeECB('测试AES-ECB加密~', keyHex.getDataRow(), 'base64');
    // let ecbDecode = AESSync.decodeECB(ecbEncode.getDataRow(), keyHex.getDataRow(), 'base64');
    // this.msg = ecbDecode.getDataRow();

    // let ecbEncodeHex = AESSync.encodeECB('测试AES-ECB加密~', keyHex.getDataRow(), 'hex', 'hex');
    // let ecbDecodeHex = AESSync.decodeECB(ecbEncodeHex.getDataRow(), keyHex.getDataRow(), 'hex', 'hex');
    // this.msg = ecbDecodeHex.getDataRow();

    // let ecbEncodeBase64 = AESSync.encodeECB('测试AES-ECB加密~', keyHex.getDataRow(), 'hex');
    // let ecbDecodBase64 = AESSync.decodeECB(ecbEncodeBase64.getDataRow(), keyHex.getDataRow(), 'hex');
    // this.msg = ecbDecodBase64.getDataRow();

    // let encode1 = AESSync.encodeECB('测试AES外部传入key加密~~~~', '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
    // let decode1 = AESSync.decodeECB(encode1.getDataRow(), '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
    // this.msg = decode1.getDataRow();


    // let key128 = AESSync.generateAESKey128();
    // let key128Hex = AESSync.generateAESKey128('hex');

    // let encodeCBC128 = AESSync.encodeCBC128('测试AES-128-CBC加密~~~~', key128.getDataRow(), iv.getDataRow(), 'base64');
    // let decodeCBC128 = AESSync.decodeCBC128(encodeCBC128.getDataRow(), key128.getDataRow(), iv.getDataRow(), 'base64');
    // this.msg = decodeCBC128.getDataRow();

    // let encodeCBC128 =
    //   AESSync.encodeCBC128('测试AES-128-CBC加密~~~~', key128Hex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
    // let decodeCBC128 =
    //   AESSync.decodeCBC128(encodeCBC128.getDataRow(), key128Hex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
    // this.msg = decodeCBC128.getDataRow();

    // let encodeCBC128 =
    //   AESSync.encodeCBC128('测试AES-128-CBC加密~~~~', key128Hex.getDataRow(), ivHex.getDataRow(), 'hex');
    // let decodeCBC128 =
    //   AESSync.decodeCBC128(encodeCBC128.getDataRow(), key128Hex.getDataRow(), ivHex.getDataRow(), 'hex');
    // this.msg = decodeCBC128.getDataRow();

    // let encode128 = AESSync.encodeECB128('测试AES-128-ECB加密~~~~', key128.getDataRow(), 'base64');
    // let decode128 = AESSync.decodeECB128(encode128.getDataRow(), key128.getDataRow(), 'base64');
    // this.msg = decode128.getDataRow();

    // let encode1 = AESSync.encodeECB128('测试AES外部传入key加密~~~~', '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
    // let decode1 = AESSync.decodeECB128(encode1.getDataRow(), '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
    // this.msg = decode1.getDataRow();

    // let encode2 = AESSync.encodeCBC128("测试AES外部传入key/iv加密~~~", "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8');
    // let decode2 = AESSync.decodeCBC128(encode2.getDataRow(), "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8');
    // this.msg = decode2.getDataRow();

    // let encode2 =
    //   AESSync.encodeCBC128("测试AES外部传入key/iv加密~~~", "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8', 'hex');
    // let decode2 = AESSync.decodeCBC128(encode2.getDataRow(), "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8', 'hex');
    // this.msg = decode2.getDataRow();

    let key = AESSync.generateAESKey192();

    // let encode192 = AESSync.encodeCBC192('测试AES-192-CBC加密~~~', key.getDataRow(), iv.getDataRow(), 'base64');
    // let decode192 = AESSync.decodeCBC192(encode192.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64');
    // this.msg = decode192.getDataRow();

    let encode192Ecb = AESSync.encodeECB192('测试AES-192-ECB加密~~~', key.getDataRow(), 'base64');
    let decode192Ecb = AESSync.decodeECB192(encode192Ecb.getDataRow(), key.getDataRow(), 'base64');
    this.msg = decode192Ecb.getDataRow();


  }

  testSHA() {
    let digest = SHASync.digest('测试SHASync~~~~~');
    this.msg = digest.getDataRow();
  }

  test3DES() {

    let iv = RandomUtil.generateIV();
    let ivHex = RandomUtil.generateIV('hex');

    let key = DESSync.generate3DESKey();
    let keyHex = DESSync.generate3DESKey('hex');

    let encodeEcb = DESSync.encodeECB('', key.getDataRow(), 'base64');
    let encodeEcbH = DESSync.encodeECB('', key.getDataRow(), 'base64', 'hex');
    let encodeEcbHex = DESSync.encodeECB('', keyHex.getDataRow(), 'hex');
    let encodeEcbHexH = DESSync.encodeECB('', keyHex.getDataRow(), 'hex', 'hex');

    let decodeEcb = DESSync.decodeECB(encodeEcb.getDataRow(), key.getDataRow(), 'base64');
    let decodeEcbH = DESSync.decodeECB(encodeEcbH.getDataRow(), key.getDataRow(), 'base64', 'hex');
    let decodeEcbHex = DESSync.decodeECB(encodeEcbHex.getDataRow(), keyHex.getDataRow(), 'hex');
    let decodeEcbHexH = DESSync.decodeECB(encodeEcbHexH.getDataRow(), keyHex.getDataRow(), 'hex', 'hex');

    let encodeCbc = DESSync.encodeCBC('', key.getDataRow(), iv.getDataRow(), 'base64');
    let encodeCbcH = DESSync.encodeCBC('', key.getDataRow(), iv.getDataRow(), 'base64', 'hex');
    let encodeCbcHex = DESSync.encodeCBC('', keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
    let encodeCbcHexH = DESSync.encodeCBC('', keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');

    let decodeCbc = DESSync.decodeCBC(encodeCbc.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64');
    let decodeCbcH = DESSync.decodeCBC(encodeCbcH.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64', 'hex');
    let decodeCbcHex = DESSync.decodeCBC(encodeCbcHex.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
    let decodeCbcHexH =
      DESSync.decodeCBC(encodeCbcHexH.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');

  }

  testSM2() {
    let key = SM2Sync.generateSM2Key();
    // let encode = SM2Sync.encode('测试SM2的加密~~~~', key.getDataRow().publicKey, 'base64');
    // let decode = SM2Sync.decode(encode.getDataRow(), key.getDataRow().privateKey, 'base64');
    // this.msg = decode.getDataRow();

    // let encode = SM2Sync.encode('测试SM2的加密~~~~', key.getDataRow().publicKey, 'base64', 'hex');
    // let decode = SM2Sync.decode(encode.getDataRow(), key.getDataRow().privateKey, 'base64', 'hex');
    // this.msg = decode.getDataRow();

    let sign = SM2Sync.sign('测试SM2的加密~~~~', key.getDataRow().privateKey, 'base64');
    this.msg = sign.getDataRow();
    let verify = SM2Sync.verify(sign.getDataRow(), '测试SM2的加密~~~~', key.getDataRow().publicKey, 'base64');
    this.msg = verify.getMsg();

  }

  testSM3() {

    let digest = SM3Sync.digest('测试SM3的digest~~~~');
    this.msg = digest.getDataRow();

    let hmac = SM3Sync.hmac('测试SM3的hmac~~~~');
    this.msg = hmac.getDataRow();

  }

  testSM4() {
    // let iv = RandomUtil.generateIV();
    let key = SM4Sync.generateSM4Key();
    // let encode = SM4Sync.encodeCBC('测试SM4-CBC加密~~~~', key.getDataRow(), iv.getDataRow(), 'base64');
    // let decode = SM4Sync.decodeCBC(encode.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64');
    // this.msg = decode.getDataRow();

    // let ivHex = RandomUtil.generateIV('hex');
    let keyHex = SM4Sync.generateSM4Key('hex');
    // let encodeHex = SM4Sync.encodeCBC('测试SM4-CBC加密-hex~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
    // let decodeHex = SM4Sync.decodeCBC(encodeHex.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
    // this.msg = decodeHex.getDataRow();


    // let encodeBase64 = SM4Sync.encodeCBC('测试SM4-CBC加密-base64~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
    // let decodeBase64 = SM4Sync.decodeCBC(encodeBase64.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
    // this.msg = decodeBase64.getDataRow();

    // let encode2 = SM4Sync.encodeCBC("测试SM4外部传入key/iv加密~~~", "TESTsdiloia20230ass3[2K8%fw68sw7",
    //   "ass3[2K8%fw68sw7", 'utf8');
    // let decode2 =
    //   SM4Sync.decodeCBC(encode2.getDataRow(), "TESTsdiloia20230ass3[2K8%fw68sw7", "ass3[2K8%fw68sw7", 'utf8');
    // this.msg = decode2.getDataRow();


    // let ecbEncode = SM4Sync.encodeECB('测试SM4-ECB加密-base64~', key.getDataRow(), 'base64');
    // let ecbDecode = SM4Sync.decodeECB(ecbEncode.getDataRow(), key.getDataRow(), 'base64');
    // this.msg = ecbDecode.getDataRow();

    // let ecbEncodeHex = SM4Sync.encodeECB('测试SM4-ECB加密-hex~', keyHex.getDataRow(), 'hex', 'hex');
    // let ecbDecodeHex = SM4Sync.decodeECB(ecbEncodeHex.getDataRow(), keyHex.getDataRow(), 'hex', 'hex');
    // this.msg = ecbDecodeHex.getDataRow();

    // let ecbEncodeBase64 = SM4Sync.encodeECB('测试SM4-ECB加密-hex-base64~', keyHex.getDataRow(), 'hex');
    // let ecbDecodBase64 = SM4Sync.decodeECB(ecbEncodeBase64.getDataRow(), keyHex.getDataRow(), 'hex');
    // this.msg = ecbDecodBase64.getDataRow();


    let encode1 = SM4Sync.encodeECB('测试SM4外部传入key加密~~~~', '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
    let decode1 = SM4Sync.decodeECB(encode1.getDataRow(), '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
    this.msg = decode1.getDataRow();


  }

  testECDH() {
    //模拟当前项目的公钥
    let sm2Key = CryptoSyncUtil.generateCryptoKey('ECC256', 'base64');
    //模拟外部传入的私钥
    let eccKey = CryptoSyncUtil.generateCryptoKey('ECC256', 'base64');
    //动态协商
    let shareKey = ECDHSync.ecdh(sm2Key.getDataRow().publicKey, eccKey.getDataRow().privateKey, 'base64', 'base64');
    this.msg = "生成的共享密钥为:" + shareKey.getDataRow();

    //模拟加密
    let shareEncode = AESSync.encodeECB('使用ECDH共享密钥加密数据测试~~~~', shareKey.getDataRow(), 'base64');
    this.msg = shareEncode.getDataRow();
    //动态协商解密key
    let decodeKey = ECDHSync.ecdh(eccKey.getDataRow().publicKey, sm2Key.getDataRow().privateKey, 'base64', 'base64');
    //解密
    let shareDecode = AESSync.decodeECB(shareEncode.getDataRow(), decodeKey.getDataRow(), 'base64');
    this.msg = "共享密钥解密结果为:" + shareDecode.getDataRow();
  }

  build() {

    Scroll(this.scroller) {
      Column() {

        Text(this.msg)
          .fontSize(UiConst.FONT_18);

        Button('测试AES各种编码加解密').margin({ top: 20 }).onClick(() => {
          this.testAES();
        })

        Button('测试RSA各种编码加解密').margin({ top: 20 }).onClick(() => {
          this.testRSA();
        })

        Button('测试SHA各种编码签名').margin({ top: 20 }).onClick(() => {
          this.testSHA();
        })

        Button('测试3DES各种编码加解密').margin({ top: 20 }).onClick(() => {
          this.test3DES();
        })

        Button('测试SM2各种编码签名').margin({ top: 20 }).onClick(() => {
          this.testSM2();
        })

        Button('测试SM3各种编码签名').margin({ top: 20 }).onClick(() => {
          this.testSM3();
        })

        Button('测试SM4各种编码签名').margin({ top: 20 }).onClick(() => {
          this.testSM4();
        })

        Button('测试ECDH各种编码签名').margin({ top: 20 }).onClick(() => {
          this.testECDH();
        })

      }
      .width('100%')
      .padding({ top: 60 })
    }
    .height('100%')
    .width('100%')
    .scrollable(ScrollDirection.Vertical)
  }
}