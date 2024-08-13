/**
 * @Author csx
 * @DateTime 2024/7/24 00:39
 * @TODO EfRcpClientApi rcp请求工具类
 */
import { rcp } from '@kit.RemoteCommunicationKit';
import { efRcpInstance, efRcpParams, efRcpResponseParams } from './EfRcpUtil';
import { JSON } from '@kit.ArkTS';
import { RcpInterceptor } from './RcpInterceptor';
import fs from '@ohos.file.fs';
import { RcpLoadingUtil } from '../ui/RcpLoadingUtil';
import { RcpImgLayout, RcpLoadingShape } from '../ui/rcpLoading';
import { CertificateUtil } from './CertificateUtil';
import { CacheUtil } from '@yunkss/ef_core';
import { common } from '@kit.AbilityKit';
import { fileUri } from '@kit.CoreFileKit';

export class EfRcpClientApi {
  /**
   * 构建请求对象
   * @param url 请求url
   * @param method 请求方式
   * @param headers 请求头
   * @param cookies 自定义cookie
   * @param isSecurity 是否开启证书加密
   * @param loadingTxt 是否覆写loading文本
   * @returns
   */
  private static async buildRequest(url: string, method: string, headers?: Record<string, string>,
    cookies?: Record<string, string>, loadingTxt?: string): Promise<rcp.Request> {
    //需要添加的header对象
    let addHead: rcp.RequestHeaders = {};
    //是否需要拼接token
    if (efRcpParams.tokenValue) {
      addHead.authorization = efRcpParams.tokenValue;
      if (efRcpParams.tokenName) {
        addHead[efRcpParams.tokenName] = efRcpParams.tokenValue;
      }
    }
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
    //是否开启全局loading
    if (efRcpParams.isLoading) {
      await RcpLoadingUtil.showLoading({
        content: loadingTxt ? loadingTxt : efRcpParams.loadingTxt,
        imgLayout: RcpImgLayout.TOP,
        layoutShape: RcpLoadingShape.SQUARE
      });
    }
    if (!addHead["content-type"]) {
      addHead['content-type'] = "application/json";
    }
    //创建请求
    let request = new rcp.Request(efRcpParams.baseURL + url, method, addHead, "", cookie);
    //返回
    return request;
  }

  /**
   * 构建响应对象
   * @param request  请求
   * @param isSecurity 是否开启证书校验
   * @returns
   */
  private static async buildResponse<E>(request: rcp.Request, isSecurity?: boolean) {
    //是否开启证书加密
    if (efRcpParams.isSecurity || (isSecurity !== false && isSecurity)) {
      if (efRcpInstance.configuration) {
        if (efRcpInstance.configuration.requestConfiguration) {
          efRcpInstance.configuration.requestConfiguration.security = CertificateUtil.getRcpSecurityCfg();
        }
      }
    }
    try { //发送请求
      let response = await efRcpInstance.fetch(request);
      if (efRcpParams.isLoading) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
      //响应结果
      if (efRcpParams.isConvertDTO) {
        //转换为DTO
        return RcpInterceptor.convertResponseDTO(response) as E;
      }
      //返回response的数据
      return response.toJSON() as E;
    } catch (e) {
      throw new Error("错误编码:" + e["code"] + ",错误消息:" + e["data"]);
    }
  }

