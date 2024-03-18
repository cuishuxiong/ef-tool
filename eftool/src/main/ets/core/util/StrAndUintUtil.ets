/**
 * @Author csx
 * @DateTime 2024/3/18 21:29
 * @TODO StrAndUintUtil 字符串和Uint8Array工具类
 */
import { StringBuilder } from '../base/StringBuilder';

export class StrAndUintUtil {
  /**
   * 将字节流以16进制字符串输出
   * @param arr  Uint8Array数组
   * @returns 字符串
   */
  static unitArray2String(arr: Uint8Array): string {
    //转换成可以读懂的字符串
    let sb = new StringBuilder();
    arr.forEach((value) => {
      sb.append(('00' + value.toString(16)).slice(-2));
    });
    return sb.toString();
  }


  /**
   * 字节流转成可理解的字符串
   * @param array Uint8Array数组
   * @returns 字符串
   */
  static unit8ArrayToString(array: Uint8Array): string {
    let sb = new StringBuilder();
    for (let i = 0; i < array.length; i++) {
      sb.append(String.fromCharCode(array[i]));
    }
    return sb.toString();
  }

  /**
   * 字符串转换为Uint8Array数组
   * @param str  字符串
   * @returns Uint8Array数组
   */
  static stringToByteArray(str: string): Uint8Array {
    const hexString = str.match(/.{1,2}/g); // 将字符串按每两个字符分割为数组
    let arr = new Array<string>();
    hexString?.forEach((val) => {
      arr.push(val);
    })
    const byteArray: number[] = arr.map(byte => parseInt(byte, 16)); // 将每个十六进制字节转换为整数
    return new Uint8Array(byteArray);
  }

  /**
   * 可理解的字符串转成字节流
   * @param str  字符串
   * @returns Uint8Array字节流
   */
  static stringToUnit8Array(str: string): Uint8Array {
    let arr = Array<number>();
    for (let i = 0, j = str.length; i < j; ++i) {
      arr.push(str.charCodeAt(i));
    }
    return new Uint8Array(arr);
  }
}