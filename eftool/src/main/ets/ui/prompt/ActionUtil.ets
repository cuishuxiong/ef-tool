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
    title?: ResourceStr,
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

  /**
   * 显示操作菜单
   * @param options: {title:标题,btn:菜单字符串数组,clickCallBack:点击菜单回调函数，默认传回当前点击菜单项}
   */
  static showMenu(options: {
    title?: ResourceStr,
    btn: Array<string>,
    clickCallBack:(data:string)=>void
  }) {
    let { title = Const.ACTION_TITLE,btn,clickCallBack } = options;
    // @ts-ignore
    const btns: [Button, Button?, Button?, Button?, Button?, Button?] = [
      { text: btn[0], color: Const.ALERT_OK_BG_COLOR  }
    ];
    //判断传入的数据赋值
    btn.forEach((item, index) => {
      if (index > 0 && index <6 ) {
        if (item) {
          btns[index] = { text: item, color: index%2==0?Const.ALERT_OK_BG_COLOR:Const.MENU_BG_COLOR };
        }
      }
    })
    let action = promptAction.showActionMenu({
      title: title,
      buttons: btns
    });
    action.then(data => {
       clickCallBack(btn[data.index]);
    })
  }


  /**
   * 显示一个列表选择弹窗
   * @param options  {title:提示,msg:内容,alignment:弹框对齐方式默认为(底部Bottom),sheets:列表项字符串数组,clickCallBack:点击列表项回调事件,默认传回选中的当前项}
   */
  static showActionSheet(options: {
    title?: ResourceStr,
    msg?: ResourceStr,
    alignment?: DialogAlignment
    sheets: Array<string>,
    clickCallBack:(data:string)=>void
  }) {
    //解构入参
    let { title='',msg='',alignment=DialogAlignment.Bottom,sheets=[""],clickCallBack } = options || {};
    let sheetList = [];
    //遍历组装数据
    sheets.forEach(item=>{
      sheetList.push({title:item,action:()=>clickCallBack(item)})
    })
    ActionSheet.show({
      title: title,
      message: msg,
      autoCancel: true,
      alignment: alignment,
      offset: alignment == DialogAlignment.Bottom ? { dx: 0, dy: -20 } : alignment == DialogAlignment.Top ? { dx: 0,dy: 20} : {dx: 0,dy: 0 },
      sheets: sheetList
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