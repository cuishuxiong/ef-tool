/**
 Copyright 2024 csx - @yunkss/ef_axios

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

import { AxiosError, AxiosHeaders, AxiosProgressEvent, AxiosResponse, FormData } from '@ohos/axios';
import { efAxios, efAxiosParams } from './AxiosUtil';
import fs from '@ohos.file.fs';
import { common } from '@kit.AbilityKit';
import { fileUri } from '@kit.CoreFileKit';
import { EfAxiosError } from './EfAxiosError';
import { ArrayList } from '@kit.ArkTS';
import { EfAxiosConst } from '../EfAxiosConst';

/**
 * @Author csx
 * @DateTime 2024/4/19 08:00:04
 * @TODO EfApi  axios封装的请求工具类
 */
class EfClientApi {
  /**
   * 拼接header
   * @param headers  传入的header
   * @returns 拼接结果
   */
  private static appendHeader(headers?: Record<string, Object>): AxiosHeaders {
    let addHead: AxiosHeaders = new AxiosHeaders();
    //是否有传入header
    if (headers) {
      Object.entries(headers).forEach((row) => {
        addHead.set(row[0], row[1] as string, true);
      });
    }

    //是否有公共header
    if (efAxiosParams.headers) {
      Object.entries(efAxiosParams.headers).forEach((row) => {
        addHead.set(row[0], row[1] as string, true);
      });
    }
    return addHead;
  }

  private static appendBaseURL(baseurl?: string): string {
    let url: string = '';
    if (baseurl) {
      url = baseurl;
    }
    return url;
  }

