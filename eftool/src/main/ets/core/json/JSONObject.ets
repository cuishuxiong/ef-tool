/**
 * @Author csx
 * @DateTime 2024/4/25 19:25:04
 * @TODO JSONObject  定义json对象
 */
import { JSONValue } from './JSONValue';
import { HashMap } from '@kit.ArkTS';
import { JSONArray } from './JSONArray';
import { StringBuilder } from '../base/StringBuilder';
import { CommonConst as Const } from '../const/CommonConst';
import { DateUtil } from '../util/DateUtil';
import { DateConst } from '../const/DateConst';

export class JSONObject extends HashMap<string, JSONValue> {
  /**
   * 将本对象转换成json字符串
   * @returns
   */
  public toString(): string {
    //转换的字符串
    let sb: StringBuilder = new StringBuilder();
    //拼接左括号
    sb.append(Const.zkh);
    //获取key的迭代器
    let iter: IterableIterator<string> = this.keys();
    // 是否为第一个字符
    let isFirst: boolean = true;
    //迭代获取值转换成字符串
    for (const key of iter) {
      if (!isFirst) {
        //拼接逗号
        sb.append(Const.dh);
      }
      isFirst = false;
      //获取值
      let val: JSONValue = this.get(key);
      //判断类型
      if (val instanceof JSONObject) {
        sb.append(Const.quot + key + Const.quot + Const.mh + (val as JSONObject).toString());
      } else if (val instanceof JSONArray) {
        sb.append(Const.quot + key + Const.quot + Const.mh + (val as JSONArray).toString());
      } else if (val instanceof Date) {
        sb.append(Const.quot + key + Const.quot + Const.mh + DateUtil.format((val as Date), DateConst.YMD_HLINE_HMS));
      } else if (val instanceof Object) {
        //转换成字符串
        let str = JSON.stringify(val);
        //转换成json对象
        let jVal: Record<string, JSONValue> = JSON.parse(str);
        //接收
        let jo = new JSONObject();
        //循环赋值
        Object.entries(jVal).forEach((item) => {
          jo.set(item[0], item[1]);
        })
        sb.append(Const.quot + key + Const.quot + Const.mh + jo.toString());
      } else if (typeof val === 'string') {
        sb.append(Const.quot + key + Const.quot + Const.mh + Const.quot + val + Const.quot);
      } else if (typeof val === 'number' || typeof val === 'boolean') {
        sb.append(Const.quot + key + Const.quot + Const.mh + val);
      } else {
        continue;
      }
    }
    //拼接右括号
    sb.append(Const.ykh);
    return sb.toString();
  }
}