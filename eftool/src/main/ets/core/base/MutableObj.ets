/**
 * @Author csx
 * @DateTime 2023/12/29 22:45
 * @TODO MutableObj  可变Object
 */
import { Mutable } from './Mutable';

export class MutableObj<T> implements Mutable<T> {

  /**
   * 构建MutableObj
   * @param value 被包装的值
   * @param <T> 值类型
   * @return MutableObj
   * @since 5.8.0
   */
  public static of<T>(value: T): MutableObj<T> {
    return new MutableObj<T>(value);
  }

  private value: T;

  /**
   * 构造
   */
  constructor(value: T) {
    this.value = value;
  }


  public get(): T {
    return this.value;
  }

  public set(value: T): void {
    this.value = value;
  }

  // public equals(obj: object): boolean {
  //   if (!(obj instanceof MutableObj)) {
  //     return false;
  //   }
  //   return Object.is(this, obj) && Object.is(this.value, (obj as MutableObj<T>).get());
  // }

  public toString(): String {
    return this.value == null ? "null" : this.value.toString();
  }
}