/**
 * @Author csx
 * @DateTime 2023/12/29 20:10
 * @TODO JSONUtil   各种json转换工具类
 */
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
        result[key] = this.formatDate(value, dateFormat);
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
          jsonObj[key] = this.formatDate(value, dateFormat);
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

  static formatDate(value: string, format: string = 'yyyy-MM-dd'): string {
    const date = new Date(value);
    const year = date.getFullYear();
    const month = this.padZero(date.getMonth() + 1);
    const day = this.padZero(date.getDate());
    const hour = this.padZero(date.getHours());
    const minute = this.padZero(date.getMinutes());
    const second = this.padZero(date.getSeconds());
    let result;
    if (this.hasSecondUsingRegExp(value)) {
      result = format.replace('yyyy', year.toString())
        .replace('MM', month)
        .replace('dd', day)
        .replace('HH', hour)
        .replace('mm', minute)
        .replace('ss', second);
    } else if (this.hasMinuteUsingRegExp(value)) {
      result = format.replace('yyyy', year.toString())
        .replace('MM', month)
        .replace('dd', day)
        .replace('HH', hour)
        .replace('mm', minute);
    } else if (this.hasHourUsingRegExp(value)) {
      result = format.replace('yyyy', year.toString())
        .replace('MM', month)
        .replace('dd', day)
        .replace('HH', hour);
    } else {
      result = format.replace('yyyy', year.toString())
        .replace('MM', month)
        .replace('dd', day)
        .replace('HH', '00')
        .replace('mm', '00')
        .replace('ss', '00');
    }
    return result;
  }

  static hasHourUsingRegExp(dateString) {
    const pattern = /(?:\d{1,2}:)/;
    return pattern.test(dateString);
  }

  static hasMinuteUsingRegExp(dateString) {
    const pattern = /(?:\d{1,2}:\d{2})/;
    return pattern.test(dateString);
  }

  static hasSecondUsingRegExp(dateString) {
    const pattern = /(?:\d{1,2}:\d{2}:\d{2})/;
    return pattern.test(dateString);
  }

  static padZero(value: number): string {
    return value.toString().padStart(2, '0');
  }
}