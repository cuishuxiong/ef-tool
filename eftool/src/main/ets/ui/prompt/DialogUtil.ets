import promptAction from '@ohos.promptAction'

import { UiConst as Const } from '../../core/const/UiConst'
/**
 * @Author csx
 * @DateTime 2024/1/24 19:31
 * @TODO DialogUtil 对话框工具类
 */
export class DialogUtil {

  /**
   * 创建一个dialog提示框
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
}