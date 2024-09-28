/**
 Copyright 2024 csx - @yunkss/ef_core

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

/**
 * @Author csx
 * @DateTime 2024/2/22 11:21:02
 * @TODO CacheUtil 缓存工具类
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_core
 */
export namespace CacheUtil {

  /**
   * 私有缓存对象
   */
  const cache: Record<string, Object> = {};


  /**
   * 存值
   * @param key  存入key
   * @param value  存入数据
   */
  export function save<T>(key: string, value: T): void {
    cache[key] = value as Object;
  }

  /**
   * 取值
   * @param key   存入的key
   * @returns
   */
  export function get<T>(key: string): T {
    return cache[key] as T;
  }

}
