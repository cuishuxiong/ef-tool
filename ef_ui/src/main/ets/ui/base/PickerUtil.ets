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


import { picker } from '@kit.CoreFileKit';
import { ToastUtil } from '../prompt/ToastUtil';
import { BusinessError } from '@kit.BasicServicesKit';
import contact from '@ohos.contact';
import { common } from '@kit.AbilityKit';
import { photoAccessHelper } from '@kit.MediaLibraryKit';

/**
 * @Author csx
 * @DateTime 2024/5/11 09:26:05
 * @TODO PickerUtil  拉起系统picker工具类-均无需获取权限
 */
export class PickerUtil {
  /**
   * 初始化内置的文件选择后缀
   * @returns
   */
  private static initSuffixList(): Array<string> {
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
    return suffixList;
  }

  /**
   * 拉起picker选择文件 - 回调方式
   * @param options 选择入参详见efPickerOptions
   * @returns
   */
  static async selectFileCallBack(options?: efPickerOptions): Promise<void> {
    //默认的文档后缀集合
    if (!options) {
      options = new efPickerOptions();
      options.suffixList = PickerUtil.initSuffixList();
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
      options.suffixList = PickerUtil.initSuffixList();
    }
    try {
      let selectOpts = new picker.DocumentSelectOptions();
      selectOpts.fileSuffixFilters = options.suffixList;
      selectOpts.maxSelectNumber = options.maxNumber;
      selectOpts.selectMode = options.selectMode;
      //创建picker
      let context = getContext() as common.Context;
      let documentPicker = new picker.DocumentViewPicker(context);
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

  /**
   * 拉起picker选择文件 - 返回值方式
   * @param options 选择入参详见efPickerOptions
   * @returns
   */
  static async selectFile(options?: efPickerOptions): Promise<Array<string>> {
    if (!options) {
      options = new efPickerOptions();
      options.suffixList = PickerUtil.initSuffixList();
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
      options.suffixList = PickerUtil.initSuffixList();
    }
    let selectOpts = new picker.DocumentSelectOptions();
    selectOpts.fileSuffixFilters = options.suffixList;
    selectOpts.maxSelectNumber = options.maxNumber;
    selectOpts.selectMode = options.selectMode;
    //创建picker
    let documentPicker = new picker.DocumentViewPicker();
    //拉起
    let list = await documentPicker.select(selectOpts);
    if (list !== null && list !== undefined) {
      return list;
    }
    return new Array<string>();
  }

  /**
   * 拉起照片和视频选择 - 回调方式
   * @param options 选择入参详见efPickerOptions 参数中只有maxNumber使用
   * @returns
   */
  static async selectPhotoVideoCallBack(options?: efPickerOptions): Promise<void> {
    if (!options) {
      options = new efPickerOptions();
      options.maxNumber = 5;
    }
    if (!options.maxNumber) {
      options.maxNumber = 5;
    }
    try {
      let selectOpts = new photoAccessHelper.PhotoSelectOptions();
      selectOpts.maxSelectNumber = options.maxNumber;
      selectOpts.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_VIDEO_TYPE;
      //创建picker
      let photoPicker = new photoAccessHelper.PhotoViewPicker();
      //拉起选择
      let list: photoAccessHelper.PhotoSelectResult = await photoPicker.select(selectOpts);
      //回调
      if (list !== null && list !== undefined) {
        if (options?.selectCallBack) {
          options.selectCallBack(list.photoUris);
        }
      }
    } catch (err) {
      ToastUtil.showToast(err.message);
    }
  }

  /**
   * 拉起照片和视频选择 -返回值方式
   * @param options 选择入参详见efPickerOptions 参数中只有maxNumber使用
   * @returns
   */
  static async selectPhotoVideo(options?: efPickerOptions): Promise<Array<string>> {
    if (!options) {
      options = new efPickerOptions();
      options.maxNumber = 5;
    }
    if (!options.maxNumber) {
      options.maxNumber = 5;
    }
    let selectOpts = new photoAccessHelper.PhotoSelectOptions();
    selectOpts.maxSelectNumber = options.maxNumber;
    selectOpts.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_VIDEO_TYPE;
    //创建picker
    let photoPicker = new photoAccessHelper.PhotoViewPicker();
    //拉起选择
    let list: photoAccessHelper.PhotoSelectResult = await photoPicker.select(selectOpts);
    //回调
    if (list !== null && list !== undefined) {
      return list.photoUris;
    }
    return new Array<string>();
  }

  /**
   * 拉起picker选择音频 - 回调方式
   * @param options 选择入参详见efPickerOptions 参数中只有selectCallBack使用
   * @returns
   */
  static async selectAudioCallBack(options?: efPickerOptions): Promise<void> {
    try {
      //创建picker
      let documentPicker = new picker.AudioViewPicker();
      //调起选择
      documentPicker.select(new picker.AudioSelectOptions()).then((list: Array<string>) => {
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

  /**
   * 拉起picker选择音频 - 返回值方式
   * @returns
   */
  static async selectAudio(): Promise<Array<string>> {
    //创建picker
    let audioPicker = new picker.AudioViewPicker();
    //拉起
    let list = await audioPicker.select(new picker.AudioSelectOptions());
    if (list !== null && list !== undefined) {
      return list;
    }
    return new Array<string>();
  }

  /**
   * 拉起picker选择联系人 - 返回值方式
   * @returns
   */
  static async selectContact(options?: efPickerOptions): Promise<Array<contact.Contact>> {
    if (!options) {
      options = new efPickerOptions();
      options.isMultiSelect = true;
    }
    if (options.isMultiSelect == undefined) {
      options.isMultiSelect = true;
    }
    //创建picker
    let list = await contact.selectContacts({ isMultiSelect: options.isMultiSelect });
    if (list !== null && list !== undefined) {
      return list;
    }
    return new Array<contact.Contact>();
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
  selectMode?: picker.DocumentSelectMode;
  /**
   * 是否多选联系人
   */
  isMultiSelect?: boolean;
  /**
   * 选择完成回调
   */
  selectCallBack?: (list: Array<string>) => void = () => {
  };
}