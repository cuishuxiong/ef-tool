/**
 * @Author csx
 * @DateTime 2024/4/19 08:00:04
 * @TODO EfApi  axios封装的请求工具类
 */
import { AxiosResponse } from '@ohos/axios';
import { efAxios } from './AxiosUtil';

class EfClientApi {
  /**
   * post请求
   * @param url 请求url
   * @param query  请求参数
   * @returns 响应结果
   */
  async post<F, E>(url: string, query: Record<string, Object>): Promise<E> {
    return await efAxios.post<E, AxiosResponse<E>, F>(url, query as F).then((response: AxiosResponse<E>) => {
      return response.data
    });
  }

  /**
   * get请求 -rest 风格
   * @param url  请求URL附带参数
   * @returns 响应结果
   */
  async get<E>(url: string): Promise<E> {
    return await efAxios.get<E, AxiosResponse<E>, null>(url).then((response: AxiosResponse<E>) => {
      return response.data
    });
  }

  /**
   * get请求 - json格式
   * @param url
   * @param params
   * @returns
   */
  async getByParams<E>(url: string, params: Record<string, Object>): Promise<E> {
    return await efAxios.get<E, AxiosResponse<E>, null>(url, {
      params: params
    }).then((response: AxiosResponse<E>) => {
      return response.data
    });
  }

  /**
   * put  请求
   * @param url  请求url
   * @param query  请求参数
   * @returns
   */
  async put<F, E>(url: string, query: Record<string, Object>): Promise<E> {
    return await efAxios.put<E, AxiosResponse<E>, F>(url, query as F).then((response: AxiosResponse<E>) => {
      return response.data
    });
  }

  /**
   * delete请求
   * @param url  请求url
   * @returns
   */
  async delete<E>(url: string): Promise<E> {
    return await efAxios.delete<E, AxiosResponse<E>, null>(url).then((response: AxiosResponse<E>) => {
      return response.data
    });
  }

  /**
   * 统一的上传请求【预计1.1.9版本可用】
   */
  upload() {

  }

  /**
   * 统一的下载请求【预计1.1.9版本可用】
   */
  download() {

  }
}

export const efClientApi = new EfClientApi();