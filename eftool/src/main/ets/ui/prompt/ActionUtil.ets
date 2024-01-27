import promptAction from '@ohos.promptAction'

import { UiConst as Const } from '../../core/const/UiConst'

/**
 * @Author csx
 * @DateTime 2024/1/24 19:32
 * @TODO ActionUtil  操作菜单工具类
 */
export class ActionUtil {
  /**
   * 显示操作菜单
   * @param options: {title:标题,btn:{text:显示文本,color:显示颜色,btnCallBack:点击菜单触发的事件}}
   */
  static showActionMenu(options: {
    title?: string | Resource,
    btn: Buttons[]
  }) {
    let { title = Const.ACTION_TITLE,btn } = options;
    // @ts-ignore
    const btns: [Button, Button?, Button?, Button?, Button?, Button?] = [
      { text: btn[0].text, color: btn[0].color }
    ];
    //判断传入的数据赋值
    btn.forEach((item, index) => {
      if (index > 0) {
        if (item) {
          btns[index] = { text: item.text, color: item.color };
        }
      }
    })
    let action = promptAction.showActionMenu({
      title: title,
      buttons: btns
    });
    action.then(data => {
      if (btn[data.index]) {
        btn[data.index].btnCallBack();
      }
    })
  }
}

/**
 * 自定义按钮对象
 */
class Buttons {
  public text: string;
  public color: string;
  public btnCallBack?: () => void;

  constructor(text: string, color: string, callBack: () => void) {
    this.text = text;
    this.color = color;
    this.btnCallBack = callBack;
  }
}