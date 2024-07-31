/**
 * @Author csx
 * @DateTime 2024/7/24 00:39
 * @TODO EfRcpClientApi rcp请求工具类
 */
import { rcp } from '@kit.RemoteCommunicationKit';
import { efRcpInstance, efRcpParams, efRcpResponseParams } from './EfRcpUtil';
import { JSON } from '@kit.ArkTS';
import { RcpInterceptor } from './RcpInterceptor';
import { CacheUtil } from '../../core/cache/CacheUtil';
import fs from '@ohos.file.fs';
import { FileUtil } from '../../core/media/FileUtil';

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
   * 取消请求
   * @param url  待取消的URL
   */
  async cancel(url: string) {
    //获取请求
    let request = CacheUtil.get<rcp.Request>(efRcpParams.baseURL + url);
    if (request) {
      //取消请求
      efRcpInstance.cancel(request);
    }
  }


  /**
   * 上传文件 - MultipartFormFields形式
   * @param url 请求url
   * @param fileInfo  需要上传的文件对象
   * @param headers 请求头
   * @param cookies 自定义cookie
   * @returns 响应结果
   */
  async uploadFile<E>(url: string, fileInfo: rcp.MultipartFormFields, progressCallBack: (progress: number) => void,
    headers?: Record<string, string>,
    cookies?: Record<string, string>) {
    try {
      //需要添加的header对象
      let addHead: rcp.RequestHeaders = {
        "content-type": "multipart/form-data"
      };
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
      //拼接上传对象
      let multipart = new rcp.MultipartForm(fileInfo);
      //创建请求
      let request = new rcp.Request(efRcpParams.baseURL + url, 'POST', addHead, multipart, cookie);
      //发送请求
      let response = await efRcpInstance.fetch(request);
      //设置上传进度
      progressCallBack(efRcpResponseParams.uploadProgress);
      //响应结果
      if (efRcpParams.isConvertDTO) {
        //转换为DTO
        return RcpInterceptor.convertResponseDTO(response) as E;
      }
      //返回response的数据
      return response.toJSON() as E;
    } catch (error) {
      //响应结果
      if (efRcpParams.isConvertDTO) {
        //转换为DTO
        return RcpInterceptor.convertErrorDTO(error) as E;
      }
      //将异常抛出
      return error as E;
    }
  }


  /**
   * 下载文件 - 保存路径方式 - 外部调用方式与downloadStream一致
   * @param url 请求url
   * @param fileName   保存的文件名,默认在沙箱环境下
   * @param progressCallBack  下载进度回调
   * @returns
   */
  async downloadFile<E>(url: string, fileName: string, progressCallBack: (progress: number) => void) {
    try {
      //获取保存路径
      let finalPath = FileUtil.getFilesDirPath('', fileName);
      //判断是否存在
      let isExists = fs.accessSync(finalPath);
      //如果已存在则删除
      if (isExists) {
        fs.unlinkSync(finalPath);
      }
      //下载对象
      let downloadToFile: rcp.DownloadToFile = {
        kind: 'file',
        file: finalPath
      };
      let response = await efRcpInstance.downloadToFile(efRcpParams.baseURL + url, downloadToFile)
      //设置上传进度
      progressCallBack(efRcpResponseParams.downloadProgress);
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
   * 下载文件 - 保存流形式  外部调用方式与downloadFile一致
   * @param url 请求url
   * @param fileName   保存的文件名,默认在沙箱环境下
   * @param progressCallBack  下载进度回调
   * @returns
   */
  async downloadStream<E>(url: string, fileName: string, progressCallBack: (progress: number) => void) {
    try {
      //获取保存路径
      let finalPath = FileUtil.getFilesDirPath('', fileName);
      //创建stream
      let stream = fs.createStreamSync(finalPath, "w+");
      //需要保存的stream对象
      const streamData: rcp.Stream = stream;
      //封装下载对象
      let downloadToStream: rcp.DownloadToStream = {
        kind: 'stream',
        stream: streamData
      }
      //发送下载请求
      let response = await efRcpInstance.downloadToStream(efRcpParams.baseURL + url, downloadToStream);
      //设置上传进度
      progressCallBack(efRcpResponseParams.downloadProgress);
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