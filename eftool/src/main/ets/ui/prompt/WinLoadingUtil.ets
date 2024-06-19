/**
 * @Author csx
 * @DateTime 2024/6/19 00:16
 * @TODO WinLoadingUtil  子窗口方式实现全局加载框
 */
import { display, window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { RandomUtil } from '../../core/util/RandomUtil';
import { efLoadingOptions, ImgLayout } from './efLoading';
import { ToastUtil } from './ToastUtil';

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
        if (!options.imgLayout) {
          options.imgLayout = ImgLayout.RIGHT;
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
      windowClass.setWindowBackgroundColor('#88000000');
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