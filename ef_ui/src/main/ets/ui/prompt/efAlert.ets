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

import { UiConst } from '@yunkss/ef_core';
import { WinDialogUtil } from './WinDialogUtil';

/**
 * @Author csx
 * @DateTime 2024/5/24 21:05
 * @TODO Loading
 */
@Entry({ routeName: 'efAlert', storage: LocalStorage.getShared() })
@Component
struct efAlert {
  /**
   * 属性配置
   */
  @LocalStorageProp('efAlertOptions') options: efAlertOptions = new efAlertOptions();

  build() {
    Stack() {
      Column() {
        Row() {
          Text(this.options.title)
            .fontSize(UiConst.FONT_18)
          Image($r("app.media.tips"))
            .width(UiConst.NUMBER_18)
            .margin({ left: UiConst.NUMBER_5 })
            .padding({ bottom: UiConst.NUMBER_3 })
        }.width('100%')

        Row() {
          Text(this.options.content)
            .fontSize(UiConst.FONT_16)
        }
        .margin({ top: UiConst.NUMBER_20 })
        .width('100%')

        Row() {
          Button(this.options.okText)
            .backgroundColor(UiConst.ALERT_OK_BG_COLOR)
            .padding({ left: UiConst.NUMBER_50, right: UiConst.NUMBER_50 })
            .onClick(() => {
              //当前窗体名称
              let winName = LocalStorage.getShared().get<string>("efDialogName");
              //确定点击事件
              this.getUIContext().runScopedTask(() => {
                if (this.options.okCallBack) {
                  //如果非自动关闭回调函数返回当前窗体名称
                  if (this.options.isAutoClose == false) {
                    this.options.okCallBack(winName);
                  } else {
                    this.options.okCallBack();
                  }
                }
              })
              if (this.options.isAutoClose) {
                if (winName) {
                  //关闭弹窗
                  WinDialogUtil.closeAlert(winName);
                }
              }
            })
          Button(this.options.cancelText)
            .backgroundColor(UiConst.DIALOG_CANCEL_COLOR)
            .padding({ left: UiConst.NUMBER_50, right: UiConst.NUMBER_50 })
            .onClick(() => {
              //当前窗体名称
              let winName = LocalStorage.getShared().get<string>("efDialogName");
              //取消点击事件
              this.getUIContext().runScopedTask(() => {
                if (this.options.cancelCallBack) {
                  //如果非自动关闭回调函数返回当前窗体名称
                  if (this.options.isAutoClose == false) {
                    this.options.cancelCallBack(winName);
                  } else {
                    this.options.cancelCallBack();
                  }
                }
              });
              if (this.options.isAutoClose) {
                if (winName) {
                  //关闭弹窗
                  WinDialogUtil.closeAlert(winName);
                }
              }
            })
        }
        .padding({ top: UiConst.NUMBER_20 })
        .width('100%')
        .alignItems(VerticalAlign.Bottom)
        .justifyContent(FlexAlign.SpaceAround)
      }
      .backgroundColor('#fff')
      .borderRadius(UiConst.NUMBER_10)
      .margin({
        top: UiConst.NUMBER_20,
        bottom: UiConst.NUMBER_20,
        left: UiConst.NUMBER_20,
        right: UiConst.NUMBER_20
      })
      .padding({
        top: UiConst.NUMBER_20,
        bottom: UiConst.NUMBER_20,
        left: UiConst.NUMBER_20,
        right: UiConst.NUMBER_20
      })
    }
    .width('100%')
    .height('100%')
  }
}

/**
 * 窗口弹框方式入参实体
 */
export class efAlertOptions {
  /**
   * 提醒标题
   */
  title?: string;
  /**
   * 提醒内容
   */
  content: string = '';
  /**
   * 确认文本
   */
  okText?: string;
  /**
   * 取消文本
   */
  cancelText?: string;
  /**
   * 是否点击时自动关闭弹框(1.1.13+)
   */
  isAutoClose?: boolean;
  /**
   * 确认回调函数,非自动关闭窗体时winName为当前窗体名称
   */
  okCallBack?: (winName?: string) => void;
  /**
   * 取消回调函数,非自动关闭窗体时winName为当前窗体名称
   */
  cancelCallBack?: (winName?: string) => void;

  constructor() {
    this.title = '温馨提示';
    this.okText = "确定";
    this.cancelText = "取消";
    this.isAutoClose = true;
  }
}