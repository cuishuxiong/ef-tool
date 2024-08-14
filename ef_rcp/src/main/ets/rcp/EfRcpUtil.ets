import { rcp } from '@kit.RemoteCommunicationKit';
import { RcpLogInterceptor } from './RcpLogInterceptor';
import { Callback } from '@kit.BasicServicesKit';
import { EfRcpError } from './EfRcpError';
import { efRcpConfig } from './efRcpConfig'

/**
 * @Author csx
 * @DateTime 2024/7/23 23:56
 * @TODO RcpUtil 远场通信服务工具类
 */
export class EfRcp {
  /**
   * 全局session配置
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
          transferMs: 10000,
        },
      },
      tracing: {
        verbose: true,
        //默认传输事件
        // httpEventsHandler: efRcpEventsHandler
      }
    },
    //请求头
    headers: {
      "content-type": "application/json"
    },
    //连接配置
    connectionConfiguration: {
      //单个主机允许的最大并发 TCP 连接数（主机与主机名+端口号对相同）
      maxConnectionsPerHost: 10,
      //此会话中允许的最大同时 TCP 连接总数
      maxTotalConnections: 80
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
   * 添加自定义加解密拦截器
   * @param cryptoInterceptor
   * @returns
   */
  addCryptoInterceptor(cryptoInterceptor: rcp.Interceptor): EfRcp {
    if (this.efRcp?.configuration) {
      if (this.efRcp.configuration.interceptors) {
        this.efRcp.configuration.interceptors.push(cryptoInterceptor);
      } else {
        this.efRcp.configuration.interceptors = [cryptoInterceptor];
      }
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
   * 添加统一的编码拦截器操作
   * @param codeEvent  对返回编码的判断操作
   * @returns
   */
  addCodeInterceptors(codeEvent: Callback<string>): EfRcp {
    if (this.efRcp?.configuration) {
      // if (this.efRcp.configuration.interceptors) {
      //   this.efRcp.configuration.interceptors.push(cryptoInterceptor);
      // } else {
      //   this.efRcp.configuration.interceptors = [cryptoInterceptor];
      // }
    }
    return this
  }


  /**
   * 设置超时时间
   * @param timeout
   */
  setTimeOut(timeout: efRcpConfig.TimeOut): EfRcp {
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
}

/**
 * rcp响应参数实体
 */
export class efRcpResponseParams {
  /**
   * 上传进度
   */
  static uploadProgress: number = 0;
  /**
   * 下载进度
   */
  static downloadProgress: number = 0;
}


/**
 * rcp请求参数实体
 */
export class efRcpParams {
  /**
   * 登录成功后的token的key
   */
  static tokenName: string = 'authorization';
  /**
   * 登录成功后的token值
   */
  static tokenValue: string = '';
  /**
   * 是否将响应数据转换为OutDTO对象,默认为true,如业务后台返回无法转换则关闭
   */
  static isConvertDTO: boolean = true;
  /**
   * 服务器 URL
   */
  static baseURL: string;
  /**
   * 是否开启全局请求loading弹框,默认为true
   */
  static isLoading: boolean = true;
  /**
   * 全局loading的加载内容,默认值为[努力获取数据中,请稍后...]
   */
  static loadingTxt: string = '努力获取数据中,请稍后...';
  /**
   * 允许建立连接的最长时间
   */
  static connectMs: number = 5000;
  /**
   * 允许传输数据的最长时间
   */
  static transferMs: number = 10000;
  /**
   * 会话session请求取消事件回调
   */
  static cancelCallBack?: () => void;
  /**
   *  会话session关闭事件回调
   */
  static closeCallBack?: () => void;
  /**
   * 是否开启证书加密,默认为false
   */
  static isSecurity: boolean = false;
  /**
   * 是否开启全局日志打印,默认为true
   */
  static isLogger: boolean = true;
}

/**
 * rcp证书相关参数
 */
export class efRcpSecurityParam {
  /**
   * 服务器端验证用户
   */
  static userName: string;
  /**
   * 服务器端验证密码
   */
  static pwd: string;
  /**
   * 服务器的认证类型 默认为basic
   */
  static authenticationType: rcp.AuthenticationType = 'basic';
  /**
   * 证书颁发机构（CA） 目前只兼容 system|skip
   */
  static remoteValidation: 'system' | 'skip' = 'system';
  /**
   * 证书内容
   */
  static certContent: string | ArrayBuffer;
  /**
   * 证书路径
   */
  static certPath: string;
  /**
   * 证书格式
   */
  static certType: 'PEM' | 'DER' | 'P12';
  /**
   *
   */
  static certKey: string;
  /**
   *
   */
  static certKeyPwd: string;
}
