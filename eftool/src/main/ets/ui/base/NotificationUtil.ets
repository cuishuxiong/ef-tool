import notificationManager from '@ohos.notificationManager';
import Base from '@ohos.base';
import { common, wantAgent } from '@kit.AbilityKit';
import { RandomUtil } from '../../core/util/RandomUtil';
import { ToastUtil } from '../prompt/ToastUtil';

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
  static async authorizeNotification(callBack: (index: number) => void): Promise<void> {
    //判断用户是否授权通知服务
    let isAuth = await notificationManager.isNotificationEnabled();
    //true为授权
    if (!isAuth) {
      //未授权，尝试拉起授权
      notificationManager.requestEnableNotification(getContext() as common.UIAbilityContext, (err: Base.BusinessError) => {
        if (err) {
          callBack(-1);
        } else {
          callBack(1);
        }
      })
    } else {
      callBack(1);
    }
  }

  /**
   * 创建一个可拉起Ability的Want
   * @returns
   */
  private static createWantAgent(noticeId: number): wantAgent.WantAgentInfo {
    //获取当前上下文对象
    let ctx = getContext() as common.UIAbilityContext;
    let wantAgentInfo: wantAgent.WantAgentInfo = {
      wants: [
        {
          deviceId: '',
          bundleName: ctx.abilityInfo.bundleName,
          abilityName: ctx.abilityInfo.name,
          action: '',
          entities: [],
          uri: '',
          parameters: {
            'eftoolNotice': noticeId
          }
        }
      ],
      actionType: wantAgent.OperationType.START_ABILITY,
      requestCode: RandomUtil.randomInt(),
      actionFlags: [wantAgent.WantAgentFlags.CONSTANT_FLAG]
    };
    return wantAgentInfo;
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
    //创建wantAgentInfo
    let wantAgentInfo = NotificationUtil.createWantAgent(options.id);
    //创建wantAgent
    let wantAgentObj = await wantAgent.getWantAgent(wantAgentInfo);
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
      badgeNumber: 1,
      wantAgent: wantAgentObj
    };
    //发送通知
    notificationManager.publish(notificationRequest, (err: Base.BusinessError) => {
      if (!err && options.callBack) {
        if (options.id) {
          //执行回调
          options.callBack(options.id);
        }
      }
    });
  }

  /**
   * 取消通知
   * @param noticeId 通知id
   * @param callBack  回调函数
   * @returns
   */
  static cancelNotice(noticeId: number, callBack?: () => void): void {
    notificationManager.cancel(noticeId, (err: Base.BusinessError) => {
      if (err) {
        ToastUtil.showToast('取消通知出错,原因为:' + err.message);
      } else {
        if (callBack) {
          callBack();
        }
      }
    });
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
  callBack?: (noticeId: number) => void;
}