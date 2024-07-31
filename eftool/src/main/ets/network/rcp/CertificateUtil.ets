import { fileIo } from '@kit.CoreFileKit';
import { rcp } from '@kit.RemoteCommunicationKit';

/**
 * @Author csx
 * @DateTime 2024/7/31 23:29
 * @TODO CertificateUtil  rpc证书相关工具类
 */
export class CertificateUtil {
  /**
   * 读取证书内容
   * @param filePath  证书路径
   * @returns 证书内容字符串
   */
  static readClientCerts(filePath: string): string {
    //读取文件内容
    let file = fileIo.openSync(filePath, fileIo.OpenMode.READ_WRITE);
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

  /**
   * 获取组装的rcp安全校验配置
   * @returns
   */
  static getRcpSecurityCfg(filePath: string) {
    const securityConfig: rcp.SecurityConfiguration = {
      remoteValidation: "system",
      certificate: {
        content: CertificateUtil.readClientCerts(filePath),
        type: "PEM",
        key: "-----BEGIN PRIVATE KEY-----\n...", //请根据自身业务选择合适的key
        keyPassword: "your-password",
      },
      serverAuthentication: {
        credential: {
          username: "exampleUser",
          password: "examplePassword",
        },
        authenticationType: "basic",
      },
    };
    return securityConfig;
  }
}