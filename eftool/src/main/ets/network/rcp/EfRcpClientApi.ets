/**
 * @Author csx
 * @DateTime 2024/7/24 00:39
 * @TODO EfRcpClientApi rcp请求工具类
 */
import { rcp } from '@kit.RemoteCommunicationKit';
import { efRcpInstance } from './EfRcpUtil';

export class EfRcpClientApi {
  /**
   * post请求 - json格式
   * @param url 请求url
   * @param query 请求参数
   * @param headers 请求头
   * @param cookies 自定义cookie
   * @returns 响应结果
   */
  async post<E>(url: string, query: Record<string, rcp.FormFieldValue>, headers?: Record<string, string>,
    cookies?: Record<string, string>): Promise<E> {
    try {
      //转换请求参数
      let form: rcp.Form = new rcp.Form(query);
      //需要添加的header对象
      let addHead: rcp.RequestHeaders = {};
      //是否有传入header
      if (headers) {
        Object.entries(headers).forEach((row) => {
          addHead[row[0]] = row[1];
        });
      }
      //是否有cookie
      let cookie: rcp.RequestCookies = {};
      if (cookies) {
        Object.entries(cookies).forEach((row) => {
          cookie[row[0]] = row[1];
        });
      }
      //创建请求
      let request = new rcp.Request(efRcpInstance.configuration?.baseAddress + url, 'POST', headers, form, cookie);
      //发送请求
      let response = await efRcpInstance.fetch(request);
      //返回response的数据
      return response.toJSON() as E;
    } catch (error) {
      //将异常抛出
      return error as E;
    }
  }
}

//抛出
export const efRcpClientApi = new EfRcpClientApi();