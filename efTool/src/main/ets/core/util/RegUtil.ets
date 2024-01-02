/**
 * @Author csx
 * @DateTime 2023/12/29 21:56
 * @TODO ReUtil 正则工具类
 */
type Consumer = (matched: string) => void;
import { RegexConst as Const } from '../const/RegexConst'
import { HashSet } from '../base/HashSet'
import { MutableObj } from '../base/MutableObj'
import { StrUtil } from './StrUtil';

export class RegUtil {

  /**
   * 正则表达式匹配中文汉字
   */
  static RE_CHINESE: string = Const.CHINESE;
  /**
   * 正则表达式匹配中文字符串
   */
  static RE_CHINESES: string = Const.CHINESES;

  /**
   * 正则中需要被转义的关键字
   */
  static RE_KEYS: HashSet<string> = new HashSet<string>(['$', '(', ')', '*', '+', '.', '[', ']', '?', '\\', '^', '{', '}', '|']);


  /**
   * 给定内容是否匹配正则
   *
   * @param regex   正则
   * @param content 内容
   * @return 正则为null或者""则不检查，返回true，内容为null返回false
   */
  static isMatch(pattern: string, content: string): boolean {
    if (content == null) {
      // 提供null的字符串为不匹配
      return false;
    }
    if (content == null || pattern == null) {
      // 提供 null 的字符串为不匹配
      return false;
    }
    return new RegExp(pattern).test(content);
  }
}