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
import { RcpLogInterceptor } from './RcpLogInterceptor';
import { EfRcpError } from './EfRcpError';
import { efRcpConfig } from './efRcpConfig'
import { EfCodeInterceptor } from './EfCodeInterceptor';
import { EfCryptoInterceptor } from './EfCryptoInterceptor';

/**
 * @Author csx
 * @DateTime 2024/7/23 23:56
 * @TODO RcpUtil 远场通信服务工具类
 * @TODO 本类单例思路来源于Java懒汉模式,链式调用思路来源于jdk8 lambda表达式
 */
class EfRcp {
  /**
   * 全局session配置-默认设置
   */
  private cfg: rcp.SessionConfiguration = {
    //请求配置
    requestConfiguration: {
      //数据传输行为
      transfer: {
        //指定HTTP客户端是否应自动遵循重定向
        autoRedirect: true,
        timeout: {
          //允许建立连接的最长时间
          connectMs: 5000,
          //允许传输数据的最长时间
          transferMs: 20000,
        },
      },
      tracing: {
        verbose: true
      }
    },
    //请求头
    headers: {
      "content-type": "application/json"
    },
    //cookies
    cookies: {},
    //连接配置
    connectionConfiguration: {
      //单个主机允许的最大并发 TCP 连接数（主机与主机名+端口号对相同）
      maxConnectionsPerHost: 10,
      //此会话中允许的最大同时 TCP 连接总数
      maxTotalConnections: 100
    }
  };
  /**
   * 封装后的全局rcp对象
   */
  private efRcp: rcp.Session | undefined;

  /**
   * 私有化构造
   */
  private constructor() {
  }

  /**
   * 私有单例对象
   */
  private static efRcpInstance: EfRcp;

  /**
   * 创建单例
   * @returns
   */
  public static getInstance(): EfRcp {
    if (!EfRcp.efRcpInstance) {
      EfRcp.efRcpInstance = new EfRcp();
    }
    return EfRcp.efRcpInstance;
  }

  /**
   * 创建session对象
   * @returns
   */
  create(): EfRcp {
    if (this.efRcp) {
      this.efRcp.close();
      this.efRcp = undefined;
    }
    this.efRcp = rcp.createSession(this.cfg);
    return this;
  }

  /**
   * 构建efRcpSession对象
   * @returns
   */
  builder(): rcp.Session {
    if (this.efRcp === undefined) {
      throw new EfRcpError(12306, '构建efRcpSession异常', '请在构建之前调用create方法创建~');
    }
    return this.efRcp as rcp.Session;
  }

  /**
   * 添加efRcp默认的日志拦截器
   * @returns
   */
  private addLogInterceptor(): EfRcp {
    if (this.cfg.interceptors) {
      this.cfg.interceptors.push(new RcpLogInterceptor());
    } else {
      this.cfg.interceptors = [new RcpLogInterceptor()];
    }
    return this;
  }

  /**
   * 启用日志拦截器
   * @returns
   */
  enableLogInterceptor(): EfRcp {
    return this.addLogInterceptor();
  }

  /**
   * 添加用户自定义拦截器
   * @param customInterceptors 自定义拦截器数组
   * @returns
   */
  addCustomInterceptors(customInterceptors: rcp.Interceptor[]): EfRcp {
    if (this.cfg.interceptors) {
      this.cfg.interceptors.push(...customInterceptors);
    } else {
      this.cfg.interceptors = customInterceptors;
    }
    return this;
  }

  /**
   * 添加公共的header
   * @param headers
   * @returns
   */
  addCommonHeaders(headers: Record<string, string>): EfRcp {
    if (headers) {
      Object.entries(headers).forEach((row) => {
        if (this.cfg.headers) {
          this.cfg.headers[row[0]] = row[1];
        } else {
          this.cfg.headers = {};
          this.cfg.headers[row[0]] = row[1];
        }
      });
    }
    return this;
  }

  /**
   * 添加公共的cookie
   * @param cookies
   * @returns
   */
  addCommonCookies(cookies: Record<string, string>): EfRcp {
    if (cookies) {
      Object.entries(cookies).forEach((row) => {
        if (this.cfg.cookies) {
          this.cfg.cookies[row[0]] = row[1];
        } else {
          this.cfg.cookies = {};
          this.cfg.cookies[row[0]] = row[1];
        }
      });
    }
    return this;
  }

  /**
   * 全部自定义session配置 - 特殊场景如efRcp所有默认配置均不满足开发需求，则全部自定义并设置
   * @param config  用户自定义全部配置
   * @returns
   */
  setConfig(config: rcp.SessionConfiguration): EfRcp {
    this.cfg = config;
    return this;
  }

  /**
   * 添加统一的编码拦截操作
   * @param codeEvent  编码操作事件  efRcpConfig.codeEvent
   * @returns
   */
  addCodeEvent(codeEvent: efRcpConfig.codeEvent): EfRcp {
    if (this.cfg.interceptors) {
      this.cfg.interceptors.push(new EfCodeInterceptor(codeEvent));
    } else {
      this.cfg.interceptors = [new EfCodeInterceptor(codeEvent)];
    }
    return this;
  }

  /**
   * 添加自定义加解密拦截
   * @param cryptoEvent 加解密操作事件 efRcpConfig.cryptoEvent
   * @returns
   */
  addCryptoEvent(cryptoEvent: efRcpConfig.cryptoEvent): EfRcp {
    if (this.cfg.interceptors) {
      this.cfg.interceptors.push(new EfCryptoInterceptor(cryptoEvent));
    } else {
      this.cfg.interceptors = [new EfCryptoInterceptor(cryptoEvent)];
    }
    return this;
  }

