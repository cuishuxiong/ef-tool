/**
 * @Author csx
 * @DateTime 2024/8/14 23:40
 * @TODO efRcpConfig  efRcp配置对象命名空间
 */
export namespace efRcpConfig {

  /**
   * 超时对象
   */
  export class TimeOut {
    /**
     * 允许建立连接的最长时间
     */
    connectMs?: number;
    /**
     * 允许传输数据的最长时间
     */
    transferMs?: number;
  }

}