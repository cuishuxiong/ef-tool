import geoLocationManager from '@ohos.geoLocationManager';
import { AuthUtil } from '../../core/auth/AuthUtil';
import { OutDTO } from '../../core/base/OutDTO';
import { JSONUtil } from '../../core/util/JSONUtil';
import { ToastUtil } from '../prompt/ToastUtil';

/**
 * @Author csx
 * @DateTime 2024/4/10 23:26
 * @TODO LocationUtil  位置工具类
 */
export class LocationUtil {
  /**
   * 当前定位方法
   */
  private static locationChange = async () => {
    //解析定位
    let current = await geoLocationManager.getCurrentLocation({
      scenario: geoLocationManager.LocationRequestScenario.DAILY_LIFE_SERVICE,
      maxAccuracy: 0,
      timeoutMs: 1000
    });
    return current;
  }

  static async startLocation() {
    if (!await AuthUtil.checkPermissions('ohos.permission.APPROXIMATELY_LOCATION')) {
      await AuthUtil.reqPermissionsFromUser('ohos.permission.APPROXIMATELY_LOCATION', (index) => {
        if (index > 0) {
          //授权成功
          LocationUtil.locationChange().then(position => {
            LocationUtil.geoConvert(position.latitude, position.longitude).then(geoAdd => {
              ToastUtil.showToast('地理位置为:' + geoAdd.placeName);
            });
          });
        }
      })
    } else {
      //授权成功
      LocationUtil.locationChange().then(position => {
        LocationUtil.geoConvert(position.latitude, position.longitude).then(geoAdd => {
          ToastUtil.showToast('地理位置为:' + geoAdd.placeName);
        });
      });
    }
  }

  /**
   * 地理逆编码,转换为中文
   * @param latitude  维度
   * @param longitude 经度
   * @returns 逆编码后对象
   */
  static async geoConvert(latitude: number, longitude: number): Promise<geoLocationManager.GeoAddress> {
    //校验是否逆编码可用
    let isAvailable = geoLocationManager.isGeocoderAvailable();
    if (isAvailable) {
      let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest = {
        latitude: latitude,
        longitude: longitude,
        maxItems: 1,
        locale: 'zh'
      };
      let result = await geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest);
      if (result) {
        return result[0];
      } else {
        ToastUtil.showToast('地理编码失败~');
        return {} as geoLocationManager.GeoAddress;
      }
    } else {
      ToastUtil.showToast('地理编码服务异常~');
      return {} as geoLocationManager.GeoAddress;
    }
  }
}