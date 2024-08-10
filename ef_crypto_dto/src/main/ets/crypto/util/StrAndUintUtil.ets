/**
 * @Author csx
 * @DateTime 2024/3/18 21:29
 * @TODO StrAndUintUtil 字符串和Uint8Array工具类
 */
import { StringBuilder, Base64Util } from '@yunkss/ef_core';
import { buffer } from '@kit.ArkTS';

// import { SM2Convert } from '../crypto/encryption/sm2/SM2Convert';

export class StrAndUintUtil {
  /**
   * 字符串转uint8Array
   * @param str  待转换字符串
   * @param coding  转换结果编码
   * @returns
   */
  static str2Uint8Array(str: string, coding: buffer.BufferEncoding) {
    return new Uint8Array(buffer.from(str, coding).buffer);
  }


  /**
   * 将字节流以16进制字符串输出
   * @param arr  Uint8Array数组
   * @param isC1C3C2  是否需要输出为C1C3C2格式的字符串，true需要
   * @returns 字符串
   */
  static unitArray2String(arr: Uint8Array, isC1C3C2?: boolean): string {
    //转换成可以读懂的字符串
    let asn1Str = buffer.from(arr).toString('hex');
    // if (isC1C3C2) {
    //   asn1Str = new SM2Convert().d2i(asn1Str);
    // }
    return asn1Str;
  }

  /**
   * 将字节流以16进制字符串输出-入参编码格式
   * @param arr  Uint8Array数组
   * @param coding
   * @returns 字符串
   */
  static unitArray2StrCoding(arr: Uint8Array, coding: buffer.BufferEncoding): string {
    return buffer.from(arr).toString(coding);
  }

  /**
   * 字节流转成可理解的字符串
   * @param array Uint8Array数组
   * @param isC1C3C2  是否需要输出为C1C3C2格式的字符串，true需要
   * @returns 字符串
   */
  static unit8ArrayToString(array: Uint8Array, isC1C3C2?: boolean): string {
    let sb = new StringBuilder();
    for (let i = 0; i < array.length; i++) {
      sb.append(String.fromCharCode(array[i]));
    }
    let asn1Str = sb.toString();
    // if (isC1C3C2) {
    //   asn1Str = new SM2Convert().d2i(asn1Str);
    // }
    return asn1Str;
  }

  /**
   * 将字符串转换成uint8Array-加解密key
   * @param str  字符串
   * @param keyLen  编码长度
   * @param keyCoding key的编码格式
   * @returns
   */
  static strKey2Uint8Array(str: string, keyLen: number, keyCoding: buffer.BufferEncoding): Uint8Array {
    //判断编码类型
    if (keyCoding === 'base64') {
      //base64
      // let base64Arr = Base64Util.decodeSync(str);
      return Base64Util.decodeSync(str);
      // if (base64Arr.length != keyLen / 8) {
      //需要
      //转换成hex字符串
      // let str1 = buffer.from(base64Arr).toString('hex');
      // const hexString = str1.match(/.{1,2}/g); // 将字符串按每两个字符分割为数组
      // let arr = new Array<string>();
      // hexString?.forEach((val) => {
      //   arr.push(val);
      // })
      // let byteArray: number[] = arr.map(byte => parseInt(byte, 16)); // 将每个十六进制字节转换为整数
      // if (byteArray.length === base64Arr.length) {
      //   //说明是utf8字符串
      //   str1 = buffer.from(base64Arr).toString('utf8');
      //   const hexString = str1.match(/.{1,2}/g); // 将字符串按每两个字符分割为数组
      //   arr = new Array<string>();
      //   hexString?.forEach((val) => {
      //     arr.push(val);
      //   })
      //   byteArray = arr.map(byte => parseInt(byte, 16));
      // }
      // return new Uint8Array(byteArray);
      // }
      // return base64Arr;
    }
    if (keyCoding === 'hex') {
      let arr = StrAndUintUtil.str2Uint8Array(str, 'hex');
      return StrAndUintUtil.arrNeedSplit(arr, str, keyLen);
    }
    if (keyCoding === 'utf8') {
      let arr = StrAndUintUtil.str2Uint8Array(str, 'utf8');
      return StrAndUintUtil.arrNeedSplit(arr, str, keyLen);
    }
    return new Uint8Array(buffer.from(str).buffer);
  }


