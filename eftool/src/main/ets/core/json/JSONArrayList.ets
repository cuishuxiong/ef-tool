/**
 * @Author csx
 * @DateTime 2024/4/25 19:35:04
 * @TODO JSONArray  定义json集合
 */
import { StringBuilder } from '../base/StringBuilder';
import { JSONValue } from './JSONValue';
import { CommonConst as Const } from '../const/CommonConst';
import { DateUtil } from '../util/DateUtil';
import { DateConst } from '../const/DateConst';
import { JSONObject } from './JSONObject';
import { ArrayList } from '@kit.ArkTS';
import { JSONArray } from './JSONArray';

export class JSONArrayList extends ArrayList<JSONValue> {
  /**
   * json字符串转换为JSONArrayList对象
   * @param bean 实体对象
   * @returns JSON 对象
   */
  public static parse(jsonStr: string): JSONArrayList {
    let json = new JSONArrayList();
    //转换成json对象
    let jVal: Record<string, JSONValue> = JSON.parse(jsonStr);
    //循环赋值
    Object.entries(jVal).forEach((item) => {
      if (item[1] instanceof JSONObject) {
        json.add(JSONObject.from(item[1]));
      } else if (item[1] instanceof JSONArray) {
        json.add(JSONArray.from(item[1]));
      } else if (item[1] instanceof JSONArrayList) {
        json.add(JSONArrayList.from(item[1]));
      } else if (item[1] instanceof Date) {
        json.add(DateUtil.format(item[1], DateConst.YMD_HLINE_HMS));
      } else if (item[1] instanceof Object) {
        json.add(JSONObject.from(item[1]));
      } else {
        json.add(item[1]);
      }
    })
    return json;
  }

  /**
   * json字符串转换为实体对象【预计1.1.10上线】
   * @param bean 实体对象
   * @returns JSON 对象
   */
  // public static parseObject<T>(jsonStr: string): T {
  //   let json = new JSONArrayList();
  //
  //   return json as T;
  // }

  /**
   * 集合对象转换为json字符串
   * @param bean 实体对象
   * @returns JSON 对象
   */
  public static toJSONString(object: Object): string {
    //转换成字符串
    let str = JSON.stringify(object);
    //转换成json对象
    let jVal: Record<string, JSONValue> = JSON.parse(str);
    let list = new ArrayList<JSONValue>();
    //转换成map
    Object.entries(jVal).forEach(item => {
      list.add(item[1]);
    })
    return new JSONArrayList().convertString(list);
  }

  /**
   * 实体集合转换为JSONArrayList对象
   * @param bean 实体对象
   * @returns JSON 对象
   */
  public static from<T>(bean: T): JSONArrayList {
    let json = new JSONArrayList();
    //转换成字符串
    let str = JSON.stringify(bean);
    //转换成json对象
    let jVal: Record<string, JSONValue> = JSON.parse(str);
    //接收
    //循环赋值
    Object.entries(jVal).forEach((item) => {
      if (item[1] instanceof JSONObject) {
        json.add(JSONObject.from(item[1]));
      } else if (item[1] instanceof JSONArray) {
        json.add(JSONArray.from(item[1]));
      } else if (item[1] instanceof JSONArrayList) {
        json.add(JSONArrayList.from(item[1]));
      } else if (item[1] instanceof Date) {
        json.add(DateUtil.format(item[1], DateConst.YMD_HLINE_HMS));
      } else if (item[1] instanceof Object) {
        json.add(JSONObject.from(item[1]));
      } else if (typeof item[1] === 'string') {
        if (DateUtil.isDate(item[1])) {
          json.add(DateUtil.formatDate(item[1], DateConst.YMD_HLINE_HMS));
        } else {
          json.add(item[1]);
        }
      } else {
        json.add(item[1]);
      }
    })
    return json;
  }


  /**
   * 迭代获取
   * @param arr
   * @returns
   */
  private convertString(arr: ArrayList<JSONValue>): string {
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
      } else if (item instanceof JSONArrayList) {
        sb.append(JSONArrayList.toJSONString(item));
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
    return new JSONArrayList().convertString(this);
  }
}