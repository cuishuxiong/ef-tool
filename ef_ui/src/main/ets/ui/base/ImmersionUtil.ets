/**
 Copyright 2024 csx - @yunkss/ef_ui

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

import { display, window } from '@kit.ArkUI';
import { Logger } from '@yunkss/ef_core';
import { BusinessError } from '@kit.BasicServicesKit';


export class TextMargin {
  left: number = 0; // 状态栏左偏移量
  right: number = 0; // 状态栏右偏移量
}

/**
 * @Author csx
 * @DateTime 2024/3/28 20:54
 * @TODO ImmersionUtil  沉浸式导航工具类
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_ui
 */
export class ImmersionUtil {
  //适配屏幕挖孔
  //https://developer.huawei.com/consumer/cn/forum/topic/0201145617527203077?fid=0109140870620153026

  private static instance: ImmersionUtil;
  cacheWindowStage?: window.WindowStage;
  private boundingRect: display.Rect[] = []; // 不可用区域数据
  private displayClass: display.Display | null = null;
  private topTextMargin: TextMargin = { left: 0, right: 0 }; // 顶部状态栏偏移量

  constructor() {
    if (!ImmersionUtil.instance) {
      ImmersionUtil.instance = this;
    }
    return ImmersionUtil.instance;
  }

  /**
   * 沉浸式设置
   * @param windowStage
   * @param isLayoutFullScreen  是否开启全屏默认true
   * @param hiddenBar  是否隐藏底部导航,默认false,当为true时页面无需避让
   * @param color  窗口背景颜色默认值为白色
   */
  immersiveWindow(windowStage: window.WindowStage, isLayoutFullScreen: boolean = true, hiddenBar: boolean = false,
    color: string = '#ffffff') {
    if (windowStage) {
      this.cacheWindowStage = windowStage;
    } else if (this.cacheWindowStage) {
      windowStage = this.cacheWindowStage;
    }
    //加载主窗口
    let windowClass = windowStage.getMainWindowSync();
    //1.设置全屏模式
    windowClass.setWindowLayoutFullScreen(isLayoutFullScreen).then(() => {
      windowClass.setWindowBackgroundColor(color);
    }).catch((err: BusinessError) => {
      Logger.error('设置全屏失败原因为:' + JSON.stringify(err));
    });
    // 2. 获取布局避让遮挡的区域
    let type = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR;
    let avoidArea = windowClass.getWindowAvoidArea(type);
    let bottomRectHeight = avoidArea.bottomRect.height;
    AppStorage.setOrCreate('bottomHeight', bottomRectHeight);
    if (hiddenBar) {
      // 3.设置顶部状态栏为隐藏状态
      windowClass.setWindowSystemBarEnable(['navigation']);
      this.displayClass = display.getDefaultDisplaySync();
      display.getDefaultDisplaySync().getCutoutInfo((err, data) => {
        if (err.code !== 0) {
          return;
        }
        this.boundingRect = data.boundingRects;
        this.topTextMargin = this.getBoundingRectPosition();
        AppStorage.setAndProp('topTextMargin', JSON.stringify(this.topTextMargin))
        // AppStorage.setOrCreate('topTextMargin', JSON.stringify(this.topTextMargin));
      });
      //3.设置顶部导航栏全部隐藏
      // windowClass.setSpecificSystemBarEnabled('status', false).then(() => {
      //   Logger.info('设置顶部导航隐藏成功.');
      // }).catch((err: BusinessError) => {
      //   Logger.error(`Failed to set the status bar to be invisible. Code is ${err.code}`, `message is ${err.message}`);
      // });
    }
  }

  /**
   * TODO 知识点：通过获取到的屏幕属性和屏幕不可用区域来判断不可用区域位置
   * 1.getCutoutInfo接口获取到不可用区域的左边界、上边界、宽度、高度。
   * 2.不可用区域左边宽度即为左边界的值。
   * 3.不可用区域右边界宽度等于屏幕宽度减去不可用区域宽度和左边界。
   * 4.获取到不可用区域到左右屏幕边缘的宽度进行对比判断出不可用区域位置。
   * 5.不可用区域位于中间时，不同设备左右距离可能存在小于10的差值，判断是否在中间取去左右距离差值的绝对值进行判断。
   * @returns left：左偏移量 right：右偏移量
   */
  getBoundingRectPosition(): TextMargin {
    if (this.boundingRect !== null && this.displayClass !== null && this.boundingRect[0] !== undefined) {
      // 不可用区域右侧到屏幕右边界的距离：屏幕宽度减去左侧宽度和不可用区域宽度
      const boundingRectRight: number =
        this.displayClass.width - (this.boundingRect[0].left + this.boundingRect[0].width);
      // 不可用区域左侧到屏幕左边界的距离：getCutoutInfo接口可以直接获取
      const boundingRectLeft: number = this.boundingRect[0].left;
      // 部分设备不可用区域在中间时存在左右距离会有10像素以内的差距，获取到的左右距离差值绝对值小于10都按照不可用区域位于中间处理
      if (Math.abs(boundingRectLeft - boundingRectRight) <= 10) {
        return { left: 0, right: 0 };
      }
      if (boundingRectLeft > boundingRectRight) {
        // 不可用区域在右边
        return { left: 0, right: this.displayClass.width - boundingRectLeft };
      } else if (boundingRectLeft < boundingRectRight) {
        // 不可用区域在左边
        return { left: this.boundingRect[0].left + this.boundingRect[0].width, right: 0 };
      }
    }
    return { left: 0, right: 0 };
  }
}