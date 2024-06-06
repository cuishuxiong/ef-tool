/**
 * 加密-ECB模式
 * @author csx
 * @param str 待加密的字符串
 * @param key  des的key
 * @returns 加密后的字符串
 */
export const encodeECB: (str: string, key: string) => string;

/**
 * 解密-ECB模式
 * @author csx
 * @param str 待解密的字符串
 * @param key  des的key
 * @returns 解密后的字符串
 */
export const decodeECB: (str: string, key: string) => string;

/**
 * 加密-CBC模式 需要传入iv偏移量字符串
 * @author csx
 * @param str 待加密的字符串
 * @param iv 偏移量
 * @param key  des的key
 * @returns 加密后的字符串
 */
export const encodeCBC: (str: string, iv: string, key: string) => string;

/**
 * 解密-CBC模式 需要传入iv偏移量字符串
 * @author csx
 * @param str 待解密的字符串
 * @param iv 偏移量
 * @param key  des的key
 * @returns 解密后的字符串
 */
export const decodeCBC: (str: string, iv: string, key: string) => string;