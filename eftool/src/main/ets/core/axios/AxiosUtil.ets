import axios from '@ohos/axios'
import { AxiosError } from '@ohos/axios';
import { InternalAxiosRequestConfig } from '@ohos/axios';
import { AxiosResponse } from '@ohos/axios';
import { AxiosStatic } from '@ohos/axios';
import { SM2 } from '../crypto/encryption/SM2';
import { SM3 } from '../crypto/encryption/SM3';
import { SM4 } from '../crypto/encryption/SM4';
import { RandomUtil } from '../util/RandomUtil';


/**
 * @Author csx
 * @DateTime 2024/4/10 23:27
 * @TODO AxiosUtil  网络工具类
 */
export class AxiosUtil {
  /**
   * 获取默认的axios对象
   * @returns AxiosStatic
   */
  private static getAxios(): AxiosStatic {
    const context = axios.create({
      baseURL: efAxiosParams.baseURL,
      timeout: 1000
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
  static async convertRequestInfo(config: InternalAxiosRequestConfig) {
    //防篡改字段的随机数因子
    let nonce = RandomUtil.randomStrBySize(16);
    //防篡改字段的随机数因子
    config.headers.nonce = nonce;
    if (!config.baseURL) {
      config.baseURL = efAxiosParams.baseURL;
    }
    //防重放的随机数因子
    config.headers.timestamp = new Date().getTime();
    //设置默认请求类型
    config.headers['Content-Type'] = 'application/json';
    //是否全局加密或者是局部加密 并且是post请求
    if ((efAxiosParams.isAllEncrypt || efAxiosParams.isPartEncrypt) && config.method === 'post') {
      let sm4Key = await SM4.generateSM4Key();
      //拼接sm2的请求头秘钥
      config.headers.ef_random_key = (await SM2.encode(sm4Key.getDataRow(), efAxiosParams.sm2PubKey)).getDataRow();
      //关键字加密
      if (efAxiosParams.isPartEncrypt) {
        //给部分敏感字段加密
        config.data = AxiosUtil.encryptPartParam(config.data, sm4Key.getDataRow());
      }
      //整体加密
      if (efAxiosParams.isAllEncrypt && config.headers["Req-Type"] != "uploadOrDownload") {
        config.data = await AxiosUtil.encryptRequestData(
          config.data,
          sm4Key.getDataRow(),
          "post"
        );
        let obj: Record<string, Object> = {};
        obj.sm4keyNum = sm4Key.getDataRow();
        obj.ef_request_params = config.data.ef_request_params;
        // sm4KeyArr.push(obj);
      }
    }
    //有token值说明登录成功则添加到请求头
    if (efAxiosParams.tokenValue) {
      //token鉴权值
      config.headers[efAxiosParams.tokenName] = efAxiosParams.tokenValue;
    }
    //此处操作为将入参获取做的32位长度进行sm3摘要,然后传入后台进行数据完整性校验时使用
    if ((efAxiosParams.isAllEncrypt || efAxiosParams.isPartEncrypt) && config.method === 'post') {
      let params = "";
      // 注意：config.method 的判断值必须是小写的post和get
      if (config.method === "post") {
        params = JSON.stringify(config.data);
      } else if (config.method === "get") {
        params = config.params;
      }
      if (params.length > 32) {
        params = params.substring(0, 32);
      }
      //校验因子
      let enCodeKey = RandomUtil.randomStrBySize(32);
      let sm3 = await SM3.digest(params + enCodeKey + config.headers.timestamp);
      // "veV8QV5bk2xGkeYkbRmXlsQADcqdX3qU";
      config.headers.sign = (await SM3.digest(sm3.getDataRow())).getDataRow();
    }
  }

  /**
   * 统一处理响应
   * @param response  axios返回的响应对象
   */
  static async convertResponseInfo(response: AxiosResponse) {
    let lastUrl: string =
      response.config.url?.slice(
        response.config.url?.lastIndexOf("/") + 1,
        response.config.url.length
      ).trim() || "";
    // if (response.status === 200) {
    //   let data = response.data;
    //   if (response.config.headers["Req-Type"] == "uploadOrDownload") {
    //     if (response.config.headers["ImageUpdata"] == "ImageUpdata") {
    //       data = data;
    //     } else {
    //       data = await promiseBlobToJson(data, response);
    //     }
    //   }
    //   if (isAddSM) {
    //     if (NO_SM_URL.indexOf(lastUrl) < 0) {
    //       if (typeof data === "string" && data.indexOf("OutDTO") > -1) {
    //       } else {
    //         // } else {
    //         let result: string = responseData(data);
    //         try {
    //           data = JSON.parse(result);
    //         } catch (error) {
    //           Message.error("json解析失败");
    //         }
    //         data.encryptParKey = response.headers.sm4key || "";
    //         // }
    //       }
    //     }
    //   }
    //   if (data.success) {
    //     return Promise.resolve(data);
    //   } else {
    //     let code: any, msgStr: any, msg: any;
    //
    //     if (typeof data === "string") {
    //       const matchs = data.match(/code=(\d+)/);
    //       msgStr = data.split(",");
    //       msg = msgStr[1].split("=")[1];
    //       if (matchs) {
    //         code = Number(matchs[1]);
    //       }
    //     } else {
    //       code = data.code;
    //     }
    //
    //     switch (code) {
    //     // 401: 未登录
    //     // 未登录则跳转登录页面，并携带当前页面的路径
    //     // 在登录成功后返回当前页面，这一步需要在登录页操作。
    //       case 401:
    //         {
    //           let lastMsg: any = msg;
    //           let IsSSo = getStore("isSSo");
    //           if (router.currentRoute.name != "login") {
    //             if (IsSSo == "3" || IsSSo == "4" || IsSSo == "2") {
    //               let str: any = localStorage.getItem("userInfo");
    //               const UserInfo = JSON.parse(str);
    //               newAxios
    //                 .post("/api/system/security/isc/logout", {
    //                   express: { iscUserId: UserInfo.iscUserId },
    //                 })
    //                 .then((iscLogout: any) => {
    //                   if (iscLogout.data.success) {
    //                     localStorage.setItem("userInfo", "");
    //                     localStorage.clear();
    //                     store.commit("setAdded", false);
    //                     setStore("accessToken", "");
    //                     if (msg) {
    //                       if (msg == "token已被顶下线") {
    //                         lastMsg = "您的账号在其他地方登录，已强制下线！";
    //                       }
    //                       if (msg == "token已过期") {
    //                         lastMsg = "您的会话已过期，请重新登录！";
    //                       }
    //                       if (msg == "token已被踢下线") {
    //                         lastMsg =
    //                           "同一机器仅允许登录一个账号，您已被踢下线";
    //                       }
    //                       //   Message.closeAll();
    //                       Message.error(lastMsg);
    //                     } else {
    //                       Message.error("未知错误，请重新登录");
    //                     }
    //                     window.location = iscLogout.data.dataRow;
    //                   }
    //                 })
    //                 .catch((err) => {
    //                   console.log("csxxxxxxxxxxxxxxx:" + err);
    //                 });
    //             } else {
    //               localStorage.setItem("userInfo", "");
    //               localStorage.clear();
    //               // store.commit("logout", this);
    //               setStore("accessToken", "");
    //               if (msg) {
    //                 if (msg == "token已被顶下线") {
    //                   lastMsg = "您的账号在其他地方登录，已强制下线！";
    //                 }
    //                 if (msg == "token已过期") {
    //                   lastMsg = "您的会话已过期，请重新登录！";
    //                 }
    //                 if (msg == "token已被踢下线") {
    //                   lastMsg = "同一机器仅允许登录一个账号，您已被踢下线";
    //                 }
    //                 // Message.closeAll();
    //                 Message.error(lastMsg);
    //               } else {
    //                 Message.error("未知错误，请重新登录");
    //               }
    //               router.replace({
    //                 path: "/",
    //                 query: {
    //                   redirect: router.currentRoute.fullPath,
    //                 },
    //               });
    //               localStorage.clear();
    //             }
    //           } else {
    //             // Message.closeAll();
    //             Message.error(lastMsg);
    //           }
    //         }
    //         break;
    //     // 没有权限
    //       case 403:
    //         {
    //           if (msg !== null) {
    //             Message.error(msg);
    //           } else {
    //             Message.error("未知错误");
    //           }
    //         }
    //         break;
    //       case 500:
    //         {
    //           Message.error("服务器异常，请稍后重试");
    //         }
    //         break;
    //       default: {
    //         Message.error(data.message);
    //       }
    //     }
    //     return Promise.reject(data);
    //   }
    // } else {
    //   return Promise.reject(response);
    // }
  }

  /**
   * 加密全部请求参数
   * @param data
   * @param sm4key
   * @param type
   * @returns
   */
  private static async encryptRequestData(data: Record<string, Object>, sm4key: string, type: string): Promise<Record<string, Object>> {
    let params = '';
    let obj: Record<string, Object>;
    if (!data) {
      if (type == "get") {
        params = "tp=" + Date.now();
      } else {
        data = {
          "tp": Date.now() as Object,
        };
        params = JSON.stringify(data);
      }

      obj = {
        'ef_request_params': (await SM4.encodeECB(params, sm4key)).getDataRow(),
        'ef_fingerprint': (await SM3.digest(params)).getDataRow()
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
        // 'stalk_request_params': SG_sm4encrypt(params, sm4key),
        'ef_request_params': (await SM4.encodeECB(params, sm4key)).getDataRow(),
        'ef_fingerprint': (await SM3.digest(params)).getDataRow()
      };
    }
    return obj;
  }

  /**
   * 关键字加密
   * @param obj
   * @param sm4Key
   * @returns
   */
  private static async encryptPartParam(obj: Record<string, Object>, sm4Key: string) {
    for (let inObj of Object.keys(obj).entries()) {
      if (typeof inObj[1] === "object") {
        AxiosUtil.encryptPartParam(inObj[1], sm4Key);
      } else {
        let objKeys = Object.keys(obj);
        for (let item of objKeys.entries()) {
          if (efAxiosParams.keyWordsList.indexOf(item[1]) > -1) {
            obj[item[0]] = (await SM4.encodeECB(item[1], sm4Key)).getDataRow();
          }
        }
        return;
      }
    }
    return obj;
  }
}

/**
 * efAxios所需参数实体
 */
export class efAxiosParams {
  /**
   * 是否整体传输加密
   */
  static isAllEncrypt: boolean = true;
  /**
   * 是否部分关键字传输加密
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
   * 请求头加密的SM2g公钥
   */
  static sm2PubKey: string = '';
}

/**
 * 抛出封装后的axios
 */
export const efAxios = new AxiosUtil().efAxios;

/**
 * 设置统一的请求拦截
 */
efAxios.interceptors.request.use(async (config: InternalAxiosRequestConfig) => {
  await AxiosUtil.convertRequestInfo(config);
  return config;
}, (error: AxiosError) => {
  // 对请求错误做些什么
  return Promise.reject(error);
})

/**
 * 设置统一的响应拦截
 */
efAxios.interceptors.response.use(async (response: AxiosResponse) => {
  // 处理响应数据
  await AxiosUtil.convertResponseInfo(response);
  return response;
}, (error: AxiosError) => {
  // 对响应错误做点什么
  return Promise.reject(error);
});

