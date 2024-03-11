import webSocket from '@ohos.net.webSocket';

import { ToastUtil } from '../../ui/prompt/ToastUtil'
import { JSONUtil } from './JSONUtil';

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
      ToastUtil.showToast("请输入websocket地址~");
      return;
    }
    let hd = {}
    if (headers) {
      hd = { header: headers }
    }
    WsUtil.ws.connect("ws://" + ip, hd, (err, value) => {
      if (!err) {
        ToastUtil.showToast("连接ws成功~");
      } else {
        ToastUtil.showToast("连接ws失败,原因为:" + JSONUtil.toJSONString(err));
      }
    });
  }
}