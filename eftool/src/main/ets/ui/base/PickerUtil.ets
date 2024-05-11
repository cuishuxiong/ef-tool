/**
 * @Author csx
 * @DateTime 2024/5/11 09:26:05
 * @TODO PickerUtil  拉起系统picker工具类
 */
import { picker } from '@kit.CoreFileKit';
import { ToastUtil } from '../prompt/ToastUtil';
import { BusinessError } from '@kit.BasicServicesKit';
import { AuthUtil } from '../../core/auth/AuthUtil';

export class PickerUtil {
  /**
   * 拉起picker选择文件
   * @param options 选择入参详见efPickerOptions
   * @returns
   */
  static async selectFile(options?: efPickerOptions): Promise<void> {
    //1.校验是否有权限
    let isAuth = await AuthUtil.checkPermissions('ohos.permission.READ_MEDIA');
    if (!isAuth) {
      let res = await AuthUtil.reqPermissions('ohos.permission.READ_MEDIA');
      if (res < 0) {
        ToastUtil.showToast('用户取消授权读取媒体文件,调用失败~');
        return;
      }
    }
    //默认的文档后缀集合
    let suffixList = new Array<string>();
    suffixList.push('.doc');
    suffixList.push('.docx');
    suffixList.push('.pdf');
    suffixList.push('.ppt');
    suffixList.push('.pptx');
    suffixList.push('.txt');
    suffixList.push('.wps');
    suffixList.push('.xls');
    suffixList.push('.xlsx');
    if (!options) {
      options = new efPickerOptions();
      options.suffixList = suffixList;
      options.maxNumber = 5;
      options.selectMode = picker.DocumentSelectMode.FILE;
    }
    if (!options.maxNumber) {
      options.maxNumber = 5;
    }
    if (!options.selectMode) {
      options.selectMode = picker.DocumentSelectMode.FILE;
    }
    if (!options.suffixList) {
      options.suffixList = suffixList;
    }
    try {
      let selectOpts = new picker.DocumentSelectOptions();
      selectOpts.fileSuffixFilters = options.suffixList;
      selectOpts.maxSelectNumber = options.maxNumber;
      selectOpts.selectMode = options.selectMode;
      //创建picker
      let documentPicker = new picker.DocumentViewPicker();
      documentPicker.select(selectOpts).then((list: Array<string>) => {
        if (list !== null && list !== undefined) {
          if (options?.selectCallBack) {
            options.selectCallBack(list);
          }
        }
      }).catch((err: BusinessError) => {
        ToastUtil.showToast(err.message);
      });
    } catch (err) {
      ToastUtil.showToast(err.message);
    }
  }

  static async selectPhotoVideo(options?: efPickerOptions): Promise<void> {
    //1.校验是否有权限
    let isAuth = await AuthUtil.checkPermissions('ohos.permission.READ_MEDIA');
    if (!isAuth) {
      let res = await AuthUtil.reqPermissions('ohos.permission.READ_MEDIA');
      if (res < 0) {
        ToastUtil.showToast('用户取消授权读取媒体文件,调用失败~');
        return;
      }
    }
    if (!options) {
      options = new efPickerOptions();
      options.maxNumber = 5;
    }
    if (!options.maxNumber) {
      options.maxNumber = 5;
    }
    try {
      let selectOpts = new picker.PhotoSelectOptions();
      selectOpts.maxSelectNumber = options.maxNumber;
      selectOpts.MIMEType = picker.PhotoViewMIMETypes.IMAGE_VIDEO_TYPE;
      //创建picker
      let photoPicker = new picker.PhotoViewPicker();
      photoPicker.select(selectOpts).then((list: picker.PhotoSelectResult) => {
        if (list !== null && list !== undefined) {
          if (options?.selectCallBack) {
            options.selectCallBack(list.photoUris);
          }
        }
      }).catch((err: BusinessError) => {
        ToastUtil.showToast(err.message);
      });
    } catch (err) {
      ToastUtil.showToast(err.message);
    }
  }
}

/**
 * picker选择入参实体
 */
class efPickerOptions {
  /**
   * 选择文件的后缀类型
   */
  suffixList?: Array<string>;
  /**
   *选择文档的最大数目
   */
  maxNumber?: number;
  /**
   * 选择模式是文件还是目录
   */
  selectMode?: number;
  /**
   * 选择完成回调
   */
  selectCallBack: (list: Array<string>) => void = () => {
  };
}