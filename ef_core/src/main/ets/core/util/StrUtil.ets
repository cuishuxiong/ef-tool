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
 * @TODO StrUtil   字符串工具类
 */
import { ArrayUtil } from './ArrayUtil';
import { Base64Util } from './Base64Util';
import { CharUtil } from './CharUtil'
import { util } from '@kit.ArkTS';
import { it } from '@ohos/hypium';

export class StrUtil {
  /**
   *判断字符串是否为空白符(空白符包括空格、制表符、全角空格和不间断空格)true为空，否则false
   * @param str
   * @returns
   */
  static isBlank(str: string): boolean {
    let length: number;
    if ((str == null) || ((length = str.length) == 0)) {
      return true;
    }
    for (let i = 0; i < length; i++) {
      // 只要有一个非空字符即为非空字符串
      if (false == CharUtil.isBlankChar(str.charCodeAt(i))) {
        return false;
      }
    }

    return true;
  }

  /**
   * 类型转换为字符串
   * @param s  传入要转换的值
   * @returns 转换后的字符串
   */
  static asString(s: object): string | undefined {
    return typeof s === 'string' ? s as string : undefined
  }

  /**
   * 判断字符串是否为非空白符(空白符包括空格、制表符、全角空格和不间断空格)true为非空，否则false
   * @param str
   * @returns
   */
  static isNotBlank(str: string): boolean {
    return false == StrUtil.isBlank(str);
  }

  /**
   * 判断传入的对象是否是空格
   * @param obj
   * @returns
   */
  static isBlankIfStr(obj: Object): boolean {
    if (null == obj) {
      return true;
    } else {
      return obj instanceof String ? StrUtil.isBlank(String(obj)) : false;
    }
  }

  /**
   * 判断传入的对象是否是空
   * @param obj
   * @returns
   */
  static isEmptyIfStr(obj: Object): boolean {
    if (null == obj) {
      return true;
    } else if (obj instanceof String) {
      return 0 == (obj).length;
    } else {
      return false;
    }
  }

  /**
   *去除传入集合的每个值的前后空格
   * @param strs
   * @returns
   */
  static trim(strs: String[]): String[] {
    return strs.map((value) => value.trim());
  }

  /**
   * 判断传入的字符串中是否包含有空值,只要有一个则返回true,否则false
   * @param strs 字符串列表
   * @return 是否包含空字符串
   */
  static hasBlank(...strs: string[]): boolean {
    if (ArrayUtil.strValIsEmpty(strs)) {
      return true;
    }
    for (let str of strs) {
      if (StrUtil.isBlank(str)) {
        return true;
      }
    }
    return false;
  }

  /**
   *  字符串是否为空
   * @param str 被检测的字符串
   * @return 是否为空
   */
  static isEmpty(str: string): boolean {
    return str == null || str.length == 0;
  }

  /**
   * 将字符串转换为驼峰
   * @param input  传入待转换字符串
   * @returns 转换后字符串
   */
  static camelCase(input: string = ''): string {
    if (!input) {
      return '';
    }
    // 将字符串转换为小写，并按照空格、下划线、中划线来分割单词
    const words = input.toLowerCase().split(/[\s_-]+/);
    // 将首字母小写的单词转换为驼峰命名
    const output = ArrayUtil.removeEmptyValues(words).map((word: string, index) => {
      if (index === 0) {
        return word;
      }
      return word.charAt(0).toUpperCase() + word.slice(1);
    }).join('');
    return output;
  }

  /**
   * 转换字符串首字母为大写，剩下为小写
   * @param str 待转换的字符串
   * @returns 转换后的
   */
  static capitalize(str: string = ''): string {
    if (!str) {
      return '';
    }
    const firstChar = str.charAt(0).toUpperCase();
    const restChars = str.slice(1).toLowerCase();
    return firstChar + restChars;
  }

