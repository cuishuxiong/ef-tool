import { hilog } from '@kit.PerformanceAnalysisKit';
import { common } from '@kit.AbilityKit';
import { ToastUtil } from '../../ui/prompt/ToastUtil';
import fs from '@ohos.file.fs';
/**
 * @Author csx
 * @DateTime 2023/12/29 20:10
 * @TODO Logger   日志工具类
 */
export class Logger {

  //优化日志   https://gitee.com/harmonyos_samples/logger

  private static domain: number;
  private static prefix: string;
  private static format: string = '%{public}s%{public}s';

  /**
   * 初始化Logger，只需传入应用名和域
   * @param prefix 应用名
   * @param domain 域
   */
  static init(prefix: string = 'efTool',ctx:common.Context, domain: number = 0xFF00) {
    Logger.prefix = prefix;
    Logger.domain = domain;
    //此处从1.1.6版本增加将日志写入文件
    // let context = getContext() as common.UIAbilityContext;
    // let tempDir = context.tempDir;
    // 获取应用文件路径
    if (ctx) {
      let logPath= ctx.filesDir+'/logs';
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
    hilog.debug(Logger.domain, Logger.prefix, Logger.format, args);
  }

  /**
   * info级别日志【入参为两个字符串,第一个为提示消息,第二个为错误原因】
   * @param args 错误信息
   */
  static info(...args: string[]): void {
    hilog.info(Logger.domain, Logger.prefix, Logger.format, args);
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