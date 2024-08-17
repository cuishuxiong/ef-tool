/**
 Copyright 2024 csx - @yunkss/ef_rcp

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import { rcp } from '@kit.RemoteCommunicationKit';
import { efRcp, efRcpParams } from './EfRcp';
import { efRcpConfig } from './efRcpConfig';
import { JSON } from '@kit.ArkTS';
import fs from '@ohos.file.fs';
import { RcpLoadingUtil } from '../ui/RcpLoadingUtil';
import { RcpImgLayout, RcpLoadingShape } from '../ui/rcpLoading';
import { CacheUtil } from '@yunkss/ef_core';
import { common } from '@kit.AbilityKit';
import { fileUri } from '@kit.CoreFileKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { EfRcpError } from './EfRcpError';

/**
 * @Author csx
 * @DateTime 2024/7/24 00:39
 * @TODO EfRcpClientApi rcp请求工具类
 */
export class EfRcpClientApi {
  /**
   * 构建请求的header
   * @param headers 传入的自定义header
   * @returns 拼接完公共系列全部完整header
   */
  private static buildHeaders(headers?: Record<string, string>): rcp.RequestHeaders {
    //需要添加的header对象
    let addHead: rcp.RequestHeaders = {};
    //是否需要拼接token
    if (efRcpConfig.token.tokenValue) {
      if (efRcpConfig.token.tokenName && efRcpConfig.token.tokenName != 'authorization') {
        addHead[efRcpConfig.token.tokenName] = efRcpConfig.token.tokenValue;
      } else {
        addHead.authorization = efRcpConfig.token.tokenValue;
      }
    }
    //获取全局header配置
    let cfg = efRcp.builder().configuration;
    //如果配置中有headers
    if (cfg && cfg.headers) {
      Object.entries(cfg.headers).forEach((row) => {
        addHead[row[0]] = row[1];
      });
    }
    //是否有传入header
    if (headers) {
      Object.entries(headers).forEach((row) => {
        addHead[row[0]] = row[1];
      });
    }
    if (!addHead["content-type"]) {
      addHead['content-type'] = "application/json";
    }
    return addHead;
  }

  /**
   * 构建请求的cookies
   * @param headers 传入的自定义cookies
   * @returns 拼接完公共系列全部完整cookies
   */
  private static buildCookies(cookies?: Record<string, string>): rcp.RequestCookies {
    //需要添加的header对象
    let addCookie: rcp.RequestCookies = {};
    //获取全局header配置
    let cfg = efRcp.builder().configuration;
    //如果配置中有headers
    if (cfg && cfg.cookies) {
      Object.entries(cfg.cookies).forEach((row) => {
        addCookie[row[0]] = row[1];
      });
    }
    //是否有传入header
    if (cookies) {
      Object.entries(cookies).forEach((row) => {
        addCookie[row[0]] = row[1];
      });
    }
    return addCookie;
  }

