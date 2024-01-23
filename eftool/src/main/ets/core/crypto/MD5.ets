import crypto from "@ohos.security.cryptoFramework"
import util from '@ohos.util';
import { OutDTO } from '../base/OutDTO';

/**
 * @Author csx
 * @DateTime 2024/1/17 14:23:01
 * @TODO MD5  MD5工具类
 */
export class MD5 {

  /**
   * 字节流转成可理解的字符串
   * @param unit8Array
   * @returns
   */
  private static unit8ArrayToShowStr(unit8Array) {
    return Array.prototype.map
      .call(unit8Array, (x) => ('00' + x.toString(16)).slice(-2))
      .join('');
  }

  /**
   * MD5摘要
   * @param str  需要摘要的字符串
   * @returns 摘要字符串
   */
  static async digest(str: string): Promise<OutDTO<string>> {
    //创建MD5摘要器
    let md = crypto.createMd("MD5");
    //转换需要摘要的字符串
    let encode = new util.TextEncoder();
    let digestData = { data: encode.encodeInto(str) };
    //进行更新计算
    let promiseMdUpdate = await md.update(digestData);
    let digestResult = await md.digest();
    if (digestResult != null) {
      let digestStr = this.unit8ArrayToShowStr(digestResult.data);
      return OutDTO.OKByDataRow('MD5摘要成功~', digestStr);
    } else {
      return OutDTO.Error("MD5摘要失败~");
    }
  }
}