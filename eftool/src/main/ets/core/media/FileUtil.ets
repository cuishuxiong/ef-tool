/**
 Copyright 2024 csx - @yunkss/eftool

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

import { StrUtil } from '@yunkss/ef_core';
import { fileUri } from '@kit.CoreFileKit';
import fs from '@ohos.file.fs';
import { common } from '@kit.AbilityKit';

/**
 * @Author csx
 * @DateTime 2024/6/6 00:23
 * @TODO FileUtil  文件工具类
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Feftool
 */
export class FileUtil {
  /**
   * 左斜杠
   */
  static readonly separator: string = '/';

  /**
   * 获取文件目录下的文件夹路径或文件路径。
   * @param dirPath 文件路径,支持完整路径 和 相对路径（download/wps/doc）。dirPath传空表示根目录
   * @param fileName 文件名（test.text）
   * @returns
   */
  static getFilesDirPath(dirPath: string, fileName?: string): string {
    let filePath = (getContext() as common.UIAbilityContext).filesDir; //根目录
    if (!StrUtil.isEmpty(dirPath)) {
      if (StrUtil.startsWith(dirPath, filePath)) { //路径中包含根目录，是完整路径。
        filePath = dirPath;
      } else { //路径中不包含根目录，拼接成完整路径。
        filePath = filePath + FileUtil.separator + dirPath;
      }
      if (!fs.accessSync(filePath)) {
        FileUtil.mkdirSync(filePath) //如果文件夹不存在就创建
      }
    }
    if (fileName && !StrUtil.isEmpty(fileName)) {
      filePath = filePath + FileUtil.separator + fileName;
    }
    return filePath;
  }

  /**
   * 获取缓存目录下的文件夹路径或文件路径。
   * @param dirPath 文件路径,支持完整路径 和 相对路径（download/wps/doc）。dirPath传空表示根目录
   * @param fileName 文件名（test.text）
   * @returns
   */
  static getCacheDirPath(dirPath: string, fileName?: string): string {
    let filePath = getContext().cacheDir; //根目录
    if (!StrUtil.isEmpty(dirPath)) {
      if (FileUtil.hasDirPath(dirPath)) { //路径中包含根目录，是完整路径。
        filePath = dirPath;
      } else { //路径中不包含根目录，拼接成完整路径。
        filePath = filePath + FileUtil.separator + dirPath;
      }
      if (!fs.accessSync(filePath)) {
        FileUtil.mkdirSync(filePath) //如果文件夹不存在就创建
      }
    }
    if (fileName && !StrUtil.isEmpty(fileName)) {
      filePath = filePath + FileUtil.separator + fileName;
    }
    return filePath;
  }

  /**
   * 获取临时目录下的文件夹路径或文件路径。
   * @param dirPath 文件路径,支持完整路径 和 相对路径（download/wps/doc）。dirPath传空表示根目录
   * @param fileName 文件名（test.text）
   * @returns
   */
  static getTempDirPath(dirPath: string, fileName?: string): string {
    let filePath = getContext().tempDir; //根目录
    if (!StrUtil.isEmpty(dirPath)) {
      if (FileUtil.hasDirPath(dirPath)) { //路径中包含根目录，是完整路径。
        filePath = dirPath;
      } else { //路径中不包含根目录，拼接成完整路径。
        filePath = filePath + FileUtil.separator + dirPath;
      }
      if (!fs.accessSync(filePath)) {
        FileUtil.mkdirSync(filePath) //如果文件夹不存在就创建
      }
    }
    if (fileName && !StrUtil.isEmpty(fileName)) {
      filePath = filePath + FileUtil.separator + fileName;
    }
    return filePath;
  }

  /**
   * 判断是否是完整路径
   * @param path 文件路径
   */
  static hasDirPath(path: string): boolean {
    let filesDir = getContext().filesDir; //根目录
    let cacheDir = getContext().cacheDir; //根目录
    let tempDir = getContext().tempDir; //根目录
    return StrUtil.startsWith(path, filesDir) || StrUtil.startsWith(path, cacheDir) ||
    StrUtil.startsWith(path, tempDir);
  }

  /**
   * 通过URI或路径获取文件名。
   * @param uriOrPath URI或路径
   * @returns
   */
  static getFileName(uriOrPath: string): string {
    return new fileUri.FileUri(uriOrPath).name;
  }

  /**
   * 通过URI或路径获取文件路径
   * @param uriOrPath URI或路径
   * @returns
   */
  static getFilePath(uriOrPath: string): string {
    return new fileUri.FileUri(uriOrPath).path;
  }

  /**
   * 通过URI或路径获取对应文件父目录的URI。
   * @param uriOrPath URI或路径
   */
  static getParentUri(uriOrPath: string): string {
    return new fileUri.FileUri(uriOrPath).getFullDirectoryUri();
  }

