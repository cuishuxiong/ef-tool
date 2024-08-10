import promptAction from '@ohos.promptAction'

import { UiConst as Const } from '@yunkss/ef_core'
import { Button } from '@system.prompt';

/**
 * @Author csx
 * @DateTime 2024/1/24 19:31
 * @TODO DialogUtil 对话框工具类
 */
export class DialogUtil {
  /**
   * 弹出一个Dialog提示框
   * @param options: {
   * title:标题默认为温馨提示,
   * msg:提示消息,
   * okText:确定按钮文本,
   * cancelText:取消按钮文本,
   * alignment:弹窗在竖直方向上的对齐方式,
   * maskRect:弹窗遮蔽层区域,
   * isModal:弹窗是否为模态窗口,
   * offset:弹窗相对alignment所在位置的偏移量,
   * okCallBack:确定按钮事件,
   * cancelCallBack:取消按钮事件
   * }
   */
  static showDialog(options: DialogOptions) {
    if (!options) {
      options = new DialogOptions();
    }
    if (!options.okText) {
      options.okText = Const.DIALOG_OK;
    }
    if (!options.title) {
      options.title = Const.DIALOG_TITLE;
    }
    if (!options.cancelText) {
      options.cancelText = Const.DIALOG_CANCEL;
    }
    if (options.alignment == undefined) {
      options.alignment = DialogAlignment.Bottom;
    }
    if (!options.maskRect) {
      options.maskRect = { x: 0, y: 0, width: '100%', height: '100%' };
    }
    if (options.isModal == undefined) {
      options.isModal = true;
    }
    if (!options.offset) {
      options.offset = options.alignment == DialogAlignment.Bottom || options.alignment == DialogAlignment.BottomEnd || options.alignment == DialogAlignment.BottomStart ? {
        dx: 0,
        dy: -20
      } : options.alignment == DialogAlignment.Top || options.alignment == DialogAlignment.TopStart || options.alignment == DialogAlignment.TopEnd ? {
        dx: 0,
        dy: 20
      } : { dx: 0, dy: 0 };
    }
    let dialogBtn = new Array<Button>();
    dialogBtn.push({
      text: options.okText,
      color: Const.DIALOG_OK_COLOR
    });
    if (options.cancelText && options.cancelCallBack) {
      dialogBtn.push({
        text: options.cancelText,
        color: Const.DIALOG_CANCEL_COLOR
      })
    }
    //创建弹框
    let dialogResult = promptAction.showDialog({
      title: options.title,
      message: options.msg,
      alignment: options.alignment,
      maskRect: options.maskRect,
      isModal: options.isModal,
      offset: options.offset,
      buttons: dialogBtn
    });
    //处理结果
    dialogResult.then((data) => {
      let idx = data.index;
      if (idx == 0) {
        //确定
        if (options.okCallBack) {
          options.okCallBack();
        }
      }
      if (idx == 1) {
        //取消
        if (options.cancelCallBack) {
          options.cancelCallBack();
        }
      }
    })
  }

