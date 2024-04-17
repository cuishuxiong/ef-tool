import axios from '@ohos/axios'
import { AxiosError } from '@ohos/axios';
import { InternalAxiosRequestConfig } from '@ohos/axios';
import { AxiosStatic } from '@ohos/axios';
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
  static async convertConfigInfo(config: InternalAxiosRequestConfig) {
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
      //拼接sm4的请求头秘钥
      config.headers.ef_random_key = sm4Key.getDataRow();
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
}

/**
 * 抛出封装后的axios
 */
export const efAxios = new AxiosUtil().efAxios;

/**
 * 设置统一的请求拦截
 */
efAxios.interceptors.request.use(async (config: InternalAxiosRequestConfig) => {
  await AxiosUtil.convertConfigInfo(config);
  return config;
}, (error: AxiosError) => {
  // 对请求错误做些什么
  return Promise.reject(error);
})

/**
 * 设置统一的响应拦截
 */
// efAxios.interceptors.response.use();

