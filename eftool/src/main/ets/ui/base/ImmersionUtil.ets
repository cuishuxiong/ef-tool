import { window } from '@kit.ArkUI';
import { Logger } from '../../core/util/Logger';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * @Author csx
 * @DateTime 2024/3/28 20:54
 * @TODO ImmersionUtil  沉浸式导航工具类
 */
export class ImmersionUtil {

  //适配屏幕挖孔
  //https://developer.huawei.com/consumer/cn/forum/topic/0201145617527203077?fid=0109140870620153026

  private static instance: ImmersionUtil;
  cacheWindowStage?: window.WindowStage;

  constructor() {
    if (!ImmersionUtil.instance) {
      ImmersionUtil.instance = this;
    }
    return ImmersionUtil.instance;
  }

  /**
   * 沉浸式设置
   * @param windowStage
   * @param isLayoutFullScreen  是否开启全屏默认true
   * @param hiddenBar  是否隐藏底部导航,默认false,当为true时页面无需避让
   * @param color  窗口背景颜色默认值为白色
   */
  immersiveWindow(windowStage: window.WindowStage, isLayoutFullScreen: boolean = true, hiddenBar: boolean = false, color: string = '#ffffff') {
    if (windowStage) {
      this.cacheWindowStage = windowStage;
    } else if (this.cacheWindowStage) {
      windowStage = this.cacheWindowStage;
    }
    //加载主窗口
    let windowClass = windowStage.getMainWindowSync();
    //1.设置全屏模式
    windowClass.setWindowLayoutFullScreen(isLayoutFullScreen).then(() => {
      windowClass.setWindowBackgroundColor(color);
      Logger.info('Succeeded in setting the window layout to full-screen mode.');
    }).catch((err: BusinessError) => {
      Logger.error('Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
    });
    // 2. 获取布局避让遮挡的区域
    let type = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR;
    let avoidArea = windowClass.getWindowAvoidArea(type);
    let bottomRectHeight = avoidArea.bottomRect.height;
    AppStorage.setOrCreate('bottomHeight', bottomRectHeight);
    if (hiddenBar) {
      //3.设置顶部导航栏全部隐藏
      windowClass.setSpecificSystemBarEnabled('status', false).then(() => {
        Logger.info('设置顶部导航隐藏成功.');
      }).catch((err: BusinessError) => {
        Logger.error(`Failed to set the status bar to be invisible. Code is ${err.code}`, `message is ${err.message}`);
      });
    }
  }
}