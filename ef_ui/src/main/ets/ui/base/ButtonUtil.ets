/**
 Copyright 2024 csx - @yunkss/ef_ui

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

import { FunctionalButton, functionalButtonComponentManager } from '@kit.ScenarioFusionKit';
import { ToastUtil } from '../prompt/ToastUtil';
import { JSONObject } from '@yunkss/ef_json';

/**
 * 场景按钮UI
 * @param params  场景类型参数
 * @param callBack  按钮回调函数
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_ui
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
          if (err) {
            ToastUtil.showToast('快速验证手机号失败,原因为:' + err.message)
          } else {
            if (data.code) {
              callBack(data.code);
            }
          }
        })
    })
  }
  if (params.openType === functionalButtonComponentManager.OpenType.GET_REALTIME_PHONENUMBER) {
    //实时验证手机号
    FunctionalButton({
      params: params,
      controller: new functionalButtonComponentManager.FunctionalButtonController()
        .onGetRealtimePhoneNumber((err, data) => {
          if (err) {
            ToastUtil.showToast('实时验证手机号失败,原因为:' + err.message)
          } else {
            if (data.code) {
              callBack(data.code);
            }
          }
        })
    })
  }
  if (params.openType === functionalButtonComponentManager.OpenType.LAUNCH_APP) {
    //打开应用
    FunctionalButton({
      params: params,
      controller: new functionalButtonComponentManager.FunctionalButtonController()
        .onLaunchApp((err) => {
          if (err) {
            ToastUtil.showToast('打开APP失败,原因为:' + err.message)
          }
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
            ToastUtil.showToast('打开设置失败,原因为:' + err.message)
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
          if (err) {
            ToastUtil.showToast('选择头像失败,原因为:' + err.message)
          } else {
            if (data.avatarUri) {
              callBack(data.avatarUri);
            }
          }
        })
    })
  }
  if (params.openType === functionalButtonComponentManager.OpenType.CHOOSE_ADDRESS) {
    //选择地址
    FunctionalButton({
      params: params,
      controller: new functionalButtonComponentManager.FunctionalButtonController()
        .onChooseAddress((err, data) => {
          if (err) {
            ToastUtil.showToast('选择地址失败,原因为:' + err.message)
          } else {
            if (data) {
              callBack(JSONObject.toJSONString(data));
            }
          }
        })
    })
  }
  if (params.openType === functionalButtonComponentManager.OpenType.CHOOSE_INVOICE_TITLE) {
    //选择发票抬头
    FunctionalButton({
      params: params,
      controller: new functionalButtonComponentManager.FunctionalButtonController()
        .onChooseInvoiceTitle((err, data) => {
          if (err) {
            ToastUtil.showToast('选择发票抬头失败,原因为:' + err.message)
          } else {
            if (data) {
              callBack(JSONObject.toJSONString(data));
            }
          }
        })
    })
  }
  if (params.openType === functionalButtonComponentManager.OpenType.FACE_AUTHENTICATION) {
    //人脸核验
    FunctionalButton({
      params: params,
      controller: new functionalButtonComponentManager.FunctionalButtonController()
        .onFaceAuthentication((err, data) => {
          if (err) {
            ToastUtil.showToast('人脸核验错误,原因为:' + err.message)
          } else {
            if (data) {
              callBack(JSONObject.toJSONString(data));
            }
          }
        })
    })
  }

  if (params.openType === functionalButtonComponentManager.OpenType.REAL_NAME_AUTHENTICATION) {
    //实名认证
    FunctionalButton({
      params: params,
      controller: new functionalButtonComponentManager.FunctionalButtonController()
        .onRealNameAuthentication((err, data) => {
          if (err) {
            ToastUtil.showToast('实名认证失败,原因为:' + err.message)
          } else {
            if (data) {
              callBack(JSONObject.toJSONString(data));
            }
          }
        })
    })
  }
  if (params.openType === functionalButtonComponentManager.OpenType.CHOOSE_LOCATION) {
    //地图选点
    FunctionalButton({
      params: params,
      controller: new functionalButtonComponentManager.FunctionalButtonController()
        .onChooseLocation((err, data) => {
          if (err) {
            ToastUtil.showToast('地图选点失败,原因为:' + err.message)
          } else {
            if (data) {
              callBack(JSONObject.toJSONString(data));
            }
          }
        })
    })
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
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_ui
 */
@Component
export struct ButtonUtil {
  /**
   * 场景按钮入参实体
   */
  @Prop btnOptions: BtnOptions = new BtnOptions();

  build() {
    FunctionalButtonBuilder.builder({
      openType: this.btnOptions.type,
      label: this.btnOptions.label,
      styleOption: {
        //按钮镂空
        plain: true
      },
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
  /**
   * 按钮文本
   */
  label: string = '';
  /**
   * 场景按钮类型
   */
  type: functionalButtonComponentManager.OpenType = functionalButtonComponentManager.OpenType.GET_PHONE_NUMBER;
  /**
   * 如果是app时所需参数
   */
  appParams?: functionalButtonComponentManager.AppParam;
}

