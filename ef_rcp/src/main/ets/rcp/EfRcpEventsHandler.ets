import { rcp } from '@kit.RemoteCommunicationKit';
import { efRcpResponseParams } from './EfRcpUtil';

/**
 * @Author csx
 * @DateTime 2024/8/14 00:57
 * @TODO EfRcpEventsHandler  网络事件回调监听
 */
export class EfRcpEventsHandler implements rcp.HttpEventsHandler {
  /**
   * 上传进度
   */
  onUploadProgress(totalSize: number, transferredSize: number) {
    //传递给公共参数
    efRcpResponseParams.uploadProgress = Math.ceil(transferredSize / totalSize * 100);
  }

  /**
   * 下载进度
   */
  onDownloadProgress(totalSize: number, transferredSize: number) {
    //传递给公共参数
    efRcpResponseParams.downloadProgress = Math.ceil(transferredSize / totalSize * 100);
  }

  /**
   * 数据传输完成
   */
  onDataEnd() {
    // Custom logic for handling data transfer completion
    console.info("Data transfer complete");
  }

  /**
   * 取消请求/响应
   */
  onCanceled() {
    // Custom logic for handling cancellation
    console.info("Request/response canceled");
  }
}