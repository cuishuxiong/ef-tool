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


import { ExceptionPrompt, MarginType } from '@ohos.arkui.advanced.ExceptionPrompt';

/**
 * @Author csx
 * @DateTime 2024/3/28 10:13:03
 * @TODO ExceptionUtil  异常提醒工具类
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_ui
 */
@Component
export struct ExceptionUtil {
  @Prop options: PromOptions = new PromOptions();

  build() {
    Column() {
      ExceptionPrompt({
        options: {
          tip: this.options.content != undefined ? this.options.content : '连接服务器异常,请重试!',
          icon: $r("app.media.error"),
          marginType: MarginType.FIT_MARGIN,
          actionText: this.options.actionText != undefined ? this.options.actionText : '重试',
          marginTop: '40vp',
          isShown: this.options.show
        },
        onTipClick: () => {
          this.options.clickCallBack(0);
        },
        onActionTextClick: () => {
          this.options.clickCallBack(1);
        },
      })
    }
  }
}

/**
 * Tips框参数
 */
class PromOptions {
  /**
   * 提示框内容
   */
  public content?: ResourceStr;
  /**
   * 指定当前异常提示的右侧图标按钮的文字
   */
  public actionText?: ResourceStr;
  /**
   * 是否显示
   */
  public show: boolean = false;
  /**
   * 点击弹框按钮回调函数
   */
  public clickCallBack: (index: number) => void = () => {
  };
}