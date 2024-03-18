import promptAction from '@ohos.promptAction'

import { UiConst as Const, UiConst } from '../../core/const/UiConst'
import { Button } from '@system.prompt';
import { ToastUtil } from './ToastUtil';

/**
 * @Author csx
 * @DateTime 2024/1/24 19:32
 * @TODO ActionUtil  操作菜单工具类
 */
export class ActionUtil {
  /**
   * 显示操作菜单
   * @param options:
   * {
   * title:标题,
   * btn:{text:显示文本,color:显示颜色,btnCallBack:点击菜单触发的事件}
   * showInSubWindow:某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗
   * isModal:弹窗是否为模态窗口，模态窗口有蒙层，非模态窗口无蒙层
   * }
   */
  static showActionMenu(options: ActionOptions) {
    if (!options) {
      options = new ActionOptions();
    }
    if (options.btn.length <= 0) {
      ToastUtil.showToast('菜单按钮数量必须大于1,且小于6!');
      return;
    }
    if (!options.title) {
      options.title = Const.ACTION_TITLE;
    }
    if (options.isModal == undefined) {
      options.isModal = true;
    }
    if (options.showInSubWindow == undefined) {
      options.showInSubWindow = false;
    }
    let resBtn: [Button, Button?, Button?, Button?, Button?, Button?] = [{
      text: options.btn[0].text,
      color: options.btn[0].color
    }];
    //判断传入的数据赋值
    options.btn.forEach((item, index) => {
      if (index > 0) {
        if (item) {
          resBtn[index] = {
            text: item.text, color: item.color
          };
        }
      }
    })

    let action = promptAction.showActionMenu({
      title: options.title,
      buttons: resBtn,
      isModal: options.isModal,
      showInSubWindow: options.showInSubWindow
    });
    action.then(data => {
      if (options.btn[data.index]) {
        options.btn[data.index].btnCallBack();
      }
    })
  }

  /**
   * 显示操作菜单
   * @param options:
   * {
   * title:标题,
   * btn:菜单字符串数组,
   * clickCallBack:点击菜单回调函数，默认传回当前点击菜单项
   * showInSubWindow:某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗
   * isModal:弹窗是否为模态窗口，模态窗口有蒙层，非模态窗口无蒙层
   * }
   */
  static showMenu(options: ActionBtnsOptions) {
    if (!options) {
      options = new ActionBtnsOptions();
    }
    if (!options.title) {
      options.title = Const.ACTION_TITLE;
    }
    if (options.isModal == undefined) {
      options.isModal = true;
    }
    if (options.showInSubWindow == undefined) {
      options.showInSubWindow = false;
    }
    const btns: [Button, Button?, Button?, Button?, Button?, Button?] = [
      { text: options.btn[0], color: Const.ALERT_OK_BG_COLOR }
    ];
    //判断传入的数据赋值
    options.btn.forEach((item, index) => {
      if (index > 0 && index < 6) {
        if (item) {
          btns[index] = { text: item, color: index % 2 == 0 ? Const.ALERT_OK_BG_COLOR : Const.MENU_BG_COLOR };
        }
      }
    })
    let action = promptAction.showActionMenu({
      title: options.title,
      buttons: btns
    });
    action.then(data => {
      options.clickCallBack(options.btn[data.index]);
    })
  }

  /**
   * 显示一个列表选择弹窗
   * @param options
   * {
   * title:提示,
   * msg:内容,
   * subtitle:副标题,
   * autoCancel:点击遮障层时，是否关闭弹窗,
   * offset:弹窗相对alignment所在位置的偏移量,
   * maskRect:弹窗遮蔽层区域，在遮蔽层区域内的事件不透传，在遮蔽层区域外的事件透传,
   * showInSubWindow:某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗,
   * isModal:弹窗是否为模态窗口，模态窗口有蒙层，非模态窗口无蒙层,
   * alignment:弹框对齐方式默认为(底部Bottom),
   * sheets:列表项字符串数组,
   * clickCallBack:点击列表项回调事件,默认传回选中的当前项,
   * backgroundColor:弹窗背板颜色,
   * backgroundBlurStyle:弹窗背板模糊材质
   * }
   */
  static showActionSheet(options: SheetOption) {
    if (!options) {
      options = new SheetOption();
    }
    if (!options.subtitle) {
      options.subtitle = '';
    }
    if (!options.title) {
      options.title = '';
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
    if (options.isModal == undefined) {
      options.isModal = true;
    }
    if (options.showInSubWindow == undefined) {
      options.showInSubWindow = false;
    }
    if (!options.backgroundColor) {
      options.backgroundColor = Color.Transparent;
    }
    if (!options.backgroundBlurStyle) {
      options.backgroundBlurStyle = BlurStyle.COMPONENT_THICK;
    }
    if (!options.offset) {
      options.offset = options.alignment == DialogAlignment.Bottom || options.alignment == DialogAlignment.BottomEnd || options.alignment == DialogAlignment.BottomStart ? {
        dx: 0,
        dy: -40
      } : options.alignment == DialogAlignment.Top || options.alignment == DialogAlignment.TopStart || options.alignment == DialogAlignment.TopEnd ? {
        dx: 0,
        dy: 40
      } : { dx: 0, dy: 0 };
    }
    //解构入参
    let sheetList = Array<SheetInfo>();
    //遍历组装数据
    options.sheets.forEach(item => {
      sheetList.push({ title: item, icon: $r("app.media.dian"), action: () => options.clickCallBack(item) })
    })
    ActionSheet.show({
      title: options.title,
      message: options.msg,
      autoCancel: options.autoCancel,
      alignment: options.alignment,
      offset: options.offset,
      sheets: sheetList,
      subtitle: options.subtitle,
      maskRect: options.maskRect,
      showInSubWindow: options.showInSubWindow,
      isModal: options.isModal,
      backgroundColor: options.backgroundColor,
      backgroundBlurStyle: options.backgroundBlurStyle
    })
  }
}

/**
 * sheet入参对象
 */
class SheetOption {
  title?: ResourceStr;
  msg?: ResourceStr;
  subtitle?: ResourceStr;
  autoCancel?: boolean;
  alignment?: DialogAlignment;
  sheets: Array<string> = new Array();
  offset?: Offset;
  maskRect?: Rectangle;
  showInSubWindow?: boolean;
  isModal?: boolean;
  backgroundColor?: ResourceColor;
  backgroundBlurStyle?: BlurStyle;
  clickCallBack: (data: string) => void = () => {
  }
}

/**
 * 简易版action入参对象
 */
class ActionBtnsOptions {
  title?: ResourceStr;
  btn: Array<string> = new Array();
  clickCallBack: (data: string) => void = () => {
  };
  showInSubWindow?: boolean = false;
  isModal?: boolean = true;
}

/**
 * actionMenu入参实体
 */
class ActionOptions {
  title?: ResourceStr;
  btn: Array<Buttons> = new Array();
  showInSubWindow?: boolean;
  isModal?: boolean;
}

/**
 * 自定义按钮对象
 */
class Buttons {
  public text: string = '';
  public color: string = '';
  public btnCallBack: () => void = () => {
  };
}