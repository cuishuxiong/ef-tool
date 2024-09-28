/**
 Copyright 2024 csx - @yunkss/ef_axios

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


@Extend(Text)
function loadingTxt(fontSize: string | number) {
  .fontSize(fontSize)
  .fontColor("#fff")
}

/**
 * @Author csx
 * @DateTime 2024/5/24 21:05
 * @TODO Loading
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_axios
 */
@Entry({ routeName: 'efAxiosLoading', storage: LocalStorage.getShared() })
@Component
struct efAxiosLoading {
  @State rotateAngle: number = 0;
  /**
   * 属性配置
   */
  @LocalStorageProp('efAxiosLoadingOptions') options: efAxiosLoadingOptions = new efAxiosLoadingOptions();

  build() {
    Stack() {
      Column() {
        if (this.options.imgLayout != undefined && this.options.imgLayout === ImgLayout.TOP) {
          Column() {
            Image($r("app.media.axiosLoading"))
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
            Text(this.options.content)
              .margin({ top: UiConst.NUMBER_20 })
              .loadingTxt(this.options.fontSize ? this.options.fontSize : UiConst.FONT_16)
          }
          .width(this.options.layoutShape != undefined && this.options.layoutShape === LoadingShape.RECTANGLE ? '100%' :
            '50%')
        }
        if (this.options.imgLayout != undefined && this.options.imgLayout === ImgLayout.BOTTOM) {
          Column() {
            Text(this.options.content)
              .loadingTxt(this.options.fontSize ? this.options.fontSize : UiConst.FONT_16)
              .margin({ bottom: UiConst.NUMBER_20 })
            Image($r("app.media.axiosLoading"))
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
          .width(this.options.layoutShape != undefined && this.options.layoutShape === LoadingShape.RECTANGLE ? '100%' :
            '50%')
        }
        if (this.options.imgLayout != undefined && this.options.imgLayout === ImgLayout.RIGHT) {
          Row() {
            Text(this.options.content)
              .loadingTxt(this.options.fontSize ? this.options.fontSize : UiConst.FONT_16)
            Image($r("app.media.axiosLoading"))
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
          .width(this.options.layoutShape != undefined && this.options.layoutShape === LoadingShape.RECTANGLE ? '100%' :
            '50%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        if (this.options.imgLayout != undefined && this.options.imgLayout === ImgLayout.LEFT) {
          Row() {
            Image($r("app.media.axiosLoading"))
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
            Text(this.options.content)
              .loadingTxt(this.options.fontSize ? this.options.fontSize : UiConst.FONT_16)
              .margin({ left: UiConst.NUMBER_20 })
          }
          .width(this.options.layoutShape != undefined && this.options.layoutShape === LoadingShape.RECTANGLE ? '100%' :
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
export class efAxiosLoadingOptions {
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