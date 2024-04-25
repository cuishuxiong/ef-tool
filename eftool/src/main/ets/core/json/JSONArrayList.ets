/**
 * @Author csx
 * @DateTime 2024/4/25 19:35:04
 * @TODO JSONArray  定义json集合
 */
import { ArrayList } from '@kit.ArkTS';
import { JSONValue } from './JSONValue';

export class JSONArrayList extends ArrayList<JSONValue> {
  static bean2JSONArray(arg0: JSONArrayList): JSONValue {
    throw new Error('Method not implemented.');
  }
}