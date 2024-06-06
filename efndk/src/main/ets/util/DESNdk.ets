import { encodeECB, decodeECB, encodeCBC, decodeCBC } from 'libefndk'

/**
 * @Author csx
 * @DateTime 2024/6/6 16:41:06
 * @TODO DESNdk  des加密的ndk包
 */
export class DESNdk {
  /**
   * 加密-ECB模式
   * @author csx
   * @param str 待加密的字符串
   * @param key  des的key
   * @returns 加密后的字符串
   */
  static ndkEncodeECB(str: string, key: string): string {
    return encodeECB(str, key);
  }

  /**
   * 解密-ECB模式
   * @author csx
   * @param str 待解密的字符串
   * @param key  des的key
   * @returns 解密后的字符串
   */
  static ndkDecodeECB(str: string, key: string): string {
    return decodeECB(str, key);
  }

  /**
   * 加密-CBC模式 需要传入iv偏移量字符串
   * @author csx
   * @param str 待加密的字符串
   * @param iv 偏移量
   * @param key  des的key
   * @returns 加密后的字符串
   */
  static ndkEncodeCBC(str: string, iv: string, key: string): string {
    return encodeCBC(str, iv, key);
  }

  /**
   * 解密-CBC模式 需要传入iv偏移量字符串
   * @author csx
   * @param str 待解密的字符串
   * @param iv 偏移量
   * @param key  des的key
   * @returns 解密后的字符串
   */
  static ndkDecodeCBC(str: string, iv: string, key: string): string {
    return decodeCBC(str, iv, key);
  }
}