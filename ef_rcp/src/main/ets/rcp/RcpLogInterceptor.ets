/**
 Copyright 2024 csx - @yunkss/ef_rcp

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
import { rcp } from '@kit.RemoteCommunicationKit';
import { CacheUtil, Logger } from '@yunkss/ef_core'
import { JSONObject } from '@yunkss/ef_json';
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
      //抛出
      return Promise.reject(error);
    }
  }
}