import promptAction from '@ohos.promptAction'

import { UiConst as Const } from '../../core/const/UiConst'
import { JSONUtil } from '../../core/util/JSONUtil';
/**
 * @Author csx
 * @DateTime 2024/1/24 19:32
 * @TODO ActionUtil  操作菜单工具类
 */
export class ActionUtil {
  static showActionMenu(options: {
    title?: string | Resource,
    btn?: Buttons[]
  }) {
    let { title = '操作',btn=[] } = options;
    let action = promptAction.showActionMenu({
      title: title,
      buttons: [
        btn[0] ? { text: btn[0].text, color: btn[0].color } : { text: Const.DIALOG_OK, color: Const.DIALOG_OK_COLOR },
        btn[1] ? { text: btn[1].text, color: btn[1].color } : undefined,
        btn[2] ? { text: btn[2].text, color: btn[2].color } : undefined,
        btn[3] ? { text: btn[3].text, color: btn[3].color } : undefined,
        btn[4] ? { text: btn[4].text, color: btn[4].color } : undefined,
        btn[5] ? { text: btn[5].text, color: btn[5].color } : undefined,
      ]
    });
    action.then(data => {
      console.info(JSONUtil.toJSONString(data))
    })
  }
}

class Buttons {
  public text: string;
  public color: string;
  public btnCallBack: () => void;

  constructor(text: string, color: string, callBack: () => void) {
    this.text = text;
    this.color = color;
    this.btnCallBack = callBack;
  }
}