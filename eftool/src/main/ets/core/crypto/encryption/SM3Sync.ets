import { OutDTO } from '../../base/OutDTO';
import { CryptoSyncUtil } from '../../util/CryptoSyncUtil';
import { buffer } from '@kit.ArkTS';
import { DynamicSyncUtil } from '../../util/DynamicSyncUtil';

/**
 * @Author csx
 * @DateTime 2024/3/18 10:37:03
 * @TODO SM3Sync SM3同步工具类
 */
export class SM3Sync {
  /**
   * SM3摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
  static digest(str: string, resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return CryptoSyncUtil.digest(str, 'SM3', resultCoding);
  }

  /**
   * 消息认证码计算
   * @param str  计算字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns
   */
  static hmac(str: string, resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    return DynamicSyncUtil.hmac(str, 'SM3', resultCoding);
  }
}