/**
 * @Author csx
 * @DateTime 2024/4/19 08:00:04
 * @TODO EfApi  axios封装的请求工具类
 */
import { AxiosError, AxiosHeaders, AxiosProgressEvent, AxiosResponse, FormData } from '@ohos/axios';
import { efAxios } from './AxiosUtil';
import fs from '@ohos.file.fs';
import { ToastUtil } from '../../ui/prompt/ToastUtil';
import { common } from '@kit.AbilityKit';


class EfClientApi {
  /**
   * post请求
   * @param url 请求url
   * @param query 请求参数
   * @param headers 请求头
   * @returns 响应结果
   */
  async post<F, E>(url: string, query: Record<string, Object>, headers?: Record<string, Object>): Promise<E> {
    //需要添加的header对象
    let addHead: AxiosHeaders = new AxiosHeaders();
    //是否有传入header
    if (headers) {
      Object.entries(headers).forEach((row) => {
        addHead.set(row[0], row[1] as string, true);
      });
    }
    return await efAxios.post<E, AxiosResponse<E>, F>(url, query as F, {
      headers: addHead
    }).then((response: AxiosResponse<E>) => {
      return response.data
    });
  }

  /**
   * get请求 -rest 风格
   * @param url  请求URL附带参数
   * @param headers 请求头
   * @returns 响应结果
   */
  async get<E>(url: string, headers?: Record<string, Object>): Promise<E> {
    //需要添加的header对象
    let addHead: AxiosHeaders = new AxiosHeaders();
    //是否有传入header
    if (headers) {
      Object.entries(headers).forEach((row) => {
        addHead.set(row[0], row[1] as string, true);
      });
    }
    return await efAxios.get<E, AxiosResponse<E>, null>(url, {
      headers: addHead
    }).then((response: AxiosResponse<E>) => {
      return response.data
    });
  }

  /**
   * get请求 - json格式
   * @param url 请求URL
   * @param params 请求参数
   * @param headers 请求头
   * @returns
   */
  async getByParams<E>(url: string, params: Record<string, Object>, headers?: Record<string, Object>): Promise<E> {
    //需要添加的header对象
    let addHead: AxiosHeaders = new AxiosHeaders();
    //是否有传入header
    if (headers) {
      Object.entries(headers).forEach((row) => {
        addHead.set(row[0], row[1] as string, true);
      });
    }
    return await efAxios.get<E, AxiosResponse<E>, null>(url, {
      params: params,
      headers: addHead
    }).then((response: AxiosResponse<E>) => {
      return response.data
    });
  }

  /**
   * put  请求
   * @param url  请求url
   * @param query  请求参数
   * @param headers 请求头
   * @returns
   */
  async put<F, E>(url: string, query: Record<string, Object>,headers?: Record<string, Object>): Promise<E> {
    //需要添加的header对象
    let addHead: AxiosHeaders = new AxiosHeaders();
    //是否有传入header
    if (headers) {
      Object.entries(headers).forEach((row) => {
        addHead.set(row[0], row[1] as string, true);
      });
    }
    return await efAxios.put<E, AxiosResponse<E>, F>(url, query as F, {
      headers: addHead
    }).then((response: AxiosResponse<E>) => {
      return response.data
    });
  }

  /**
   * delete请求
   * @param url  请求url
   * @param headers 请求头
   * @returns
   */
  async delete<E>(url: string, headers?: Record<string, Object>): Promise<E> {
    //需要添加的header对象
    let addHead: AxiosHeaders = new AxiosHeaders();
    //是否有传入header
    if (headers) {
      Object.entries(headers).forEach((row) => {
        addHead.set(row[0], row[1] as string, true);
      });
    }
    return await efAxios.delete<E, AxiosResponse<E>, null>(url, {
      headers: addHead
    }).then((response: AxiosResponse<E>) => {
      return response.data
    });
  }

  /**
   *
   * 统一的上传请求
   * @param url 上次url
   * @param progressCallBack 上传进度回调
   * @param fieldData 表单其他字段，如文件名
   * @param isUri  是否为uri文件
   * @param data  isUri=false时传入 表示上传的文件为ArrayBuffer格式
   * @param uri   isUri=true时传入  表示上传的文件为uri格式
   * @param keyName  上传时后端接收的key,默认为file
   * @param headers 自定义请求头
   * @returns 上传结果
   */
  async upload(url: string, isUri: boolean, progressCallBack: (process: number) => void,data?: ArrayBuffer, uri?: string, keyName?: string, headers?: Record<string, Object>) {
    let formData = new FormData();
    if (keyName) {
      if (isUri) {
        formData.append(keyName, 'internal://cache/' + uri);
      } else {
        formData.append(keyName, data);
      }
    } else {
      if (isUri) {
        formData.append('file', 'internal://cache/' + uri);
      } else {
        formData.append('file', data);
      }
    }
    //需要添加的header对象
    let addHead: AxiosHeaders = new AxiosHeaders();
    addHead.set('Content-Type', 'multipart/form-data', true);
    addHead.set('Accept', '*/*', true);
    addHead.set('Req-Type', 'uploadOrDownload', true);
    //是否有传入header
    if (headers) {
      Object.entries(headers).forEach((row) => {
        addHead.set(row[0], row[1] as string, true);
      });
    }
    return await efAxios.post<string, AxiosResponse<string>, FormData>(url, formData, {
      headers: addHead,
      context: getContext(this) as common.UIAbilityContext,
      onUploadProgress: (progressEvent: AxiosProgressEvent): void => {
        if (progressEvent && progressEvent.loaded && progressEvent.total) {
          //回调进度
          progressCallBack(Math.ceil(progressEvent.loaded / progressEvent.total * 100));
        }
      }
    }).then((response: AxiosResponse<string>) => {
      return response.data
    }).catch((err: AxiosError) => {
      ToastUtil.showToast(err.message);
    });

  }

  /**
   * 统一的下载请求
   * @param url 下载URL
   * @param filePath  下载文件全路径
   * @param progressCallBack  下载进度回调方法
   * @param headers 自定义请求头
   * @returns
   */
  async download(url: string, filePath: string, progressCallBack: (process: number) => void, headers?: Record<string, Object>) {
    //获取上下文
    let context = getContext(this) as common.UIAbilityContext;
    let filesDir = context.filesDir;
    //组装下载路径
    let finalPath = filesDir + "/" + filePath;
    try {
      let isExists = fs.accessSync(finalPath);
      //如果已存在则删除
      if (isExists) {
        fs.unlinkSync(finalPath);
      }
    } catch (err) {
      ToastUtil.showToast('删除路径下已存在文件失败:' + filePath);
      return;
    }
    //需要添加的header对象
    let addHead: AxiosHeaders = new AxiosHeaders();
    addHead.set('Req-Type', 'uploadOrDownload', true);
    //是否有传入header
    if (headers) {
      Object.entries(headers).forEach((row) => {
        addHead.set(row[0], row[1] as string, true);
      });
    }
    //下载
    return await efAxios({
      url: url,
      method: 'get',
      context: context,
      filePath: finalPath,
      headers: addHead,
      onDownloadProgress: (progressEvent: AxiosProgressEvent): void => {
        if (progressEvent && progressEvent.loaded && progressEvent.total) {
          //回调进度
          progressCallBack(Math.ceil(progressEvent.loaded / progressEvent.total * 100));
        }
      }
    }).then((response: AxiosResponse<string>) => {
      return response.data
    }).catch((err: AxiosError) => {
      ToastUtil.showToast(err.message);
    });
  }
}

export const efClientApi = new EfClientApi();