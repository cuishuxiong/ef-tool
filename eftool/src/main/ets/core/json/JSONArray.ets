/**
 * @Author csx
 * @DateTime 2024/4/25 19:35:04
 * @TODO JSONArray  定义json集合
 */
import { StringBuilder } from '../base/StringBuilder';
import { JSONValue } from './JSONValue';
import { CommonConst as Const } from '../const/CommonConst';
import { JSONObject } from './JSONObject';
import { JSONArrayList } from './JSONArrayList';
import { DateUtil } from '../util/DateUtil';
import { DateConst } from '../const/DateConst';

export class JSONArray extends Array<JSONValue> {
  /**
   * json字符串转换为JSONObject对象
   * @param bean 实体对象
   * @returns JSON 对象
   */
  public static parse(jsonStr: string): JSONArray {
    let json = new JSONArray();
    //转换成json对象
    let jVal: Record<string, JSONValue> = JSON.parse(jsonStr);
    //循环赋值
    Object.entries(jVal).forEach((item) => {
      if (item[1] instanceof JSONObject) {
        json.push(JSONObject.from(item[1]));
      } else if (item[1] instanceof JSONArray) {
        json.push(JSONArray.from(item[1]));
      } else if (item[1] instanceof JSONArrayList) {
        json.push(JSONArrayList.from(item[1]));
      } else if (item[1] instanceof Date) {
        json.push(DateUtil.format(item[1], DateConst.YMD_HLINE_HMS));
      } else if (item[1] instanceof Object) {
        json.push(JSONObject.from(item[1]));
      } else {
        json.push(item[1]);
      }
    })
    return json;
  }

  /**
   * json字符串转换为实体对象
   * @param bean 实体对象
   * @returns JSON 对象
   */
  public static parseObject<T>(jsonStr: string): T {
    let json = new JSONArray();

    return json as T;
  }

  /**
   * json字符串转换为实体对象
   * @param bean 实体对象
   * @returns JSON 对象
   */
  public static toJSONString(object: Object): string {
    //转换成字符串
    let str = JSON.stringify(object);
    //转换成json对象
    let jVal: Record<string, JSONValue> = JSON.parse(str);
    let list = new Array<JSONValue>();
    //转换成map
    Object.entries(jVal).forEach(item => {
      list.push(item[1]);
    })
    return new JSONArray().convertString(list);
  }

  /**
   * 实体对象转换为JSONObject对象
   * @param bean 实体对象
   * @returns JSON 对象
   */
  public static from<T>(bean: T): JSONArray {
    let json = new JSONArray();
    //转换成字符串
    let str = JSON.stringify(bean);
    //转换成json对象
    let jVal: Record<string, JSONValue> = JSON.parse(str);
    //接收
    //循环赋值
    Object.entries(jVal).forEach((item) => {
      if (item[1] instanceof JSONObject) {
        json.push(JSONObject.from(item[1]));
      } else if (item[1] instanceof JSONArray) {
        json.push(JSONArray.from(item[1]));
      } else if (item[1] instanceof JSONArrayList) {
        json.push(JSONArrayList.from(item[1]));
      } else if (item[1] instanceof Date) {
        json.push(DateUtil.format(item[1], DateConst.YMD_HLINE_HMS));
      } else if (item[1] instanceof Object) {
        json.push(JSONObject.from(item[1]));
      } else if (typeof item[1] === 'string') {
        if (DateUtil.isDate(item[1])) {
          json.push(DateUtil.formatDate(item[1], DateConst.YMD_HLINE_HMS));
        } else {
          json.push(item[1]);
        }
      } else {
        json.push(item[1]);
      }
    })
    return json;
  }

  /**
   * 迭代获取
   * @param arr
   * @returns
   */
  private convertString(arr: Array<JSONValue>): string {
    //转换的字符串
    let sb: StringBuilder = new StringBuilder();
    //拼接左括号
    sb.append(Const.zzkh);
    // 是否为第一个字符
    let isFirst: boolean = true;
    //迭代获取值转换成字符串
    arr.forEach((item: JSONValue) => {
      if (!isFirst) {
        //拼接逗号
        sb.append(Const.dh);
      }
      isFirst = false;
      //获取值
      if (item == null) {
        sb.append(null);
      } else if (item instanceof Date) {
        sb.append(DateUtil.format((item as Date), DateConst.YMD_HLINE_HMS));
      } else if (item instanceof JSONArray) {
        sb.append(JSONArray.toJSONString(item));
      } else if (item instanceof JSONArrayList) {
        sb.append(JSONArrayList.toJSONString(item));
      } else if (item instanceof JSONObject || item instanceof Object) {
        sb.append(JSONObject.toJSONString(item));
      } else if (typeof item === 'string') {
        if (DateUtil.isDate(item)) {
          sb.append(DateUtil.formatDate(item, DateConst.YMD_HLINE_HMS));
        } else {
          sb.append(Const.quot + item + Const.quot);
        }
      } else {
        sb.append(item);
      }
    });
    //拼接右括号
    sb.append(Const.yzkh);
    return sb.toString();
  }

  /**
   * 将本对象转换成json字符串
   * @returns
   */
  public toString(): string {
    return new JSONArray().convertString(this);
  }
}