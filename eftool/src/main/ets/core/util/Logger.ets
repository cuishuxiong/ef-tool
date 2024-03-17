import hilog from '@ohos.hilog';

/**
 * @Author csx
 * @DateTime 2023/12/29 20:10
 * @TODO Logger   日志工具类
 */
export class Logger {
  private static domain: number;
  private static prefix: string;
  private static format: string = '%{public}s%{public}s';

  /**
   * 初始化Logger，只需传入应用名和域
   * @param prefix 应用名
   * @param domain 域
   */
  static init(prefix: string = 'efTool', domain: number = 0xFF00) {
    Logger.prefix = prefix;
    Logger.domain = domain;
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