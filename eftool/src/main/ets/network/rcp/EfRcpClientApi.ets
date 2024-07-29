/**
 * @Author csx
 * @DateTime 2024/7/24 00:39
 * @TODO EfRcpClientApi rcp请求工具类
 */
import { rcp } from '@kit.RemoteCommunicationKit';
import { efRcpInstance, efRcpParams, efRcpResponseParams } from './EfRcpUtil';
import { JSON } from '@kit.ArkTS';
import { RcpInterceptor } from './RcpInterceptor';

export class EfRcpClientApi {
  /**
   * post请求 - json格式
   * @param url 请求url
   * @param query 请求参数
   * @param headers 请求头
   * @param cookies 自定义cookie
   * @returns 响应结果
   */
  async post<E>(url: string, query: Record<string, Object>, headers?: Record<string, string>,
    cookies?: Record<string, string>): Promise<E> {
    try {
      //转换请求参数
      let jsonStr = JSON.stringify(query);
      //需要添加的header对象
      let addHead: rcp.RequestHeaders = {};
      //是否有传入header
      if (headers) {
        Object.entries(headers).forEach((row) => {
          addHead[row[0]] = row[1];
        });
      }
      //是否需要拼接token
      if (efRcpParams.tokenValue) {
        addHead.authorization = efRcpParams.tokenValue;
        if (efRcpParams.tokenName) {
          addHead[efRcpParams.tokenName] = efRcpParams.tokenValue;
        }
      }
      //是否有cookie
      let cookie: rcp.RequestCookies = {};
      if (cookies) {
        Object.entries(cookies).forEach((row) => {
          cookie[row[0]] = row[1];
        });
      }
      //创建请求
      let request = new rcp.Request(efRcpParams.baseURL + url, 'POST', addHead, jsonStr, cookie);
      //发送请求
      let response = await efRcpInstance.fetch(request);
      //响应结果
      if (efRcpParams.isConvertDTO) {
        //转换为DTO
        return RcpInterceptor.convertResponseDTO(response) as E;
      }
      //返回response的数据
      return response.toJSON() as E;
    } catch (error) {
      //将异常抛出
      return error as E;
    }
  }

  /**
   * post请求 - 普通表单
   * @param url 请求url
   * @param query 请求参数
   * @param headers 请求头
   * @param cookies 自定义cookie
   * @returns 响应结果
   */
  async postForm<E>(url: string, query: rcp.FormFields, headers?: Record<string, string>,
    cookies?: Record<string, string>): Promise<E> {
    try {
      //转换请求参数
      let form = new rcp.Form(query);
      //需要添加的header对象
      let addHead: rcp.RequestHeaders = {};
      //是否有传入header
      if (headers) {
        Object.entries(headers).forEach((row) => {
          addHead[row[0]] = row[1];
        });
      }
      //是否需要拼接token
      if (efRcpParams.tokenValue) {
        addHead.authorization = efRcpParams.tokenValue;
        if (efRcpParams.tokenName) {
          addHead[efRcpParams.tokenName] = efRcpParams.tokenValue;
        }
      }
      //更改请求方式
      addHead['content-type'] = "application/x-www-form-urlencoded";
      //是否有cookie
      let cookie: rcp.RequestCookies = {};
      if (cookies) {
        Object.entries(cookies).forEach((row) => {
          cookie[row[0]] = row[1];
        });
      }
      //创建请求
      let request = new rcp.Request(efRcpParams.baseURL + url, 'POST', addHead, form, cookie);
      //发送请求
      let response = await efRcpInstance.fetch(request);
      //响应结果
      if (efRcpParams.isConvertDTO) {
        //转换为DTO
        return RcpInterceptor.convertResponseDTO(response) as E;
      }
      //返回response的数据
      return response.toJSON() as E;
    } catch (error) {
      //将异常抛出
      return error as E;
    }
  }

  /**
   * get请求
   * @param url 请求url
   * @param headers 请求头
   * @param cookies 自定义cookie
   * @returns 响应结果
   */
  async get<E>(url: string, headers?: Record<string, string>,
    cookies?: Record<string, string>): Promise<E> {
    try {
      //需要添加的header对象
      let addHead: rcp.RequestHeaders = {};
      //是否有传入header
      if (headers) {
        Object.entries(headers).forEach((row) => {
          addHead[row[0]] = row[1];
        });
      }
      //是否需要拼接token
      if (efRcpParams.tokenValue) {
        addHead.authorization = efRcpParams.tokenValue;
        if (efRcpParams.tokenName) {
          addHead[efRcpParams.tokenName] = efRcpParams.tokenValue;
        }
      }
      //是否有cookie
      let cookie: rcp.RequestCookies = {};
      if (cookies) {
        Object.entries(cookies).forEach((row) => {
          cookie[row[0]] = row[1];
        });
      }
      //创建请求
      let request = new rcp.Request(efRcpParams.baseURL + url, 'GET', addHead, "", cookie);
      //发送请求
      let response = await efRcpInstance.fetch(request);
      //响应结果
      if (efRcpParams.isConvertDTO) {
        //转换为DTO
        return RcpInterceptor.convertResponseDTO(response) as E;
      }
      //返回response的数据
      return response.toJSON() as E;
    } catch (error) {
      //将异常抛出
      return error as E;
    }
  }