  /**
   * post请求 - json格式
   * @param efClientParams post请求入参实体
   * @returns 响应结果
   */
  async post<F, E>(efClientParams: efClientParams<F>): Promise<E | EfAxiosError> {
    try {
      //如果当前请求efClientParams.loadingTxt传入参数  则 更改当前的loading文本
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = efClientParams.loadingTxt;
      }
      //发送请求
      let response: AxiosResponse<E> =
        await efAxios.post<E, AxiosResponse<E>, F>(efClientParams.url, efClientParams.query, {
          headers: EfClientApi.appendHeader(efClientParams.headers),
          baseURL: EfClientApi.appendBaseURL(efClientParams.baseUrl)
        });
      //如果当前请求更改过loading文字的话 - 更改默认值
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = EfAxiosConst.loadingTxt;
      }
      //返回response的数据
      return response.data;
    } catch (error) {
      //如果当前请求更改过loading文字的话 - 更改默认值
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = EfAxiosConst.loadingTxt;
      }
      let e: AxiosError = error as AxiosError;
      //将异常抛出
      return new EfAxiosError(Number(e.code), e.name, e.message, e.stack);
    }
  }

  /**
   * post请求 - formData
   * @param efClientParams formData请求入参实体
   * @returns 响应结果
   */
  async postFormData<E>(efClientParams: efClientParams<null>): Promise<E | EfAxiosError> {
    //需要添加的header对象
    try {
      //如果当前请求efClientParams.loadingTxt传入参数  则 更改当前的loading文本
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = efClientParams.loadingTxt;
      }
      let addHead: AxiosHeaders = EfClientApi.appendHeader(efClientParams.headers);
      addHead.set('Content-Type', 'multipart/form-data', true);
      addHead.set('Accept', '*/*', true);
      let response: AxiosResponse<E> =
        await efAxios.post<E, AxiosResponse<E>, FormData>(efClientParams.url, efClientParams.formData, {
          headers: addHead,
          baseURL: EfClientApi.appendBaseURL(efClientParams.baseUrl)
        });
      //如果当前请求更改过loading文字的话 - 更改默认值
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = EfAxiosConst.loadingTxt;
      }
      //返回response的数据
      return response.data;
    } catch (error) {
      //如果当前请求更改过loading文字的话 - 更改默认值
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = EfAxiosConst.loadingTxt;
      }
      let e: AxiosError = error as AxiosError;
      //将异常抛出
      return new EfAxiosError(Number(e.code), e.name, e.message, e.stack);
    }
  }

  /**
   * get请求 -rest 风格
   * @param efClientParams  get请求入参实体
   * @returns 响应结果
   */
  async get<E>(efClientParams: efClientParams<null>): Promise<E | EfAxiosError> {
    try {
      //如果当前请求efClientParams.loadingTxt传入参数  则 更改当前的loading文本
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = efClientParams.loadingTxt;
      }
      let response: AxiosResponse<E> = await efAxios.get<E, AxiosResponse<E>, null>(efClientParams.url, {
        headers: EfClientApi.appendHeader(efClientParams.headers),
        baseURL: EfClientApi.appendBaseURL(efClientParams.baseUrl)
      });
      //如果当前请求更改过loading文字的话 - 更改默认值
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = EfAxiosConst.loadingTxt;
      }
      //返回response的数据
      return response.data;
    } catch (error) {
      //如果当前请求更改过loading文字的话 - 更改默认值
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = EfAxiosConst.loadingTxt;
      }
      let e: AxiosError = error as AxiosError;
      //将异常抛出
      return new EfAxiosError(Number(e.code), e.name, e.message, e.stack);
    }
  }

  /**
   * get请求 - json格式
   * @param efClientParams  get请求入参实体
   * @returns
   */
  async getByParams<E>(efClientParams: efClientParams<null>): Promise<E | EfAxiosError> {
    try {
      //如果当前请求efClientParams.loadingTxt传入参数  则 更改当前的loading文本
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = efClientParams.loadingTxt;
      }
      let response: AxiosResponse<E> = await efAxios.get<E, AxiosResponse<E>, null>(efClientParams.url, {
        params: efClientParams.params,
        headers: EfClientApi.appendHeader(efClientParams.headers),
        baseURL: EfClientApi.appendBaseURL(efClientParams.baseUrl)
      });
      //如果当前请求更改过loading文字的话 - 更改默认值
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = EfAxiosConst.loadingTxt;
      }
      //返回response的数据
      return response.data;
    } catch (error) {
      //如果当前请求更改过loading文字的话 - 更改默认值
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = EfAxiosConst.loadingTxt;
      }
      let e: AxiosError = error as AxiosError;
      //将异常抛出
      return new EfAxiosError(Number(e.code), e.name, e.message, e.stack);
    }
  }

  /**
   * put  请求
   * @param efClientParams  put请求入参实体
   * @returns
   */
  async put<F, E>(efClientParams: efClientParams<F>): Promise<E | EfAxiosError> {
    try {
      //如果当前请求efClientParams.loadingTxt传入参数  则 更改当前的loading文本
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = efClientParams.loadingTxt;
      }
      let response: AxiosResponse<E> =
        await efAxios.put<E, AxiosResponse<E>, F>(efClientParams.url, efClientParams.query, {
          headers: EfClientApi.appendHeader(efClientParams.headers),
          baseURL: EfClientApi.appendBaseURL(efClientParams.baseUrl)
        });
      //如果当前请求更改过loading文字的话 - 更改默认值
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = EfAxiosConst.loadingTxt;
      }
      //返回response的数据
      return response.data;
    } catch (error) {
      //如果当前请求更改过loading文字的话 - 更改默认值
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = EfAxiosConst.loadingTxt;
      }
      let e: AxiosError = error as AxiosError;
      //将异常抛出
      return new EfAxiosError(Number(e.code), e.name, e.message, e.stack);
    }
  }

  /**
   * delete请求
   * @param efClientParams  删除请求入参实体
   * @returns
   */
  async delete<E>(efClientParams: efClientParams<null>): Promise<E | EfAxiosError> {
    try {
      //如果当前请求efClientParams.loadingTxt传入参数  则 更改当前的loading文本
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = efClientParams.loadingTxt;
      }
      let response: AxiosResponse<E> = await efAxios.delete<E, AxiosResponse<E>, null>(efClientParams.url, {
        headers: EfClientApi.appendHeader(efClientParams.headers),
        baseURL: EfClientApi.appendBaseURL(efClientParams.baseUrl)
      });
      //如果当前请求更改过loading文字的话 - 更改默认值
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = EfAxiosConst.loadingTxt;
      }
      //返回response的数据
      return response.data;
    } catch (error) {
      //如果当前请求更改过loading文字的话 - 更改默认值
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = EfAxiosConst.loadingTxt;
      }
      let e: AxiosError = error as AxiosError;
      //将异常抛出
      return new EfAxiosError(Number(e.code), e.name, e.message, e.stack);
    }
  }

  /**
   * 批量获取请求
   * @param requestList  需要传入的请求集合
   * @returns 返回的请求结果ArrayList集合组装
   */
  async all(requestList: Promise<AxiosResponse>[]): Promise<ArrayList<string> | EfAxiosError> {
    try {
      //返回结果
      let result: ArrayList<string> = new ArrayList();
      //发起请求
      let responseList: AxiosResponse[] = await Promise.all(requestList);
      //返回response的数据
      responseList.forEach((response: AxiosResponse) => {
        if (response.data) {
          result.add(JSON.stringify(response.data));
        }
      });
      return result;
    } catch (error) {
      let e: AxiosError = error as AxiosError;
      //将异常抛出
      return new EfAxiosError(Number(e.code), e.name, e.message, e.stack);
    }
  }

  /**
   *
   * 统一的上传请求
   * @param efClientParams 上传入参实体
   * @param progressCallBack 上传进度回调
   * @returns 上传结果
   */
  async upload(efClientParams: efClientParams<null>, progressCallBack: (process: number) => void): Promise<Object> {
    try {
      //如果当前请求efClientParams.loadingTxt传入参数  则 更改当前的loading文本
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = efClientParams.loadingTxt;
      }
      let formData = new FormData();
      if (efClientParams.keyName) {
        if (efClientParams.isUri) {
          formData.append(efClientParams.keyName, 'internal://cache/' + efClientParams.uri);
        } else {
          formData.append(efClientParams.keyName, efClientParams.data);
        }
      } else {
        if (efClientParams.isUri) {
          formData.append('file', 'internal://cache/' + efClientParams.uri);
        } else {
          formData.append('file', efClientParams.data);
        }
      }
      //需要添加的header对象
      let addHead: AxiosHeaders = EfClientApi.appendHeader(efClientParams.headers);
      addHead.set('Content-Type', 'multipart/form-data', true);
      addHead.set('Accept', '*/*', true);
      addHead.set('Req-Type', 'uploadOrDownload', true);
      //是否有公共header
      if (efAxiosParams.headers) {
        Object.entries(efAxiosParams.headers).forEach((row) => {
          addHead.set(row[0], row[1] as string, true);
        });
      }
      let response: AxiosResponse<string> =
        await efAxios.post<string, AxiosResponse<string>, FormData>(efClientParams.url, formData, {
          headers: addHead,
          baseURL: EfClientApi.appendBaseURL(efClientParams.baseUrl),
          context: getContext(this) as common.UIAbilityContext,
          onUploadProgress: (progressEvent: AxiosProgressEvent): void => {
            if (progressEvent && progressEvent.loaded && progressEvent.total) {
              //回调进度
              progressCallBack(Math.ceil(progressEvent.loaded / progressEvent.total * 100));
            }
          }
        });
      //如果当前请求更改过loading文字的话 - 更改默认值
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = EfAxiosConst.loadingTxt;
      }
      return response.data;
    } catch (error) {
      //如果当前请求更改过loading文字的话 - 更改默认值
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = EfAxiosConst.loadingTxt;
      }
      let e: AxiosError = error as AxiosError;
      //将异常抛出
      return new EfAxiosError(Number(e.code), e.name, e.message, e.stack);
    }
  }

  /**
   * 统一的下载请求
   * @param efClientParams 下载入参实体
   * @param progressCallBack  下载进度回调方法
   * @returns
   */
  async download(efClientParams: efClientParams<null>, progressCallBack: (process: number) => void): Promise<Object> {
    try {
      //如果当前请求efClientParams.loadingTxt传入参数  则 更改当前的loading文本
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = efClientParams.loadingTxt;
      }
      //获取上下文
      let context = getContext(this) as common.UIAbilityContext;
      let filesDir = context.filesDir;
      //组装下载路径
      let finalPath = filesDir + "/" + efClientParams.filePath;
      //获取文件名
      let fName = new fileUri.FileUri(finalPath).name;
      //获取目录路径
      let path = finalPath.replace(fName, "");
      try {
        let isExists = fs.accessSync(finalPath);
        //如果已存在则删除
        if (isExists) {
          fs.unlinkSync(finalPath);
        } else {
          //创建
          if (path != filesDir + "/") {
            fs.mkdirSync(path, true);
          }
        }
      } catch (err) {
        return "下载失败,指定路径下已存在文件~";
      }
      //需要添加的header对象
      let addHead: AxiosHeaders = EfClientApi.appendHeader(efClientParams.headers);
      addHead.set('Req-Type', 'uploadOrDownload', true);
      //是否有公共header
      if (efAxiosParams.headers) {
        Object.entries(efAxiosParams.headers).forEach((row) => {
          addHead.set(row[0], row[1] as string, true);
        });
      }
      //下载
      let response: AxiosResponse<string> = await efAxios({
        url: efClientParams.url,
        method: 'get',
        context: context,
        filePath: finalPath,
        headers: addHead,
        baseURL: EfClientApi.appendBaseURL(efClientParams.baseUrl),
        onDownloadProgress: (progressEvent: AxiosProgressEvent): void => {
          if (progressEvent && progressEvent.loaded && progressEvent.total) {
            //回调进度
            progressCallBack(Math.ceil(progressEvent.loaded / progressEvent.total * 100));
          }
        }
      });
      //如果当前请求更改过loading文字的话 - 更改默认值
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = EfAxiosConst.loadingTxt;
      }
      //返回结果
      return response.data;
    } catch (error) {
      //如果当前请求更改过loading文字的话 - 更改默认值
      if (efClientParams.loadingTxt) {
        efAxiosParams.loadingTxt = EfAxiosConst.loadingTxt;
      }
      let e: AxiosError = error as AxiosError;
      //将异常抛出
      return new EfAxiosError(Number(e.code), e.name, e.message, e.stack);
    }
  }
}

/**
 * 单个请求的入参实体
 */
export class efClientParams<T> {
  /**
   * 请求基地址
   */
  baseUrl?: string;
  /**
   * 请求路径
   */
  url: string = '';
  /**
   *  post/put请求参数
   */
  query?: T;
  /**
   *  get入参
   */
  params?: Record<string, Object>;
  /**
   *  请求头
   */
  headers?: Record<string, Object>;
  /**
   * formData数据
   */
  formData?: FormData;
  /**
   * 文件路径
   */
  filePath?: string;
  /**
   * 文件上传时-是否为uri标识
   */
  isUri?: boolean;
  /**
   * 文件上传时的文件流
   */
  data?: ArrayBuffer;
  /**
   * 文件上传时的uri
   */
  uri?: string;
  /**
   * 文件上传时的后端key名称
   */
  keyName?: string;
  /**
   * 单个请求需要更改的loading提示
   */
  loadingTxt?: string;
}


export const efClientApi = new EfClientApi();