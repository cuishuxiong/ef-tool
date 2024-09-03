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
import { UiConst } from '@yunkss/ef_core';

/**
 * @Author csx
 * @DateTime 2024/8/23 00:47
 * @TODO MessageUtil 警告类提示框工具类
 */
class MessageUtil {
  /**
   * 私有单例对象
   */
  private static instance: MessageUtil;
  private componentContent: ComponentContent<MessageCfg> | undefined;
  private promptAction: PromptAction | undefined;
  private timer: number = -1

  private constructor() {
  }

  /**
   * 创建单例
   * @returns
   */
  public static getInstance(): MessageUtil {
    if (!MessageUtil.instance) {
      MessageUtil.instance = new MessageUtil();
    }
    return MessageUtil.instance;
  }

  /**
   * 构建view
   * @param viewName
   */
  private buildView(componentContent: ComponentContent<MessageCfg>, cfg: MessageCfg) {
    /**
     * 获取弹框控制对象
     */
    if (!this.promptAction) {
      this.promptAction = cfg.context.getPromptAction();
    }
    //打开弹框
    this.promptAction?.openCustomDialog(componentContent, {
      alignment: DialogAlignment.Bottom,
      autoCancel: false,
      offset: { dx: 0, dy: -30 },
      maskColor: Color.Transparent,
      onDidDisappear: () => {
        componentContent = undefined;
        this.promptAction = undefined;
      },
      onWillDismiss: () => {
        /*如果需要屏蔽返回键，这里空实现即可*/
      }
    })
    this.timer = setTimeout(() => {
      this.close();
    }, cfg.duration ? cfg.duration : 3000);
  }

  /**
   * 显示成功警告框
   * @param cfg
   */
  success(cfg: MessageCfg) {
    //设置成功弹框页面内容
    this.componentContent = new ComponentContent(cfg.context, wrapBuilder(successView), cfg);
    this.buildView(this.componentContent, cfg);
  }

  /**
   * 显示警告框
   * @param cfg
   */
  warn(cfg: MessageCfg) {
    //设置成功弹框页面内容
    let componentContent = new ComponentContent(cfg.context, wrapBuilder(warnView), cfg);
    this.buildView(componentContent, cfg);
  }

  /**
   * 显示异常框
   * @param cfg
   */
  error(cfg: MessageCfg) {
    //设置成功弹框页面内容
    let componentContent = new ComponentContent(cfg.context, wrapBuilder(errorView), cfg);
    this.buildView(componentContent, cfg);
  }

  /**
   * 显示信息框
   * @param cfg
   */
  info(cfg: MessageCfg) {
    //设置成功弹框页面内容
    let componentContent = new ComponentContent(cfg.context, wrapBuilder(infoView), cfg);
    this.buildView(componentContent, cfg);
  }

  /**
   * 关闭
   * @param componentContent
   * @param promptAction
   */
  close() {
    // close(componentContent: ComponentContent<MessageCfg>, promptAction: PromptAction) {
    // promptAction.closeCustomDialog(componentContent);
    clearTimeout(this.timer);
    this.promptAction?.closeCustomDialog(this.componentContent);
  }
}

/**
 * 左侧icon样式
 * @param icon  用户自定义
 * @param defaultIcon  默认
 */
@Extend(Image)
function icon() {
  .width(UiConst.VP_15)
  .height(UiConst.VP_15)
}

/**
 * 文本样式
 * @param color
 */
@Extend(Text)
function txtStyle(color: string) {
  .margin({
    left: UiConst.VP_10
  })
  .fontColor(color)
  .fontSize(UiConst.FONT_14)
}

@Builder
function buildClose() {
  Image($r("app.media.close"))
    .width(12)
    .height(12)
    .onClick(() => {
      MessageUtil.getInstance().close();
      // MessageUtil.close(componentContent, promptAction);
    })
}

/**
 * 基础的视图
 * @param messageCfg
 * @param defaultIcon
 * @param defaultTxtColor
 * @param defaultBgColor
 * @param defaultBorderColor
 */
@Builder
function basicView(messageCfg: MessageCfg, defaultIcon: ResourceStr, defaultTxtColor: string, defaultBgColor: string,
  defaultBorderColor: string) {
  Row() {
    Row() {
      Image(messageCfg.icon ? messageCfg.icon : defaultIcon).icon()
      Text(messageCfg.message).txtStyle(defaultTxtColor)
    }

    if (messageCfg.showClose) {
      buildClose()
    }
  }
  .padding(UiConst.VP_10)
  .borderRadius(UiConst.VP_5)
  .backgroundColor(defaultBgColor)
  .border({
    width: 1,
    color: defaultBorderColor,
    style: BorderStyle.Solid
  })
  .justifyContent(FlexAlign.SpaceBetween)
  .width('80%')
  .height(50)
}

@Builder
function successView(messageCfg: MessageCfg) {
  basicView(messageCfg, $r("app.media.successMsg"), '#67c23a', "#f0f9eb", '#e1f3d8');
}


@Builder
function errorView(messageCfg: MessageCfg) {
  Row() {
    Row() {
      Image(messageCfg.icon ? messageCfg.icon : $r("app.media.successMsg")).icon()
      Text(messageCfg.message).txtStyle('#67c23a')
    }

    if (messageCfg.showClose) {
      buildClose()
    }
  }
  .padding(UiConst.VP_10)
  .borderRadius(UiConst.VP_5)
  .backgroundColor("#f0f9eb")
  .border({
    width: 1,
    color: '#e1f3d8',
    style: BorderStyle.Solid
  })
  .justifyContent(FlexAlign.SpaceBetween)
  .width('80%')
  .height(50)
}


@Builder
function warnView(messageCfg: MessageCfg) {
  Row() {
    Row() {
      Image(messageCfg.icon ? messageCfg.icon : $r("app.media.successMsg")).icon()
      Text(messageCfg.message).txtStyle('#67c23a')
    }

    if (messageCfg.showClose) {
      buildClose()
    }
  }
  .padding(UiConst.VP_10)
  .borderRadius(UiConst.VP_5)
  .backgroundColor("#f0f9eb")
  .border({
    width: 1,
    color: '#e1f3d8',
    style: BorderStyle.Solid
  })
  .justifyContent(FlexAlign.SpaceBetween)
  .width('80%')
  .height(50)
}


@Builder
function infoView(messageCfg: MessageCfg) {
  basicView(messageCfg, $r("app.media.info"), '#909399', "#edf2fc", '#ebeef5');
}

/**
 * 抛出
 */
export const message = MessageUtil.getInstance();


/**
 * 警告提示框入参
 */
export interface MessageCfg {
  /**
   * 上下文对象
   */
  context: UIContext;
  message: string;
  icon?: ResourceStr;
  duration?: number;
  showClose?: boolean;
  center?: boolean;
  onClose?: Function;
}