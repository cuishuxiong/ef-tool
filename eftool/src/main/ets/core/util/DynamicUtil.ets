/**
 * @Author csx
 * @DateTime 2024/3/20 21:19
 * @TODO DynamicUtil  动态协商工具类
 */
import { OutDTO } from '../base/OutDTO';
import { CryptoUtil } from './CryptoUtil';
import crypto from '@ohos.security.cryptoFramework';
import { StrAndUintUtil } from './StrAndUintUtil';
import { buffer } from '@kit.ArkTS';

export class DynamicUtil {
  /**
   * 动态协商密钥
   * @param pubKey  符合格式的非对称密钥的公钥字符串或Uint8Array字节流
   * @param priKey  符合格式的非对称密钥的私钥字符串或Uint8Array字节流
   * @param symAlgName 秘钥规格
   * @returns 共享密钥
   */
  static async dynamicKey(pubKey: string | Uint8Array, priKey: string | Uint8Array, symAlgName: string): Promise<OutDTO<string>> {
    //公钥数据
    let pubKeyArray: Uint8Array = new Uint8Array();
    //私钥数据
    let priKeyArray: Uint8Array = new Uint8Array();
    //转换公钥
    if (typeof pubKey === 'string') {
      let pk = await CryptoUtil.convertPubKeyFromStr(pubKey as string, symAlgName);
      pubKeyArray = pk.pubKey.getEncoded().data;
    } else {
      pubKeyArray = pubKey as Uint8Array;
    }
    //转换私钥
    if (typeof priKey === 'string') {
      let pik = await CryptoUtil.convertPriKeyFromStr(priKey as string, symAlgName);
      priKeyArray = pik.priKey.getEncoded().data;
    } else {
      priKeyArray = priKey as Uint8Array;
    }
    //创建密钥生成器
    let eccGen = crypto.createAsyKeyGenerator(symAlgName);
    // 外部传入的公私钥对A
    let keyPairA = await eccGen.convertKey({ data: pubKeyArray }, null);
    // 内部生成的公私钥对B
    let keyPairB = await eccGen.convertKey(null, { data: priKeyArray });
    let eccKeyAgreement = crypto.createKeyAgreement(symAlgName);
    // 使用A的公钥和B的私钥进行密钥协商
    let secret1 = await eccKeyAgreement.generateSecret(keyPairB.priKey, keyPairA.pubKey);
    // 两种协商的结果应当一致
    if (secret1.data) {
      return OutDTO.OKByDataRow<string>('生成共享密钥成功', StrAndUintUtil.unitArray2String(secret1.data));
    } else {
      return OutDTO.ErrorByDataRow<string>('生成共享密钥失败', '动态协商交换结果不相等,请检查公私钥是否正确！');
    }
  }


  /**
   * 消息认证码计算
   * @param str  计算字符串
   * @param symAlgName  秘钥规格
   * @returns
   */
  static async hmac(str: string, symAlgName: string): Promise<OutDTO<string>> {
    //创建消息认证码计算器
    let mac = crypto.createMac(symAlgName);
    let messageData = new Uint8Array(buffer.from(str, 'utf-8').buffer);
    let updateLength = 200; // 默认以200字节为单位进行分段update
    let symKeyGenerator = crypto.createSymKeyGenerator('AES256');
    // 通过非对称密钥生成器，随机生成非对称密钥
    let symKey = await symKeyGenerator.generateSymKey();
    //初始化密钥
    await mac.init(symKey);
    for (let i = 0; i < messageData.length; i += updateLength) {
      let updateMessage = messageData.subarray(i, i + updateLength);
      let updateMessageBlob: crypto.DataBlob = { data: updateMessage };
      await mac.update(updateMessageBlob);
    }
    let macOutput = await mac.doFinal();
    return OutDTO.OKByDataRow<string>(symAlgName + '消息认证码计算数据成功！', StrAndUintUtil.unitArray2String(macOutput.data));
  }
}