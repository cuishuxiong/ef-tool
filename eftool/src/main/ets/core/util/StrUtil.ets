/**
 * @Author csx
 * @DateTime 2023/12/29 20:08
 * @TODO StrUtil   字符串工具类
 */
import { ArrayUtil } from './ArrayUtil';
import { CharUtil } from './CharUtil'

export class StrUtil {
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

  static isNotBlank(str: string): boolean {
    return false == StrUtil.isBlank(str);
  }


  static isBlankIfStr(obj: Object): boolean {
    if (null == obj) {
      return true;
    } else {
      return obj instanceof String ? StrUtil.isBlank(String(obj)) : false;
    }
  }

  static isEmptyIfStr(obj: Object): boolean {
    if (null == obj) {
      return true;
    } else if (obj instanceof String) {
      return 0 == (obj).length;
    } else {
      return false;
    }
  }

  static trim(strs: String[]): String[] {
    return strs.map((value) => value.trim());
  }

  /**
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
   * <p>字符串是否为空，空的定义如下：</p>
   * @param str 被检测的字符串
   * @return 是否为空
   */
  static isEmpty(str: string): boolean {
    return str == null || str.length == 0;
  }
}