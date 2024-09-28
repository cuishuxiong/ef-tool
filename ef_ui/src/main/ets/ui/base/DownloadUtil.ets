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

import { ProgressButton } from '@kit.ArkUI'

/**
 * @Author csx
 * @DateTime 2024/3/28 20:52
 * @TODO DownloadUtil  下载按钮工具类
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_ui
 */
@Component
export struct DownloadUtil {
  /**
   * 当前下载进度
   */
  @Prop halfProgress: number = 0
  /**
   * 下载提示内容
   */
  @Prop ctx: string = '下载中...'
  /**
   * 是否显示
   */
  @Prop progressState: Visibility = Visibility.None

  build() {
    Column() {
      ProgressButton({
        progress: this.halfProgress,
        progressButtonWidth: "120",
        content: this.ctx,
        enable: true,
        clickCallback: () => {
        }
      })
        .visibility(this.progressState)
        .padding({ top: 12, bottom: 12 })
    }
  }
}