/**
 * @Author csx
 * @DateTime 2023/12/29 20:07
 * @TODO ArrayUtil  数组工具类
 */
import { StrUtil } from './StrUtil'

export class ArrayUtil {

  /**
   *集合为空时传入默认集合
   * @param array 判断的集合
   * @param defaultArray   默认的集合
   * @returns
   */
  static defaultIfEmpty<T>(array: T[], defaultArray: T[]): T[] {
    return ArrayUtil.isEmpty(array) ? defaultArray : array;
  }

  /**
   *集合是否为空集合，不空为true否则false
   * @param array
   * @returns
   */
  static isNotEmpty<T>(array: T[]): boolean {
    return null != array && array.length != 0;
  }

  /**
   *集合是否为空集合,空为true否则false
   * @param array
   * @returns
   */
  static isEmpty<T>(array: T[]): boolean {
    return array == null || array.length == 0;
  }

  /**
   *集合中每个值都为空则返回true,否则返回false
   * @param array
   * @returns
   */
  static strValIsEmpty(array: string[]): boolean {
    let flag: boolean = true;
    array.forEach(item => {
      if (StrUtil.isNotBlank(item)) {
        flag = false;
      }
    })
    return flag;
  }

  /**
   *集合中只要有一个值不为空则返回true,否则返回false
   * @param array
   * @returns
   */
  static strValIsNotEmpty(array: string[]): boolean {
    return !ArrayUtil.strValIsEmpty(array);
  }
}