  /**
   * 通过URI或路径获取对应文件父目录的路径名。
   * @param uriOrPath URI或路径
   */
  static getParentPath(uriOrPath: string): string {
    let parentUri = FileUtil.getParentUri(uriOrPath);
    return FileUtil.getFilePath(parentUri)
  }

  /**
   * 根据文件名获取文件后缀
   * @param fileName 例如: test.txt  test.doc
   * @returns
   */
  static getFileExtention(fileName: string) {
    if (!StrUtil.isEmpty(fileName) && fileName.includes(".")) {
      return fileName.substring(fileName.lastIndexOf(".") + 1);
    }
    return '';
  }

  /**
   * 判断文件是否是普通文件。
   * @param file string|number 文件应用沙箱路径path或已打开的文件描述符fd。
   * @returns
   */
  static isFile(file: string | number): boolean {
    return fs.statSync(file).isFile();
  }

  /**
   * 判断文件是否是目录。
   * @param file string|number 文件应用沙箱路径path或已打开的文件描述符fd。
   * @returns
   */
  static isDirectory(file: string | number): boolean {
    return fs.statSync(file).isDirectory();
  }

  /**
   * 创建目录，当recursion指定为true，可多层级创建目录，使用Promise异步回调。
   * @param path 目录的应用沙箱路径。
   * @param recursion 是否多层级创建目录。recursion指定为true时，可多层级创建目录。recursion指定为false时，仅可创建单层目录。
   * @returns
   */
  static mkdir(path: string, recursion: boolean = true): Promise<void> {
    if (recursion) {
      return fs.mkdir(path, recursion);
    } else {
      return fs.mkdir(path);
    }
  }

  /**
   * 创建目录以同步方法，当recursion指定为true，可多层级创建目录。
   * @param path 目录的应用沙箱路径。
   * @param recursion 是否多层级创建目录。recursion指定为true时，可多层级创建目录。recursion指定为false时，仅可创建单层目录。
   */
  static mkdirSync(path: string, recursion: boolean = true) {
    if (recursion) {
      fs.mkdirSync(path, recursion);
    } else {
      fs.mkdirSync(path);
    }
  }

  /**
   * 格式化文件大小
   * @param fileSize
   * @returns
   */
  static getFormatFileSize(fileSize: number): string {
    if (fileSize < 1024) {
      return fileSize + "B";
    } else if (fileSize < 1024 * 1024) {
      return (fileSize / 1024).toFixed(1) + "KB";
    } else if (fileSize < 1024 * 1024 * 1024) {
      return (fileSize / (1024 * 1024)).toFixed(1) + "MB";
    } else if (fileSize < 1024 * 1024 * 1024 * 1024) {
      return (fileSize / (1024 * 1024 * 1024)).toFixed(1) + "GB";
    } else {
      return (fileSize / (1024 * 1024 * 1024 * 1024)).toFixed(1) + "TB";
    }
  }

  /**
   * 获取resources/rawfile目录下对应的rawfile文件内容，使用同步形式返回
   * @param path rawfile文件路径
   * @returns
   */
  static getRawFileContentSync(path: string): Uint8Array {
    let resourceManager = getContext().resourceManager;
    return resourceManager.getRawFileContentSync(path);
  }

  /**
   * 获取resources/rawfile目录下对应的rawfile文件内容，使用Promise异步回调
   * @param path
   * @returns
   */
  static getRawFileContent(path: string): Promise<Uint8Array> {
    let resourceManager = getContext().resourceManager;
    return resourceManager.getRawFileContent(path);
  }

  /**
   * 从给定的uri中获取文件二进制流
   * @param uri 如picker返回的uri
   * @returns 文件的ArrayBuffer
   */
  static getBufferByURI(uri: string): ArrayBuffer {
    //创建文件信息
    let fileUriObject = new fileUri.FileUri(uri);
    //获取文件名
    let name = fileUriObject.name;
    //打开文件
    let file = fs.openSync(uri, fs.OpenMode.READ_ONLY);
    //读取文件大小
    let info = fs.statSync(file.fd);
    //缓存照片数据
    let bufferImg: ArrayBuffer = new ArrayBuffer(info.size);
    //写入缓存
    fs.readSync(file.fd, bufferImg);
    //关闭文件流
    fs.closeSync(file);
    //返回
    return bufferImg;
  }

  /**
   * 删除路径下的文件
   * @param path  要删除的路径
   * @param fileName  要删除的文件 为空则删除path目录  直接写文件名即可无需左斜杠
   * @returns true删除成功，false删除失败
   */
  static deleteFile(path: string, fileName?: string): boolean {
    try {
      if (fileName) {
        //删除文件
        fs.unlinkSync(path + '/' + fileName);
        return true;
      }
      //删除整个目录
      fs.rmdirSync(path);
      return true;
    } catch (e) {
      return false;
    }
  }
}