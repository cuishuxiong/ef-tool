/**
 * @Author csx
 * @DateTime 2024/3/27 19:56
 * @TODO SelectUtil
 */
import { SelectDialog } from '@kit.ArkUI';
import { UiConst } from '../../core/const/UiConst';

@Component
export struct SelectUtil {
  @Prop @Watch("change") options: SelectOptions = new SelectOptions();
  private radioIndex = -1;
  private radioList: Array<SheetInfo> = new Array<SheetInfo>();
  /**
   * 自定义Tips
   */
  private dialogControllerProgress: CustomDialogController = new CustomDialogController({
    builder: SelectDialog({
      title: this.options.title != undefined ? this.options.title : '请选择',
      content: this.options.content != undefined ? this.options.content : '',
      selectedIndex: this.radioIndex,
      confirm: {
        value: this.options.btnTxt != undefined ? this.options.btnTxt : '取消',
        background: UiConst.DIALOG_OK_COLOR,
        fontColor: UiConst.ALERT_OK_COLOR,
        action: () => {
          this.options.clickCallBack("");
        }
      },
      radioContent: this.radioList
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
    if (this.options.ctxList) {
      this.radioList = new Array();
      this.options.ctxList.forEach((item) => {
        this.radioList.push({
          title: item,
          action: () => {
            this.radioIndex = this.options.ctxList.indexOf(item);
            this.options.clickCallBack(this.options.ctxList[this.radioIndex]);
          }
        })
      })
    }
    if (this.options.show) {
      this.show();
    } else {
      this.radioIndex = -1;
      this.radioList = new Array();
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
 * 下拉框框参数
 */
class SelectOptions {
  /**
   * 选择弹出框标题
   */
  public title?: ResourceStr;
  /**
   * 选择弹出框内容
   */
  public content?: ResourceStr;
  /**
   * 选项内容数组
   */
  public ctxList: Array<string> = new Array();
  /**
   * 按钮字符串
   */
  public btnTxt?: string;
  /**
   * 点击弹框按钮回调函数
   */
  public clickCallBack: (selectData: string) => void = () => {
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