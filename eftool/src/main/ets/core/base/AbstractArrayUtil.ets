/**
 * @Author csx
 * @DateTime 2023/12/29 20:15
 * @TODO AbstractArrayUtil  抽象基础数组工具类
 */
export class AbstractArrayUtil {
  static readonly INDEX_NOT_FOUND: number = -1;

  AbstractArrayUtil() {
  }

  static isEmpty(array: bigint[] | number[] | string[] | object[]): boolean {
    return array == null || array.length == 0;
  }

  static isNotEmpty(array: bigint[] | number[] | string[] | object[]) {
    return !AbstractArrayUtil.isEmpty(array);
  }

}