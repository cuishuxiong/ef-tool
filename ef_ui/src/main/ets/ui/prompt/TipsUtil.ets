/**
 * @Author csx
 * @DateTime 2024/3/27 19:55
 * @TODO TipsUtil  提示弹出框工具类
 */
import { TipsDialog } from '@kit.ArkUI';
import { UiConst } from '@yunkss/ef_core';

@Component
export struct TipsUtil {
  @Prop @Watch("change") options: TipsOptions = new TipsOptions();
  private isChecked: boolean = true;
  /**
   * 自定义Tips
   */
  private dialogControllerProgress: CustomDialogController = new CustomDialogController({
    builder: TipsDialog({
      title: this.options.title,
      content: this.options.content,
      imageRes: $r("app.media.tips"),
      imageSize: { width: 40, height: 40 },
      checkTips: this.options.checkTips != undefined ? this.options.checkTips : '不再提醒',
      isChecked: this.isChecked,
      primaryButton: {
        value: this.options.btnList ? this.options.btnList[0] : '同意',
        background: UiConst.DIALOG_OK_COLOR,
        fontColor: UiConst.ALERT_OK_COLOR,
        action: () => {
          this.isChecked = true;
          this.options.clickCallBack(0, this.isChecked);
        }
      },
      secondaryButton: {
        value: this.options.btnList && this.options.btnList.length > 1 ? this.options.btnList[1] : '取消',
        background: UiConst.DIALOG_CANCEL_COLOR,
        fontColor: UiConst.ALERT_OK_COLOR,
        action: () => {
          this.isChecked = false;
          this.options.clickCallBack(1, this.isChecked);
        }
      }
    }),
    autoCancel: false,
    alignment: this.options.alignment != undefined ? this.options.alignment : DialogAlignment.Center,
    offset: this.options.offset != undefined ? this.options.offset : this.options.alignment == DialogAlignment.Bottom || this.options.alignment == DialogAlignment.BottomEnd || this.options.alignment == DialogAlignment.BottomStart ? {
      dx: 0,
      dy: -20
    } : this.options.alignment == DialogAlignment.Top || this.options.alignment == DialogAlignment.TopStart || this.options.alignment == DialogAlignment.TopEnd ? {
      dx: 0,
      dy: 50
    } : { dx: 0, dy: 0 },
    customStyle: true,
    gridCount: 10,
    maskRect: { x: 0, y: 0, width: '100%', height: '100%' },
    // maskColor: UiConst.DIALOG_CANCEL_COLOR,
    openAnimation: { duration: 500, tempo: 0.7, curve: Curve.EaseInOut },
    closeAnimation: { duration: 500, tempo: 0.7, curve: Curve.FastOutLinearIn },
    showInSubWindow: false,
    isModal: true
  })

  change() {
    if (!this.options.title) {
      this.options.title = '温馨提示';
    }
    if (this.options.show) {
      this.show();
    } else {
      this.close()
    }
  }

  /**
   * 打开提示模态框
   */
  show() {
    this.dialogControllerProgress.open();
  }

  /**
   * 关闭提示模态框
   */
  close() {
    this.dialogControllerProgress.close();
  }

  build() {
    Row()
  }
}

/**
 * Tips框参数
 */
class TipsOptions {
  /**
   * 提示框标题
   */
  public title?: ResourceStr;
  /**
   * 提示框内容
   */
  public content?: ResourceStr;
  /**
   * checkbox的提示内容
   */
  public checkTips?: ResourceStr;
  /**
   * 按钮字符串数组
   */
  public btnList?: Array<string>;
  /**
   * 点击弹框按钮回调函数
   */
  public clickCallBack: (index: number, isCheck: boolean) => void = () => {
  };
  /**
   * 是否显示
   */
  public show: boolean = false;
  /**
   * 弹窗在竖直方向上的对齐方式
   */
  public alignment?: DialogAlignment;
  /**
   * 弹窗相对alignment所在位置的偏移量
   */
  public offset?: Offset;
}