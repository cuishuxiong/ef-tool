import webSocket from '@ohos.net.webSocket';
import { Logger } from '@yunkss/ef_core';

/**
 * @Author csx
 * @DateTime 2024/3/10 21:43
 * @TODO WsUtil websocket工具类
 */
export class WsUtil {
  private static ws = webSocket.createWebSocket();

  /**
   * 连接websocket
   * @param ip  需要连接的IP(必填)
   * @param headers  连接时的请求头参数(非必填)
   */
  static connect(ip: string, headers?: Record<string, string>): void {
    if (!ip) {
      Logger.error("请输入IP");
      return;
    }
    let head: Record<string, Record<string, string>> = {}
    if (headers) {
      head.header = headers;
    }
    WsUtil.ws.connect("ws://" + ip, head, (err, value) => {
      if (!err) {
        Logger.error("连接ws成功~");
      } else {
        Logger.error("连接ws失败,原因为:", JSON.stringify(err));
      }
    });
  }
}