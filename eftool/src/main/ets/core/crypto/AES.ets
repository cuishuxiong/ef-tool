import crypto from '@ohos.security.cryptoFramework';

/**
 * @Author csx
 * @DateTime 2024/1/18 21:25
 * @TODO AES
 */
export class AES {
  /**
   *
   * @param unit8Array
   * @returns
   */
  private static unit8ArrayToShowStr(unit8Array) {
    return Array.prototype.map
      .call(unit8Array, (x) => ('00' + x.toString(16)).slice(-2))
      .join('');
  }

  /**
   * 生成AES的对称密钥
   * @returns
   */
  static async generateAesKey(): Promise<string> {
    // 创建对称密钥生成器
    let symKeyGenerator = crypto.createSymKeyGenerator('AES256');
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseSymKey = await symKeyGenerator.generateSymKey();
    // 获取非对称密钥的二进制数据
    return this.unit8ArrayToShowStr(promiseSymKey.getEncoded().data);
  }
}