import notificationManager from '@ohos.notificationManager';
import Base from '@ohos.base';
import { common, Want, wantAgent } from '@kit.AbilityKit';
import { RandomUtil } from '../../core/util/RandomUtil';
import { ToastUtil } from '../prompt/ToastUtil';
import { image } from '@kit.ImageKit';

/**
 * @Author csx
 * @DateTime 2024/4/10 23:28
 * @TODO NotificationUtil  通知工具列
 */
export class NotificationUtil {
  /**
   * 校验是否已授权通知服务
   * @param callBack  回调函数
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
          moduleName: ctx.abilityInfo.moduleName,
          abilityName: ctx.abilityInfo.name,
          action: 'click_notice',
          entities: [],
          uri: '',
          parameters: {
            'eftoolNotice': noticeId
          }
        }
      ],
      actionType: wantAgent.OperationType.START_ABILITY | wantAgent.OperationType.SEND_COMMON_EVENT,
      requestCode: 0,
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
      options.id = RandomUtil.randomNumber(10000, 100000);
    }
    if (options.isOngoing == undefined) {
      options.isOngoing = true;
    }
    if (options.isStopwatch == undefined) {
      options.isStopwatch = true;
    }
    if (!options.label) {
      options.label = 'eftool';
    }
    if (!options.title) {
      options.title = '来自eftool通知';
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
      isStopwatch: options.isStopwatch,
      label: options.label,
      isFloatingIcon: true,
      badgeNumber: 1,
      wantAgent: wantAgentObj,
      removalWantAgent: wantAgentObj
      // actionButtons: [{ title: '查看', wantAgent: wantAgentObj }]
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
   * 推送多文本通知
   * @param options  通知实体
   * @returns
   */
  static async publishMultiLine(options: NoticeOptions): Promise<void> {
    if (!options) {
      options = new NoticeOptions();
    }
    if (!options.id) {
      options.id = RandomUtil.randomNumber(100001, 200000);
    }
    if (options.isOngoing == undefined) {
      options.isOngoing = true;
    }
    if (options.isStopwatch == undefined) {
      options.isStopwatch = true;
    }
    if (!options.label) {
      options.label = 'eftool';
    }
    if (!options.title) {
      options.title = 'eftool的通知';
    }
    if (!options.additionalText) {
      options.additionalText = '';
    }
    if (!options.briefText) {
      options.briefText = '默认概要内容';
    }
    if (!options.longText) {
      options.longText = '默认多文本内容';
    }
    if (!options.expandedTitle) {
      options.expandedTitle = '默认展开标题';
    }
    //创建wantAgentInfo
    let wantAgentInfo = NotificationUtil.createWantAgent(options.id);
    //创建wantAgent
    let wantAgentObj = await wantAgent.getWantAgent(wantAgentInfo);
    //通知Request对象
    let notificationRequest: notificationManager.NotificationRequest = {
      id: options.id,
      content: {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
        multiLine: {
          title: options.title,
          text: options.text,
          additionalText: options.additionalText,
          briefText: options.briefText,
          longTitle: options.expandedTitle,
          lines: options.longText.split(',')
        }
      },
      isOngoing: options.isOngoing,
      isStopwatch: options.isStopwatch,
      label: options.label,
      isFloatingIcon: true,
      badgeNumber: 1,
      wantAgent: wantAgentObj,
      removalWantAgent: wantAgentObj
      // actionButtons: [{ title: '查看', wantAgent: wantAgentObj }]
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
   * 推送长文本通知
   * @param options  通知实体
   * @returns
   */
  static async publishLongText(options: NoticeOptions): Promise<void> {
    if (!options) {
      options = new NoticeOptions();
    }
    if (!options.id) {
      options.id = RandomUtil.randomNumber(200001, 300000);
    }
    if (options.isOngoing == undefined) {
      options.isOngoing = true;
    }
    if (options.isStopwatch == undefined) {
      options.isStopwatch = true;
    }
    if (!options.label) {
      options.label = 'eftool';
    }
    if (!options.title) {
      options.title = 'eftool的通知';
    }
    if (!options.additionalText) {
      options.additionalText = '';
    }
    if (!options.briefText) {
      options.briefText = '默认概要内容';
    }
    if (!options.longText) {
      options.longText = '默认长文本内容';
    }
    if (!options.expandedTitle) {
      options.expandedTitle = '默认展开标题';
    }

    //创建wantAgentInfo
    let wantAgentInfo = NotificationUtil.createWantAgent(options.id);
    //创建wantAgent
    let wantAgentObj = await wantAgent.getWantAgent(wantAgentInfo);
    //通知Request对象
    let notificationRequest: notificationManager.NotificationRequest = {
      id: options.id,
      content: {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
        longText: {
          title: options.title,
          text: options.text,
          additionalText: options.additionalText,
          longText: options.longText,
          briefText: options.briefText,
          expandedTitle: options.expandedTitle
        }
      },
      isOngoing: options.isOngoing,
      isStopwatch: options.isStopwatch,
      label: options.label,
      isFloatingIcon: true,
      badgeNumber: 1,
      wantAgent: wantAgentObj,
      removalWantAgent: wantAgentObj
      // actionButtons: [{ title: '查看', wantAgent: wantAgentObj }]
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
   * 推送带有图片的通知
   * @param options  通知实体
   * @returns
   */
  static async publishPicture(options: NoticeOptions): Promise<void> {
    if (!options) {
      options = new NoticeOptions();
    }
    if (!options.id) {
      options.id = RandomUtil.randomNumber(300001, 400000);
    }
    if (options.isOngoing == undefined) {
      options.isOngoing = true;
    }
    if (options.isStopwatch == undefined) {
      options.isStopwatch = true;
    }
    if (!options.label) {
      options.label = 'eftool';
    }
    if (!options.title) {
      options.title = 'eftool的通知';
    }
    if (!options.additionalText) {
      options.additionalText = '';
    }
    if (!options.briefText) {
      options.briefText = '默认概要内容';
    }
    if (!options.expandedTitle) {
      options.expandedTitle = '默认展开标题';
    }
    if (!options.picture) {
      let ctx = getContext() as common.UIAbilityContext;
      options.picture = await image.createImageSource(ctx.resourceManager.getMediaContentSync($r("app.media.notice"))
        .buffer)
        .createPixelMap();
    }
    //创建wantAgentInfo
    let wantAgentInfo = NotificationUtil.createWantAgent(options.id);
    //创建wantAgent
    let wantAgentObj = await wantAgent.getWantAgent(wantAgentInfo);
    //通知Request对象
    let notificationRequest: notificationManager.NotificationRequest = {
      id: options.id,
      content: {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_PICTURE,
        picture: {
          title: options.title,
          text: options.text,
          additionalText: options.additionalText,
          briefText: options.briefText,
          expandedTitle: options.expandedTitle,
          picture: options.picture as image.PixelMap
        }
      },
      isOngoing: options.isOngoing,
      isStopwatch: options.isStopwatch,
      label: options.label,
      isFloatingIcon: true,
      badgeNumber: 1,
      wantAgent: wantAgentObj,
      removalWantAgent: wantAgentObj
      // actionButtons: [{ title: '查看', wantAgent: wantAgentObj }]
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

  /**
   * 重置角标
   */
  static async clearBadge() {
    await notificationManager.setBadgeNumber(0);
  }

  /**
   * 清理所所有通知
   */
  static async clearNotice() {
    await notificationManager.cancelAll();
  }

  /**
   * 读取或清除通知后重置角标
   * @param want
   */
  static readOrRemoveNotice(want: Want) {
    //获取从通知进入的参数
    if (want.parameters && want.parameters["eftoolNotice"]) {
      //设置角标
      notificationManager.getActiveNotificationCount().then(num => {
        notificationManager.setBadgeNumber(num);
      })
    }
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
   *通知附加内容
   */
  additionalText?: string;
  /**
   * 业务回调函数
   */
  callBack?: (noticeId: number) => void;
  /**
   *通知的长文本/多行的文本用英文逗号分割
   */
  longText?: string;
  /**
   *  通知概要内容
   */
  briefText?: string;
  /**
   *  通知展开时的标题
   */
  expandedTitle?: string;
  /**
   * 图片
   */
  picture?: image.PixelMap
}