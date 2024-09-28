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
import { efRcpConfig } from './efRcpConfig';
import { EfRcpError } from './EfRcpError';

/**
 * @Author csx
 * @DateTime 2024/8/15 19:07
 * @TODO EfCryptoInterceptor  内置针对于请求加解密拦截器
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_rcp
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
      //抛出
      return Promise.reject(error);
    }
  }
}