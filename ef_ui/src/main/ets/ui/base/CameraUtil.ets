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

import camera from '@ohos.multimedia.camera';
import { common } from '@kit.AbilityKit';
import { cameraPicker as picker } from '@kit.CameraKit';


/**
 * @Author csx
 * @DateTime 2024/5/11 09:30:05
 * @TODO CameraUtil  相机相关工具类
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_ui
 */
export class CameraUtil {
  /**
   * 调起照相和录屏
   * @returns
   */
  static async picker(): Promise<picker.PickerResult> {
    let mContext = getContext() as common.Context;
    let pickerProfile: picker.PickerProfile = {
      cameraPosition: camera.CameraPosition.CAMERA_POSITION_BACK
    };
    let pickerResult: picker.PickerResult =
      await picker.pick(mContext, [picker.PickerMediaType.PHOTO, picker.PickerMediaType.VIDEO], pickerProfile);
    return pickerResult;
  }
}