  /**
   * put请求
   * @param url 请求url
   * @param query 请求参数
   * @param headers 请求头
   * @param cookies 自定义cookie
   * @returns 响应结果
   */
  async put<E>(url: string, query: Record<string, Object>, headers?: Record<string, string>,
    cookies?: Record<string, string>): Promise<E> {
    try {
      //转换请求参数
      let jsonStr = JSON.stringify(query);
      //需要添加的header对象
      let addHead: rcp.RequestHeaders = {};
      //是否有传入header
      if (headers) {
        Object.entries(headers).forEach((row) => {
          addHead[row[0]] = row[1];
        });
      }
      //是否需要拼接token
      if (efRcpParams.tokenValue) {
        addHead.authorization = efRcpParams.tokenValue;
        if (efRcpParams.tokenName) {
          addHead[efRcpParams.tokenName] = efRcpParams.tokenValue;
        }
      }
      //是否有cookie
      let cookie: rcp.RequestCookies = {};
      if (cookies) {
        Object.entries(cookies).forEach((row) => {
          cookie[row[0]] = row[1];
        });
      }
      //创建请求
      let request = new rcp.Request(efRcpParams.baseURL + url, 'PUT', addHead, jsonStr, cookie);
      //发送请求
      let response = await efRcpInstance.fetch(request);
      //响应结果
      if (efRcpParams.isConvertDTO) {
        //转换为DTO
        return RcpInterceptor.convertResponseDTO(response) as E;
      }
      //返回response的数据
      return response.toJSON() as E;
    } catch (error) {
      //将异常抛出
      return error as E;
    }
  }

  /**
   * delete请求
   * @param url 请求url
   * @param headers 请求头
   * @param cookies 自定义cookie
   * @returns 响应结果
   */
  async delete<E>(url: string, headers?: Record<string, string>,
    cookies?: Record<string, string>): Promise<E> {
    try {
      //需要添加的header对象
      let addHead: rcp.RequestHeaders = {};
      //是否有传入header
      if (headers) {
        Object.entries(headers).forEach((row) => {
          addHead[row[0]] = row[1];
        });
      }
      //是否需要拼接token
      if (efRcpParams.tokenValue) {
        addHead.authorization = efRcpParams.tokenValue;
        if (efRcpParams.tokenName) {
          addHead[efRcpParams.tokenName] = efRcpParams.tokenValue;
        }
      }
      //是否有cookie
      let cookie: rcp.RequestCookies = {};
      if (cookies) {
        Object.entries(cookies).forEach((row) => {
          cookie[row[0]] = row[1];
        });
      }
      //创建请求
      let request = new rcp.Request(efRcpParams.baseURL + url, 'DELETE', addHead, "", cookie);
      //发送请求
      let response = await efRcpInstance.fetch(request);
      //响应结果
      if (efRcpParams.isConvertDTO) {
        //转换为DTO
        return RcpInterceptor.convertResponseDTO(response) as E;
      }
      //返回response的数据
      return response.toJSON() as E;
    } catch (error) {
      //将异常抛出
      return error as E;
    }
  }

  /**
   * 上传文件 - 选择文件路径方式
   * @param url 请求url
   * @param filePath  选择的需要上传的文件路径或者文件
   * @param headers 请求头
   * @param cookies 自定义cookie
   * @returns 响应结果
   */
  async uploadFile<E>(url: string, filePath: rcp.UploadFromFile, progressCallBack: (process: number) => void
    // , headers?: Record<string, string>,
    // cookies?: Record<string, string>
  ) {
    try {
      //需要添加的header对象
      // let addHead: rcp.RequestHeaders = {};
      //是否有传入header
      // if (headers) {
      //   Object.entries(headers).forEach((row) => {
      //     addHead[row[0]] = row[1];
      //   });
      // }
      //是否需要拼接token
      // if (efRcpParams.tokenValue) {
      //   addHead.authorization = efRcpParams.tokenValue;
      //   if (efRcpParams.tokenName) {
      //     addHead[efRcpParams.tokenName] = efRcpParams.tokenValue;
      //   }
      // }
      //是否有cookie
      // let cookie: rcp.RequestCookies = {};
      // if (cookies) {
      //   Object.entries(cookies).forEach((row) => {
      //     cookie[row[0]] = row[1];
      //   });
      // }
      //创建请求
      // let request = new rcp.Request(efRcpParams.baseURL + url, 'DELETE', addHead, "", cookie);
      //发送请求

      let response = await efRcpInstance.uploadFromFile(efRcpParams.baseURL + url, filePath);
      progressCallBack(efRcpResponseParams.processNumber);
      //响应结果
      if (efRcpParams.isConvertDTO) {
        //转换为DTO
        return RcpInterceptor.convertResponseDTO(response) as E;
      }
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