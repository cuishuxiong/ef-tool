/**
 * @Author csx
 * @DateTime 2023/12/29 20:07
 * @TODO ArrayUtil  数组工具类
 */
import { StrUtil } from './StrUtil'

export class ArrayUtil {

  static defaultIfEmpty<T>(array: T[], defaultArray: T[]): T[] {
    return ArrayUtil.isEmpty(array) ? defaultArray : array;
  }

  static isNotEmpty<T>(array: T[]): boolean {
    return null != array && array.length != 0;
  }

  static isEmpty<T>(array: T[]): boolean {
    return array == null || array.length == 0;
  }

  static strValIsEmpty(array: string[]): boolean {
    let flag: boolean = true;
    array.forEach(item => {
      if (StrUtil.isNotBlank(item)) {
        flag = false;
      }
    })
    return flag;
  }

  static strValIsNotEmpty(array: string[]): boolean {
    return !ArrayUtil.strValIsEmpty(array);
  }
}

