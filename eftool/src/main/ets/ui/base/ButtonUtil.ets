import { FunctionalButton, functionalButtonComponentManager } from '@kit.ScenarioFusionKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { ToastUtil } from '../prompt/ToastUtil';
import { JSONObject } from '../../core/json/JSONObject';

/**
 * 场景按钮UI
 * @param params  场景类型参数
 * @param callBack  按钮回调函数
 */
@Builder
function buildFunctionBtn(params: functionalButtonComponentManager.FunctionalButtonParams,
  callBack: (data: string) => void) {

  if (params.openType === functionalButtonComponentManager.OpenType.GET_PHONE_NUMBER) {
    //快速验证手机号
    FunctionalButton({
      params: params,
      controller: new functionalButtonComponentManager.FunctionalButtonController()
        .onGetPhoneNumber((err, data) => {
          handleMessage(err, data, callBack);
        })
    })
  }
  if (params.openType === functionalButtonComponentManager.OpenType.GET_REALTIME_PHONENUMBER) {
    //实时验证手机号
    FunctionalButton({
      params: params,
      controller: new functionalButtonComponentManager.FunctionalButtonController()
        .onGetRealtimePhoneNumber((err, data) => {
          handleMessage(err, data, callBack);
        })
    })
  }
  if (params.openType === functionalButtonComponentManager.OpenType.LAUNCH_APP) {
    //打开应用
    FunctionalButton({
      params: params,
      controller: new functionalButtonComponentManager.FunctionalButtonController()
        .onLaunchApp((err) => {
          handleMessage(err, "", callBack);
        })
    })
  }
  if (params.openType === functionalButtonComponentManager.OpenType.OPEN_SETTING) {
    //打开设置
    FunctionalButton({
      params: params,
      controller: new functionalButtonComponentManager.FunctionalButtonController()
        .onOpenSetting((err, data) => {
          if (err) {
            ToastUtil.showToast('获APP设置结果失败,原因为:' + err.message)
          } else {
            if (data.permissions) {
              callBack(JSONObject.toJSONString(data.permissions));
            }
          }
        })
    })
  }
  if (params.openType === functionalButtonComponentManager.OpenType.CHOOSE_AVATAR) {
    //选择头像
    FunctionalButton({
      params: params,
      controller: new functionalButtonComponentManager.FunctionalButtonController()
        .onChooseAvatar((err, data) => {
          handleMessage(err, data, callBack);
        })
    })
  }
  if (params.openType === functionalButtonComponentManager.OpenType.CHOOSE_ADDRESS) {
    //选择地址
    FunctionalButton({
      params: params,
      controller: new functionalButtonComponentManager.FunctionalButtonController()
        .onChooseAddress((err, data) => {
          handleMessage(err, data, callBack);
        })
    })
  }
  if (params.openType === functionalButtonComponentManager.OpenType.CHOOSE_INVOICE_TITLE) {
    //选择发票抬头
    FunctionalButton({
      params: params,
      controller: new functionalButtonComponentManager.FunctionalButtonController()
        .onChooseInvoiceTitle((err, data) => {
          handleMessage(err, data, callBack);
        })
    })
  }
  if (params.openType === functionalButtonComponentManager.OpenType.CHOOSE_LOCATION) {
    //地图选点
    FunctionalButton({
      params: params,
      controller: new functionalButtonComponentManager.FunctionalButtonController()
        .onChooseLocation((err, data) => {
          handleMessage(err, data, callBack);
        })
    })
  }

}

/**
 * 处理场景按钮统一回调
 * @param err 异常信息
 * @param data  数据
 * @param callBack  回调
 */
function handleMessage(err: BusinessError, data: Object, callBack: (data: string) => void) {
  if (err) {
    ToastUtil.showToast('获取授权结果失败,原因为:' + err.message)
  } else {
    callBack(JSONObject.toJSONString(data));
  }
}

/**
 * 创建场景按钮全局构造器
 */
export let FunctionalButtonBuilder: WrappedBuilder<[functionalButtonComponentManager.FunctionalButtonParams, (data: string) => void]> =
  wrapBuilder(buildFunctionBtn);


/**
 * @Author csx
 * @DateTime 2024/7/2 16:24:07
 * @TODO ButtonUtil  场景化按钮工具类
 */
@Component
export struct ButtonUtil {
  // 参考链接  https://gitee.com/harmonyos_samples/senario-fusion-kit_-sample-code_-functional-btn_-arkts

  /**
   * 场景按钮入参实体
   */
  @Prop btnOptions: BtnOptions = new BtnOptions();

  build() {
    FunctionalButtonBuilder.builder({
      openType: this.btnOptions.type,
      label: this.btnOptions.label,
      appParam: this.btnOptions.appParams
    }, (data) => {
      ToastUtil.showToast(data);
    });
  }
}

/**
 * 场景按钮实体
 */
export class BtnOptions {
  label: string = '';
  type: functionalButtonComponentManager.OpenType = functionalButtonComponentManager.OpenType.GET_PHONE_NUMBER;
  appParams?: functionalButtonComponentManager.AppParam;
}

