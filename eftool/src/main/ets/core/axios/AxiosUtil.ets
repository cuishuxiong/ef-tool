import axios from '@ohos/axios'
import { AxiosError } from '@ohos/axios';
import { InternalAxiosRequestConfig } from '@ohos/axios';
import { AxiosResponse } from '@ohos/axios';
import { AxiosStatic } from '@ohos/axios';
import { ToastUtil } from '../../ui/prompt/ToastUtil';
import { OutDTO } from '../base/OutDTO';
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
      //使用SM2将SM4的密钥加密,并存放header中
      config.headers.ef_random_key = (await SM2.encode(sm4Key.getDataRow(), efAxiosParams.sm2PubKey)).getDataRow();
      //关键字加密
      if (efAxiosParams.isPartEncrypt) {
        //给部分敏感字段加密
        config.data = AxiosUtil.encryptPartParam(config.data, sm4Key.getDataRow());
      }
      //整体加密(上传下载不加密请求头Req-Type为uploadOrDownload的请求)
      if (efAxiosParams.isAllEncrypt && config.headers["Req-Type"] != "uploadOrDownload") {
        config.data = await AxiosUtil.encryptRequestData(
          config.data,
          sm4Key.getDataRow(),
          config.method
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
    //此处操作为将入参获取最多32位长度进行SM3摘要,然后传入后台进行数据完整性校验时使用
    if (efAxiosParams.isAllEncrypt || efAxiosParams.isPartEncrypt) {
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
      config.headers.sign = sm3.getDataRow();
    }
  }

  /**
   * 统一处理响应
   * @param response  axios返回的响应对象
   */
  static async convertResponseInfo(response: AxiosResponse) {
    if (response.status === 200) {
      //将响应数据转换
      response.data = new OutDTO(response.data.success, response.data.message, response.data.dataRow ? response.data.dataRow : '', response.data.dataTable ? response.data.dataTable : new Array());
      //其他处理
      if (response.config.headers["Req-Type"] == "uploadOrDownload") {
        //上传下载将数据转换为blob格式 预计1.1.9版本完善
      }
      if (efAxiosParams.isAllEncrypt) {
        //整体加密 预计1.1.9版本完善
      }
      if (efAxiosParams.isPartEncrypt) {
        //关键字加密 预计1.1.9版本完善
      }
    } else {
      ToastUtil.showToast("请求接口异常~");
    }
  }

  /**
   * 加密全部请求参数
   * @param data  待加密的数据
   * @param sm4key  加密所需的SM4的密钥
   * @param type  请求类型
   * @returns 加密后的对象
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
        'ef_request_params': (await SM4.encodeECB(params, sm4key)).getDataRow(),
        'ef_fingerprint': (await SM3.digest(params)).getDataRow()
      };
    }
    return obj;
  }

  /**
   * 关键字加密
   * @param obj  待加密的数据
   * @param sm4Key 加密所需的SM4的密钥
   * @returns 加密后的对象
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

