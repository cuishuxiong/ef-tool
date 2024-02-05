import promptAction from '@ohos.promptAction'

import { UiConst as Const } from '../../core/const/UiConst'
import { JSONUtil } from '../../core/util/JSONUtil';
/**
 * @Author csx
 * @DateTime 2024/1/24 19:31
 * @TODO DialogUtil 对话框工具类
 */
export class DialogUtil {

  /**
   * 弹出一个Dialog提示框
   * @param options: {title:标题默认为温馨提示,msg:提示消息,okText:确定按钮文本,okCallBack:取消按钮文本,okCallBack:确定按钮事件,cancelCallBack:取消按钮事件}
   */
  static showDialog(options: {
    title?: string | Resource,
    msg: string | Resource,
    okText?: string | Resource,
    cancelText?: string | Resource,
    okCallBack: () => void,
    cancelCallBack?: () => void
  }) {
    let { title=Const.DIALOG_TITLE,msg,okText=Const.DIALOG_OK,cancelText=Const.DIALOG_CANCEL,okCallBack,cancelCallBack } = options;
    //创建弹框
    let dialogResult = promptAction.showDialog({
      title: title,
      message: msg,
      buttons: [
        {
          text: okText,
          color: Const.DIALOG_OK_COLOR
        },
        {
          text: cancelText,
          color: Const.DIALOG_CANCEL_COLOR
        }
      ]
    });
    //处理结果
    dialogResult.then((data) => {
      let idx = data.index;
      if (idx == 0) {
        //确定
        okCallBack();
      }
      if (idx == 1) {
        //取消
        if (cancelCallBack) {
          cancelCallBack();
        }
      }
    })
  }

  /**
   * 弹出一个警告提示框
   * @param msg  警告消息
   * @param options  {title:提示标题默认为(警告提示),autoCancel:点击遮罩是否自动关闭默认为(false),alignment:弹框对齐方式默认为(底部Bottom),gridCount:宽度所占用栅格数默认为10,buttons:按钮}
   * @Param buttons:AlertDialogBtn 弹框按钮类只允许有两个第一个为确认按按,第二个为取消按钮
   * @Param   确定按钮值: value:确定按钮文本默认为确定,fontColor:文本颜色默认为#fff,backgroundColor:背景颜色默认值为#409eff,callBack:确定按钮回调事件
   * @Param   取消按钮值: value:取消按钮文本默认为取消,fontColor:文本颜色默认为#fff,backgroundColor:背景颜色默认值为#dcdfe6,callBack:取消按钮回调事件
   */
  static showAlertDialog(msg: string | Resource,options?: {
    title?: string | Resource,
    autoCancel?: boolean,
    alignment?: DialogAlignment
    buttons: [ Partial<AlertDialogBtn>, Partial<AlertDialogBtn>],
    gridCount?:number
  }) {
    //设置默认值
    const defaultButtons = [
      //确定按钮的默认值
      { value: Const.DIALOG_OK, fontColor: Const.ALERT_OK_COLOR, backgroundColor: Const.ALERT_OK_BG_COLOR },
      //取消按钮的默认值
      { value: Const.DIALOG_CANCEL, fontColor: Const.ALERT_CANCEL_COLOR, backgroundColor: Const.ALERT_CANCEL_BG_COLOR }
    ];
    //解构入参
    let {
      title=Const.ALERT_TITLE,
      autoCancel = false,
      alignment=DialogAlignment.Bottom,
      buttons=[
        { ...defaultButtons[0] },
        { ...defaultButtons[1] }
      ],
      gridCount = 10
    } = options || {};
    // 合并传入的 buttons 和默认的 buttons
    // @ts-ignore
    buttons = buttons.map((btn, index) => ({ ...defaultButtons[index], ...btn }));
   //分解数据
    let primaryBtn = buttons[0];
    let secondBtn = buttons[1];
    //创建警告弹框
    AlertDialog.show({
      title: title,
      message: msg,
      autoCancel: autoCancel,
      alignment: alignment,
      offset: alignment==DialogAlignment.Bottom?{ dx: 0, dy: -20 }:alignment==DialogAlignment.Top?{ dx: 0, dy: 20 }:{ dx: 0, dy: 0 },
      primaryButton: {
        value: primaryBtn.value,
        fontColor: primaryBtn.fontColor,
        backgroundColor: primaryBtn.backgroundColor,
        action: primaryBtn.callBack
      },
      secondaryButton: {
        value: secondBtn.value,
        fontColor: secondBtn.fontColor,
        backgroundColor: secondBtn.backgroundColor,
        action: secondBtn.callBack
      },
      gridCount
    })
  }
}

/**
 * 提供給警告弹窗按钮使用
 */
class AlertDialogBtn {
  /**
   * 按钮值
   */
  value?: string | Resource;
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
}