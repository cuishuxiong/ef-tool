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


import { display, window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { ToastUtil } from '../prompt/ToastUtil';

/**
 * @Author csx
 * @DateTime 2024/4/3 09:11:04
 * @TODO WindowUtil  提供对窗口的工具类
 */
export class WindowUtil {
  /**
   * 缓存窗体,关闭时需要
   */
  private static cacheWindow: window.Window;

  /**
   * 根据参数创建窗口
   * @param options
   * @returns
   */
  static async createWindow(options: WinOptions): Promise<void> {
    if (!options) {
      options = new WinOptions();
    }
    if (!options.name) {
      options.name = 'eftool';
    }
    if (options.windowType == undefined) {
      options.windowType = window.WindowType.TYPE_DIALOG;
    }
    if (!options.bgColor) {
      options.bgColor = '#33606266';
    }
    try {
      //创建窗口
      let windowClass = await window.createWindow({
        name: options.name,
        windowType: options.windowType,
        ctx: getContext() as common.UIAbilityContext
      });
      //将窗口缓存
      WindowUtil.cacheWindow = windowClass;
      await windowClass.setUIContent(options.contentRouter);
      //获取屏幕四大角
      let d = display.getDefaultDisplaySync();
      //设置窗口大小
      await windowClass.resize(d.width, d.height);
      // 设置窗口背景颜色
      windowClass.setWindowBackgroundColor(options.bgColor);
      //显示窗口
      await windowClass.showWindow();
    } catch (exception) {
      ToastUtil.showToast('创建窗口失败,原因为:' + JSON.stringify(exception));
    }
  }

  /**
   * 关闭窗口
   * @returns
   */
  static async closeWindow(): Promise<void> {
    if (WindowUtil.cacheWindow) {
      await WindowUtil.cacheWindow.destroyWindow();
    }
  }
}

/**
 * 窗口入参对象
 */
class WinOptions {
  /**
   * 窗口名称 默认eftool
   */
  name?: string;
  /**
   * 窗口类型 默认TYPE_DIALOG
   */
  windowType?: window.WindowType;
  /**
   *窗口要显示的路由  如:pages/Welcome需要在main_pages.json中声明
   */
  contentRouter: string = '';
  /**
   * 窗口背景颜色,默认#33606266
   */
  bgColor?: string;
  /**
   * 窗口创建回调函数
   */
  callBack?: () => void;
}