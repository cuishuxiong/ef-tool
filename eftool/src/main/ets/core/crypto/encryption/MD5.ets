/**
 * @Author csx
 * @DateTime 2024/3/20 21:43
 * @TODO MD5
 */
import { OutDTO } from '../../base/OutDTO';
import { CryptoUtil } from '../../util/CryptoUtil';

export class MD5 {
  /**
   * MD5摘要
   * @param str 带摘要的字符串
   * @returns 摘要后的字符串
   */
  static async digest(str: string): Promise<OutDTO<string>> {
    return CryptoUtil.digest(str, 'MD5');
  }
}