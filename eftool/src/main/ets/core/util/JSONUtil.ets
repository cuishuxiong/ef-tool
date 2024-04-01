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
  // static toJSONString(object: Object): string {
  //   const stringifyValue = (value: Object): string => {
  //     if (value instanceof Map) {
  //       let jsonObject: Record<string, Object> = {};
  //       value.forEach((val: string, key: Object) => {
  //         if (key !== undefined && val !== undefined) {
  //           jsonObject[key as string] = stringifyValue(val);
  //         }
  //       });
  //       return JSON.stringify(jsonObject);
  //     } else if (Array.isArray(value)) {
  //       let a: Object[] = value.map((item: Object) => stringifyValue(item));
  //       return JSON.stringify(a);
  //     } else if (value instanceof Date) {
  //       return DateUtil.format(value, DateConst.YMD_HLINE);
  //     } else if (typeof value === 'object') {
  //       let result: Record<string, Object> = {};
  //       for (let key of Object.entries(value)) {
  //         result[key[0]] = stringifyValue(key[1]);
  //       }
  //       return JSON.stringify(result);
  //     } else if (typeof value === 'number') {
  //       return new String(value).toString();
  //     } else {
  //       return value;
  //     }
  //   };
  //
  //   if (Array.isArray(object)) {
  //     return JSON.stringify(object.map((item: Object) => stringifyValue(item)));
  //   } else {
  //     return JSON.stringify(stringifyValue(object));
  //   }
  // }


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
  static parseObject<T>(jsonStr: string): T {
    const parseValue = (value: Object): Object => {
      if (typeof value === 'object' && value !== null) {
        return JSONUtil.parseObject(JSON.stringify(value));
      } else if (typeof value === 'number') {
        return new Number(value);
      } else if (JSONUtil.isDate(value)) {
        return DateUtil.formatDate(value as string, DateConst.YMD_HLINE);
      } else {
        return value;
      }
    };
    let result: Record<string, Object> = {};
    let json: Record<string, Object> = JSON.parse(jsonStr);
    for (let key of Object.entries(json)) {
      let value = key[1];
      if (Array.isArray(value)) {
        result[0] = parseValue(value) as [];
      } else {
        result[0] = parseValue(value);
      }
    }
    return result as T;
  }


  // /**
  //  * 将传入的json字符串格式化为指定的实体对象集合
  //  * @param jsonStr
  //  * @returns
  //  */
  // static parseArray<T>(jsonStr: string): Array<T> {
  //   let result: Array<T> = new Array<T>();
  //   let arr: Record<string, Object> = JSON.parse(jsonStr);
  //   for (let index = 0; index < arr.length; index++) {
  //     const item = arr[index];
  //     result.push(item as T);
  //   }
  //   return result;
  // }
  //
  // /**
  //  * 将传入的json字符串格式化为指定的实体对象集合，如果实体中有日期类型可以传入格式化format,不传默认为yyyy-MM-dd
  //  * @param jsonStr
  //  * @param dateFormat 日期格式化字符串
  //  * @returns
  //  */
  // static parseArrayDT<T>(jsonStr: string, dateFormat?: string): Array<T> {
  //   let result: Array<T> = new Array<T>();
  //   let arr: Record<string, Object> = JSON.parse(jsonStr);
  //   let jsonObj: Record<string, Object> = {};
  //   for (let index = 0; index < arr.length; index++) {
  //     const item = arr[index];
  //     for (const key 0f Object.entries(item)) {
  //       let value:Object = key[1];
  //       if (typeof value === 'object' && value !== null) {
  //         jsonObj[key] = JSON.stringify(value);
  //       } else if (this.isDate(value)) {
  //         jsonObj[key] = DateUtil.formatDate(value, dateFormat);
  //       } else {
  //         jsonObj[key] = value;
  //       }
  //     }
  //     result.push(JSON.parse(JSON.stringify(jsonObj)) as T);
  //   }
  //   return result;
  // }
  //
  private static isDate(value: string | Object): boolean {
    return value instanceof Date || (typeof value === 'string' && !isNaN(new Date(value).getTime()));
  }
}