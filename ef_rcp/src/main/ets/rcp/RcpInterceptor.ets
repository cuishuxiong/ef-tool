import { rcp } from '@kit.RemoteCommunicationKit';
import { efRcpParams, efRcpResponseParams } from './EfRcpUtil';
import { CacheUtil, Logger, OutDTO } from '@yunkss/ef_core'
import { JSONObject } from '@yunkss/ef_json';


/**
 * @Author csx
 * @DateTime 2024/7/24 00:02
 * @TODO RcpInterceptor  rcp请求拦截器配置
 */
export class RcpInterceptor implements rcp.Interceptor {
  /**
   * 拦截核心
   * @param context
   * @param next
   * @returns
   */
  async intercept(context: rcp.RequestContext, next: rcp.RequestHandler): Promise<rcp.Response> {
    try { //获取当前请求url
      const url = context.request.url.href;
      //获取请求缓存对象
      const requestFromCache = CacheUtil.get<rcp.Request>(url);
      if (!requestFromCache) {
        //请求存入缓存
        CacheUtil.save<rcp.Request>(url, context.request);
      }
      //是否开启打印日志
      if (efRcpParams.isLogger) {
        Logger.init('efRcp', getContext(), 0xFF00);
        Logger.debug("--------请求信息---------", "");
        Logger.debug("--------请求URL:", (context.request.url.href));
        Logger.debug("--------请求方式:", context.request.method);
        if (context.request.headers) {
          Logger.debug("--------请求  头:", JSONObject.toJSONString(context.request.headers as object));
        }
        if (context.request.cookies) {
          Logger.debug("--------请求cookie:", JSONObject.toJSONString(context.request.cookies as object));
        }
        if (context.request.content) {
          Logger.debug("--------请求入参:", context.request.content.toString() as string);
        }
      }
      //获取响应结果
      const response = await next.handle(context);
      //是否开启打印日志
      if (efRcpParams.isLogger) {
        Logger.init('efRcp', getContext(), 0xFF00);
        Logger.debug("--------响应信息---------", "");
        Logger.debug("--------响应状态:", response.statusCode + "");
        Logger.debug("--------响应内容:", response.toString() as string);
      }
      return response;
    } catch (error) {
      return Promise.reject(error);
    }
  }


  /**
   * 将后端返回的常见的信息封装成OutDTO对象
   * @param response  响应对象
   * @returns
   */
  static convertResponseDTO(response: rcp.Response) {
    //转换成object
    let result = response.toJSON();
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
      if (response.headers["Req-Type"]) {
        if (result["dataRow"] || result["data"]) {
          return new OutDTO(true, '下载文件成功~', result["dataRow"] || result["data"], new Array(), code);
        }
        return new OutDTO(true, '下载文件成功~', '', new Array(), code);
      }
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

  /**
   * 将异常封装成OutDTO对象
   * @param response  响应对象
   * @returns
   */
  static convertErrorDTO(response: object) {
    //考虑几种常见的可能性
    //1.成功失败标识
    let success: boolean = false;
    //2.返回的消息提示
    let message: string = '';
    //3.返回的单行数据
    let dataRow: Record<string, Object> = {};
    //4.返回的多行数据
    let dataTable: Array<Record<string, Object>> = new Array();
    //5.返回请求状态码
    let code: string = response["code"];
    if (response) {
      Object.entries(response).forEach((item: object) => {
        if (["success", "flag"].includes(String(item[0]))) {
          success = Boolean(item[1]);
        }
        if (["msg", "message"].includes(String(item[0]))) {
          message = String(item[1]);
        }
        if (["dataRow", "data"].includes(String(item[0]))) {
          message = item[1];
        }
        if (["dataTable", "list", "arr", "array"].includes(String(item[0]))) {
          dataTable = item[1];
        }
      })
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
    //传递给公共参数
    efRcpResponseParams.uploadProgress = Math.ceil(transferredSize / totalSize * 100);
  },
  /**
   * 下载进度
   */
  onDownloadProgress: (totalSize: number, transferredSize: number) => {
    //传递给公共参数
    efRcpResponseParams.downloadProgress = Math.ceil(transferredSize / totalSize * 100);
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
