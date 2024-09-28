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

import { ConfirmDialog } from '@ohos.arkui.advanced.Dialog'
import { UiConst } from '@yunkss/ef_core';

/**
 * @Author csx
 * @DateTime 2024/3/27 19:56
 * @TODO ConfirmUtil
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_ui
 */
@Component
export struct ConfirmUtil {
  @Prop @Watch("change") options: ConfirmOptions = new ConfirmOptions();
  private isChecked: boolean = false;
  /**
   * 自定义Tips
   */
  private dialogControllerProgress: CustomDialogController = new CustomDialogController({
    builder: ConfirmDialog({
      title: this.options.title,
      content: this.options.content,
      checkTips: this.options.checkTips != undefined ? this.options.checkTips : '禁止后不再提醒',
      isChecked: this.isChecked,
      primaryButton: {
        value: this.options.btnList ? this.options.btnList[0] : '禁止',
        background: UiConst.DIALOG_OK_COLOR,
        fontColor: UiConst.ALERT_OK_COLOR,
        action: () => {
          this.isChecked = true;
          this.options.clickCallBack(0, this.isChecked);
        }
      },
      secondaryButton: {
        value: this.options.btnList && this.options.btnList.length > 1 ? this.options.btnList[1] : '允许',
        background: UiConst.DIALOG_CANCEL_COLOR,
        fontColor: UiConst.ALERT_OK_COLOR,
        action: () => {
          this.isChecked = false;
          this.options.clickCallBack(1, this.isChecked);
        }
      }
    }),
    autoCancel: false,
    alignment: this.options.alignment != undefined ? this.options.alignment : DialogAlignment.Center,
    offset: this.options.offset != undefined ? this.options.offset : this.options.alignment == DialogAlignment.Bottom || this.options.alignment == DialogAlignment.BottomEnd || this.options.alignment == DialogAlignment.BottomStart ? {
      dx: 0,
      dy: -20
    } : this.options.alignment == DialogAlignment.Top || this.options.alignment == DialogAlignment.TopStart || this.options.alignment == DialogAlignment.TopEnd ? {
      dx: 0,
      dy: 50
    } : { dx: 0, dy: 0 },
    customStyle: true,
    gridCount: 10,
    maskRect: { x: 0, y: 0, width: '100%', height: '100%' },
    // maskColor: UiConst.DIALOG_CANCEL_COLOR,
    openAnimation: { duration: 500, tempo: 0.7, curve: Curve.EaseInOut },
    closeAnimation: { duration: 500, tempo: 0.7, curve: Curve.FastOutLinearIn },
    showInSubWindow: false,
    isModal: true
  })

  change() {
    if (!this.options.title) {
      this.options.title = '操作确认';
    }
    if (this.options.show) {
      this.show();
    } else {
      this.close()
    }
  }

  /**
   * 打开提示模态框
   */
  show() {
    this.dialogControllerProgress.open();
  }

  /**
   * 关闭提示模态框
   */
  close() {
    this.dialogControllerProgress.close();
  }

  build() {
    Row()
  }
}

/**
 * Tips框参数
 */
class ConfirmOptions {
  /**
   * 提示框标题
   */
  public title?: ResourceStr;
  /**
   * 提示框内容
   */
  public content?: ResourceStr;
  /**
   * 弹窗在竖直方向上的对齐方式
   */
  public checkTips?: ResourceStr;
  /**
   * 按钮字符串数组
   */
  public btnList?: Array<string>;
  /**
   * 点击弹框按钮回调函数
   */
  public clickCallBack: (index: number, isCheck: boolean) => void = () => {
  };
  /**
   * 是否显示
   */
  public show: boolean = false;
  /**
   * 弹窗在竖直方向上的对齐方式
   */
  public alignment?: DialogAlignment;
  /**
   * 弹窗相对alignment所在位置的偏移量
   */
  public offset?: Offset;
}