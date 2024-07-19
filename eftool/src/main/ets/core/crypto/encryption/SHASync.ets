/**
 * @Author csx
 * @DateTime 2024/3/20 21:43
 * @TODO SHA
 */
import { OutDTO } from '../../base/OutDTO';
import { CryptoSyncUtil } from '../../util/CryptoSyncUtil';
import { buffer } from '@kit.ArkTS';
import { DynamicSyncUtil } from '../../util/DynamicSyncUtil';

export class SHASync {
  /**
   * SHA1摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
  static digestSHA1(str: string, resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.digest(str, 'SHA1', resultCoding);
  }

  /**
   * SHA224摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
  static digestSHA224(str: string, resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.digest(str, 'SHA224', resultCoding);
  }

  /**
   * SHA256摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
  static digest(str: string, resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.digest(str, 'SHA256', resultCoding);
  }

  /**
   * SHA384摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
  static digestSHA384(str: string, resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.digest(str, 'SHA384', resultCoding);
  }

  /**
   * SHA512摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
  static digestSHA512(str: string, resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.digest(str, 'SHA512', resultCoding);
  }

  /**
   * 消息认证码计算
   * @param str  计算字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns
   */
  static hmac(str: string, resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return DynamicSyncUtil.hmac(str, 'SHA256', resultCoding);
  }
}