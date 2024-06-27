/**
 * @Author csx
 * @DateTime 2024/5/24 21:05
 * @TODO Loading
 */
import { UiConst } from '../../core/const/UiConst';


@Extend(Text)
function loadingTxt() {
  .fontSize(UiConst.FONT_16)
  .fontColor("#fff")
}

@Preview
@Entry({ routeName: 'efLoading', storage: LocalStorage.getShared() })
@Component
struct efAlert {
  /**
   * 属性配置
   */
  @LocalStorageProp('efLoadingOptions') options: efLoadingOptions = new efLoadingOptions();

  build() {
    Stack() {
      Column() {
        if (this.options.imgLayout != undefined && this.options.imgLayout === ImgLayout.TOP) {
          Column() {
            Image($r("app.media.loading"))
              .width('30')
            Text(this.options.content)
              .margin({ top: UiConst.NUMBER_20 })
              .loadingTxt()
          }
          .width(this.options.layoutShape != undefined && this.options.layoutShape === LoadingShape.RECTANGLE ? '100%' : '50%')
        }
        if (this.options.imgLayout != undefined && this.options.imgLayout === ImgLayout.BOTTOM) {
          Column() {
            Text(this.options.content)
              .loadingTxt()
              .margin({ bottom: UiConst.NUMBER_20 })
            Image($r("app.media.loading"))
              .width('30')
          }
          .width(this.options.layoutShape != undefined && this.options.layoutShape === LoadingShape.RECTANGLE ? '100%' : '50%')
        }
        if (this.options.imgLayout != undefined && this.options.imgLayout === ImgLayout.RIGHT) {
          Row() {
            Text(this.options.content)
              .loadingTxt()
            Image($r("app.media.loading"))
              .width('30')
          }
          .width(this.options.layoutShape != undefined && this.options.layoutShape === LoadingShape.RECTANGLE ? '100%' : '50%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        if (this.options.imgLayout != undefined && this.options.imgLayout === ImgLayout.LEFT) {
          Row() {
            Image($r("app.media.loading"))
              .width('30')
            Text(this.options.content)
              .loadingTxt()
              .margin({ left: UiConst.NUMBER_20 })
          }
          .width(this.options.layoutShape != undefined && this.options.layoutShape === LoadingShape.RECTANGLE ? '100%' : '50%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Start)
        }
      }
      .backgroundColor('#cc000000')
      .borderRadius(UiConst.NUMBER_10)
      .margin({
        top: this.options.position === Alignment.Top ? UiConst.NUMBER_40 : UiConst.NUMBER_20,
        bottom: this.options.position === Alignment.Bottom ? UiConst.NUMBER_40 : UiConst.NUMBER_20,
        left: UiConst.NUMBER_20,
        right: UiConst.NUMBER_20
      })
      .padding({ top: UiConst.NUMBER_20, bottom: UiConst.NUMBER_20, left: UiConst.NUMBER_20, right: UiConst.NUMBER_20 })
    }
    .alignContent(this.options.position ? this.options.position : Alignment.Center)
    .width('100%')
    .height('100%')
  }
}

/**
 * 窗口loading方式入参实体
 */
@Observed
export class efLoadingOptions {
  /**
   * 加载内容
   */
  @Track content: string = '';
  /**
   * loading位置
   */
  @Track position?: Alignment;
  /**
   * 图片布局方式
   */
  @Track imgLayout?: ImgLayout;
  /**
   * 弹框形状
   */
  @Track layoutShape?: LoadingShape;

  constructor() {
    this.content = '小的正在努力加载中...';
  }
}


/**
 * 弹框形状布局
 */
export enum LoadingShape {
  /**
   * 正方形
   */
  SQUARE,
  /**
   * 矩形
   */
  RECTANGLE
}

/**
 * 图片文字布局枚举
 */
export enum ImgLayout {
  /**
   * 图片在文字上方
   */
  TOP,
  /**
   * 图片在文字下方
   */
  BOTTOM,
  /**
   * 图片在文字左侧
   */
  LEFT,
  /**
   * 图片在文字右侧
   */
  RIGHT
}