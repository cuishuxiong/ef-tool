import { distributedKVStore } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';
import { ToastUtil } from '../ui/prompt/ToastUtil';

/**
 * @Author csx
 * @DateTime 2024/8/6 11:08:24
 * @TODO KvUtil 数据持久化工具类
 */
export class KvUtil {
  private kvManager?: distributedKVStore.KVManager;
  private kvStore: distributedKVStore.SingleKVStore | undefined = undefined;

  public init(context: Context) {
    const kvManagerConfig: distributedKVStore.KVManagerConfig = {
      context: context,
      bundleName: 'com.yunkss.csx.tool'
    };
    try {
      // 创建KVManager实例
      this.kvManager = distributedKVStore.createKVManager(kvManagerConfig);
    } catch (e) {
      let error = e as BusinessError;
      ToastUtil.showToast(error.message);
      return;
    }

    try {
      const options: distributedKVStore.Options = {
        createIfMissing: true,
        encrypt: false,
        backup: false,
        autoSync: false,
        // kvStoreType不填时，默认创建多设备协同数据库
        kvStoreType: distributedKVStore.KVStoreType.SINGLE_VERSION,
        // 多设备协同数据库：kvStoreType: distributedKVStore.KVStoreType.DEVICE_COLLABORATION,
        securityLevel: distributedKVStore.SecurityLevel.S1
      };
      this.kvManager.getKVStore<distributedKVStore.SingleKVStore>('storeId', options,
        (err, store: distributedKVStore.SingleKVStore) => {
          if (err) {
            ToastUtil.showToast('获取KVStore失败,原因为:' + err.message)
            return;
          }
          this.kvStore = store as distributedKVStore.SingleKVStore;
        });
    } catch (e) {
      let error = e as BusinessError;
      ToastUtil.showToast('遇到异常,原因为:' + error.message)
    }
  }

  put(key: string, value: boolean | string | number | Uint8Array) {
    this.kvStore?.put(key, value, (err) => {
      if (err !== undefined) {
        ToastUtil.showToast('存储数据失败,原因为:' + err.message)
        return;
      }
    });
  }

  async get<T>(key: string, defVal: T): Promise<T> {
    try {
      const value = await this.kvStore?.get(key);
      if (value === undefined) {
        return defVal;
      }
      return value as T;
    } catch (e) {
      let error = e as BusinessError;
      ToastUtil.showToast('获取数据失败,原因为:' + error.message)
      return defVal;
    }
  }

  delete(key: string) {
    this.kvStore?.delete(key, (err) => {
      if (err !== undefined) {
        ToastUtil.showToast('删除数据失败,原因为:' + err.message)
        return;
      }
    });
  }
}

/**
 * 抛出对象
 */
export const kvUtil = new KvUtil();