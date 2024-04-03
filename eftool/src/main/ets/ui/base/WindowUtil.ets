/**
 * @Author csx
 * @DateTime 2024/4/3 09:11:04
 * @TODO WindowUtil  提供对窗口的工具类
 */
import { display, window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { UiConst } from '../../core/const/UiConst';
import { ToastUtil } from '../prompt/ToastUtil';

export class WindowUtil {
  //https://developer.huawei.com/consumer/cn/doc/harmonyos-references/js-apis-window-0000001820880785

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
  name?: string;
  windowType?: window.WindowType;
  contentRouter: string = '';
  bgColor?: string;
  callBack?: () => void;
}