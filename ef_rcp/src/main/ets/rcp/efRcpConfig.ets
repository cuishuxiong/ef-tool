/**
 * @Author csx
 * @DateTime 2024/8/14 23:40
 * @TODO efRcpConfig  efRcp配置对象命名空间
 */
import { rcp } from '@kit.RemoteCommunicationKit';
import { fileIo } from '@kit.CoreFileKit';

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
   * 请求响应码对象
   */
  export class codeEvent {
    /**
     * 请求响应码监听-业务自行处理数据
     */
    listener: (code: number) => void = () => {
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
   * 上传相关
   */
  export class uploadEvent {
    /**
     * 监听上传进度
     */
    onUploadProgress: (progress: number) => void = (progress: number) => {
    };
  }

  /**
   * 下载相关
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


}