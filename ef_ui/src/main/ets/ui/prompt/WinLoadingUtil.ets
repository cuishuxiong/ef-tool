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
import { RandomUtil } from '@yunkss/ef_core';
import { ToastUtil } from './ToastUtil';
import { efLoadingOptions, ImgLayout, LoadingShape } from './efLoading';

/**
 * @Author csx
 * @DateTime 2024/6/19 00:16
 * @TODO WinLoadingUtil  子窗口方式实现全局加载框
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_ui
 */
import('./efLoading'); // 引入命名路由页面


export class WinLoadingUtil {
  /**
   * 缓存窗体集合,关闭时需要
   */
  private static cacheWindow: window.Window;

  /**
   * 根据参数创建窗口
   * @param options
   * @returns
   */
  static async showLoading(options?: efLoadingOptions): Promise<void> {
    let ctx = getContext() as common.UIAbilityContext;
    try {
      //当前窗口的编码
      let winName = 'efLoading' + RandomUtil.randomNumber(2000, 2000000);
      //创建存储
      let efStorage = new LocalStorage();
      //创建窗口
      let windowClass = await window.createWindow({
        name: winName,
        windowType: window.WindowType.TYPE_DIALOG,
        ctx: ctx
      });
      //将窗口缓存
      WinLoadingUtil.cacheWindow = windowClass;
      //更新属性
      if (options) {
        if (!options.content) {
          options.content = '小的正在努力加载中...';
        }
        if (options.imgLayout == undefined) {
          options.imgLayout = ImgLayout.RIGHT;
        }
        if (options.layoutShape == undefined) {
          options.layoutShape = LoadingShape.RECTANGLE;
        }
        //存储数据
        efStorage.setOrCreate('efLoadingOptions', options);
      }
      await windowClass.loadContentByName('efLoading', efStorage);
      //获取屏幕四大角
      let d = display.getDefaultDisplaySync();
      //设置窗口大小
      await windowClass.resize(d.width, d.height);
      // 设置窗口背景颜色
      windowClass.setWindowBackgroundColor('#00000000');
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
  static async closeLoading(): Promise<void> {
    if (WinLoadingUtil.cacheWindow) {
      await WinLoadingUtil.cacheWindow.destroyWindow();
    }
  }
}