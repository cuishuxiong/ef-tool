/**
 * @Author csx
 * @DateTime 2024/6/28 21:54
 * @TODO Crypto
 */
import { RandomUtil, AESSync, UiConst } from '@yunkss/eftool';

@Entry
@Component
struct Crypto {
  @State msg: string = '';
  scroller: Scroller = new Scroller()

  testAESHex() {

    let iv = RandomUtil.generateIV();
    // let key = AESSync.generateAESKey();
    // let encode = AESSync.encodeCBC('测试AES-CBC加密~~~~', key.getDataRow(), iv.getDataRow(), 'base64');
    // let decode = AESSync.decodeCBC(encode.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64');
    // this.msg = decode.getDataRow();

    let ivHex = RandomUtil.generateIV('hex');
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


    let key128 = AESSync.generateAESKey128();
    let key128Hex = AESSync.generateAESKey128('hex');

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

    let encode2 =
      AESSync.encodeCBC128("测试AES外部传入key/iv加密~~~", "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8', 'hex');
    let decode2 = AESSync.decodeCBC128(encode2.getDataRow(), "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8', 'hex');
    this.msg = decode2.getDataRow();


  }

  build() {

    Scroll(this.scroller) {
      Column() {

        Text(this.msg)
          .fontSize(UiConst.FONT_18);

        Button('测试AES各种编码加解密').margin({ top: 20 }).onClick(() => {
          this.testAESHex();
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