export const add: (a: number, b: number) => number;

/**
 * 加密-ECB模式
 * @author csx
 * @param str 待加密的字符串
 * @param key  des的key
 * @returns 加密后的字符串
 */
export const encodeECB: (str: string, key: string, iv: string) => string;


export const encodeCBC: (str: string, key: string) => string;
