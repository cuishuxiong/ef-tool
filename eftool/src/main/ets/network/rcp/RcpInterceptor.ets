import { rcp } from '@kit.RemoteCommunicationKit';
import { OutDTO } from '../../core/base/OutDTO';
import { JSONObject } from '../../core/json/JSONObject';
import { efRcpParams } from './EfRcpUtil';

/**
 * 响应缓存类
 */
export class ResponseCache {
  //响应缓存变量
  private readonly cache: Record<string, rcp.Response> = {};

  /**
   * 获取响应
   * @param url
   * @returns
   */
  getResponse(url: string): rcp.Response {
    return this.cache[url];
  }

  /**
   * 存储响应
   * @param url
   * @param response
   */
  setResponse(url: string, response: rcp.Response): void {
    this.cache[url] = response;
  }
}

/**
 * @Author csx
 * @DateTime 2024/7/24 00:02
 * @TODO RcpInterceptor  rcp请求拦截器配置
 */
export class RcpInterceptor implements rcp.Interceptor {
  /**
   * 缓存响应属性
   */
  private readonly cache: ResponseCache;

  /**
   * 构造函数
   * @param cache
   */
  constructor(cache: ResponseCache) {
    this.cache = cache;
  }

  /**
   * 拦截核心
   * @param context
   * @param next
   * @returns
   */
  async intercept(context: rcp.RequestContext, next: rcp.RequestHandler): Promise<rcp.Response> {
    //获取当前请求url
    const url = context.request.url.href;
    //获取缓存对象
    const responseFromCache = this.cache.getResponse(url);
    if (responseFromCache) {
      return Promise.resolve(responseFromCache);
    }
    //获取响应结果
    const response = await next.handle(context);
    return response;
  }


  /**
   * 将后端返回的常见的信息封装成OutDTO对象
   * @param response  响应对象
   * @returns
   */
  static convertResponseDTO(response: rcp.Response) {
    //考虑几种常见的可能性
    let success: boolean = true;
    // if (response.config.headers["Req-Type"]) {
    //   if (response.data && response.data.dataRow) {
    //     return new OutDTO(true, '下载文件成功~', response.data.dataRow, new Array(), response.status);
    //   }
    //   return new OutDTO(true, '下载文件成功~', '', new Array(), response.status);
    // }
    if (response.toJSON()) {
      let obj: Object | null = response.toJSON();
      if (obj) {
        let jsonStr = JSONObject.toJSONString(obj);
        let out = JSONObject.parseObject<OutDTO<string>>(jsonStr);
        return out;
      } else {
        return new OutDTO(success, response.toString() + '', '', [], response.statusCode);
      }
    } else {
      return new OutDTO(success, response.toString() + '', '', [], response.statusCode);
    }

  }
}