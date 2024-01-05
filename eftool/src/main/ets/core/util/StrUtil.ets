/**
 * @Author csx
 * @DateTime 2023/12/29 20:08
 * @TODO StrUtil   字符串工具类
 */
import { ArrayUtil } from './ArrayUtil';
import { CharUtil } from './CharUtil'

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
   *判断字符串是否为非空白符(空白符包括空格、制表符、全角空格和不间断空格)true为非空，否则false
   * @param str
   * @returns
   */
  static isNotBlank(str: string): boolean {
    return false == StrUtil.isBlank(str);
  }

  /**
   *
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
   *
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
      if (this.isBlank(str)) {
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
}