/**
 * @Author csx
 * @DateTime 2024/5/23 21:45
 * @TODO WinDialogUtil 窗口方式实现全局Dialog
 */
import { display, window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { ToastUtil } from './ToastUtil';
import { RandomUtil } from '../../core/util/RandomUtil';
import { efAlertOptions } from './efAlert';

import('./efAlert'); // 引入命名路由页面


export class WinDialogUtil {
  /**
   * 缓存窗体,关闭时需要
   */
  private static cacheWindow: window.Window;
  /**
   * 是否打开loading
   */
  public loading: boolean = false;

  /**
   * 根据参数创建窗口
   * @param options
   * @returns
   */
  static async showAlert(options?: efAlertOptions): Promise<void> {
    let ctx = getContext() as common.UIAbilityContext;
    try {
      //创建窗口
      let windowClass = await window.createWindow({
        name: 'efLoading' + RandomUtil.randomNumber(1000, 1000000),
        windowType: window.WindowType.TYPE_DIALOG,
        ctx: ctx
      });
      //将窗口缓存
      WinDialogUtil.cacheWindow = windowClass;
      //更新属性
      if (options) {
        if (!options.title) {
          options.title = '温馨提示';
        }
        if (!options.okText) {
          options.okText = "确定";
        }
        if (!options.cancelText) {
          options.cancelText = "取消";
        }
        AppStorage.setOrCreate('efAlertOptions', options);
      }
      await windowClass.loadContentByName('efAlert')
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
  static async closeAlert(): Promise<void> {
    if (WinDialogUtil.cacheWindow) {
      await WinDialogUtil.cacheWindow.destroyWindow();
    }
  }
}