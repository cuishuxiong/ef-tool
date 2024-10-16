/**
 Copyright 2024 csx - @yunkss/ef_rcp

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import { UiConst } from '@yunkss/ef_core';
import { efRcpConfig } from '../rcp/efRcpConfig';


@Extend(Text)
function loadingTxt(fontSize: string | number) {
  .fontSize(fontSize)
  .fontColor("#fff")
}

/**
 * @Author csx
 * @DateTime 2024/5/24 21:05
 * @TODO rcpLoading loading组件
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_rcp
 */
@Entry({ routeName: 'rcpLoading', storage: LocalStorage.getShared() })
@Component
struct rcpLoading {
  @State rotateAngle: number = 0;

  @Builder
  lottieImg() {
    Canvas(efRcpConfig.loading.lottieRenderingCtx)
      .width('50%')
      .height(60)
      .backgroundColor(Color.Transparent)
      .onReady(() => {
        //抗锯齿的设置
        efRcpConfig.loading.lottieRenderingCtx.imageSmoothingEnabled = true;
        efRcpConfig.loading.lottieRenderingCtx.imageSmoothingQuality = 'medium'
      })
  }

  @Builder
  imgBuilder() {
    Image($r("app.media.rcpLoading"))
      .width('30')
      .animation({
        duration: 50,
        curve: Curve.Linear,
        iterations: 1,
        tempo: 100,
        playMode: PlayMode.Normal,
        onFinish: () => {
          this.rotateAngle = this.rotateAngle + 15
        }
      })
      .rotate({ angle: this.rotateAngle })
      .onAppear(() => {
        this.rotateAngle = 15
      })
  }

  /**
   * 属性配置
   */
  @LocalStorageProp('rcpLoadingOptions') options: rcpLoadingOptions = new rcpLoadingOptions();

  build() {
    Stack() {
      Column() {
        if (this.options.imgLayout != undefined && this.options.imgLayout === RcpImgLayout.TOP) {
          Column() {
            if (efRcpConfig.loading.enableLottie) {
              this.lottieImg()
            } else if (efRcpConfig.loading.imgBuilder) {
              efRcpConfig.loading.imgBuilder.builder();
            } else {
              this.imgBuilder();
            }
            Text(this.options.content)
              .margin({ top: UiConst.NUMBER_20 })
              .loadingTxt(this.options.fontSize ? this.options.fontSize : UiConst.FONT_16)
          }
          .width(this.options.layoutShape != undefined && this.options.layoutShape === RcpLoadingShape.RECTANGLE ?
            '100%' :
            '50%')
        }
        if (this.options.imgLayout != undefined && this.options.imgLayout === RcpImgLayout.BOTTOM) {
          Column() {
            Text(this.options.content)
              .loadingTxt(this.options.fontSize ? this.options.fontSize : UiConst.FONT_16)
              .margin({ bottom: UiConst.NUMBER_20 })
            if (efRcpConfig.loading.enableLottie) {
              this.lottieImg()
            } else if (efRcpConfig.loading.imgBuilder) {
              efRcpConfig.loading.imgBuilder.builder();
            } else {
              this.imgBuilder();
            }
          }
          .width(this.options.layoutShape != undefined && this.options.layoutShape === RcpLoadingShape.RECTANGLE ?
            '100%' :
            '50%')
        }
        if (this.options.imgLayout != undefined && this.options.imgLayout === RcpImgLayout.RIGHT) {
          Row() {
            Text(this.options.content)
              .loadingTxt(this.options.fontSize ? this.options.fontSize : UiConst.FONT_16)
            if (efRcpConfig.loading.enableLottie) {
              this.lottieImg()
            } else if (efRcpConfig.loading.imgBuilder) {
              efRcpConfig.loading.imgBuilder.builder();
            } else {
              this.imgBuilder();
            }
          }
          .width(this.options.layoutShape != undefined && this.options.layoutShape === RcpLoadingShape.RECTANGLE ?
            '100%' :
            '50%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        if (this.options.imgLayout != undefined && this.options.imgLayout === RcpImgLayout.LEFT) {
          Row() {
            if (efRcpConfig.loading.enableLottie) {
              this.lottieImg()
            } else if (efRcpConfig.loading.imgBuilder) {
              efRcpConfig.loading.imgBuilder.builder();
            } else {
              this.imgBuilder();
            }
            Text(this.options.content)
              .loadingTxt(this.options.fontSize ? this.options.fontSize : UiConst.FONT_16)
              .margin({ left: UiConst.NUMBER_20 })
          }
          .width(this.options.layoutShape != undefined && this.options.layoutShape === RcpLoadingShape.RECTANGLE ?
            '100%' :
            '50%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Start)
        }
      }
      .backgroundColor('#aa000000')
      .borderRadius(UiConst.NUMBER_10)
      .margin({
        top: this.options.position === Alignment.Top ? UiConst.NUMBER_40 : UiConst.NUMBER_20,
        bottom: this.options.position === Alignment.Bottom ? UiConst.NUMBER_40 : UiConst.NUMBER_20,
        left: UiConst.NUMBER_20,
        right: UiConst.NUMBER_20
      })
      .padding({
        top: UiConst.NUMBER_20,
        bottom: UiConst.NUMBER_20,
        left: UiConst.NUMBER_20,
        right: UiConst.NUMBER_20
      })
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
export class rcpLoadingOptions {
  /**
   * 加载内容
   */
  @Track content: string = '';
  /**
   * 内容字体大小
   */
  @Track fontSize?: string | number;
  /**
   * loading位置
   */
  @Track position?: Alignment;
  /**
   * 图片布局方式
   */
  @Track imgLayout?: RcpImgLayout;
  /**
   * 弹框形状
   */
  @Track layoutShape?: RcpLoadingShape;
  /**
   * 弹框默认背景颜色
   */
  @Track winBgColor?: string;

  constructor() {
    this.content = '小的正在努力加载中...';
    this.winBgColor = '#00000000';
  }
}


/**
 * 弹框形状布局
 */
export enum RcpLoadingShape {
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
export enum RcpImgLayout {
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