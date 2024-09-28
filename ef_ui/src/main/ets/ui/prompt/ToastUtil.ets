/**
 Copyright 2024 csx - @yunkss/ef_ui

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

import promptAction from '@ohos.promptAction'
import { UiConst as Const } from '@yunkss/ef_core'

/**
 * @Author csx
 * @DateTime 2024/1/24 19:31
 * @TODO ToastUtil 文本提示框工具类
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_ui
 */
export class ToastUtil {
  /**
   * 弹出文本消息提示框,默认时长为2s,距离底部默认为20vp
   * @param msg 提示消息
   * @param options: {duration:'',bottom:'',showMode:0}  提示参数duration为显示时长，bottom为距离底部位置,showMode设置弹窗是否显示在应用之上0内,1上
   */
  static showToast(msg: ResourceStr, options?: toastOptions): void {
    if (!options) {
      options = new toastOptions();
    }
    promptAction.showToast({
      message: msg,
      duration: options.duration ? options.duration : Const.ANIMATION_DURATION,
      bottom: options.bottom ? options.bottom : '20vp',
      showMode: options.showMode ? options.showMode : 0,
      alignment: options.alignment ? options.alignment : Alignment.Center
    })
  }
}

/**
 * toast弹窗入参对象
 */
class toastOptions {
  duration?: number;
  bottom?: string | number;
  showMode?: number;
  alignment?: number;
}