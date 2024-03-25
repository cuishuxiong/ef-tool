/**
 * @Author csx
 * @DateTime 2024/3/25 15:54:03
 * @TODO LoadingUtil 全局加载工具类
 */
import { LoadingDialog } from '@kit.ArkUI'
import { UiConst } from '../../core/const/UiConst';


export class LoadingUtil {
  options: LoadOptions = new LoadOptions();
  /**
   * 自定义loading
   */
  private dialogControllerProgress: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog({
      content: this.options.content,
    }),
    autoCancel: this.options.autoCancel,
    alignment: this.options.alignment,
    offset: this.options.offset,
    customStyle: true,
    gridCount: this.options.gridCount,
    maskRect: this.options.maskRect,
    maskColor: this.options.maskColor,
    openAnimation: this.options.openAnimation,
    closeAnimation: this.options.closeAnimation,
    showInSubWindow: this.options.showInSubWindow,
    backgroundColor: this.options.backgroundColor,
    cornerRadius: this.options.cornerRadius,
    isModal: this.options.isModal
  })

  show() {
    this.dialogControllerProgress.open();
  }

  close() {
    this.dialogControllerProgress.close();
  }
}

/**
 * 加载框参数
 */
class LoadOptions {
  /**
   *是否允许点击遮障层退出
   */
  public autoCancel: boolean;
  public alignment: DialogAlignment;
  public offset: Offset;
  public gridCount: number;
  public maskRect: Rectangle;
  public maskColor: ResourceColor;
  public openAnimation: AnimateParam;
  public closeAnimation: AnimateParam;
  public showInSubWindow: boolean;
  public backgroundColor: ResourceColor;
  public cornerRadius: BorderRadiuses | Dimension;
  public isModal: boolean;
  public content: ResourceStr;

  constructor() {
    this.autoCancel = false;
    this.alignment = DialogAlignment.Center;
    this.offset = this.alignment == DialogAlignment.Bottom || this.alignment == DialogAlignment.BottomEnd || this.alignment == DialogAlignment.BottomStart ? {
      dx: 0,
      dy: -20
    } : this.alignment == DialogAlignment.Top || this.alignment == DialogAlignment.TopStart || this.alignment == DialogAlignment.TopEnd ? {
      dx: 0,
      dy: 20
    } : { dx: 0, dy: 0 };
    this.gridCount = 10;
    this.maskRect = { x: 0, y: 0, width: '100%', height: '100%' };
    this.maskColor = UiConst.DIALOG_CANCEL_COLOR
    this.openAnimation = { duration: 500, tempo: 0.7, curve: Curve.FastOutSlowIn };
    this.closeAnimation = { duration: 500, tempo: 0.7, curve: Curve.FastOutLinearIn };
    this.showInSubWindow = false;
    this.backgroundColor = UiConst.DIALOG_OK_COLOR;
    this.cornerRadius = { topLeft: '24vp', topRight: '24vp', bottomLeft: '24vp', bottomRight: '24vp' };
    this.isModal = true;
    this.content = '正在加载中,请稍等...';
  }
}