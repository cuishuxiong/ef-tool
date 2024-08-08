/**
 * @Author csx
 * @DateTime 2023/12/29 21:52
 * @TODO StringBuilder
 */
export class StringBuilder {
  private value: (string | number | boolean | null)[];

  constructor() {
    this.value = [];
  }

  append(str: string | number | boolean | null): StringBuilder {
    this.value.push(str);
    return this;
  }


  toString(): string {
    return this.value.join('');
  }
}