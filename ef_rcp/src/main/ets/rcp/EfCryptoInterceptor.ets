/**
 * @Author csx
 * @DateTime 2024/8/15 19:07
 * @TODO RfCryptoInterceptor  内置针对于请求响应的加解密拦截器
 */
import { rcp } from '@kit.RemoteCommunicationKit';
import { efRcpConfig } from './efRcpConfig';
import { EfRcpError } from './EfRcpError';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * @Author csx
 * @DateTime 2024/8/15 19:07
 * @TODO EfCryptoInterceptor  内置针对于请求加解密拦截器
 */
export class EfCryptoInterceptor implements rcp.Interceptor {
  /**
   * 加解密监听
   */
  private cryptoEventListener: efRcpConfig.cryptoEvent;

  constructor(cryptoEventListener: efRcpConfig.cryptoEvent) {
    this.cryptoEventListener = cryptoEventListener;
  }

  async intercept(context: rcp.RequestContext, next: rcp.RequestHandler): Promise<rcp.Response> {
    try {
      //如果未设置监听则提示
      if (!this.cryptoEventListener) {
        let efRcpError = new EfRcpError(10011, '加解密监听异常', '启用加解密监听请设置efRcpConfig.cryptoEvent属性~');
        return Promise.reject(efRcpError);
      }
      //请求拦截
      context = this.cryptoEventListener.requestEncoder(context);
      //响应对象
      const response = await next.handle(context);
      //解密响应对象
      const decoderResponse = this.cryptoEventListener.responseDecoder(response);
      //返回解密后的Response
      return decoderResponse;
    } catch (error) {
      if (error instanceof EfRcpError) {
        //此处进行实例化操作后，接口调用处可使用内部封装的一系列方法
        let efRcpError = new EfRcpError(error.code, error.name, error.message, error.stack);
        return Promise.reject(efRcpError);
      }
      //抛出
      return Promise.reject(error);
    }
  }
}