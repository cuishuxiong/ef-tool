/**
 * @Author csx
 * @DateTime 2024/6/6 00:19
 * @TODO Base64Util  base64工具类
 */
import { util } from '@kit.ArkTS';

export class Base64Util {
  /**
   * 编码，通过输入参数编码后输出对应文本。
   * @param array
   * @returns
   */
  static encodeToStrSync(array: Uint8Array, options?: util.Type): string {
    let base64 = new util.Base64Helper();
    let result = base64.encodeToStringSync(array, options);
    return result;
  }

  /**
   * 解码，通过输入参数解码后输出对应Uint8Array对象。
   * @param array
   * @returns
   */
  static decodeSync(str: string, options?: util.Type): Uint8Array {
    let base64 = new util.Base64Helper();
    let result = base64.decodeSync(str, options);
    return result;
  }


  /**
   * 编码，通过输入参数编码后输出对应文本。
   * @param array
   * @returns
   */
  static encodeToStr(array: Uint8Array, options?: util.Type): Promise<string> {
    let base64 = new util.Base64Helper();
    return base64.encodeToString(array, options);
  }

  /**
   * 解码，通过输入参数解码后输出对应Uint8Array对象。
   * @param array
   * @returns
   */
  static decode(str: string, options?: util.Type): Promise<Uint8Array> {
    let base64 = new util.Base64Helper();
    return base64.decode(str, options);
  }
}