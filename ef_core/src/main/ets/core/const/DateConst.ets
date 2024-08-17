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
 * @DateTime 2024/1/3 20:45
 * @TODO DateConst  日期格式的常量
 */
export class DateConst {
  /**
   * yyyyMMdd 格式年月日
   */
  static YMD: string = "yyyyMMdd";

  /**
   * HH:mm:ss 格式时间
   */
  static HMS: string = "HH:mm:ss";

  /**
   * HH:mm 格式时间
   */
  static HM: string = "HH:mm";

  /**
   *yyyy-MM-dd 格式年月日
   */
  static YMD_HLINE: string = "yyyy-MM-dd";

  /**
   *yyyy-MM-dd HH:mm:ss  格式日期时间
   */
  static YMD_HLINE_HMS: string = "yyyy-MM-dd HH:mm:ss";

  /**
   *yyyy-MM-dd HH:mm  格式日期时间
   */
  static YMD_HLINE_HM: string = "yyyy-MM-dd HH:mm";

  /**
   *yyyy/MM/dd 格式日期(注:官方bug对/兼容问题可能会有问题只显示yyyy格式日期)
   */
  static YMD_BLINE: string = "yyyy/MM/dd";

  /**
   *yyyy/MM/dd HH:mm:ss 格式日期(注:官方bug对/兼容问题可能会有问题只显示yyyy格式日期)
   */
  static YMD_BLINE_HMS: string = "yyyy/MM/dd HH:mm:ss";

  /**
   *yyyy/MM/dd HH:mm  格式日期(注:官方bug对/兼容问题可能会有问题只显示yyyy格式日期)
   */
  static YMD_BLINE_HM: string = "yyyy/MM/dd HH:mm";
}