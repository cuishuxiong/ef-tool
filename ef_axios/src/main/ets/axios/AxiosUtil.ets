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

import axios from '@ohos/axios'
import { AxiosError, InternalAxiosRequestConfig, AxiosResponse, AxiosStatic } from '@ohos/axios';
import { RandomUtil, Logger } from '@yunkss/ef_core';
import { SM2Sync, SM3Sync, SM4Sync } from '@yunkss/ef_crypto';
import { ArrayList } from '@kit.ArkTS';
import { JSONUtil, JSONObject } from '@yunkss/ef_json';
import { WinLoadingUtil } from '../ui/AxiosLoadingUtil';
import { ImgLayout, LoadingShape } from '../ui/axiosLoading';
import { EfAxiosConst } from '../EfAxiosConst';

/**
 * @Author csx
 * @DateTime 2024/4/10 23:27
 * @TODO AxiosUtil  网络工具类
 */
export class AxiosUtil {
  /**
   * response解密所需的数组
   */
  private static sm4KeyList: ArrayList<Record<string, Object>> = new ArrayList();

  /**
   * 获取默认的axios对象
   * @returns AxiosStatic
   */
  private static getAxios(): AxiosStatic {
    const context = axios.create({
      baseURL: efAxiosParams.baseURL,
      timeout: 10000
    });
    return context as AxiosStatic;
  }

  /**
   * 封装后的全局axios对象
   */
  efAxios = AxiosUtil.getAxios();

  /**
   * 封装对请求config的操作
   * @param config axios的默认配置
   */
  static convertRequestInfo(config: InternalAxiosRequestConfig) {
    //设置请求URL
    if (!config.baseURL) {
      config.baseURL = efAxiosParams.baseURL;
    }
    //防篡改字段的随机数因子
    let nonce = RandomUtil.randomStrBySize(16, 'hex');
    //防篡改字段的随机数因子
    config.headers.nonce = nonce;
    //防重放的随机数因子
    config.headers.timestamp = new Date().getTime();
    //设置默认请求类型
    if (!config.headers['Content-Type']) {
      config.headers['Content-Type'] = 'application/json';
    }
    //有token值说明登录成功则添加到请求头
    if (efAxiosParams.tokenValue) {
      //token鉴权值
      config.headers[efAxiosParams.tokenName] = efAxiosParams.tokenValue;
    }
    //sm3完整性校验所需sm3Params
    let sm3Params = "";
    //是否全局加密或者是局部加密 并且是post/put请求
    if ((efAxiosParams.isAllEncrypt || efAxiosParams.isPartEncrypt) &&
      (config.method === 'post' || config.method === 'put')) {
      sm3Params = JSON.stringify(config.data);
      //每次请求都重新生成sm4的秘钥
      let sm4Key = SM4Sync.generateSM4Key('hex');
      //每次请求都生成iv
      let sm4IV = RandomUtil.generateIV('hex');
      //需要将服务器端的公钥转换成前端所需的公钥
      let finalSM2 = SM2Sync.convertSM2PubKey(efAxiosParams.sm2PubKey);
      //将SM4的密钥用SM2加密存入header
      config.headers.ef_random_key = SM2Sync.encode(sm4IV.getDataRow() + sm4Key, finalSM2, 'hex', 'hex');
      //整体加密(上传下载不加密请求头Req-Type为uploadOrDownload的请求)
      if (efAxiosParams.isAllEncrypt && config.headers["Req-Type"] != "uploadOrDownload") {
        //判断如果有不加解密的接口则跳过加密
        let lastUrl: string = config.url?.slice(config.url?.lastIndexOf("/") + 1, config.url.length).trim() || "";
        //白名单接口不加密
        if (efAxiosParams.ignoreEncryptList.indexOf(lastUrl) < 0) {
          config.data = AxiosUtil.encryptRequestData(
            config.data,
            sm4Key,
            sm4IV.getDataRow(),
            config.method
          );
          let obj: Record<string, Object> = {};
          obj.sm4keyNum = sm4IV + sm4Key;
          obj.ef_request_params = config.data.ef_request_params;
          //response解密时需要
          AxiosUtil.sm4KeyList.add(obj);
        }
      }
      //关键字加密
      if (efAxiosParams.isPartEncrypt) {
        //给部分敏感字段加密
        config.data = AxiosUtil.encryptPartParam(config.data, sm4Key, sm4IV.getDataRow());
        let obj: Record<string, Object> = {};
        obj.sm4keyNum = sm4IV + sm4Key;
        obj.ef_request_params = JSON.stringify(config.data.ef_request_params);
        //response解密时需要
        AxiosUtil.sm4KeyList.add(obj);
      }
      // 注意：config.method 的判断值必须是小写的post/get/put
      if (sm3Params.length > 32) {
        sm3Params = sm3Params.substring(0, 32);
      }
      //校验因子
      let enCodeKey = RandomUtil.randomStrBySize(32, 'hex');
      let sm3 = SM3Sync.digest(sm3Params + enCodeKey + config.headers.timestamp);
      config.headers.sign = sm3;
    }
  }

