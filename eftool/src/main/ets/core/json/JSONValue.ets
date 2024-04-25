/**
 * @Author csx
 * @DateTime 2024/4/25 19:17:04
 * @TODO JSONValue  定义json值的类型
 */
import { JSONArray } from './JSONArray';
import { JSONObject } from './JSONObject';

export type JSONValue = string | number | boolean | Date | Object | JSONObject | JSONArray ;
