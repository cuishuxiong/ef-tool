import notificationManager from '@ohos.notificationManager';
import Base from '@ohos.base';
import { common } from '@kit.AbilityKit';
import { ToastUtil } from '../prompt/ToastUtil';
import { RandomUtil } from '../../core/util/RandomUtil';
import { image } from '@kit.ImageKit';

/**
 * @Author csx
 * @DateTime 2024/4/10 23:28
 * @TODO NotificationUtil  通知工具列
 */
export class NotificationUtil {
  /**
   * 校验是否已授权通知服务
   * @returns
   */
  static async authorizeNotification(): Promise<Boolean> {
    //判断用户是否授权通知服务
    let isAuth = await notificationManager.isNotificationEnabled();
    //true为授权
    if (!isAuth) {
      //未授权，尝试拉起授权
      await notificationManager.requestEnableNotification(getContext() as common.UIAbilityContext)
        .catch((err: Base.BusinessError) => {
          if (1600004 == err.code) {
            isAuth = false;
            ToastUtil.showToast('用户取消通知授权!');
          } else {
            isAuth = false;
            ToastUtil.showToast('获取通知授权失败,原因为:' + err.message);
          }
        });
      isAuth = true;
    }
    return isAuth;
  }

  /**
   * 推送普通文本通知
   * @param options  通知实体
   * @returns
   */
  static async publishBasic(options: NoticeOptions): Promise<void> {
    if (!options) {
      options = new NoticeOptions();
    }
    if (!options.id) {
      options.id = RandomUtil.randomInt();
    }
    if (!options.title) {
      options.title = '';
    }
    if (options.isOngoing == undefined) {
      options.isOngoing = false;
    }
    if (options.tapDismissed == undefined) {
      options.tapDismissed = false;
    }
    if (!options.autoDeletedTime) {
      options.autoDeletedTime = -1;
    }
    if (options.isStopwatch == undefined) {
      options.isStopwatch = true;
    }
    if (!options.label) {
      options.label = '标题';
    }
    if (!options.title) {
      options.title = 'eftool的通知';
    }
    if (!options.additionalText) {
      options.additionalText = '';
    }
    //获取小图标
    let ctx = getContext() as common.UIAbilityContext;
    let imgStr = await ctx.resourceManager.getMediaContent($r("app.media.tips"));
    let small = await image.createImageSource(imgStr).createPixelMap();
    //通知Request对象
    let notificationRequest: notificationManager.NotificationRequest = {
      id: options.id,
      content: {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: options.title,
          text: options.text,
          additionalText: options.additionalText
        }
      },
      isOngoing: options.isOngoing,
      tapDismissed: options.tapDismissed,
      autoDeletedTime: options.autoDeletedTime,
      isStopwatch: options.isStopwatch,
      label: options.label,
      smallIcon: small,
      badgeNumber: 1
    };
    //发送通知
    await notificationManager.publish(notificationRequest);
    //执行回调
    options.callBack;
  }
}

/**
 * 通知入参实体类
 */
class NoticeOptions {
  /**
   * 通知ID
   */
  id?: number;
  /**
   *是否进行时通知
   */
  isOngoing?: boolean;
  /**
   *通知是否自动清除
   */
  tapDismissed?: boolean;
  /**
   *自动清除的时间
   */
  autoDeletedTime?: number;
  /**
   *是否显示已用时间
   */
  isStopwatch?: boolean;
  /**
   *通知标签
   */
  label?: string;
  /**
   *通知标题
   */
  title?: string;
  /**
   *通知内容
   */
  text: string = '';
  /**
   *通知附加内容，是对通知内容的补充
   */
  additionalText?: string;
  /**
   * 业务回调函数
   */
  callBack?: () => void;
}