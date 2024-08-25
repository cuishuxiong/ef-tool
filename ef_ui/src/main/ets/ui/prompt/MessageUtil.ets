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

import { ComponentContent, PromptAction } from '@kit.ArkUI';

/**
 * @Author csx
 * @DateTime 2024/8/23 00:47
 * @TODO MessageUtil 警告类提示框工具类
 */
export class MessageUtil {
  /**
   * 显示成功警告框
   * @param cfg
   */
  static success(cfg: MessageCfg) {
    /**
     * 获取弹框控制对象
     */
    let promptAction = cfg.context.getPromptAction()
    //设置成功弹框页面内容
    let componentContent = new ComponentContent(cfg.context, wrapBuilder(successView), cfg);
    //打开弹框
    promptAction.openCustomDialog(componentContent, {
      alignment: DialogAlignment.Bottom,
      autoCancel: true,
      offset: { dx: 0, dy: -30 },
      onDidDisappear: () => {
        componentContent = undefined;
        promptAction = undefined;
      },
      onWillDismiss: () => {
        /*如果需要屏蔽返回键，这里空实现即可*/
      }
    })
    setTimeout(() => {
      MessageUtil.close(componentContent, promptAction);
    }, 1000);
  }

  warn() {

  }

  error() {

  }

  info() {

  }

  /**
   * 关闭
   * @param componentContent
   * @param promptAction
   */
  static close(componentContent: ComponentContent<MessageCfg>, promptAction: PromptAction) {
    promptAction.closeCustomDialog(componentContent);
  }
}


@Builder
function successView(messageCfg: MessageCfg) {
  Column() {
    Text('success')
  }
}

/**
 * 警告提示框入参
 */
export interface MessageCfg {
  /**
   * 上下文对象
   */
  context: UIContext;
  message: string;
  icon: string;
  duration: number;
  showClose: boolean;
  center: boolean;
  onClose: Function;
}