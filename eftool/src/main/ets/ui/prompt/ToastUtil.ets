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
   * @param options: {duration:'',bottom:''}  提示参数duration为显示时长，bottom为距离底部位置
   */
  static showToast(msg: string | Resource, options?: {
    duration?: number,
    bottom?: string | number
  }): void {
    const { duration = Const.ANIMATION_DURATION, bottom = '20vp' } = options || {};
    promptAction.showToast({
      message: msg,
      duration: duration,
      bottom: bottom
    })
  }
}