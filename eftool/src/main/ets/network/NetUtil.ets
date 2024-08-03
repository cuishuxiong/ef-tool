/**
 * @Author csx
 * @DateTime 2024/8/3 09:25
 * @TODO NetUtil 网络相关工具类
 */
import { connection } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { GlobalContext } from '../core/cache/GlobalContext';
import { Logger } from '../core/util/Logger';

export class NetUtil {
  /**
   * 网络连接对象
   */
  private static conn: connection.NetConnection;
  // 指定超时时间为10s(默认值为0)
  private static timeout = 10 * 1000;

  /**
   * 创建网络连接
   */
  private static createConnection() {
    // let netSpecifier: connection.NetSpecifier = {
    //   netCapabilities: {
    //     // 假设当前默认网络是WiFi，需要创建蜂窝网络连接，可指定网络类型为蜂窝网
    //     bearerTypes: [connection.NetBearType.BEARER_CELLULAR],
    //     // 指定网络能力为Internet
    //     networkCap: [connection.NetCap.NET_CAPABILITY_INTERNET]
    //   },
    // };
    return connection.createNetConnection();
  }

  /**
   * 获取所有处于连接状态的网络列表
   */
  static getAllNets(): GlobalContext {
    let list = connection.getAllNetsSync();
    let ctx = GlobalContext.getContext();
    if (list) {
      ctx.netList = list;
    }
    return ctx;
  }


  /**
   * 检查默认数据网络是否激活
   */
  static hasDefaultNet(): boolean {
    return connection.hasDefaultNetSync();
  }

  /**
   * 获取App绑定的网络信息
   */
  static getAppNet(): connection.NetHandle {
    return connection.getAppNetSync();
  }


  /**
   * 判断当前网络是否是WiFi
   */
  static isWiFi(): boolean {
    let net = connection.getDefaultNetSync();
    let netCapabilities = connection.getNetCapabilitiesSync(net);
    let bearerTypes = netCapabilities.bearerTypes;
    if (bearerTypes) {
      return bearerTypes.indexOf(connection.NetBearType.BEARER_WIFI) >= 0
    }
    return false;
  }


  /**
   * 注册网络监听
   * @param netHandler  网络监听事件
   */
  static register(netHandler: netEventHandler) {
    if (!NetUtil.conn) {
      //创建NetConnection对象
      NetUtil.conn = NetUtil.createConnection();
    }
    //注册
    NetUtil.conn.register((error: BusinessError) => {
      if (error) {
        Logger.error(`网络注册异常,编码: ${error.code} , 原因: ${error.message}`);
      }
    });
    //网络可用
    if (netHandler.availableCallback) {
      NetUtil.conn.on('netAvailable', netHandler.availableCallback);
    }
    ////网络不可用
    if (netHandler.unavailableCallback) {
      NetUtil.conn.on('netUnavailable', netHandler.unavailableCallback);
    }
    //网络能力变化
    if (netHandler.capabilitiesChangeCallback) {
      NetUtil.conn.on('netCapabilitiesChange', netHandler.capabilitiesChangeCallback);
    }
    //网络连接信息变化
    if (netHandler.connPropertiesChangeCallback) {
      NetUtil.conn.on('netConnectionPropertiesChange', netHandler.connPropertiesChangeCallback);
    }
    //网络阻塞
    if (netHandler.blockStatusChangeCallback) {
      NetUtil.conn.on('netBlockStatusChange', netHandler.blockStatusChangeCallback);
    }
    //网络丢失
    if (netHandler.lostCallback) {
      NetUtil.conn.on('netLost', netHandler.lostCallback);
    }
  }


  /**
   * 取消注册
   */
  static unregister() {
    if (NetUtil.conn) {
      NetUtil.conn.unregister((error: BusinessError) => {
        if (error) {
          Logger.error(`网络取消异常, 编码: ${error.code} ,原因: ${error.message}`);
        }
      });
    }
  }
}

/**
 * 网络变化事件
 */
export class netEventHandler {
  /**
   * 网络可用
   */
  availableCallback?: Callback<connection.NetHandle>;
  /**
   * 网络不可用
   */
  unavailableCallback?: Callback<void>;
  /**
   * 网络能力变化
   */
  capabilitiesChangeCallback?: Callback<connection.NetCapabilityInfo>;
  /**
   * 网络连接信息变化
   */
  connPropertiesChangeCallback?: Callback<connection.NetConnectionPropertyInfo>;
  /**
   * 网络阻塞
   */
  blockStatusChangeCallback?: Callback<connection.NetBlockStatusInfo>;
  /**
   * 网络丢失
   */
  lostCallback?: Callback<connection.NetHandle>;
}