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

import { filePreview } from '@kit.PreviewKit';
import common from '@ohos.app.ability.common';
import { fileUri } from '@kit.CoreFileKit';
import { ToastUtil } from '../prompt/ToastUtil';
import { OutDTO } from '@yunkss/ef_core';


/**
 * @Author csx
 * @DateTime 2024/5/11 09:41:05
 * @TODO PreviewUtil  预览工具类
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_ui
 */
export class PreviewUtil {
  /**
   * 预览文本
   * @param uri 预览uri
   */
  static async previewTxt(uri: string): Promise<void> {
    await PreviewUtil.openPreview('txt', uri);
  }

  /**
   * 预览网页
   * @param uri 预览uri
   */
  static async previewHtml(uri: string): Promise<void> {
    await PreviewUtil.openPreview('html', uri);
  }

  /**
   * 预览图片
   * @param uri 预览uri
   */
  static async previewImage(uri: string): Promise<void> {
    await PreviewUtil.openPreview('image', uri);
  }

  /**
   * 预览视频
   * @param uri 预览uri
   */
  static async previewVideo(uri: string): Promise<void> {
    await PreviewUtil.openPreview('video', uri);
  }

  /**
   * 预览音频
   * @param uri 预览uri
   */
  static async previewAudio(uri: string): Promise<void> {
    await PreviewUtil.openPreview('audio', uri);
  }

  /**
   * 打开预览
   * @param type  预览类型
   * @param uri  预览uri
   * @returns
   */
  private static async openPreview(type: string, uri: string): Promise<void> {
    //获取上下文
    let uiContext = getContext() as common.UIAbilityContext;
    //预览格式判断
    let result = PreviewUtil.rightFileSuffix(type, uri);
    if (result.getSuccess()) {
      //获取文件信息
      let fileUriObject = new fileUri.FileUri(uri);
      //文件名
      let fileName = fileUriObject.name;
      //预览文件信息
      let fileInfo: filePreview.PreviewInfo = {
        title: fileName,
        uri: uri,
        mimeType: result.getDataRow()
      };
      //悬浮窗口的属性值，包含了悬浮窗大小以及位置信息。2in1端不填写则展示默认大小窗口，手机和平板设备填写无效。
      let displayInfo: filePreview.DisplayInfo = {
        x: 100,
        y: 100,
        width: 800,
        height: 800
      };
      //打开预览
      await filePreview.openPreview(uiContext, fileInfo, displayInfo);
    } else {
      ToastUtil.showToast(result.getMsg());
    }
  }

  /**
   * 判断传入uri是否可以预览
   * @param uri 判断的uri
   * @returns
   */
  static async canPreview(uri: string): Promise<boolean> {
    return await filePreview.canPreview(getContext() as common.UIAbilityContext, uri);
  }

  /**
   * 预览格式判断
   * @param type  预览类型
   * @param uri  预览url
   * @returns 判断结果
   */
  private static rightFileSuffix(type: string, uri: string): OutDTO<string> {
    //判断结果
    let result: OutDTO<string> = OutDTO.create();
    //获取后缀
    let suffix = uri.substring(uri.lastIndexOf(".") + 1);
    if (type === 'txt') {
      result.setSuccess(true);
      if (suffix === 'txt') {
        result.setDataRow('text/plain');
      } else {
        result.setSuccess(false);
        result.setMsg("预览文本uri格式不正确~");
      }
    } else if (type === 'image') {
      result.setSuccess(true);
      if (['png', 'gif', 'webp', 'bmp'].includes(suffix)) {
        result.setDataRow('image/' + suffix);
      } else if (suffix === 'jpg' || suffix === 'jpeg') {
        result.setDataRow('image/jpeg');
      } else if (suffix === 'svg') {
        result.setDataRow('image/svg+xml');
      } else {
        result.setSuccess(false);
        result.setMsg("预览图片uri格式不正确~");
      }
    } else if (type === 'video') {
      result.setSuccess(true);
      if (suffix === 'mp4') {
        result.setDataRow('video/mp4');
      } else if (suffix === 'mkv') {
        result.setDataRow('video/x-matroska');
      } else if (suffix === 'ts') {
        result.setDataRow('video/mp2ts');
      } else {
        result.setSuccess(false);
        result.setMsg("预览视频uri格式不正确~");
      }
    } else if (type === 'audio') {
      result.setSuccess(true);
      if (['aac', 'ogg'].includes(suffix)) {
        result.setDataRow('audio/' + suffix);
      } else if (suffix === 'm4a') {
        result.setDataRow('audio/mp4a-latm');
      } else if (suffix === 'mp3') {
        result.setDataRow('audio/mpeg');
      } else if (suffix === 'wav') {
        result.setDataRow('audio/x-wav');
      } else {
        result.setSuccess(false);
        result.setMsg("预览音频uri格式不正确~");
      }
    } else if (type === 'html') {
      result.setSuccess(true);
      if (['html', 'htm'].includes(suffix)) {
        result.setDataRow('text/html');
      } else {
        result.setSuccess(false);
        result.setMsg("预览html的uri格式不正确~");
      }
    } else {
      result.setSuccess(false);
      result.setMsg("该uri格式暂时无法预览~");
    }
    return result;
  }
}