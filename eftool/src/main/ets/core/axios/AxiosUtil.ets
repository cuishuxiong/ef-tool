import axios from '@ohos/axios'
import { AxiosError } from '@ohos/axios';
import { InternalAxiosRequestConfig } from '@ohos/axios';
import { AxiosStatic } from '@ohos/axios';


/**
 * @Author csx
 * @DateTime 2024/4/10 23:27
 * @TODO AxiosUtil  网络工具类
 */
export class AxiosUtil {
  static baseURL: string = "/";

  private static getAxios(): AxiosStatic {
    const context = axios.create({
      baseURL: AxiosUtil.baseURL,
      timeout: 1000
    });
    return context as AxiosStatic;
  }

  efAxios = AxiosUtil.getAxios();

  constructor() {
    // this.efAxios.interceptors.request.use((config: InternalAxiosRequestConfig) => {
    //   let nonce = "";
    //   const chars =
    //     "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    //   for (let i = 16; i > 0; --i) {
    //     nonce += chars.split('')[Math.floor(Math.random() * chars.length)];
    //   }
    //   config.headers["nonce"] = nonce;
    //   config.headers["timestamp"] = new Date().getTime();
    //
    //
    // }, (error: AxiosError) => {
    //   // 对请求错误做些什么
    //   return Promise.reject(error);
    // })
  }
}

export const efAxios = new AxiosUtil().efAxios;
