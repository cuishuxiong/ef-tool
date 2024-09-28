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


import { UiConst } from '@yunkss/ef_core'
import { ExceptionUtil } from './ExceptionUtil'

/**
 * @Author csx
 * @DateTime 2024/3/28 10:50:03
 * @TODO ExceptionDialogUtil 异常提醒弹框工具类
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_ui
 */
@Component
export struct ExceptionDialogUtil {
  callBack: (data: string) => void = () => {
  };
  dialogController: CustomDialogController = new CustomDialogController({
    builder: ExceptionUI({
      callBack: (data: string) => {
        this.callBack(data);
        this.dialogController.close();
      }
    }),
    autoCancel: false,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 10,
    customStyle: false,
    isModal: true
  })

  build() {
    Column() {
      Button('点我有奇迹')
        .margin({ top: 20, bottom: 20 })
        .onClick(() => {
          if (this.dialogController != undefined) {
            this.dialogController.open()
          }
        })
    }
  }
}

@CustomDialog
struct ExceptionUI {
  callBack: (data: string) => void = () => {
  };
  controller: CustomDialogController

  build() {
    Column() {
      ExceptionUtil({
        options: {
          show: true,
          clickCallBack: (index) => {
            this.callBack(index == 0 ? '点击了提示文本' : '点击了提示图标');
          }
        }
      }).zIndex(999)
      Text('是否需要上报服务器,获得更高体验?').fontSize(16).margin({ top: 10, bottom: 10 }).textAlign(TextAlign.Start);
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .fontColor(UiConst.ALERT_CANCEL_COLOR)
          .backgroundColor(UiConst.ALERT_CANCEL_BG_COLOR)
          .onClick(() => {
            this.callBack('取消')
          })
        Button('确认')
          .fontColor(UiConst.ALERT_OK_COLOR)
          .backgroundColor(UiConst.ALERT_OK_BG_COLOR)
          .onClick(() => {
            this.callBack('确认')
          })
      }.margin({ top: 10, bottom: 10 })
    }.height('80vp')
  }
}