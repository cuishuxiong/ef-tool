/**
 Copyright 2024 csx - @yunkss/eftool

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

import dataPreferences from '@ohos.data.preferences';
import { BusinessError } from '@kit.BasicServicesKit';
import { preferences } from '@kit.ArkData';

/**
 * @Author 幻凡ss
 * @DateTime 2024/7/4 00:12
 * @TODO PrefUtil  首选项工具类
 */
export class PrefUtil {
  /**
   * 全局缓存
   */
  private static pref: dataPreferences.Preferences | null = null
  /**
   * 默认首选项名称
   */
  private static prefName: string = 'ef_data' //首选项默认名字
  /**
   * 首选项初始化
   * @param context
   * @param name
   */
  static init(name?: string) {
    if (name) {
      PrefUtil.prefName = name;
    }
    PrefUtil.pref = dataPreferences.getPreferencesSync(getContext(), { name: PrefUtil.prefName })
  }

  private static getStore(): dataPreferences.Preferences | null {
    if (PrefUtil.pref) {
      return PrefUtil.pref
    }
    return null
  }


  /**
   * 根据KEY获取value  对象
   * @param key
   * @param def  默认返回对象，建议空对象
   * @param T  返回类型
   */
  static getValueT<T>(key: string, def: T): T {
    const defStore = PrefUtil.getStore()
    const res = defStore?.getSync(key, '')
    if (!res) {
      return def
    } else {
      return JSON.parse(res as string) as T
    }
  }

  /**
   * 根据KEY获取value  字符串
   * @param key
   * @returns value
   */
  static getValueStr(key: string): string {
    const defStore = PrefUtil.getStore()
    return defStore?.getSync(key, '') as string
  }

  /**
   * 根据KEY设置 value
   * @param key
   * @param value
   */
  static setValue(key: string, value: preferences.ValueType): void {
    console.info('PrefUtil setValue {' + key + '} start')
    const defStore = PrefUtil.getStore()
    defStore?.putSync(key, value)
    defStore?.flush()
  }


  /**
   * 根据KEY删除
   * @param key
   */
  static delValue(key: string): void {
    console.info('PrefUtil delValue {' + key + '} start')
    const defStore = PrefUtil.getStore()
    defStore?.deleteSync(key)
    defStore?.flush()
  }

  /*
   * 获取首选项 默认Store里的所有数据
   */
  static getDefDataAll(): string[] {
    console.info('PrefUtil delValue  start')
    const defStore = PrefUtil.getStore()
    return defStore?.getAllSync() as string[]
  }

  /*
   * 销毁默认store
   */
  static delDefStroePrimose(context: Context, storeName?: string): Promise<boolean> {
    let prefName: string = PrefUtil.prefName
    if (storeName !== undefined && storeName !== '') {
      prefName = storeName
    }
    console.info('PrefUtil delDefStroePrimose {' + prefName + '} start')
    return new Promise<boolean>((resolve) => {
      dataPreferences.deletePreferences(context, prefName, (err: BusinessError) => {
        if (err) {
          console.info('PrefUtil delDefStroePrimose delete {' + prefName + '} failed :' + err.message)
          resolve(false)
        }
        console.info('PrefUtil delDefStroePrimose delete {' + prefName + '} Succeeded')
        PrefUtil.pref = null
        resolve(true)
      })
    })
  }
}