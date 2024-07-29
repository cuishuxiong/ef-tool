import { rcp } from '@kit.RemoteCommunicationKit';
import { OutDTO } from '../../core/base/OutDTO';
import { CacheUtil } from '../../core/cache/CacheUtil';
import { JSONObject } from '../../core/json/JSONObject';
import { ImgLayout, LoadingShape } from '../../ui/prompt/efLoading';
import { WinLoadingUtil } from '../../ui/prompt/WinLoadingUtil';
import { efRcpParams, efRcpResponseParams } from './EfRcpUtil';

/**
 * 响应缓存类
 */
export class ResponseCache {
  //响应缓存变量
  private readonly cache: Record<string, rcp.Response> = {};

  /**
   * 获取响应
   * @param url
   * @returns
   */
  getResponse(url: string): rcp.Response {
    return this.cache[url];
  }

  /**
   * 存储响应
   * @param url
   * @param response
   */
  setResponse(url: string, response: rcp.Response): void {
    this.cache[url] = response;
  }
}

/**
 * @Author csx
 * @DateTime 2024/7/24 00:02
 * @TODO RcpInterceptor  rcp请求拦截器配置
 */
export class RcpInterceptor implements rcp.Interceptor {
  /**
   * 缓存响应属性
   */
  private readonly responseCache: ResponseCache;

  /**
   * 构造函数
   * @param cache
   */
  constructor(responseCache: ResponseCache) {
    this.responseCache = responseCache;
  }

  /**
   * 拦截核心
   * @param context
   * @param next
   * @returns
   */
  async intercept(context: rcp.RequestContext, next: rcp.RequestHandler): Promise<rcp.Response> {
    //获取当前请求url
    const url = context.request.url.href;
    //是否开启全局loading
    if (efRcpParams.isLoading) {
      await WinLoadingUtil.showLoading({
        content: efRcpParams.loadingTxt,
        imgLayout: ImgLayout.TOP,
        layoutShape: LoadingShape.SQUARE
      });
    }
    //获取请求缓存对象
    const requestFromCache = CacheUtil.get<rcp.Request>(url);
    if (!requestFromCache) {
      //请求存入缓存
      CacheUtil.save<rcp.Request>(url, context.request);
    }
    //获取缓存对象
    const responseFromCache = this.responseCache.getResponse(url);
    if (responseFromCache) {
      if (efRcpParams.isLoading) {
        //关闭loading
        await WinLoadingUtil.closeLoading();
      }
      return Promise.resolve(responseFromCache);
    }
    //获取响应结果
    const response = await next.handle(context);
    //存入缓存
    this.responseCache.setResponse(url, response);
    if (efRcpParams.isLoading) {
      //关闭loading
      await WinLoadingUtil.closeLoading();
    }
    return response;
  }


  /**
   * 将后端返回的常见的信息封装成OutDTO对象
   * @param response  响应对象
   * @returns
   */
  static convertResponseDTO(response: rcp.Response) {
    //转换成object
    let result = response.toJSON();
    // if (response.config.headers["Req-Type"]) {
    //   if (response.data && response.data.dataRow) {
    //     return new OutDTO(true, '下载文件成功~', response.data.dataRow, new Array(), response.status);
    //   }
    //   return new OutDTO(true, '下载文件成功~', '', new Array(), response.status);
    // }
    //考虑几种常见的可能性
    //1.成功失败标识
    let success: boolean = true;
    //2.返回的消息提示
    let message: string = '';
    //3.返回的单行数据
    let dataRow: Record<string, Object> = {};
    //4.返回的多行数据
    let dataTable: Array<Record<string, Object>> = new Array();
    //5.返回请求状态码
    let code = response.statusCode;
    if (result) {
      Object.entries(result).forEach((item: object) => {
        if (["success", "flag"].includes(String(item[0]))) {
          success = Boolean(item[1]);
        }
        if (["msg", "message"].includes(String(item[0]))) {
          message = String(item[1]);
        }
        if (["dataRow", "data"].includes(String(item[0]))) {
          dataRow = item[1];
        }
        if (["dataTable", "list", "arr", "array"].includes(String(item[0]))) {
          dataTable = item[1];
        }
      })
    }
    if (response.statusCode != 200) {
      message = response.toString() as string;
    }
    return new OutDTO(success, message, dataRow, dataTable, code);

  }
}

/**
 * efRcp请求事件处理器
 */
export const efRcpEventsHandler: rcp.HttpEventsHandler = {
  /**
   * 上传进度
   */
  onUploadProgress: (totalSize: number, transferredSize: number) => {
    // Custom logic for handling upload progress
    console.info("Upload progress:", transferredSize, "of", totalSize);
    //传递给公共参数
    efRcpResponseParams.processNumber = Math.ceil(transferredSize / totalSize * 100);
  },
  /**
   * 下载进度
   */
  onDownloadProgress: (totalSize: number, transferredSize: number) => {
    // Custom logic for handling download progress
    console.info("Download progress:", transferredSize, "of", totalSize);
  },
  /**
   * 数据传输完成
   */
  onDataEnd: () => {
    // Custom logic for handling data transfer completion
    console.info("Data transfer complete");
  },
  /**
   * 取消请求/响应
   */
  onCanceled: () => {
    // Custom logic for handling cancellation
    console.info("Request/response canceled");
  },
};
