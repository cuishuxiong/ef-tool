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
 * @DateTime 2023/12/29 21:56
 * @TODO ReUtil 正则工具类
 */
import { RegexConst as Const } from '../const/RegexConst'
import { OutDTO } from '../base/OutDTO'

export class RegUtil {
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