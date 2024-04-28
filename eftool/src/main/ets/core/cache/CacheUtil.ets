/**
 * @Author csx
 * @DateTime 2024/2/22 11:21:02
 * @TODO CacheUtil 缓存工具类
 */
export namespace CacheUtil {

  /**
   * 私有缓存对象
   */
  const cache: Record<string, Object> = {};


  /**
   * 存值
   * @param key  存入key
   * @param value  存入数据
   */
  export function save<T>(key: string, value: T): void {
    cache[key] = value as Object;
  }

  /**
   * 取值
   * @param key   存入的key
   * @returns
   */
  export function get<T>(key: string): T {
    return cache[key] as T;
  }

}
