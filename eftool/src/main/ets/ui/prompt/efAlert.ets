/**
 * @Author csx
 * @DateTime 2024/5/24 21:05
 * @TODO Loading
 */
import { UiConst } from '../../core/const/UiConst';
import { WinDialogUtil } from './WinDialogUtil';

@Entry({ routeName: 'efAlert' })
@Component
export struct efAlert {
  /**
   * 属性配置
   */
  @StorageProp('efAlertOptions') options: efAlertOptions = new efAlertOptions();

  build() {
    Stack() {
      Column() {
        Row() {
          Text(this.options.title)
            .fontSize(UiConst.FONT_18)
          Image($r("app.media.tips"))
            .width(UiConst.NUMBER_18)
            .margin({ left: UiConst.NUMBER_5 })
            .padding({ bottom: UiConst.NUMBER_3 })
        }.width('100%')

        Row() {
          Text(this.options.content)
            .fontSize(UiConst.FONT_16)
        }
        .margin({ top: UiConst.NUMBER_20 })
        .width('100%')

        Row() {
          Button(this.options.okText)
            .backgroundColor(UiConst.ALERT_OK_BG_COLOR)
            .padding({ left: UiConst.NUMBER_50, right: UiConst.NUMBER_50 })
            .onClick(() => {
              //确定点击事件
              if (this.options.okCallBack) {
                this.options.okCallBack();
              }
              //关闭弹窗
              WinDialogUtil.closeAlert();
            })
          Button(this.options.cancelText)
            .backgroundColor(UiConst.DIALOG_CANCEL_COLOR)
            .padding({ left: UiConst.NUMBER_50, right: UiConst.NUMBER_50 })
            .onClick(() => {
              //取消点击事件
              if (this.options.cancelCallBack) {
                this.options.cancelCallBack();
              }
              //关闭弹窗
              WinDialogUtil.closeAlert();
            })
        }
        .padding({ top: UiConst.NUMBER_20 })
        .width('100%')
        .alignItems(VerticalAlign.Bottom)
        .justifyContent(FlexAlign.SpaceAround)
      }
      .backgroundColor('#fff')
      .borderRadius(UiConst.NUMBER_10)
      .margin({ top: UiConst.NUMBER_20, bottom: UiConst.NUMBER_20, left: UiConst.NUMBER_20, right: UiConst.NUMBER_20 })
      .padding({ top: UiConst.NUMBER_20, bottom: UiConst.NUMBER_20, left: UiConst.NUMBER_20, right: UiConst.NUMBER_20 })
    }
    .width('100%')
    .height('100%')
  }
}

/**
 *
 */
export class efAlertOptions {
  /**
   * 提醒标题
   */
  title?: string;
  /**
   * 提醒内容
   */
  content?: string;
  /**
   * 确认文本
   */
  okText?: string;
  /**
   * 取消文本
   */
  cancelText?: string;
  /**
   * 确认回调函数
   */
  okCallBack?: () => void = () => {
  };
  /**
   * 取消回调函数
   */
  cancelCallBack?: () => void = () => {
  };

  constructor() {
    this.title = '温馨提示';
    this.okText = "确定";
    this.cancelText = "取消";
  }
}