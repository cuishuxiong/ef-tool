import { rcp } from '@kit.RemoteCommunicationKit';
import { EfRcpError } from './EfRcpError';
import { efRcpConfig } from './efRcpConfig';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * @Author csx
 * @DateTime 2024/8/15 19:07
 * @TODO RfCryptoInterceptor  内置针对于请求code拦截器
 */
export class EfCodeInterceptor implements rcp.Interceptor {
  /**
   * 编码监听
   */
  private codeEventListener: efRcpConfig.codeEvent;

  constructor(codeEventListener: efRcpConfig.codeEvent) {
    this.codeEventListener = codeEventListener;
  }

  /**
   * 拦截器
   * @param context
   * @param next
   * @returns
   */
  async intercept(context: rcp.RequestContext, next: rcp.RequestHandler): Promise<rcp.Response> {
    try {
      //响应对象
      const response = await next.handle(context);
      //无监听则抛出异常
      if (!this.codeEventListener) {
        let efRcpError = new EfRcpError(10010, '响应码监听异常', '启用编码监听请设置efRcpConfig.codeEvent属性~');
        return Promise.reject(efRcpError);
      } else {
        //设置监听
        this.codeEventListener.listener(response.statusCode);
      }
      return response;
    } catch (error) {
      let b = error as BusinessError;
      //无监听则抛出异常
      if (!this.codeEventListener) {
        let efRcpError: EfRcpError =
          new EfRcpError(10010, '响应码监听异常', '启用编码监听请设置efRcpConfig.codeEvent属性~');
        return Promise.reject(efRcpError);
      } else {
        this.codeEventListener.listener(b.code);
      }
      //抛出
      return Promise.reject(b);
    }
  }
}