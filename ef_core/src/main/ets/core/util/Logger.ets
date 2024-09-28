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

import { hilog } from '@kit.PerformanceAnalysisKit';
import { common } from '@kit.AbilityKit';
import { IdUtil } from './IdUtil';

/**
 * @Author csx
 * @DateTime 2023/12/29 20:10
 * @TODO Logger   日志工具类
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_core
 */
export class Logger {
  //优化日志   https://gitee.com/harmonyos_samples/logger
  //获取内存信息  https://gitee.com/harmonyos_samples/debug

  private static maxSize = 1024;
  private static domain: number;
  private static prefix: string;
  private static format: string = '%{public}s%{public}s';

  /**
   * 初始化Logger，只需传入应用名和域
   * @param prefix 应用名
   * @param domain 域
   */
  static init(prefix: string = 'efTool', ctx: common.Context, domain: number = 0xFF00) {
    Logger.prefix = prefix;
    Logger.domain = domain;
    //此处从1.1.6版本增加将日志写入文件
    // let context = getContext() as common.UIAbilityContext;
    // let tempDir = context.tempDir;
    // 获取应用文件路径
    if (ctx) {
      let logPath = ctx.filesDir + '/logs';
      // let stat = fs.statSync(logPath);
      // if (stat.isDirectory()) {
      //
      // }

    }


    // fs.mkdirSync('./logs/');
    // let filePath = tempDir + prefix + '.log';
    // ToastUtil.showToast(filePath);

  }


  /**
   * debug级别日志【入参为两个字符串,第一个为提示消息,第二个为错误原因】
   * @param args 错误信息
   */
  static debug(...args: string[]): void {
    let content: string = args.join();
    if (content.length <= Logger.maxSize) {
      // 长度小于等于限制直接打印
      hilog.debug(Logger.domain, Logger.prefix, Logger.format, args);
    } else {
      // 循环分段打印
      let newPrefix = Logger.prefix + "[" + IdUtil.randomUUID() + "]"
      while (content.length > Logger.maxSize) {
        let logContent: string = content.substring(0, Logger.maxSize);
        content = content.replace(logContent, '');
        hilog.debug(Logger.domain, newPrefix, Logger.format, logContent);
      }
      // 打印剩余日志
      hilog.debug(Logger.domain, newPrefix, Logger.format, content);
    }
  }

  /**
   * 统一的日志打印
   * @param logCallBack  日志级别
   * @param args  入参
   */
  static printLog(logCallBack: (prefix: string, args: string[] | string) => void, ...args: string[]) {
    let content: string = args.join();
    if (content.length <= Logger.maxSize) {
      // 长度小于等于限制直接打印
      logCallBack(Logger.prefix, args);
    } else {
      // 循环分段打印
      let newPrefix = Logger.prefix + "[" + IdUtil.randomUUID() + "]"
      while (content.length > Logger.maxSize) {
        let logContent: string = content.substring(0, Logger.maxSize);
        content = content.replace(logContent, '');
        logCallBack(newPrefix, logContent);
      }
      // 打印剩余日志
      logCallBack(newPrefix, content);
    }
  }

  /**
   * info级别日志【入参为两个字符串,第一个为提示消息,第二个为错误原因】
   * @param args 错误信息
   */
  static info(...args1: string[]): void {
    // Logger.printLog((prefix: string, args: string[] | string) => {
    //   hilog.info(Logger.domain, prefix, Logger.format, args);
    // }, args1);
    // let content: string = args.join();
    // if (content.length <= Logger.maxSize) {
    //   // 长度小于等于限制直接打印
    //   hilog.info(Logger.domain, Logger.prefix, Logger.format, args);
    // } else {
    //   // 循环分段打印
    //   let newPrefix = Logger.prefix + "[" + IdUtil.randomUUID() + "]"
    //   while (content.length > Logger.maxSize) {
    //     let logContent: string = content.substring(0, Logger.maxSize);
    //     content = content.replace(logContent, '');
    //     hilog.info(Logger.domain, newPrefix, Logger.format, logContent);
    //   }
    //   // 打印剩余日志
    //   hilog.info(Logger.domain, newPrefix, Logger.format, content);
    // }
  }

  /**
   * warn级别日志【入参为两个字符串,第一个为提示消息,第二个为错误原因】
   * @param args 错误信息
   */
  static warn(...args: string[]): void {
    hilog.warn(Logger.domain, Logger.prefix, Logger.format, args);
  }

  /**
   * error级别日志【入参为两个字符串,第一个为提示消息,第二个为错误原因】
   * @param args 错误信息
   */
  static error(...args: string[]): void {
    hilog.error(Logger.domain, Logger.prefix, Logger.format, args);
  }
}