  /**
   * 统一处理响应
   * @param response  axios返回的响应对象
   */
  static convertResponseInfo(response: AxiosResponse) {
    //判断如果有不加解密的接口则跳过加密
    let lastUrl: string =
      response.config.url?.slice(response.config.url?.lastIndexOf("/") + 1, response.config.url.length).trim() || "";
    //整体解密
    if (efAxiosParams.isAllEncrypt) {
      //判断如果有不加解密的接口则跳过加密
      if (efAxiosParams.ignoreEncryptList.indexOf(lastUrl) < 0) {
        response.data = AxiosUtil.decryptResponseData(response.data);
      }
    }
    //关键字解密
    if (efAxiosParams.isPartEncrypt) {
      response.data = AxiosUtil.decryptPartResponseData(response.data);
    }
  }

  /**
   * 关键字解密全部响应结果
   * @param data
   * @returns
   */
  private static decryptPartResponseData(data: Object): Record<string, Object> {
    //最终返回结果
    let result: Record<string, Object> = {};
    //获取SM4的key
    let sm4: string = '';
    let convertData: Record<string, Object> = JSON.parse(JSON.stringify(data));
    //获取解密密钥
    if (convertData.ef_request_params) {
      //循环获取数据
      AxiosUtil.sm4KeyList.forEach((item: Record<string, Object>) => {
        if (item["ef_request_params"] === convertData.ef_request_params) {
          sm4 = item["sm4keyNum"] as string;
          //从结果中移除
          AxiosUtil.sm4KeyList.remove(item);
        }
      })
      //获取到了密钥
      if (sm4) {
        if (convertData.data) {
          //是否是json
          if (JSONUtil.isJSONString(convertData.data as string)) {
            let key = sm4.substring(32);
            let iv = sm4.substring(0, 32);
            //解密  递归获取关键字解密
            let inObj: Record<string, Object> = JSON.parse(convertData.data as string);
            result = AxiosUtil.convertResponseData(inObj, key, iv);
          } else {
            result = convertData;
          }
        }
      }
    } else {
      result = convertData;
    }
    return result;
  }

  /**
   * 递归查找响应字符串中是否有解密关键字
   * @param data  待递归的数据
   * @param key  sm4的key
   * @param iv  sm4的偏移量
   * @returns 查找后的结果
   */
  private static convertResponseData(data: Record<string, Object>, key: string,
    iv: string): Record<string, Object> {
    if (typeof data === "object") {
      for (let item of Object.entries(data)) {
        if (typeof item[1] === "object") {
          data[item[0]] = AxiosUtil.convertResponseData(item[1] as Record<string, Object>, key, iv);
        } else if (typeof item[1] === "string" && JSONUtil.isJSONString(item[1])) {
          data[item[0]] = AxiosUtil.convertResponseData(JSON.parse(item[1]), key, iv);
        } else {
          if (efAxiosParams.keyWordsList.includes(item[0])) {
            data[item[0]] = SM4Sync.decodeCBC(item[1], key, iv, 'hex', 'hex');
          }
        }
      }
    }
    return data;
  }


  /**
   * 解密全部响应结果
   * @param data
   * @returns
   */
  private static decryptResponseData(data: Object): Record<string, Object> {
    //最终返回结果
    let result: Record<string, Object> = {};
    //获取SM4的key
    let sm4: string = '';
    let convertData: Record<string, Object> = JSON.parse(JSON.stringify(data));
    //判断data是不是json字符串
    //获取解密密钥
    if (convertData.ef_request_params) {
      //循环获取数据
      AxiosUtil.sm4KeyList.forEach((item: Record<string, Object>) => {
        if (item["ef_request_params"] === convertData.ef_request_params) {
          sm4 = item["sm4keyNum"] as string;
          //从结果中移除
          AxiosUtil.sm4KeyList.remove(item);
        }
      })
      //获取到了密钥
      if (sm4) {
        if (convertData.data) {
          let key = sm4.substring(32);
          let iv = sm4.substring(0, 32);
          //解密
          let r = SM4Sync.decodeCBC(convertData.data as string, key, iv, 'hex', 'hex');
          result = JSON.parse(r);
        }
      }
    } else {
      result = convertData;
    }
    return result;
  }

  /**
   * 加密全部请求参数
   * @param data  待加密的数据
   * @param sm4key  加密所需的SM4的密钥
   * @param sm4Iv   加密所需的SM4的偏移量
   * @param type  请求类型
   * @returns 加密后的对象
   */
  private static encryptRequestData(data: Record<string, Object>, sm4key: string, sm4Iv: string,
    type: string): Record<string, Object> {
    let params = '';
    let obj: Record<string, Object>;
    if (!data) {
      data = {
        "tp": Date.now() as Object,
      };
      params = JSON.stringify(data);
      obj = {
        'ef_request_params': SM4Sync.encodeCBC(params, sm4key, sm4Iv, 'hex', 'hex'),
        'ef_fingerprint': SM3Sync.digest(params, 'hex')
      };
    } else {
      if (type == "get") {
        params = Object.keys(data).map((key) => {
          return key + "=" + data[key];
        }).join("&");
      } else {
        params = JSON.stringify(data);
      }
      obj = {
        'ef_request_params': SM4Sync.encodeCBC(params, sm4key, sm4Iv, 'hex', 'hex'),
        'ef_fingerprint': SM3Sync.digest(params, 'hex')
      };
    }
    return obj;
  }

