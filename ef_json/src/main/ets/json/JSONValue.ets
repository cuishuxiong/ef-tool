/**
 Copyright 2024 csx - @yunkss/ef_json

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */


import { JSONArray } from './JSONArray';
import { JSONArrayList } from './JSONArrayList';
import { JSONObject } from './JSONObject';

/**
 * @Author csx
 * @DateTime 2024/4/25 19:17:04
 * @TODO JSONValue  定义json值的类型
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_json
 */
export type JSONValue = string | number | boolean | Date | Object | JSONObject | JSONArray | JSONArrayList | null;
