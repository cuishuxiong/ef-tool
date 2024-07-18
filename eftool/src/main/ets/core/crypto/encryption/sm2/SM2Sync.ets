import { OutDTO } from '../../../base/OutDTO';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { ToastUtil } from '../../../../ui/prompt/ToastUtil';
import { StrAndUintUtil } from '../../../util/StrAndUintUtil';
import { CryptoKey, CryptoSyncUtil } from '../../../util/CryptoSyncUtil';
import { buffer } from '@kit.ArkTS';

/**
 * @Author csx
 * @DateTime 2024/3/18 10:33:03
 * @TODO SM2Sync SM2同步操作类
 */
export class SM2Sync {
  /**
   * 生成SM2的非对称密钥
   * @param resultCoding 生成RSA秘钥的字符串格式-默认不传为base64格式
   * @returns SM2密钥{publicKey:公钥,privateKey:私钥}
   */
  static generateSM2Key(resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<CryptoKey> {
    return CryptoSyncUtil.generateCryptoKey('SM2_256', resultCoding);
  }


  /**
   * 加密
   * @param encodeStr  待加密的字符串
   * @param pubKey  SM2公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64)
   * @param resultCoding  返回结果编码方式(utf8/hex/base64)-默认不传为base64格式
   */
  static encode(str: string, pubKey: string, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.encodeAsym(str, pubKey, 'SM2_256', 'SM2_256|SM3', 256, keyCoding, resultCoding);
  }

  /**
   * 解密
   * @param decodeStr  待解密的字符串
   * @param priKey    SM2私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64)
   * @param dataCoding  待解密字符串编码方式(utf8/hex/base64)-默认不传为base64格式
   */
  static decode(str: string, priKey: string, keyCoding: buffer.BufferEncoding,
    dataCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.decodeAsym(str, priKey, 'SM2_256', 'SM2_256|SM3', 256, keyCoding, dataCoding);
  }

  /**
   * 签名
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64)
   * @param resultCoding  返回结果编码方式(utf8/hex/base64)-默认不传为base64格式
   * @returns OutDTO<string> 签名对象
   */
  static sign(str: string, priKey: string, keyCoding: buffer.BufferEncoding,
    resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.sign(str, priKey, 'SM2_256', 'SM2_256|SM3', 256, keyCoding, resultCoding);
  }

  /**
   * 验签
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  SM2公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64)
   * @param dataCoding  返回结果编码方式(utf8/hex/base64)-默认不传为base64格式
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
  static verify(signStr: string, verifyStr: string, pubKey: string, keyCoding: buffer.BufferEncoding,
    dataCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.verify(signStr, verifyStr, pubKey, 'SM2_256', 'SM2_256|SM3', 256, keyCoding, dataCoding);
  }

  /**
   * 将服务器端生成的16进制的长度为130位的04开头的C1C3C2格式的SM2公钥转换为前端所需的ASN.1格式公钥字符串
   * @param pubKey   04开头的16进制的130位的公钥字符串
   * @returns 转换后的公钥字符串
   */
  static convertSM2PubKey(pubKey: string): OutDTO<string> {
    if (pubKey.length != 130) {
      ToastUtil.showToast("SM2公钥长度不正确~");
      return OutDTO.Error('服务器端SM2公钥长度不正确~');
    }
    //截取x参数
    let px = pubKey.substring(2, 66);
    //截取y参数
    let py = pubKey.substring(66);
    //转16进制放入对应的位置 04+x+y
    let pk: cryptoFramework.Point = {
      x: BigInt("0x" + px),
      y: BigInt("0x" + py)
    }
    //构建SM2公钥参数对象
    let keyPair: cryptoFramework.ECCPubKeySpec = {
      params: cryptoFramework.ECCKeyUtil.genECCCommonParamsSpec('NID_sm2'),
      pk: pk,
      algName: 'SM2',
      specType: cryptoFramework.AsyKeySpecType.PUBLIC_KEY_SPEC
    }
    //创建密钥生成器
    let keyPairGenerator = cryptoFramework.createAsyKeyGeneratorBySpec(keyPair);
    //生成uint8Array格式密钥
    let unit8PubKey = keyPairGenerator.generatePubKeySync();
    //转换成鸿蒙所需公钥字符串
    return OutDTO.OKByDataRow<string>('转换服务器端公钥成功~', StrAndUintUtil.unitArray2String(unit8PubKey.getEncoded()
      .data));
  }

  /**
   * 将服务器端生成的16进制的长度为64位的C1C3C2格式的SM2私钥转换为前端所需的ASN.1格式SM2私钥字符串
   * @param priKey   16进制的64位的私钥字符串
   * @returns 转换后的私钥字符串
   */
  static convertSM2PriKey(priKey: string): OutDTO<string> {
    if (priKey.length != 64) {
      ToastUtil.showToast("SM2私钥长度不正确~");
      return OutDTO.Error('服务器端SM2私钥长度不正确~');
    }
    //构建SM2私钥参数对象
    let keyPair: cryptoFramework.ECCPriKeySpec = {
      params: cryptoFramework.ECCKeyUtil.genECCCommonParamsSpec('NID_sm2'),
      algName: 'SM2',
      sk: BigInt('0x' + priKey),
      specType: cryptoFramework.AsyKeySpecType.PRIVATE_KEY_SPEC
    }
    //创建密钥生成器
    let keyPairGenerator = cryptoFramework.createAsyKeyGeneratorBySpec(keyPair);
    //生成uint8Array格式密钥
    let unit8PriKey = keyPairGenerator.generatePriKeySync();
    //转换成鸿蒙所需私钥字符串
    return OutDTO.OKByDataRow<string>('转换服务器端私钥成功~', StrAndUintUtil.unitArray2String(unit8PriKey.getEncoded()
      .data));
  }
}