  /**
   * post请求 - json格式
   * @param url 请求url
   * @param query 请求参数
   * @param headers 请求头
   * @param cookies 自定义cookie
   * @param loadingTxt 是否覆写loading文本
   * @param isSecurity 是否开启证书加密
   * @returns 响应结果
   */
  async post<E>(url: string, query: Record<string, Object>, headers?: Record<string, string>,
    cookies?: Record<string, string>, loadingTxt?: string, isSecurity?: boolean): Promise<E> {
    try {
      //转换请求参数
      let jsonStr = JSON.stringify(query);
      //构建request
      let request = await EfRcpClientApi.buildRequest(url, 'POST', headers, cookies, loadingTxt);
      //传入请求参数
      request.content = jsonStr;
      //构建响应
      return await EfRcpClientApi.buildResponse<E>(request, isSecurity);
    } catch (error) {
      if (efRcpParams.isLoading) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
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
   * @param loadingTxt 是否覆写loading文本
   * @param isSecurity 是否开启证书加密
   * @returns 响应结果
   */
  async postForm<E>(url: string, query: rcp.FormFields, headers?: Record<string, string>,
    cookies?: Record<string, string>, loadingTxt?: string, isSecurity?: boolean): Promise<E> {
    try {
      //转换请求参数
      let form = new rcp.Form(query);
      //更改请求方式
      if (headers && !headers['content-type']) {
        headers['content-type'] = "application/x-www-form-urlencoded";
      } else {
        headers = {
          'content-type': 'application/x-www-form-urlencoded'
        }
      }
      //构建request
      let request = await EfRcpClientApi.buildRequest(url, 'POST', headers, cookies, loadingTxt);
      //设置请求内容
      request.content = form;
      //构建响应
      return await EfRcpClientApi.buildResponse<E>(request, isSecurity);
    } catch (error) {
      if (efRcpParams.isLoading) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
      //将异常抛出
      return error as E;
    }
  }

  /**
   * get请求
   * @param url 请求url
   * @param headers 请求头
   * @param cookies 自定义cookie
   * @param loadingTxt 是否覆写loading文本
   * @param isSecurity 是否开启证书加密
   * @returns 响应结果
   */
  async get<E>(url: string, headers?: Record<string, string>,
    cookies?: Record<string, string>, loadingTxt?: string, isSecurity?: boolean): Promise<E> {
    try {
      //创建请求
      let request = await EfRcpClientApi.buildRequest(url, 'GET', headers, cookies, loadingTxt);
      //构建响应
      return await EfRcpClientApi.buildResponse<E>(request, isSecurity);
    } catch (error) {
      if (efRcpParams.isLoading) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
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
   * @param loadingTxt 是否覆写loading文本
   * @param isSecurity 是否开启证书加密
   * @returns 响应结果
   */
  async put<E>(url: string, query: Record<string, Object>, headers?: Record<string, string>,
    cookies?: Record<string, string>, loadingTxt?: string, isSecurity?: boolean): Promise<E> {
    try {
      //转换请求参数
      let jsonStr = JSON.stringify(query);
      //构建request
      let request = await EfRcpClientApi.buildRequest(url, 'PUT', headers, cookies, loadingTxt);
      //传入请求参数
      request.content = jsonStr;
      //构建响应
      return await EfRcpClientApi.buildResponse<E>(request, isSecurity);
    } catch (error) {
      if (efRcpParams.isLoading) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
      //将异常抛出
      return error as E;
    }
  }

  /**
   * delete请求
   * @param url 请求url
   * @param headers 请求头
   * @param cookies 自定义cookie
   * @param loadingTxt 是否覆写loading文本
   * @param isSecurity 是否开启证书加密
   * @returns 响应结果
   */
  async delete<E>(url: string, headers?: Record<string, string>,
    cookies?: Record<string, string>, loadingTxt?: string, isSecurity?: boolean): Promise<E> {
    try {
      //创建请求
      let request = await EfRcpClientApi.buildRequest(url, 'DELETE', headers, cookies, loadingTxt);
      //构建响应
      return await EfRcpClientApi.buildResponse<E>(request, isSecurity);
    } catch (error) {
      if (efRcpParams.isLoading) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
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
   * @param loadingTxt 是否覆写loading文本
   * @param isSecurity 是否开启证书加密
   * @returns 响应结果
   */
  async uploadFile<E>(url: string, fileInfo: rcp.MultipartFormFields, progressCallBack: (progress: number) => void,
    headers?: Record<string, string>, cookies?: Record<string, string>, loadingTxt?: string,
    isSecurity?: boolean): Promise<E> {
    try {
      //更改请求方式
      if (headers && !headers['content-type']) {
        headers['content-type'] = "multipart/form-data";
      } else {
        headers = {
          'content-type': 'multipart/form-data'
        }
      }
      //拼接上传对象
      let multipart = new rcp.MultipartForm(fileInfo);
      //创建请求
      let request = await EfRcpClientApi.buildRequest(url, 'POST', headers, cookies, loadingTxt);
      //设置参数
      request.content = multipart;
      //设置上传进度
      progressCallBack(efRcpResponseParams.uploadProgress);
      //构建响应
      return await EfRcpClientApi.buildResponse<E>(request, isSecurity);
    } catch (error) {
      if (efRcpParams.isLoading) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
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
   * @param loadingTxt 是否覆写loading文本
   * @param isSecurity 是否开启证书加密
   * @returns
   */
  async downloadFile<E>(url: string, fileName: string, progressCallBack: (progress: number) => void,
    loadingTxt?: string, isSecurity?: boolean) {
    try {
      //根路径
      let filesDir = (getContext() as common.UIAbilityContext).filesDir;
      //获取文件全路径
      let filePath = filesDir + "/" + fileName;
      //获取文件名
      let fName = new fileUri.FileUri(filePath).name;
      //获取文件路径
      let path = filePath.replace(fName, "");
      //判断是否存在
      let isExists = fs.accessSync(filePath);
      //如果已存在则删除
      if (isExists) {
        fs.unlinkSync(filePath);
      } else {
        //创建
        if (path != filesDir + "/") {
          fs.mkdirSync(path, true);
        }
      }
      //下载对象
      let downloadToFile: rcp.DownloadToFile = {
        kind: 'file',
        file: filePath
      };
      //是否开启全局loading
      if (efRcpParams.isLoading) {
        await RcpLoadingUtil.showLoading({
          content: loadingTxt ? loadingTxt : efRcpParams.loadingTxt,
          imgLayout: RcpImgLayout.TOP,
          layoutShape: RcpLoadingShape.SQUARE
        });
      }
      //是否开启证书加密
      if (efRcpParams.isSecurity || (isSecurity !== false && isSecurity)) {
        if (efRcpInstance.configuration) {
          if (efRcpInstance.configuration.requestConfiguration) {
            efRcpInstance.configuration.requestConfiguration.security = CertificateUtil.getRcpSecurityCfg();
          }
        }
      }
      let response = await efRcpInstance.downloadToFile(efRcpParams.baseURL + url, downloadToFile)
      //设置上传进度
      progressCallBack(efRcpResponseParams.downloadProgress);
      if (efRcpParams.isLoading) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
      //响应结果
      if (efRcpParams.isConvertDTO) {
        //转换为DTO
        return RcpInterceptor.convertResponseDTO(response) as E;
      }
      //返回response的数据
      return response.toJSON() as E;
    } catch (error) {
      if (efRcpParams.isLoading) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
      //将异常抛出
      return error as E;
    }
  }

  /**
   * 下载文件 - 保存流形式  外部调用方式与downloadFile一致
   * @param url 请求url
   * @param fileName   保存的文件名,默认在沙箱环境下
   * @param progressCallBack  下载进度回调
   * @param loadingTxt 是否覆写loading文本
   * @param isSecurity 是否开启证书加密
   * @returns
   */
  async downloadStream<E>(url: string, fileName: string, progressCallBack: (progress: number) => void,
    loadingTxt?: string, isSecurity?: boolean) {
    try {
      //根路径
      let filesDir = (getContext() as common.UIAbilityContext).filesDir;
      //获取保存路径
      let finalPath = filesDir + "/" + fileName;
      //创建stream
      let stream = fs.createStreamSync(finalPath, "w+");
      //需要保存的stream对象
      const streamData: rcp.Stream = stream;
      //封装下载对象
      let downloadToStream: rcp.DownloadToStream = {
        kind: 'stream',
        stream: streamData
      }
      //是否开启全局loading
      if (efRcpParams.isLoading) {
        await RcpLoadingUtil.showLoading({
          content: loadingTxt ? loadingTxt : efRcpParams.loadingTxt,
          imgLayout: RcpImgLayout.TOP,
          layoutShape: RcpLoadingShape.SQUARE
        });
      }
      //是否开启证书加密
      if (efRcpParams.isSecurity || (isSecurity !== false && isSecurity)) {
        if (efRcpInstance.configuration) {
          if (efRcpInstance.configuration.requestConfiguration) {
            efRcpInstance.configuration.requestConfiguration.security = CertificateUtil.getRcpSecurityCfg();
          }
        }
      }
      //发送下载请求
      let response = await efRcpInstance.downloadToStream(efRcpParams.baseURL + url, downloadToStream);
      //设置上传进度
      progressCallBack(efRcpResponseParams.downloadProgress);
      if (efRcpParams.isLoading) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
      //响应结果
      if (efRcpParams.isConvertDTO) {
        //转换为DTO
        return RcpInterceptor.convertResponseDTO(response) as E;
      }
      //返回response的数据
      return response.toJSON() as E;
    } catch (error) {
      if (efRcpParams.isLoading) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
      //将异常抛出
      return error as E;
    }
  }
}

//抛出
export const efRcpClientApi = new EfRcpClientApi();