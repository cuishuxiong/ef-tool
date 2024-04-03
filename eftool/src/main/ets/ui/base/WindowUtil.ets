/**
 * @Author csx
 * @DateTime 2024/4/3 09:11:04
 * @TODO WindowUtil  提供对窗口的工具类
 */
import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

export class WindowUtil {
  //https://developer.huawei.com/consumer/cn/doc/harmonyos-references/js-apis-window-0000001820880785

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
    try {
      let windowClass = await window.createWindow({
        name: options.name,
        windowType: options.windowType,
        ctx: getContext() as common.UIAbilityContext
      });
      if (options.contentRouter) {
        await windowClass.loadContentByName("com.yunkss.csx.tool/" + options.contentRouter);
      }
      await windowClass.showWindow();


    } catch (exception) {
      console.error('Failed to create the window. Cause: ' + JSON.stringify(exception));
    }
  }
}

/**
 * 窗口入参对象
 */
class WinOptions {
  name?: string;
  windowType?: window.WindowType;
  contentRouter: string;
  callBack?: () => void;

  constructor() {
    this.name = '';
    this.contentRouter = '';
    this.windowType = window.WindowType.TYPE_DIALOG;
    this.callBack = () => {
    };

  }
}