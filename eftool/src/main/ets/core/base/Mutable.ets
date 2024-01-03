/**
 * @Author csx
 * @DateTime 2023/12/29 22:40
 * @TODO Mutable 提供可变值类型接口
 */
export interface Mutable<T> {

  /**
   * 获得原始值
   * @return 原始值
   */
  get(): T;

  /**
   * 设置值
   * @param value 值
   */
  set(value: T): void;

}