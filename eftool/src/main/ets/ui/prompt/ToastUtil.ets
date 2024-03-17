import promptAction from '@ohos.promptAction'
import { UiConst as Const } from '../../core/const/UiConst'

/**
 * @Author csx
 * @DateTime 2024/1/24 19:31
 * @TODO ToastUtil 文本提示框工具类
 */
export class ToastUtil {
  /**
   * 弹出文本消息提示框,默认时长为2s,距离底部默认为20vp
   * @param msg 提示消息
   * @param options: {duration:'',bottom:'',showMode:0}  提示参数duration为显示时长，bottom为距离底部位置,showMode设置弹窗是否显示在应用之上0内,1上
   */
  static showToast(msg: ResourceStr, options?: toastOptions): void {
    if (!options) {
      options = new toastOptions();
    }
    promptAction.showToast({
      message: msg,
      duration: options.duration,
      bottom: options.bottom,
      showMode: options.showMode
    })
  }
}

/**
 * toast弹窗入参对象
 */
class toastOptions {
  duration: number = Const.ANIMATION_DURATION;
  bottom: string | number = '20vp';
  showMode: number = 0;
}