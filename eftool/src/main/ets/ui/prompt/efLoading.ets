/**
 * @Author csx
 * @DateTime 2024/5/24 21:05
 * @TODO Loading
 */
import { UiConst } from '../../core/const/UiConst';

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
        Row() {
          Text(this.options.content)
            .fontSize(UiConst.FONT_16)
          Image($r("app.media.loading"))
            .width('30')
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .backgroundColor('#fff')
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
   * 图片布局方式(right在文字右侧,bottom在文字下方,top在文字上方,left在文字左侧)
   */
  @Track imgLayout?: ImgLayout;

  constructor() {
    this.content = '小的正在努力加载中...';
  }
}

/**
 * 图片文字布局枚举
 */
export declare enum ImgLayout {
  TOP,
  BOTTOM,
  LEFT,
  /**
   * 图片在文字右侧
   */
  RIGHT
}