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
import { EfRcpError } from './EfRcpError';
import { efRcpConfig } from './efRcpConfig';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * @Author csx
 * @DateTime 2024/8/15 19:07
 * @TODO RfCryptoInterceptor  内置针对于系统框架级别的请求code拦截器
 */
export class EfSysCodeInterceptor implements rcp.Interceptor {
  /**
   * 编码监听
   */
  private codeEventListener: efRcpConfig.sysCodeEvent;

  constructor(codeEventListener: efRcpConfig.sysCodeEvent) {
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
        let efRcpError =
          new EfRcpError(10010, '系统级响应码监听异常', '启用系统级响应码监听请设置efRcpConfig.sysCodeEvent属性~');
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
          new EfRcpError(10010, '系统级响应码监听异常', '启用系统级响应码监听请设置efRcpConfig.sysCodeEvent属性~');
        return Promise.reject(efRcpError);
      } else {
        this.codeEventListener.listener(b.code);
      }
      //抛出
      return Promise.reject(b);
    }
  }
}