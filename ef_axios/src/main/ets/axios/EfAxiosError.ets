/**
 * @Author csx
 * @DateTime 2024/8/12 22:45
 * @TODO EfAxiosError
 */
import { BusinessError } from '@kit.BasicServicesKit';
import { JSONObject } from '@yunkss/ef_json';

/**
 * efAxios自定义异常
 */
export class EfAxiosError implements BusinessError {
  /**
   * 编码
   */
  code: number;
  /**
   * 数据
   */
  data?: void | undefined;
  /**
   * 名称
   */
  name: string;
  /**
   * 消息
   */
  message: string;
  /**
   * 堆栈信息
   */
  stack?: string | undefined;

  constructor(code: number, name: string, message: string, stack?: string) {
    this.code = code;
    this.name = name;
    this.message = message;
    if (stack) {
      this.stack = stack;
    }
  }

  toString(): string {
    return JSONObject.toJSONString(this);
  }

  getCode(): number {
    return this.code;
  }

  getName(): string {
    return this.name;
  }

  getMessage(): string {
    return this.message;
  }
}