/**
 * @Author csx
 * @DateTime 2024/8/3 09:33
 * @TODO GlobalContext  全局网络对象上下午
 */
import { connection } from '@kit.NetworkKit';

export class GlobalContext {
  public netList: connection.NetHandle[] = [];
  private static instance: GlobalContext;
  private _objects = new Map<string, Object>();

  public static getContext(): GlobalContext {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext();
    }
    return GlobalContext.instance;
  }

  getObject(value: string): Object | undefined {
    return this._objects.get(value);
  }

  setObject(key: string, objectClass: Object): void {
    this._objects.set(key, objectClass);
  }
}
