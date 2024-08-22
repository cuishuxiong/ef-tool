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
import { fileIo } from '@kit.CoreFileKit';

/**
 * @Author csx
 * @DateTime 2024/8/14 23:40
 * @TODO efRcpConfig  efRcp配置对象命名空间   本类灵感来源于官方rcp.xxxxxxx
 */
export namespace efRcpConfig {

  /**
   * 超时对象
   */
  export class timeout {
    /**
     * 允许建立连接的最长时间
     */
    connectMs?: number;
    /**
     * 允许传输数据的最长时间
     */
    transferMs?: number;
  }

  /**
   * 系统框架级别请求响应码对象
   */
  export class sysCodeEvent {
    /**
     * 请求响应码监听-业务自行处理数据
     */
    listener: (code: number) => void = () => {
    };
  }

  /**
   * 业务自定义级别请求响应码对象
   */
  export class businessCodeEvent {
    /**
     * 业务级别自定义错误编码/异常code字段名称
     */
    businessCodeName: string = '';
    /**
     * 请求响应码监听-业务自行处理数据
     */
    listener: (code: Object | null) => void = () => {
    };
  }

  /**
   * 请求拦截加解密操作
   */
  export class cryptoEvent {
    /**
     * 请求加密操作-业务自行处理数据
     */
    requestEncoder: (request: rcp.RequestContext) => rcp.RequestContext =
      (request: rcp.RequestContext): rcp.RequestContext => {
        return request;
      };
    /**
     * 请求解密操作-业务自行处理数据
     */
    responseDecoder: (response: rcp.Response) => rcp.Response =
      (response: rcp.Response): rcp.Response => {
        return response;
      };
  }

  /**
   * 会话监听器
   */
  export class sessionListener {
    /**
     * 会话关闭事件回调。会话关闭时调用
     */
    onClosed: () => void = () => {
    };
    /**
     * 会话取消事件的回调。会话取消时调用
     */
    onCanceled: () => void = () => {
    };
  }

  /**
   * 上传相关事件
   */
  export class uploadEvent {
    /**
     * 监听上传进度
     */
    onUploadProgress: (progress: number) => void = (progress: number) => {
    };
  }

  /**
   * 下载相关事件
   */
  export class downloadEvent {
    /**
     * 监听下载进度
     */
    onDownloadProgress: (progress: number) => void = (progress: number) => {
    };
  }

  /**
   * 证书相关配置
   */
  export class securityCfg {
    /**
     * 证书颁发机构
     */
    remoteValidation?: 'system' | 'skip' | rcp.CertificateAuthority | rcp.ValidationCallback = 'system';
    /**
     * 客户端证书,身份认证
     */
    certificate?: rcp.ClientCertificate;
    /**
     * 安全连接期间的服务器身份验证配置
     */
    serverAuthentication?: rcp.ServerAuthentication
  }

  /**
   * 证书工具类
   */
  export class securityUtil {
    /**
     * 读取证书内容
     * @param certPath 证书地址需要为沙箱环境地址
     * @returns 证书字符串
     */
    static readClientCerts(certPath: string): string {
      //读取文件内容
      let file = fileIo.openSync(certPath, fileIo.OpenMode.READ_ONLY);
      //读取文件大小
      let info = fileIo.statSync(file.fd);
      //创建buffer对象
      let buffer = new ArrayBuffer(info.size);
      //读取证书内容
      let readLen = fileIo.readSync(file.fd, buffer);
      //转换为字符串
      let content = String.fromCharCode(...new Uint8Array(buffer.slice(0, readLen)));
      //关闭io流
      fileIo.closeSync(file);
      //返回证书内容
      return content;
    }
  }

  /**
   * 全局加载对象设置
   */
  export class loading {
    /**
     * 是否启用 - 默认true
     */
    static enable: boolean = true;
    /**
     * loading提示内容 - 默认为【努力获取数据中,请稍后...】
     */
    static content: string = '努力获取数据中,请稍后...';
    /**
     * 动画builder属性-图片类
     */
    static imgBuilder?: WrappedBuilder<[]>;
    /**
     * 是否为lottie动画
     */
    static enableLottie: boolean = false
    /**
     * lottie动画所需画板
     */
    static lottieRenderingCtx: CanvasRenderingContext2D =
      new CanvasRenderingContext2D(new RenderingContextSettings(true));
  }

  /**
   * token相关配置
   */
  export class token {
    /**
     * 登录成功后的token的key
     */
    static tokenName: string = 'authorization';
    /**
     * 登录成功后的token值
     */
    static tokenValue: string = '';
  }

  /**
   * 请求公共传参
   */
  export class commonParams {
    /**
     * 请求路径 必填
     */
    url: string = '';
    /**
     * 当次请求需要设置的请求头
     */
    headers?: Record<string, string>;
    /**
     * 当次请求需要设置的cookies
     */
    cookies?: Record<string, string>;
    /**
     * 当次请求需要设置的loading文本
     */
    loadingTxt?: string;
  }

  /**
   * post/put请求所需参数对象
   */
  export class requestBaseParams extends commonParams {
    /**
     * 请求参数 post/put
     */
    query: Record<string, Object> | rcp.FormFields = {};
    /**
     * 解决post传参但是需要将参数拼接URL情况
     */
    isParams?: boolean;
  }

  /**
   * 上传入参对象
   */
  export class uploadParams extends commonParams {
    /**
     * 上传文件字段
     */
    fileInfo: rcp.MultipartFormFields = {};
  }

  /**
   * 下载入参对象
   */
  export class downloadParams extends commonParams {
    /**
     * 下载文件名
     */
    fileName: string = '';
  }

  /**
   * 基础请求前缀地址
   */
  export let baseURL: string = "";

}