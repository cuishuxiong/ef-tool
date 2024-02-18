/**
 * @Author csx
 * @DateTime 2024/2/2 21:33
 * @TODO AuthUtil  权限相关工具类
 */
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import UIAbility from '@ohos.app.ability.UIAbility';

export class AuthUtil {
  static async applyPermission(context: UIAbility, list: Array<Permissions>) {
    let atManager = abilityAccessCtrl.createAtManager();
    let result = await  atManager.requestPermissionsFromUser(context.context, list);
    console.info("data permissions:" + result.permissions);
    console.info("data authResults:" + result.authResults);
  }
}