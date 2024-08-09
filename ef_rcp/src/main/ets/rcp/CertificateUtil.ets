import { fileIo } from '@kit.CoreFileKit';
import { rcp } from '@kit.RemoteCommunicationKit';
import { efRcpSecurityParam } from './EfRcpUtil';

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
  private static readClientCerts(): string {
    //读取文件内容
    let file = fileIo.openSync(efRcpSecurityParam.certPath, fileIo.OpenMode.READ_WRITE);
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
  static getRcpSecurityCfg() {

    let ctx: string | ArrayBuffer = '';

    //如果是证书路径
    if (efRcpSecurityParam.certPath) {
      ctx = CertificateUtil.readClientCerts();
    }
    //如果是证书内容
    if (efRcpSecurityParam.certContent) {
      ctx = efRcpSecurityParam.certContent;
    }
    //创建证书配置对象
    const securityConfig: rcp.SecurityConfiguration = {
      //证书颁发机构（CA）
      remoteValidation: efRcpSecurityParam.remoteValidation,
      //客户端证书
      certificate: {
        //证书颁发机构（CA）证书的内容
        content: ctx,
        //客户端证书编码格式类型
        type: efRcpSecurityParam.certType,
        //客户端证书的key
        key: efRcpSecurityParam.certKey,
        //客户端证书密码
        keyPassword: efRcpSecurityParam.certKeyPwd,
      },
      //HTTP服务器身份验证
      serverAuthentication: {
        credential: {
          //用于身份验证的用户名
          username: efRcpSecurityParam.userName,
          //用于身份验证的密码
          password: efRcpSecurityParam.pwd,
        },
        //服务器的认证类型
        authenticationType: efRcpSecurityParam.authenticationType,
      },
    };
    return securityConfig;
  }
}