  /**
   * 设置超时时间
   * @param timeout
   */
  setTimeOut(timeout: efRcpConfig.timeout): EfRcp {
    if (timeout && this.cfg.requestConfiguration?.transfer) {
      //允许建立连接的最长时间
      if (timeout.connectMs && this.cfg.requestConfiguration.transfer.timeout) {
        this.cfg.requestConfiguration.transfer.timeout.connectMs = timeout.connectMs;
      }
      //允许传输数据的最长时间
      if (timeout.transferMs && this.cfg.requestConfiguration.transfer.timeout) {
        this.cfg.requestConfiguration.transfer.timeout.transferMs = timeout.transferMs;
      }
    }
    return this;
  }

  /**
   * 设置会话监听
   * @param sessionListener  会话监听事件
   * @returns
   */
  setSessionListener(sessionListener: efRcpConfig.sessionListener): EfRcp {
    this.cfg.sessionListener = sessionListener;
    return this;
  }

  /**
   * 设置上传进度操作
   * @param uploadEvent  上传进度监听 - efRcpConfig.uploadEvent
   * @returns
   */
  setUploadEvent(uploadEvent: efRcpConfig.uploadEvent): EfRcp {
    if (this.cfg.requestConfiguration && this.cfg.requestConfiguration.tracing) {
      if (this.cfg.requestConfiguration.tracing.httpEventsHandler) {
        this.cfg.requestConfiguration.tracing.httpEventsHandler.onUploadProgress =
          (totalSize: number, transferredSize: number) => {
            uploadEvent.onUploadProgress(Math.ceil(transferredSize / totalSize * 100));
          }
      } else {
        this.cfg.requestConfiguration.tracing.httpEventsHandler = {
          onUploadProgress: (totalSize: number, transferredSize: number) => {
            uploadEvent.onUploadProgress(Math.ceil(transferredSize / totalSize * 100));
          }
        }
      }
    } else {
      this.cfg.requestConfiguration = {
        tracing: {
          httpEventsHandler: {
            onUploadProgress: (totalSize: number, transferredSize: number) => {
              uploadEvent.onUploadProgress(Math.ceil(transferredSize / totalSize * 100));
            }
          }
        }
      }
    }
    return this;
  }

  /**
   * 设置下载进度操作
   * @param uploadEvent  下载进度监听 - efRcpConfig.downloadEvent
   * @returns
   */
  setDownLoadEvent(downloadEvent: efRcpConfig.downloadEvent): EfRcp {
    if (this.cfg.requestConfiguration && this.cfg.requestConfiguration.tracing) {
      if (this.cfg.requestConfiguration.tracing.httpEventsHandler) {
        this.cfg.requestConfiguration.tracing.httpEventsHandler.onDownloadProgress =
          (totalSize: number, transferredSize: number) => {
            downloadEvent.onDownloadProgress(Math.ceil(transferredSize / totalSize * 100));
          }
      } else {
        this.cfg.requestConfiguration.tracing.httpEventsHandler = {
          onDownloadProgress: (totalSize: number, transferredSize: number) => {
            downloadEvent.onDownloadProgress(Math.ceil(transferredSize / totalSize * 100));
          }
        }
      }
    } else {
      this.cfg.requestConfiguration = {
        tracing: {
          httpEventsHandler: {
            onDownloadProgress: (totalSize: number, transferredSize: number) => {
              downloadEvent.onDownloadProgress(Math.ceil(transferredSize / totalSize * 100));
            }
          }
        }
      }
    }
    return this;
  }

  /**
   * 设置证书
   * @param securityCfg 证书配置 - efRcpConfig.securityCfg
   * @returns
   */
  addSecurity(securityCfg: efRcpConfig.securityCfg): EfRcp {
    if (this.cfg.requestConfiguration) {
      if (this.cfg.requestConfiguration.security) {
        this.cfg.requestConfiguration.security.remoteValidation = securityCfg.remoteValidation;
        this.cfg.requestConfiguration.security.certificate = securityCfg.certificate;
        this.cfg.requestConfiguration.security.serverAuthentication = securityCfg.serverAuthentication;
      } else {
        this.cfg.requestConfiguration.security = securityCfg;
      }
    }
    return this;
  }

  /**
   * 禁用全局加载框
   * @returns
   */
  disableLoading(): EfRcp {
    efRcpConfig.loading.enable = false;
    return this;
  }

  /**
   * 更改全局默认loading的提示内容
   * @param content
   * @returns
   */
  setLoadingContent(content: string): EfRcp {
    efRcpConfig.loading.content = content;
    return this;
  }

  /**
   * 更改全局默认loading的图片- 全局builder,内容业务自行传入,只支持gif动图,不支持内部使用状态变量
   * @param builder 全局构造builder
   * @returns
   */
  setLoadingImg(builder: WrappedBuilder<[]>): EfRcp {
    efRcpConfig.loading.imgBuilder = builder;
    return this;
  }

  /**
   * 启用loading加载使用lottie动画
   * @returns
   */
  enableLottie(): EfRcp {
    efRcpConfig.loading.enableLottie = true;
    return this;
  }

  /**
   * 设置lottie动画
   * @param lottieFunction  lottie动画函数
   * @returns
   */
  setLottieAnimation(lottieFunction: (arg: CanvasRenderingContext2D) => void): EfRcp {
    lottieFunction(efRcpConfig.loading.lottieRenderingCtx);
    return this;
  }

  /**
   * 设置全局请求路径前缀
   * @param baseURL 请求路径前缀
   * @returns
   */
  setBaseURL(baseURL: string): EfRcp {
    efRcpConfig.baseURL = baseURL;
    return this;
  }
}

/**
 * 抛出单例对象
 */
export const efRcp = EfRcp.getInstance();