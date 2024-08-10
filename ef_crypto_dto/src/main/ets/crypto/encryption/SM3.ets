/**
 * @Author csx
 * @DateTime 2024/3/18 10:37:03
 * @TODO SM3
 */
import { OutDTO } from '@yunkss/ef_core';
import { CryptoUtil } from '../util/CryptoUtil';
import { DynamicUtil } from '../util/DynamicUtil';

export class SM3 {
  /**
   * SM3摘要
   * @param str 带摘要的字符串
   * @returns 摘要后的字符串
   */
  static async digest(str: string): Promise<OutDTO<string>> {
    return CryptoUtil.digest(str, 'SM3');
  }

  /**
   * 消息认证码计算
   * @param str  计算字符串
   * @returns
   */
  static async hmac(str: string): Promise<OutDTO<string>> {
    return DynamicUtil.hmac(str, 'SM3');
  }
}