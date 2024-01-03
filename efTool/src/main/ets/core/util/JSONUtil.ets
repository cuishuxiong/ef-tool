/**
 * @Author csx
 * @DateTime 2023/12/29 20:10
 * @TODO JSONUtil   各种json转换工具类
 */

import { DateUtil } from './DateUtil'

export class JSONUtil {
  static toJSONString(object: Object): string {
    return JSON.stringify(object);
  }

  static parse(jsonStr: string): Object {
    return JSON.parse(jsonStr);
  }

  static parseObject<T>(jsonStr: string, dateFormat?: string): T {
    let result = {};
    let json = JSON.parse(jsonStr);
    for (const key in json) {
      let value = json[key];
      if (typeof value === 'object' && value !== null) {
        // @ts-ignore
        result[key] = JSON.stringify(value);
      } else if (this.isDate(value)) {
        // @ts-ignore
        result[key] = DateUtil.formatDate(value, dateFormat);
      } else {
        result[key] = value;
      }
    }
    return result as T;
  }

  static parseArray<T>(jsonStr: string, dateFormat?: string): Array<T> {
    let result: Array<T> = new Array<T>();
    let arr = JSON.parse(jsonStr);
    let jsonObj = {};
    for (let index = 0; index < arr.length; index++) {
      const item = arr[index];
      for (const key in item) {
        let value = item[key];
        if (typeof value === 'object' && value !== null) {
          // @ts-ignore
          jsonObj[key] = JSON.stringify(value);
        } else if (this.isDate(value)) {
          // @ts-ignore
          jsonObj[key] = DateUtil.formatDate(value, dateFormat);
        } else {
          jsonObj[key] = value;
        }
      }
      result.push(JSON.parse(JSON.stringify(jsonObj)) as T);
    }
    return result;
  }

  static isDate(value: any): value is Date {
    return value instanceof Date || (typeof value === 'string' && !isNaN(Date.parse(value)));
  }
}