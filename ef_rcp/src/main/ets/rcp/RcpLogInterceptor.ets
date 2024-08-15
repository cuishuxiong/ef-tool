import { rcp } from '@kit.RemoteCommunicationKit';
import { efRcpParams, efRcpResponseParams } from './EfRcp';
import { CacheUtil, Logger, OutDTO } from '@yunkss/ef_core'
import { JSONObject } from '@yunkss/ef_json';
import { BusinessError } from '@kit.BasicServicesKit';
import { EfRcpError } from './EfRcpError';


/**
 * @Author csx
 * @DateTime 2024/7/24 00:02
 * @TODO RcpInterceptor  rcp日志拦截器配置
 */
export class RcpLogInterceptor implements rcp.Interceptor {
  /**
   * 拦截核心
   * @param context
   * @param next
   * @returns
   */
  async intercept(context: rcp.RequestContext, next: rcp.RequestHandler): Promise<rcp.Response> {
    Logger.init('efRcp', getContext(), 0xFF00);
    try {
      //获取当前请求url
      const url = context.request.url.href;
      //获取请求缓存对象
      const requestFromCache = CacheUtil.get<rcp.Request>(url);
      if (!requestFromCache) {
        //请求存入缓存
        CacheUtil.save<rcp.Request>(url, context.request);
      }
      Logger.debug("--------请求信息---------", "");
      Logger.debug("--------请求URL:", (context.request.url.href));
      Logger.debug("--------请求方式:", context.request.method);
      if (context.request.headers) {
        Logger.debug("--------请求  头:", JSONObject.toJSONString(context.request.headers as object));
      }
      if (context.request.cookies) {
        Logger.debug("--------请求cookie:", JSONObject.toJSONString(context.request.cookies as object));
      }
      if (context.request.content) {
        Logger.debug("--------请求入参:", context.request.content.toString() as string);
      }
      //获取响应结果
      const response = await next.handle(context);
      //是否开启打印日志
      Logger.debug("--------响应信息---------", "");
      Logger.debug("--------响应状态:", response.statusCode + "");
      Logger.debug("--------响应内容:", response.toString() as string);
      return response;
    } catch (error) {
      if (error instanceof EfRcpError) {
        //此处进行实例化操作后，接口调用处可使用内部封装的一系列方法
        let efRcpError = new EfRcpError(error.code, error.name, error.message, error.stack);
        return Promise.reject(efRcpError);
      }
      //此处进行实例化操作后，接口调用处可使用内部封装的一系列方法
      // let b = error as BusinessError;
      // let efRcpError = new EfRcpError(b.code, b.name, b.message, b.stack);
      //抛出
      return Promise.reject(error);
    }
  }
}