  /**
   * 关键字加密
   * @param obj  待加密的数据
   * @param sm4Key 加密所需的SM4的密钥
   * @param sm4Iv   加密所需的SM4的偏移量
   * @returns 加密后的对象
   */
  private static encryptPartParam(obj: Record<string, Object>, sm4Key: string, sm4Iv: string) {
    let result: Record<string, Object> = {
      'ef_fingerprint': SM3Sync.digest(JSON.stringify(obj), 'hex')
    };
    for (let inObj of Object.entries(obj)) {
      //每行递归
      if (typeof inObj[1] === "object") {
        AxiosUtil.encryptPartParam(inObj[1] as Record<string, Object>, sm4Key, sm4Iv);
      } else {
        if (efAxiosParams.keyWordsList.indexOf(inObj[0]) > -1) {
          obj[inObj[0]] = SM4Sync.encodeCBC(inObj[1], sm4Key, sm4Iv, 'hex', 'hex');
        }
      }
    }
    result.ef_request_params = obj;
    return result;
  }
}

/**
 * efAxios所需参数实体
 */
export class efAxiosParams {
  /**
   * 是否整体传输加密 与关键字加密isAllEncrypt互斥 二者只能有其一为true
   */
  static isAllEncrypt: boolean = false;
  /**
   * 是否部分关键字传输加密 与整体传输加密互斥 二者只能有其一为true
   */
  static isPartEncrypt: boolean = false;
  /**
   * 关键字加密时的关键字集合
   */
  static keyWordsList: Array<string> = new Array<string>();
  /**
   * 用户自定义token的Key,默认为Authorization
   */
  static tokenName: string = 'Authorization';
  /**
   * 登录成功后的token值
   */
  static tokenValue: string = '';
  /**
   * 服务器 URL
   */
  static baseURL: string = '';
  /**
   * 请求头加密的SM2公钥
   */
  static sm2PubKey: string = '';
  /**
   *加解密接口忽略集合
   */
  static ignoreEncryptList: Array<string> = new Array<string>();
  /**
   * 是否开启全局请求loading弹框,默认为true
   */
  static isLoading: boolean = true;
  /**
   * 全局loading的加载内容,默认值为[努力获取数据中,请稍后...]
   */
  static loadingTxt: string = EfAxiosConst.loadingTxt;
  /**
   * 是否开启日志
   */
  static isLogger: boolean = true;
}

/**
 * 抛出封装后的axios
 */
export const efAxios = new AxiosUtil().efAxios;

/**
 * 设置统一的请求拦截
 */
efAxios.interceptors.request.use(async (config: InternalAxiosRequestConfig) => {
  if (efAxiosParams.isLoading) {
    //显示全局加载框
    await WinLoadingUtil.showLoading({
      content: efAxiosParams.loadingTxt,
      imgLayout: ImgLayout.TOP,
      layoutShape: LoadingShape.SQUARE
    });
  }
  AxiosUtil.convertRequestInfo(config);
  //是否开启日志
  if (efAxiosParams.isLogger) {
    Logger.init('efAxios', getContext(), 0xFF00);
    Logger.debug("--------请求信息---------", "");
    Logger.debug("--------请求URL:", (config.baseURL as string + config.url as string));
    Logger.debug("--------请求方式:", config.method as string);
    Logger.debug("--------请求  头:", JSONObject.toJSONString(config.headers));
    if (config.headers["Req-Type"] != "uploadOrDownload" && config.data) {
      Logger.debug("--------请求入参:", JSONObject.toJSONString(config.data));
    }

  }
  return config;
}, async (error: AxiosError) => {
  if (efAxiosParams.isLoading) {
    //关闭全局加载框
    await WinLoadingUtil.closeLoading();
  }
  // 对请求错误做些什么
  return Promise.reject(error);
})

/**
 * 设置统一的响应拦截
 */
efAxios.interceptors.response.use(async (response: AxiosResponse) => {
  // 处理响应数据
  AxiosUtil.convertResponseInfo(response);
  if (efAxiosParams.isLoading) {
    //关闭全局加载框
    await WinLoadingUtil.closeLoading();
  }
  //是否开启日志
  if (efAxiosParams.isLogger) {
    Logger.init('efAxios', getContext(), 0xFF00);
    Logger.debug("--------响应信息---------", "");
    Logger.debug("--------响应状态:", response.status + "");
    Logger.debug("--------响应文本:", response.statusText);
    if (response.config.headers["Req-Type"] != "uploadOrDownload" && response.data) {
      Logger.debug("--------响应  头:", JSON.stringify(response.headers));
      Logger.debug("--------响应结果:", JSON.stringify(response.data));
    }
  }
  return response;
}, async (error: AxiosError) => {
  if (efAxiosParams.isLoading) {
    //关闭全局加载框
    await WinLoadingUtil.closeLoading();
  }
  // 对响应错误做点什么
  return Promise.reject(error);
});

