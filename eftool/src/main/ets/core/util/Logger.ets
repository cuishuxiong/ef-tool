import hilog from '@ohos.hilog';
/**
 * @Author csx
 * @DateTime 2023/12/29 20:10
 * @TODO Logger   日志工具类
 */
export class Logger {
  private domain: number;
  private prefix: string;
  private format: string = '%{public}s%{public}s';


  /**
   * 构造  第一个入参为应用名,第二个为域可不填
   * @param prefix
   * @param domain
   */
  constructor(prefix: string = 'efTool', domain: number = 0xFF00) {
    this.prefix = prefix;
    this.domain = domain;
  }


  /**
   * debug级别日志【入参为两个字符串,第一个为提示消息,第二个为错误原因】
   * @param args 错误信息
   */
  debug(...args: string[]): void {
    hilog.debug(this.domain, this.prefix, this.format, args);
  }

  /**
   * info级别日志【入参为两个字符串,第一个为提示消息,第二个为错误原因】
   * @param args 错误信息
   */
  info(...args: string[]): void {
    hilog.info(this.domain, this.prefix, this.format, args);
  }

  /**
   * warn级别日志【入参为两个字符串,第一个为提示消息,第二个为错误原因】
   * @param args 错误信息
   */
  warn(...args: string[]): void {
    hilog.warn(this.domain, this.prefix, this.format, args);
  }

  /**
   * error级别日志【入参为两个字符串,第一个为提示消息,第二个为错误原因】
   * @param args 错误信息
   */
  error(...args: string[]): void {
    hilog.error(this.domain, this.prefix, this.format, args);
  }
}