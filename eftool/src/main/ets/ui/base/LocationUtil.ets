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
   * 获取当前精准定位定位-需要APPROXIMATELY_LOCATION和LOCATION权限
   * @returns geoLocationManager.Location 对象
   */
  private static async getCurrentLocation(): Promise<geoLocationManager.Location> {
    //解析定位
    let current = await geoLocationManager.getCurrentLocation({
      scenario: geoLocationManager.LocationRequestScenario.DAILY_LIFE_SERVICE,
      maxAccuracy: 0,
      timeoutMs: 1000
    });
    return current;
  }

  /**
   * 获取用户当前定位-逆编码后(会申请APPROXIMATELY_LOCATION和LOCATION权限)
   * @returns 返回当前位置中文描述
   */
  static async getGeoLocation(): Promise<OutDTO<string>> {
    let isAuth = await AuthUtil.checkPermissions('ohos.permission.APPROXIMATELY_LOCATION') && await AuthUtil.checkPermissions('ohos.permission.LOCATION');
    if (!isAuth) {
      //获取用户授权
      let code = await AuthUtil.reqPermissionsList(['ohos.permission.APPROXIMATELY_LOCATION', 'ohos.permission.LOCATION']);
      if (!code) {
        //授权失败
        return OutDTO.ErrorByDataRow<string>('获取当前位置失败~', '用户拒绝授权精准定位,获取定位失败~');
      }
    }
    //授权成功获取当前定位
    let current = await LocationUtil.getCurrentLocation();
    //逆编码定位
    let result = await LocationUtil.geoConvert(current.latitude, current.longitude);
    if (result.placeName) {
      return OutDTO.OKByDataRow<string>('获取当前位置成功~', result.placeName);
    }
    return OutDTO.ErrorByDataRow<string>('获取当前位置失败~', '未获取到定位信息~');
  }

  /**
   * 地理逆编码,将地理描述转换为具体坐标-无需申请定位权限
   * @param locationName  地理位置中文描述
   * @returns 编码后location对象
   */
  static async address2Location(locationName: string): Promise<OutDTO<geoLocationManager.GeoAddress>> {
    //校验是否逆编码可用
    let isAvailable = geoLocationManager.isGeocoderAvailable();
    if (isAvailable) {
      let geocodeRequest: geoLocationManager.GeoCodeRequest = {
        description: locationName,
        maxItems: 1,
        locale: 'zh'
      };
      let result = await geoLocationManager.getAddressesFromLocationName(geocodeRequest);
      if (result) {
        return OutDTO.OKByDataRow<geoLocationManager.GeoAddress>('根据位置描述获取位置信息成功~', result[0]);
      } else {
        return OutDTO.OKByDataRow('根据位置描述获取位置信息失败~', {} as geoLocationManager.GeoAddress);
      }
    } else {
      return OutDTO.OKByDataRow('地理编码服务异常~', {} as geoLocationManager.GeoAddress);
    }
  }

  /**
   * 地理逆编码,转换为中文-无需申请定位权限
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

  /**
   * 获取当前的国家码-无需申请定位权限
   * @returns 返回当前位置中文描述
   */
  static async getCountryCode(): Promise<OutDTO<string>> {
    //获取当前的国家码
    let result = await geoLocationManager.getCountryCode();
    if (result.country) {
      return OutDTO.OKByDataRow<string>('获取当前国家码成功~', result.country);
    }
    return OutDTO.ErrorByDataRow<string>('获取当前国家码失败~', '未获取到获取当前国家码信息~');
  }
}