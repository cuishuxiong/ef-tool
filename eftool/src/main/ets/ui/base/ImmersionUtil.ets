/**
 * @Author csx
 * @DateTime 2024/3/28 20:54
 * @TODO ImmersionUtil  沉浸式导航工具类
 */
import { window } from '@kit.ArkUI';
import { Logger } from '../../core/util/Logger';

export class ImmersionUtil {
  private static instance: ImmersionUtil;
  currentBarColor: string | Resource = '';
  cacheWindowStage?: window.WindowStage;

  constructor() {
    if (!ImmersionUtil.instance) {
      ImmersionUtil.instance = this;
    }
    return ImmersionUtil.instance;
  }

  immersiveWindow(windowStage: window.WindowStage, color: string, isLayoutFullScreen: boolean) {
    if (this.currentBarColor && this.currentBarColor === color) return;

    if (windowStage) {
      this.cacheWindowStage = windowStage;
    } else if (this.cacheWindowStage) {
      windowStage = this.cacheWindowStage;
    }

    let windowClass: window.Window | null = null;
    /**
     * 加载主窗口
     */
    windowStage.getMainWindow((err, data: window.Window) => {
      if (err.code) {
        Logger.error('加载主模块出错', JSON.stringify(err));
        return;
      }

      windowClass = data;
      Logger.info(`成功加载主模块. 数据:  ${JSON.stringify(data)}`);
      /**
       * 设置全屏模式
       */
      windowClass.setWindowLayoutFullScreen(isLayoutFullScreen, (err) => {
        if (err.code) {
          Logger.error(`设置主窗口全屏模式出错. 原因: ${JSON.stringify(err)}`);
          return;
        }
        Logger.info('设置主窗口全屏模式成功.');
      });

      /**
       * 设置顶部导航栏全部隐藏
       */
      windowClass.setWindowSystemBarEnable([], (err) => {
        if (err.code) {
          Logger.error(`设置顶部导航隐藏出错. 原因: ${JSON.stringify(err)}`);
          return;
        }
        Logger.info('设置顶部导航隐藏成功.');
      });


    });
  }
}