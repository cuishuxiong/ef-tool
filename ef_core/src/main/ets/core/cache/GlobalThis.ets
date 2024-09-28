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

import { common } from '@kit.AbilityKit';

/**
 * @Author csx
 * @DateTime 2024/7/29 11:04:59
 * @TODO GlobalThis  全局替换版本GlobalThis 单例对象
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_core
 */
export class GlobalThis {
  private constructor() {
  };

  /**
   * 私有单例对象
   */
  private static instance: GlobalThis;
  /**
   * 私有UI对象
   */
  private _uiContexts = new Map<string, common.UIAbilityContext>();
  /**
   * 私有值
   */
  private value = '';

  /**
   * 获取全局实例
   * @returns
   */
  public static getInstance(): GlobalThis {
    if (!GlobalThis.instance) {
      GlobalThis.instance = new GlobalThis();
    }
    return GlobalThis.instance;
  }

  /**
   * 获取上下文
   * @param key
   * @returns
   */
  getContext(key: string): common.UIAbilityContext | undefined {
    return this._uiContexts.get(key);
  }

  /**
   * 设置上下文
   * @param key
   * @param value
   */
  setContext(key: string, value: common.UIAbilityContext): void {
    this._uiContexts.set(key, value);
  }

  /**
   * 设置值
   * @param value
   */
  setValue(value: string) {
    this.value = value
  }

  /**
   * 获取值
   * @returns
   */
  getValue(): string {
    return this.value;
  }
}