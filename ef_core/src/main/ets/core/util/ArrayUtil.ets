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

  /**
   * 将新元素添加到已有数组中 添加新元素会生成一个新的数组，不影响原数组
   * @param source
   * @param item
   * @returns
   */
  static append<T>(source: T[], item: T | T[]): T[] {
    if (Array.isArray(item)) {
      return [...source, ...item];
    } else {
      return [...source, item];
    }
  }

  /**
   * 将元素值设置为数组的某个位置，当给定的index大于数组长度，则追加
   *
   * @param <T>    数组元素类型
   * @param buffer 已有数组
   * @param index  位置，大于长度追加，否则替换
   * @param value  新值
   * @return 新数组或原有数组
   */
  static setOrAppend<T>(buffer: T[], index: number, value: T): T[] {
    if (index < 0) {
      return [value, ...buffer];
    } else if (index >= buffer.length) {
      return [...buffer, value];
    } else {
      return buffer.map((item, i) => (i === index ? value : item));
    }
  }

  /**
   * 将新元素插入到到已有数组中的某个位置<br>
   * 添加新元素会生成一个新数组或原有数组<br>
   * 如果插入位置为为负数，那么生成一个由插入元素顺序加已有数组顺序的新数组
   *
   * @param <T>    数组元素类型
   * @param buffer 已有数组
   * @param index  位置，大于长度追加，否则替换，&lt;0表示从头部追加
   * @param values 新值
   * @return 新数组或原有数组
   */
  static replace<T>(buffer: T[], index: number, ...values: T[]): T[] {
    if (index < 0) {
      return [...values, ...buffer];
    } else if (index >= buffer.length) {
      return [...buffer, ...values];
    } else {
      return [
        ...buffer.slice(0, index),
        ...values,
        ...buffer.slice(index + 1),
      ];
    }
  }

  /**
   * 克隆数组(深拷贝)
   * @param arr
   * @returns
   */
  // static clone<T>(arr: T[]): T[] {
  //   return arr.map((item) => ArrayUtil.deepClone(item));
  // }

  /**
   * 深拷贝对象T
   * @param obj
   * @returns
   */
  // static deepClone<T>(obj: T): T {
  //   if (obj === null || typeof obj !== "object") {
  //     return obj;
  //   }
  //
  //   if (Array.isArray(obj)) {
  //     return obj.map((item) => ArrayUtil.deepClone(item)) as T;
  //   } else if (obj instanceof Date) {
  //     return new Date(obj.getTime()) as any;
  //   } else if (obj instanceof RegExp) {
  //     return new RegExp(obj.source, obj.flags) as any;
  //   } else {
  //     const result: Record<string, any> = {};
  //     for (const key in obj) {
  //       if (obj.hasOwnProperty(key)) {
  //         result[key] = ArrayUtil.deepClone(obj[key]);
  //       }
  //     }
  //     return result as T;
  //   }
  // }

  /**
   * 通过传入的filter实现来过滤返回需要的元素内容
   * @param array
   * @param filter  过滤函数
   * @returns
   */
  static filter<T>(array: T[], filter: (item: T) => boolean): T[] {
    return filter ? array.filter(filter) : array;
  }

  /**
   * 反转数组，会变更原数组
   *
   * @param <T>                 数组元素类型
   * @param array               数组，会变更
   * @param startIndexInclusive 开始位置（包含） 默认不填为0
   * @param endIndexExclusive   结束位置（不包含）  默认不填为array.length
   * @return 变更后的原数组
   */
  static reverse<T>(array: T[], startIndexInclusive: number = 0, endIndexExclusive: number = array.length): T[] {
    for (let i = startIndexInclusive, j = endIndexExclusive - 1; i < j; i++, j--) {
      let temp = array[j];
      array[j] = array[i];
      array[i] = temp;
    }
    return array;
  }

  /**
   * 根据传入的数值字符串日期数组取最小值
   * @param array
   * @returns
   */
  static min<T extends number | string | Date>(array: T[]): T | null {
    if (array.length === 0) {
      return null;
    }
    let minValue = array[0];
    for (let i = 1; i < array.length; i++) {
      if (array[i] < minValue) {
        minValue = array[i];
      }
    }
    return minValue;
  }

  /**
   * 根据传入的数值字符串日期数组取最大值
   * @param array
   * @returns
   */
  static max<T extends number | string | Date>(array: T[]): T | null {
    if (array.length === 0) {
      return null;
    }
    let maxValue = array[0];
    for (let i = 1; i < array.length; i++) {
      if (array[i] > maxValue) {
        maxValue = array[i];
      }
    }
    return maxValue;
  }

  /**
   * 去重数组中的元素，去重后生成新的数组，原数组不变<br>
   *
   * @param <T>      数组元素类型
   * @param <K>      唯一键类型
   * @param array    数组
   * @param uniqueGenerator 唯一键生成器
   * @param override 是否覆盖模式，如果为{true}，加入的新值会覆盖相同key的旧值，否则会忽略新加值
   * @return 去重后的数组
   */
  static distinct<T, K>(array: Array<T>, uniqueGenerator: (item: T) => K, isOverride: boolean = false,
  ): T[] {
    const resultMap: Map<K, T> = new Map<K, T>();
    for (const item of array) {
      const key: K = uniqueGenerator(item);
      if (isOverride || !resultMap.has(key)

      ) {
        resultMap.set(key, item);
      }
    }
    return Array.from(resultMap.values());
  }

  /**
   * 移除数组中predicate返回为真值的所有元素，并返回移除元素组成的数组
   * @param array 要修改的数组
   * @param predicate  断言
   * @returns 处理后的数组
   */
  static remove<T>(array: T[], predicate?: (value: T, index: number, array: T[]) => boolean): T[] {
    const removed: T[] = [];
    for (let i = array.length - 1; i >= 0; i--) {
      if (predicate && predicate(array[i], i, array)) {
        removed.push(...array.splice(i, 1));
      }
    }
    return removed;
  }

  /**
   * 去除集合中的空值
   * @param arr 待处理的集合
   * @returns 处理后的集合
   */
  static removeEmptyValues(arr: string[]): string[] {
    return arr.filter((value) => value !== null && value !== undefined && value !== '');
  }

  /**
   * 创建一个按顺序排列的唯一值的数组（注：arrays（数组）的并集，按顺序返回，返回数组的元素是唯一的）
   * @param arrays  要检查的数组
   * @returns 返回一个新的联合数组
   */
  static union(...arrays: string[][]): string[] {
    const result: string[] = [];
    for (const arr of arrays) {
      for (const item of arr) {
        if (!result.includes(item)) {
          result.push(item);
        }
      }
    }
    return result;
  }

  /**
   * 创建一个分组元素的数组，数组的第一个元素包含所有给定数组的第一个元素，数组的第二个元素包含所有给定数组的第二个元素，以此类推
   * @param arrays 要处理的数组
   * @returns 返回分组元素的新数组
   */
  // static zip<T>(...arrays: [...T: T[]]): T[][] {
  //   const maxLength = Math.max(...arrays.map(arr => arr.length));
  //   const result: T[][] = [];
  //   for (let i = 0; i < maxLength; i++) {
  //     result[i] = arrays.map(arr => arr[i]);
  //   }
  //   return result;
  // }

  /**
   * 这个方法类似于zip除了它接收分组元素的数组，并且创建一个数组，分组元素到打包前的结构(返回数组的第一个元素包含所有的输入数组的第一元素，第一个元素包含了所有的输入数组的第二元素，依此类推)
   * @param array 要处理的分组元素数组
   * @returns 返回重组元素的新数组
   */
  // static unzip<T extends any[]>(array: T[][]): T[][] {
  //   const maxLength = Math.max(...array.map(arr => arr.length));
  //   const result: T[][] = [];
  //   for (let i = 0; i < maxLength; i++) {
  //     result[i] = array.map(arr => arr[i]);
  //   }
  //   return result;
  // }
}

