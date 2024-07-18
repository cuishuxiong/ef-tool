/**
 * @Author csx
 * @DateTime 2024/3/20 21:43
 * @TODO SHA
 */
import { OutDTO } from '../../base/OutDTO';
import { CryptoUtil } from '../../util/CryptoUtil';
import { DynamicUtil } from '../../util/DynamicUtil';

export class SHASync {
  /**
   * SHA1摘要
   * @param str 带摘要的字符串
   * @returns 摘要后的字符串
   */
  static async digestSHA1(str: string): Promise<OutDTO<string>> {
    return CryptoUtil.digest(str, 'SHA1');
  }

  /**
   * SHA224摘要
   * @param str 带摘要的字符串
   * @returns 摘要后的字符串
   */
  static async digestSHA224(str: string): Promise<OutDTO<string>> {
    return CryptoUtil.digest(str, 'SHA224');
  }

  /**
   * SHA256摘要
   * @param str 带摘要的字符串
   * @returns 摘要后的字符串
   */
  static async digest(str: string): Promise<OutDTO<string>> {
    return CryptoUtil.digest(str, 'SHA256');
  }

  /**
   * SHA384摘要
   * @param str 带摘要的字符串
   * @returns 摘要后的字符串
   */
  static async digestSHA384(str: string): Promise<OutDTO<string>> {
    return CryptoUtil.digest(str, 'SHA384');
  }

  /**
   * SHA512摘要
   * @param str 带摘要的字符串
   * @returns 摘要后的字符串
   */
  static async digestSHA512(str: string): Promise<OutDTO<string>> {
    return CryptoUtil.digest(str, 'SHA512');
  }

  /**
   * 消息认证码计算
   * @param str  计算字符串
   * @returns
   */
  static async hmac(str: string): Promise<OutDTO<string>> {
    return DynamicUtil.hmac(str, 'SHA256');
  }
}