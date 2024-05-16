import picker from '@ohos.multimedia.cameraPicker';
import camera from '@ohos.multimedia.camera';
import { common } from '@kit.AbilityKit';
import { OutDTO } from '../../core/base/OutDTO';
/**
 * @Author csx
 * @DateTime 2024/5/11 09:30:05
 * @TODO CameraUtil  相机相关工具类
 */
export class CameraUtil {

  /**
   * 调起照相和录屏
   * @returns
   */
  static async picker(): Promise<OutDTO<picker.PickerResult>> {
    let mContext = getContext() as common.Context;
    let pickerProfile: picker.PickerProfile = {
      cameraPosition: camera.CameraPosition.CAMERA_POSITION_BACK
    };
    let pickerResult: picker.PickerResult = await picker.pick(mContext, [picker.PickerMediaType.PHOTO, picker.PickerMediaType.VIDEO], pickerProfile);
    return OutDTO.OKByDataRow<picker.PickerResult>('拍照或录制成功', pickerResult);
  }
}