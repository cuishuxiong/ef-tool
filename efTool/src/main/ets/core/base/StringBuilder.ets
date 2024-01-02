/**
 * @Author csx
 * @DateTime 2023/12/29 21:52
 * @TODO StringBuilder
 */
export class StringBuilder {
  private value: string[];

  constructor() {
    this.value = [];
  }

  append(str: string | number): StringBuilder {
    this.value.push(String(str));
    return this;
  }


  toString(): string {
    return this.value.join('');
  }
}