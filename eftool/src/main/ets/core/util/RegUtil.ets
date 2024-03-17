/**
 * @Author csx
 * @DateTime 2023/12/29 21:56
 * @TODO ReUtil 正则工具类
 */
import { RegexConst as Const } from '../const/RegexConst'
import { HashSet } from '../base/HashSet'
import { OutDTO } from '../base/OutDTO'

export class RegUtil {
  /**
   * 正则表达式匹配中文汉字
   */
  private static RE_CHINESE: string = Const.CHINESE;
  /**
   * 正则表达式匹配中文字符串
   */
  private static RE_CHINESES: string = Const.CHINESES;
  /**
   * 正则中需要被转义的关键字
   */
  private static RE_KEYS: HashSet<string> = new HashSet<string>(['$', '(', ')', '*', '+', '.', '[', ']', '?', '\\', '^', '{', '}', '|']);

  /**
   * 给定内容是否匹配正则
   *
   * @param regex   正则
   * @param content 内容
   */
  static isMatch(pattern: string, content: string): OutDTO<string> {
    if (content == null || content == '') {
      // 提供 null 的字符串为不匹配
      return OutDTO.Error("验证字符串不能为空");
    }
    if (new RegExp(pattern).test(content)) {
      return OutDTO.OK("验证字符串格式正确")
    } else {
      return OutDTO.Error("验证字符串格式不正确,请检查")
    }
  }

  /**
   * 给定邮箱是否匹配正则
   *
   * @param content 邮箱字符串
   */
  static isEmailMatch(content: string): OutDTO<string> {
    if (content == null || content == '') {
      // 提供null的字符串为不匹配
      return OutDTO.Error("验证邮箱不能为空");
    }
    if (new RegExp(Const.EMAIL).test(content)) {
      return OutDTO.OK("邮箱格式正确")
    } else {
      return OutDTO.Error("邮箱格式不正确,请检查")
    }
  }

  /**
   * 给定手机号是否匹配正则
   *
   * @param content 手机号码
   */
  static isMobileMatch(content: string): OutDTO<string> {
    if (content == null || content == '') {
      // 提供null的字符串为不匹配
      return OutDTO.Error("验证手机号不能为空");
    }
    if (new RegExp(Const.MOBILE).test(content)) {
      return OutDTO.OK("手机号码格式正确")
    } else {
      return OutDTO.Error("手机号码格式不正确,请检查")
    }
  }

  /**
   * 给定身份证号是否匹配正则
   *
   * @param content 身份证号
   */
  static isIdCardMatch(content: string): OutDTO<string> {
    if (content == null || content == '') {
      // 提供null的字符串为不匹配
      return OutDTO.Error("验证身份证号不能为空");
    }
    if (new RegExp(Const.CITIZEN_ID).test(content)) {
      return OutDTO.OK("身份证号格式正确")
    } else {
      return OutDTO.Error("身份证号格式不正确,请检查")
    }
  }
}