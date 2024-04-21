/**
 * @Author csx
 * @DateTime 2024/4/19 08:00:04
 * @TODO EfApi  axios封装的请求工具类
 */
import { AxiosError } from '@ohos/axios';
import { AxiosHeaders } from '@ohos/axios';
import { AxiosResponse } from '@ohos/axios';
import { ToastUtil } from '../../ui/prompt/ToastUtil';
import { OutDTO } from '../base/OutDTO';
import { efAxios, efAxiosParams } from './AxiosUtil';

class EfClientApi {
  /**
   * post请求
   * @param url 请求url
   * @param query  请求参数
   * @returns 响应结果
   */
  async post<F, E>(url: string, query: Record<string, Object>): Promise<E> {
    //获取鉴权参数名称
    // let Authorization = efAxiosParams.tokenName;
    //获取鉴权参数值
    // let token = efAxiosParams.tokenValue;
    // let result: OutDTO<E> = await efAxios.post<E, AxiosResponse<OutDTO<E>>, F>(url, query).then((response: AxiosResponse<OutDTO<E>>) => {
    //   return response.data
    // });
    return await efAxios.post<E, AxiosResponse<E>, F>(url, query as F).then((response: AxiosResponse<E>) => {
      return response.data
    });
    // .then((res: AxiosResponse<E>) => {
    //   return res
    // }).catch((err: AxiosError) => {
    //   ToastUtil.showToast('发送请求失败,是吧原因为:'+err.message);
    // });
  }

  get() {

  }

  upload() {

  }

  download() {

  }
}

export const efClientApi = new EfClientApi();