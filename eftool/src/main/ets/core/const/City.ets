/**
 * @Author csx
 * @DateTime 2024/3/16 11:25
 * @TODO City 省市区实体类
 */
export class City {
  name: string;
  code: string;
  children?: Array<City>;

  constructor(name: string, code: string, child?: Array<City>) {
    this.name = name;
    this.code = code;
    this.children = child;
  }
}