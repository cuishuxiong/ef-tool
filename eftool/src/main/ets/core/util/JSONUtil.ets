/**
 * @Author csx
 * @DateTime 2023/12/29 20:10
 * @TODO JSONUtil   各种json转换工具类
 */
import { DateConst } from '../const/DateConst';
import { DateUtil } from './DateUtil'

export class JSONUtil {
  /**
   * 将传入的json对象格式化成json字符串
   * @param object
   * @returns
   */
  static toJSONString(object: any): string {
    const stringifyValue = (value: any): any => {
      if (value instanceof Map) {
        let jsonObject: Record<string, any> = {};
        value.forEach((val, key) => {
          if (key !== undefined && val !== undefined) {
            jsonObject[key] = stringifyValue(val);
          }
        });
        return jsonObject;
      } else if (Array.isArray(value)) {
        return value.map(item => stringifyValue(item));
      } else if (value instanceof Date) {
        return DateUtil.format(value, DateConst.YMD_HLINE);
      } else if (typeof value === 'object') {
        let result: Record<string, any> = {};
        for (const key in value) {
          result[key] = stringifyValue(value[key]);
        }
        return result;
      } else if (value instanceof Number) {
        return new Number(value);
      } else {
        return value;
      }
    };

    if (Array.isArray(object)) {
      return JSON.stringify(object.map(item => stringifyValue(item)));
    } else {
      return JSON.stringify(stringifyValue(object));
    }
  }

  /**
   *将传入的json字符串格式化为Object对象
   * @param jsonStr
   * @returns
   */
  static parse(jsonStr: string): Object {
    return JSON.parse(jsonStr);
  }

  /**
   * 将传入的json字符串格式化为指定的实体对象,如果实体中有日期类型可以传入格式化format,不传默认为yyyy-MM-dd，并且支持嵌套类
   * @param jsonStr
   * @param dateFormat  日期格式化字符串
   * @returns
   */
  static parseObject<T>(jsonStr: string, dateFormat?: string): T {
    const parseValue = (value: any, dateFormat: string | undefined): any => {
      if (typeof value === 'object' && value !== null) {
        return this.parseObject(JSON.stringify(value), dateFormat);
      } else if (value instanceof Number) {
        return new Number(value);
      } else if (this.isDate(value)) {
        if (!dateFormat) {
          dateFormat = DateConst.YMD_HLINE
        }
        return DateUtil.formatDate(value, dateFormat);
      } else {
        return value;
      }
    };
    let result: any = {};
    let json = JSON.parse(jsonStr);
    for (const key in json) {
      let value = json[key];
      result[key] = parseValue(value, dateFormat);
    }
    return result as T;
  }


  /**
   * 将传入的json字符串格式化为指定的实体对象集合
   * @param jsonStr
   * @returns
   */
  static parseArray<T>(jsonStr: string): Array<T> {
    let result: Array<T> = new Array<T>();
    let arr = JSON.parse(jsonStr);
    for (let index = 0; index < arr.length; index++) {
      const item = arr[index];
      result.push(item as T);
    }
    return result;
  }

  /**
   * 将传入的json字符串格式化为指定的实体对象集合，如果实体中有日期类型可以传入格式化format,不传默认为yyyy-MM-dd
   * @param jsonStr
   * @param dateFormat 日期格式化字符串
   * @returns
   */
  static parseArrayDT<T>(jsonStr: string, dateFormat?: string): Array<T> {
    let result: Array<T> = new Array<T>();
    let arr = JSON.parse(jsonStr);
    let jsonObj = {};
    for (let index = 0; index < arr.length; index++) {
      const item = arr[index];
      for (const key in item) {
        let value = item[key];
        if (typeof value === 'object' && value !== null) {
          jsonObj[key] = JSON.stringify(value);
        } else if (this.isDate(value)) {
          jsonObj[key] = DateUtil.formatDate(value, dateFormat);
        } else {
          jsonObj[key] = value;
        }
      }
      result.push(JSON.parse(JSON.stringify(jsonObj)) as T);
    }
    return result;
  }

  private  static isDate(value: any): boolean {
    return value instanceof Date || (typeof value === 'string' && !isNaN(new Date(value).getTime()));
  }
}