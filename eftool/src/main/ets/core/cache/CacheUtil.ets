/**
 * @Author csx
 * @DateTime 2024/2/22 11:21:02
 * @TODO CacheUtil 缓存工具类
 */
export namespace CacheUtil {

/**
 * 私有缓存对象
 */
  const cache = createConst();

  /**
   * 创建一个变量
   * @param value
   * @returns
   */
  function createConst<T>(value?: T): { readonly value: T } {
    return { value };
  }

  /**
   * 存值
   * @param key  存入key
   * @param value  存入数据
   */
  export function save<T>(key: string, value: T): void {
    cache[key] = value;
  }

  /**
   * 取值
   * @param key   存入的key
   * @returns
   */
  export function get<T>(key: string): T | undefined {
    return cache[key];
  }
}
