import { rcp } from '@kit.RemoteCommunicationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { RcpInterceptor, ResponseCache } from './RcpInterceptor';

/**
 * @Author csx
 * @DateTime 2024/7/23 23:56
 * @TODO RcpUtil 远场通信服务工具类
 */
export class EfRcpUtil {
  /**
   * 创建rcp对象
   * @returns
   */
  private static createSession() {
    //创建缓存变量
    const cache = new ResponseCache();
    //创建session
    const session = rcp.createSession({
      //使用拦截器
      interceptors: [new RcpInterceptor(cache)],
      //基础前缀地址
      baseAddress: efRcpParams.baseURL,
      //请求配置
      requestConfiguration: {
        //数据传输行为
        transfer: {
          //指定HTTP客户端是否应自动遵循重定向
          autoRedirect: true,
          timeout: {
            //允许建立连接的最长时间
            connectMs: efRcpParams.connectMs,
            //允许传输数据的最长时间
            transferMs: efRcpParams.transferMs,
          },
        },
        tracing: {
          verbose: true,
        }
      },
      //请求头
      headers: {
        "Content-Type": "application/json"
      },
      //会话事件监听
      sessionListener: {
        onCanceled: () => console.info("Session was cancelled"),
        onClosed: () => console.info("Session was closed"),
      },
      //连接配置
      connectionConfiguration: {
        //单个主机允许的最大并发 TCP 连接数（主机与主机名+端口号对相同）
        maxConnectionsPerHost: 10,
        //此会话中允许的最大同时 TCP 连接总数
        maxTotalConnections: 80
      }
    });
    //返回session
    return session;
  }

  /**
   * 封装后的全局rcp对象
   */
  efRcpInstance = EfRcpUtil.createSession();
}


/**
 * rcp请求参数实体
 */
export class efRcpParams {
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
}

/**
 * 抛出session实例
 */
export const efRcpInstance = new EfRcpUtil().efRcpInstance;

