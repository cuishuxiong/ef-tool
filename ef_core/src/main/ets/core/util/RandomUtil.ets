/**
 Copyright 2024 csx - @yunkss/ef_core

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

/**
 * @Author csx
 * @DateTime 2023/12/29 20:08
 * @TODO RandomUtil  随机数工具类
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_core
 */
import { OutDTO } from '../base/OutDTO';
import { buffer } from '@kit.ArkTS';

export class RandomUtil {
  /**
   * 获得随机Boolean值
   *
   * @return true or false
   */
  static randomBoolean(): boolean {
    return Math.random() < 0.5;
  }


  /**
   * 随机汉字（'\u4E00'-'\u9FFF'）
   *
   * @return 随机的汉字字符
   */
  static randomChinese(): string {
    const start = parseInt('4e00', 16); // 第一个汉字的 Unicode 编码
    const end = parseInt('9fa5', 16); // 最后一个汉字的 Unicode 编码
    const randomCode = Math.floor(Math.random() * (end - start) + start);
    return String.fromCharCode(randomCode);
  }

  /**
   * 获得指定范围内的随机数
   *
   * @param min 最小数（包含）
   * @param max 最大数（不包含）
   * @return 随机数
   */
  static randomNumber(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min) + min);
  }

  /**
   * 获得随机数number值
   *
   * @return 随机数
   */
  static randomInt(): number {
    return Math.floor(Math.random() * Number.MAX_SAFE_INTEGER);
  }

  /**
   * 获得指定范围内的随机数 [0,limit)
   *
   * @param limit 限制随机数的范围，不包括这个数
   * @return 随机数
   */
  static randomLimit(limit: number): number {
    return Math.floor(Math.random() * limit);
  }

  /**
   * 根据传入的大小生成随机字符串
   * @param size  生成字符串长度
   * @param resultCoding  返回结果的编码格式
   * @returns
   */
  static randomStrBySize(size: number, resultCoding: buffer.BufferEncoding): string {
    let randArray = new Uint8Array(size);
    for (let i = 0; i < size; i++) {
      randArray[i] = Math.floor(Math.random() * 256);
    }
    let str = buffer.from(randArray).toString(resultCoding);
    return str;
  }


  /**
   * 根据传入的大小生成utf8随机字符串
   * @param size  生成字符串长度
   * @returns
   */
  static randomUTF8StrBySize(size: number): string {
    // 定义可打印字符的范围
    const charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[]{};:,<.>/?';
    const charsetLength = charset.length;
    // 生成随机字符串
    let result = '';
    for (let i = 0; i < size; i++) {
      const randomIndex = Math.floor(Math.random() * charsetLength);
      result += charset.charAt(randomIndex);
    }
    return result;
  }

  /**
   * 根据传入的大小生成随机Uint8Array字节流
   * @param size 生成字符串长度
   * @returns
   */
  static randomUnitBySize(size: number): Uint8Array {
    let randArray = new Array<number>();
    for (let i = 0; i < size; i++) {
      randArray.push(Math.floor(Math.random() * 256));
    }
    return new Uint8Array(randArray);
  }

  /**
   * 生成CBC模式的iv
   * @param resultCoding  返回结果的编码格式(utf8/hex/base64)-不传默认为base64
   * @returns iv字符串
   */
  static generateIV(resultCoding: buffer.BufferEncoding = 'base64'): OutDTO<string> {
    if (resultCoding === 'utf8') {
      return OutDTO.OKByDataRow<string>('获取iv成功~', RandomUtil.randomUTF8StrBySize(16));
    }
    return OutDTO.OKByDataRow<string>('获取iv成功~', RandomUtil.randomStrBySize(16, resultCoding));
  }
}