  /**
   * 将字符串转换成uint8Array-加解密内容
   * @param str  字符串
   * @param keyLen  编码长度
   * @returns
   */
  static strContent2Uint8Array(str: string, coding: buffer.BufferEncoding): Uint8Array {
    //判断编码类型
    if (coding === 'base64') {
      //base64
      return Base64Util.decodeSync(str);
    }
    if (coding === 'hex') {
      return StrAndUintUtil.str2Uint8Array(str, 'hex');
    }
    if (coding === 'utf8') {
      return StrAndUintUtil.str2Uint8Array(str, 'utf8');
    }
    return new Uint8Array(buffer.from(str).buffer);
  }


  /**
   * 判断数组是否需要截取
   * @param arr  判断的数组
   * @param str  源字符串
   * @param keyLen  编码长度
   * @returns
   */
  static arrNeedSplit(arr: Uint8Array, str: string, keyLen: number): Uint8Array {
    if (arr.length != keyLen / 8) {
      //需要截取
      const hexString = str.match(/.{1,2}/g); // 将字符串按每两个字符分割为数组
      let arr = new Array<string>();
      hexString?.forEach((val) => {
        arr.push(val);
      })
      let byteArray: number[] = arr.map(byte => parseInt(byte, 16)); // 将每个十六进制字节转换为整数
      if (byteArray.length == 0) {
        let emptyArr = new Array<number>();
        for (let i = 0; i < keyLen / 8; i++) {
          emptyArr.push(0);
        }
        byteArray = emptyArr;
      }
      return new Uint8Array(byteArray);
    }
    return arr;
  }


  /**
   * 字符串转换为Uint8Array数组
   * @param str  字符串C1C3C2格式的,true为是
   * @param keyName 密钥长度
   * @param isC1C3C2 传入的字符串是否为
   * @returns Uint8Array数组
   */
  static stringToByteArray(str: string, keyName: number, isC1C3C2?: boolean): Uint8Array {
    // if (isC1C3C2) {
    //   str = new SM2Convert().i2dSM2(str);
    // }
    //判断是否为HarmonyOS自己生成的字符串,只包含小写a-z和数字
    if (str.length != keyName / 8) {
      const hexString = str.match(/.{1,2}/g); // 将字符串按每两个字符分割为数组
      let arr = new Array<string>();
      hexString?.forEach((val) => {
        arr.push(val);
      })
      let byteArray: number[] = arr.map(byte => parseInt(byte, 16)); // 将每个十六进制字节转换为整数
      if (byteArray.length == 0) {
        let emptyArr = new Array<number>();
        for (let i = 0; i < keyName / 8; i++) {
          emptyArr.push(0);
        }
        byteArray = emptyArr;
      }
      return new Uint8Array(byteArray);
    } else {
      return new Uint8Array(buffer.from(str, 'utf-8').buffer);
    }
  }

  /**
   * 可理解的字符串转成字节流
   * @param str  字符串
   * @param str  字符串C1C3C2格式的,true为是
   * @returns Uint8Array字节流
   */
  static stringToUnit8Array(str: string, isC1C3C2?: boolean): Uint8Array {
    // if (isC1C3C2) {
    //   str = new SM2Convert().i2dSM2(str);
    // }
    let arr = Array<number>();
    for (let i = 0, j = str.length; i < j; ++i) {
      arr.push(str.charCodeAt(i));
    }
    return new Uint8Array(arr);
  }
}