  /**
   * 弹出一个警告提示框
   * @param options
   * {
   * msg:警告消息,
   * title:提示标题默认为(警告提示),
   * subtitle:副标题,
   * autoCancel:点击遮罩是否自动关闭默认为(false),
   * alignment:弹框对齐方式默认为(底部Bottom),
   * gridCount:宽度所占用栅格数默认为10,
   * buttons:按钮,
   * offset:弹窗相对alignment所在位置的偏移量,
   * maskRect:弹窗遮蔽层区域
   * }
   * @Param buttons:AlertDialogBtn 弹框按钮类只允许有两个第一个为确认按按,第二个为取消按钮
   * @Param AlertDialogBtn
   * {
   * value:按钮值
   * fontColor:按钮前景色
   * backgroundColor:按钮背景色
   * callBack:按钮事件
   * enabled:点击Button是否响应
   * defaultFocus:设置Button是否是默认焦点
   * style:设置Button的风格样式
   * }
   * @Param 确定按钮值: value:确定按钮文本默认为确定,fontColor:文本颜色默认为#fff,backgroundColor:背景颜色默认值为#409eff,callBack:确定按钮回调事件
   * @Param 取消按钮值: value:取消按钮文本默认为取消,fontColor:文本颜色默认为#fff,backgroundColor:背景颜色默认值为#dcdfe6,callBack:取消按钮回调事件
   */
  static showAlertDialog(options?: AlertOption) {
    //设置默认值
    const defaultButtons = new Array<AlertDialogBtn>();
    //如果没传则初始化
    if (!options) {
      options = new AlertOption();
    }

    if (!options.subtitle) {
      options.subtitle = '';
    }
    if (!options.title) {
      options.title = Const.ALERT_TITLE;
    }
    if (!options.gridCount) {
      options.gridCount = 10;
    }
    if (options.alignment == undefined) {
      options.alignment = DialogAlignment.Bottom;
    }
    if (!options.maskRect) {
      options.maskRect = { x: 0, y: 0, width: '100%', height: '100%' };
    }
    if (options.autoCancel == undefined) {
      options.autoCancel = false;
    }
    if (!options.offset) {
      options.offset = options.alignment == DialogAlignment.Bottom || options.alignment == DialogAlignment.BottomEnd || options.alignment == DialogAlignment.BottomStart ? {
        dx: 0,
        dy: -20
      } : options.alignment == DialogAlignment.Top || options.alignment == DialogAlignment.TopStart || options.alignment == DialogAlignment.TopEnd ? {
        dx: 0,
        dy: 20
      } : { dx: 0, dy: 0 };
    }

    //是否需要初始化默认按钮
    if (!options.buttons) {
      //设置默认按钮
      //确定按钮的默认值
      defaultButtons.push({
        value: Const.DIALOG_OK,
        fontColor: Const.ALERT_OK_COLOR,
        backgroundColor: Const.ALERT_OK_BG_COLOR,
        enabled: true,
        defaultFocus: false,
        style: DialogButtonStyle.DEFAULT
      });
      //取消按钮的默认值
      defaultButtons.push({
        value: Const.DIALOG_CANCEL,
        fontColor: Const.ALERT_CANCEL_COLOR,
        backgroundColor: Const.DIALOG_CANCEL_COLOR,
        enabled: true,
        defaultFocus: false,
        style: DialogButtonStyle.DEFAULT
      });
      options.buttons = defaultButtons;
    }

    //分解数据
    let primaryBtn = options.buttons[0];
    let secondBtn: AlertDialogBtn;
    if (options.buttons.length > 1) {
      secondBtn = options.buttons[1];
    } else {
      secondBtn = {
        value: Const.DIALOG_CANCEL,
        fontColor: Const.ALERT_CANCEL_COLOR,
        backgroundColor: Const.DIALOG_CANCEL_COLOR,
        enabled: true,
        defaultFocus: false,
        style: DialogButtonStyle.DEFAULT
      };
    }

    //创建警告弹框
    AlertDialog.show({
      title: options.title,
      subtitle: options.subtitle,
      maskRect: options.maskRect,
      message: options.msg,
      autoCancel: options.autoCancel,
      alignment: options.alignment,
      offset: options.offset,
      primaryButton: {
        value: !primaryBtn.value ? Const.DIALOG_OK : primaryBtn.value,
        fontColor: !primaryBtn.fontColor ? Const.ALERT_OK_COLOR : primaryBtn.fontColor,
        backgroundColor: !primaryBtn.backgroundColor ? Const.ALERT_OK_BG_COLOR : primaryBtn.backgroundColor,
        action: primaryBtn.callBack,
        enabled: !primaryBtn.enabled ? true : primaryBtn.enabled,
        defaultFocus: !primaryBtn.defaultFocus ? false : primaryBtn.defaultFocus,
        style: !primaryBtn.style ? DialogButtonStyle.DEFAULT : primaryBtn.style
      },
      secondaryButton: {
        value: !secondBtn.value ? Const.DIALOG_CANCEL : secondBtn.value,
        fontColor: !secondBtn.fontColor ? Const.ALERT_CANCEL_COLOR : secondBtn.fontColor,
        backgroundColor: !secondBtn.backgroundColor ? Const.DIALOG_CANCEL_COLOR : secondBtn.backgroundColor,
        action: secondBtn.callBack,
        enabled: !secondBtn.enabled ? true : secondBtn.enabled,
        defaultFocus: !secondBtn.defaultFocus ? false : secondBtn.defaultFocus,
        style: !secondBtn.style ? DialogButtonStyle.DEFAULT : secondBtn.style
      },
      gridCount: options.gridCount
    })
  }
}

/**
 * 普通dialog入参对象
 */
class DialogOptions {
  title?: ResourceStr;
  msg: ResourceStr = '';
  okText?: string;
  cancelText?: string;
  alignment?: DialogAlignment;
  maskRect?: Rectangle;
  isModal?: boolean;
  offset?: Offset;
  okCallBack?: () => void;
  cancelCallBack?: () => void
}

/**
 * 警告dialog入参对象
 */
class AlertOption {
  msg: ResourceStr = '';
  title?: ResourceStr;
  subtitle?: ResourceStr;
  autoCancel?: boolean;
  alignment?: DialogAlignment;
  buttons?: Array<AlertDialogBtn>;
  gridCount?: number;
  offset?: Offset;
  maskRect?: Rectangle;
}

/**
 * 提供給警告弹窗按钮使用
 */
class AlertDialogBtn {
  /**
   * 按钮值
   */
  value?: ResourceStr;
  /**
   * 按钮前景色
   */
  fontColor?: ResourceColor;
  /**
   * 按钮背景色
   */
  backgroundColor?: ResourceColor;
  /**
   * 按钮事件
   */
  callBack?: () => void;
  /**
   *点击Button是否响应
   */
  enabled?: boolean;
  /**
   *设置Button是否是默认焦点
   */
  defaultFocus?: boolean;
  /**
   *设置Button的风格样式
   */
  style?: DialogButtonStyle;
}