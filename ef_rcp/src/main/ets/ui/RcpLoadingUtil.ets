/**
 Copyright 2024 csx - @yunkss/ef_rcp

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
import { Logger, RandomUtil } from '@yunkss/ef_core';
import { rcpLoadingOptions, RcpImgLayout, RcpLoadingShape } from './rcpLoading';

import('./rcpLoading'); // 引入命名路由页面


/**
 * @Author csx
 * @DateTime 2024/6/19 00:16
 * @TODO RcpLoadingUtil  子窗口方式实现全局加载框
 */
export class RcpLoadingUtil {
  /**
   * 缓存窗体集合,关闭时需要
   */
  private static cacheWindow: window.Window;
  /**
   * 解决重复多次弹出关闭可能导致的异常
   */
  private static showTimes: number = 0;

  /**
   * 根据参数创建窗口
   * @param options
   * @returns
   */
  static async showLoading(options?: rcpLoadingOptions): Promise<void> {
    let ctx = getContext() as common.UIAbilityContext;
    //创建后计数器加一  思路由coder_liu提供
    RcpLoadingUtil.showTimes += 1
    if (RcpLoadingUtil.showTimes > 1) {
      //已经有一个在显示了，不要过多的创建
      return
    }
    try {
      //当前窗口的编码
      let winName = 'rcpLoading' + RandomUtil.randomNumber(2000, 2000000);
      //创建存储
      let efStorage = new LocalStorage();
      //创建窗口
      let windowClass = await window.createWindow({
        name: winName,
        windowType: window.WindowType.TYPE_DIALOG,
        ctx: ctx
      });
      //将窗口缓存
      RcpLoadingUtil.cacheWindow = windowClass;
      //更新属性
      if (options) {
        if (!options.content) {
          options.content = '小的正在努力加载中...';
        }
        if (options.imgLayout == undefined) {
          options.imgLayout = RcpImgLayout.RIGHT;
        }
        if (options.layoutShape == undefined) {
          options.layoutShape = RcpLoadingShape.RECTANGLE;
        }
        //存储数据
        efStorage.setOrCreate('rcpLoadingOptions', options);
      }
      await windowClass.loadContentByName('rcpLoading', efStorage);
      //获取屏幕四大角
      let d = display.getDefaultDisplaySync();
      //设置窗口大小
      await windowClass.resize(d.width, d.height);
      // 设置窗口背景颜色
      windowClass.setWindowBackgroundColor('#00000000');
      //显示窗口
      await windowClass.showWindow();
    } catch (exception) {
      RcpLoadingUtil.showTimes -= 1;
      Logger.warn('创建窗口失败,原因为:', JSON.stringify(exception));
    }
  }

  /**
   * 关闭窗口
   * @returns
   */
  static async closeLoading(): Promise<void> {
    if (RcpLoadingUtil.cacheWindow) {
      RcpLoadingUtil.showTimes -= 1;
      if (RcpLoadingUtil.showTimes == 0) {
        await RcpLoadingUtil.cacheWindow.destroyWindow();
      }
    }
  }
}