  /**
   * 构建当前请求的证书配置
   * @param security 当前请求证书配置
   * @returns
   */
  private static buildSecurity(security: efRcpConfig.securityCfg): rcp.SecurityConfiguration {
    let securityCfg: rcp.SecurityConfiguration = {
      remoteValidation: security.remoteValidation,
      serverAuthentication: security.serverAuthentication,
      certificate: security.certificate
    }
    return securityCfg;
  }

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
    //是否开启全局loading
    if (efRcpConfig.loading.enable) {
      await RcpLoadingUtil.showLoading({
        content: loadingTxt ? loadingTxt : efRcpConfig.loading.content,
        imgLayout: RcpImgLayout.TOP,
        layoutShape: RcpLoadingShape.SQUARE
      });
    }
    //创建请求
    let request = new rcp.Request(efRcpConfig.baseURL + url, method, EfRcpClientApi.buildHeaders(headers), "",
      EfRcpClientApi.buildCookies(cookies));
    //返回
    return request;
  }

  /**
   * 构建响应对象
   * @param request  请求
   * @param isSecurity 是否开启证书校验
   * @returns
   */
  private static async buildResponse<E>(request: rcp.Request, isSecurity?: boolean,
    securityCfg?: efRcpConfig.securityCfg): Promise<E | EfRcpError> {
    try {
      //是否针对当前请求开启证书加密
      if (isSecurity !== false && isSecurity) {
        if (request.configuration) {
          if (securityCfg) {
            request.configuration.security = EfRcpClientApi.buildSecurity(securityCfg)
          }
        } else {
          if (securityCfg) {
            request.configuration = {
              security: EfRcpClientApi.buildSecurity(securityCfg)
            }
          }
        }
      }
      //发送请求
      let response = await efRcp.builder().fetch(request);
      if (efRcpConfig.loading.enable) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
      //返回response的数据
      return response.toJSON() as E;
    } catch (error) {
      if (efRcpConfig.loading.enable) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
      //此处进行实例化操作后，接口调用处可使用内部封装的一系列方法
      let b = error as BusinessError<Object>;
      if (b.data) {
        b.message = b.data as string;
      }
      let efRcpError = new EfRcpError(b.code, b.name, b.message, b.stack);
      //抛出
      return Promise.reject(efRcpError);
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
    cookies?: Record<string, string>, loadingTxt?: string, isSecurity?: boolean): Promise<E | EfRcpError> {
    //转换请求参数
    let jsonStr = JSON.stringify(query);
    //构建request
    let request = await EfRcpClientApi.buildRequest(url, 'POST', headers, cookies, loadingTxt);
    //传入请求参数
    request.content = jsonStr;
    //构建响应
    return await EfRcpClientApi.buildResponse<E>(request, isSecurity);
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
    cookies?: Record<string, string>, loadingTxt?: string, isSecurity?: boolean): Promise<E | EfRcpError> {
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
    cookies?: Record<string, string>, loadingTxt?: string, isSecurity?: boolean): Promise<E | EfRcpError> {
    //创建请求
    let request = await EfRcpClientApi.buildRequest(url, 'GET', headers, cookies, loadingTxt);
    //构建响应
    return await EfRcpClientApi.buildResponse<E>(request, isSecurity);
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
    cookies?: Record<string, string>, loadingTxt?: string, isSecurity?: boolean): Promise<E | EfRcpError> {
    //转换请求参数
    let jsonStr = JSON.stringify(query);
    //构建request
    let request = await EfRcpClientApi.buildRequest(url, 'PUT', headers, cookies, loadingTxt);
    //传入请求参数
    request.content = jsonStr;
    //构建响应
    return await EfRcpClientApi.buildResponse<E>(request, isSecurity);
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
    cookies?: Record<string, string>, loadingTxt?: string, isSecurity?: boolean): Promise<E | EfRcpError> {
    //创建请求
    let request = await EfRcpClientApi.buildRequest(url, 'DELETE', headers, cookies, loadingTxt);
    //构建响应
    return await EfRcpClientApi.buildResponse<E>(request, isSecurity);
  }

  /**
   * 取消请求
   * @param url  待取消的URL
   */
  async cancel(url: string) {
    //获取请求
    let request = CacheUtil.get<rcp.Request>(efRcpConfig.baseURL + url);
    if (request) {
      //取消请求
      efRcp.builder().cancel(request);
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
    isSecurity?: boolean): Promise<E | EfRcpError> {
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
    //构建响应
    return await EfRcpClientApi.buildResponse<E>(request, isSecurity);
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
    loadingTxt?: string): Promise<E | EfRcpError> {
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
      if (efRcpConfig.loading.enable) {
        await RcpLoadingUtil.showLoading({
          content: loadingTxt ? loadingTxt : efRcpConfig.loading.content,
          imgLayout: RcpImgLayout.TOP,
          layoutShape: RcpLoadingShape.SQUARE
        });
      }
      let response = await efRcp.builder().downloadToFile(efRcpConfig.baseURL + url, downloadToFile)
      if (efRcpConfig.loading.enable) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
      //返回response的数据
      return response.toJSON() as E;
    } catch (error) {
      if (efRcpConfig.loading.enable) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
      //此处进行实例化操作后，接口调用处可使用内部封装的一系列方法
      let b = error as BusinessError;
      let efRcpError = new EfRcpError(b.code, b.name, b.message, b.stack);
      //抛出
      return Promise.reject(efRcpError);
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
    loadingTxt?: string): Promise<E | EfRcpError> {
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
      if (efRcpConfig.loading.enable) {
        await RcpLoadingUtil.showLoading({
          content: loadingTxt ? loadingTxt : efRcpConfig.loading.content,
          imgLayout: RcpImgLayout.TOP,
          layoutShape: RcpLoadingShape.SQUARE
        });
      }
      //发送下载请求
      let response = await efRcp.builder().downloadToStream(efRcpConfig.baseURL + url, downloadToStream);
      if (efRcpConfig.loading.enable) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
      //返回response的数据
      return response.toJSON() as E;
    } catch (error) {
      if (efRcpConfig.loading.enable) {
        //关闭loading
        await RcpLoadingUtil.closeLoading();
      }
      //此处进行实例化操作后，接口调用处可使用内部封装的一系列方法
      let b = error as BusinessError;
      let efRcpError = new EfRcpError(b.code, b.name, b.message, b.stack);
      //抛出
      return Promise.reject(efRcpError);
    }
  }
}

//抛出
export const efRcpClientApi = new EfRcpClientApi();