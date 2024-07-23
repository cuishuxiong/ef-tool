import { rcp } from '@kit.RemoteCommunicationKit';

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
  intercept(context: rcp.RequestContext, next: rcp.RequestHandler): Promise<rcp.Response> {
    //获取当前请求url
    const url = context.request.url.href;
    //获取缓存对象
    const responseFromCache = this.cache.getResponse(url);
    if (responseFromCache) {
      return Promise.resolve(responseFromCache);
    }
    const promise = next.handle(context);
    promise.then((resp) => {
      resp.statusCode;
      this.cache.setResponse(url, resp);
    });
    return promise;
  }
}