  /**
   * 检查字符串是否以给定的字符串结尾
   * @param string 要检索的字符串
   * @param target 要检索字符
   * @param position 检索的位置
   * @returns 如果字符串以字符串结尾，那么返回 true，否则返回 false
   */
  static endsWith(string: string = '', target: string, position: number = string.length): boolean {
    return string.endsWith(target, position);
  }

  /**
   * 重复 N 次给定字符串
   * @param str  要重复的字符串
   * @param n  重复的次数
   * @returns
   */
  static repeat(str: string = '', n: number = 1): string {
    return str.repeat(n);
  }

  /**
   * 替换字符串中匹配的正则为给定的字符串
   * @param str   待替换的字符串
   * @param pattern  要匹配的内容正则或字符串
   * @param replacement 替换的内容
   * @returns 返回替换后的字符串
   */
  static replace(str: string = '', pattern: RegExp | string, replacement: string): string {
    return str.replace(pattern, replacement);
  }

  /**
   * 检查字符串是否以给定的字符串卡头
   * @param string 要检索的字符串
   * @param target 要检索字符
   * @param position 检索的位置
   * @returns 如果字符串以字符串开头，那么返回 true，否则返回 false
   */
  static startsWith(string: string = '', target: string, position: number = 0): boolean {
    return string.startsWith(target, position);
  }

  /**
   * 转换整个字符串的字符为小写
   * @param str  要转换的字符串
   * @returns 返回小写的字符串
   */
  static toLower(str: string = ''): string {
    return str.toLowerCase();
  }

  /**
   * 转换整个字符串的字符为大写
   * @param str  要转换的字符串
   * @returns 返回小写的字符串
   */
  static toUpper(str: string = ''): string {
    return str.toUpperCase();
  }


  /**
   * 截断字符串，如果字符串超出了限定的最大值。 被截断的字符串后面会以 omission 代替，omission 默认是 "..."
   * @param string  要截断的字符串
   * @param options 选项对象 StrOptions
   * @param options.length=20  允许的最大长度
   * @param options.omission='...'  超出后的代替字符
   * @param options.separator  截断点
   * @returns 截取后的字符串
   */
  static truncate(string: string = '', options?: StrOptions): string {
    if (!options) {
      options = new StrOptions();
    }
    if (string.length <= options.length) {
      return string;
    }
    if (!options.separator) {
      return string.slice(0, options.length) + options.omission;
    }
    if (typeof options.separator === 'string') {
      const index = string.indexOf(options.separator, options.length);
      if (index !== -1) {
        return string.slice(0, index) + options.omission;
      }
    } else if (options.separator instanceof RegExp) {
      const match = string.slice(0, options.length).match(options.separator);
      if (match) {
        return string.slice(0, options.length - (match[0].length)) + options.omission;
      }
    }
    return string.slice(0, options.length) + options.omission;
  }

  static isBase64String(str: string): boolean {
    let isOK = false;
    try {
      let arr = Base64Util.decodeSync(str);
      let decoder = new util.TextDecoder();
      let newArr = decoder.decodeWithStream(arr)
      if (str.length != newArr.length) {
        return true;
      }
      for (let i = 0; i < str.length; i++) {
        if (str.charCodeAt(i) !== newArr.charCodeAt(i)) {
          return true; // 字符不同，不是UTF-8格式的文本
        }
      }
    } catch (e) {
      return isOK;
    }
    return isOK;
  }

  static isUTF8String(str: string): boolean {
    // UTF-8 编码的字符串通常包含 ASCII 可打印字符和特定的 UTF-8 字符
    // 这里使用一个简单的正则表达式来判断
    const utf8Regex = /^[\x00-\x7F\xC2-\xFD]*$/;
    return utf8Regex.test(str);
  }

  static isHexString(str: string): boolean {
    // 十六进制字符串通常包含 0-9 和 a-f 或 A-F
    const hexRegex = /^[0-9a-fA-F]*$/;
    return hexRegex.test(str);
  }
}

export class StrOptions {
  length: number = 20;
  omission: string = '...';
  separator?: RegExp | string
}