import crypto from '@ohos.security.cryptoFramework';
import { OutDTO } from '../base/OutDTO';
import { StringBuilder } from '../base/StringBuilder';

/**
 * @Author csx
 * @DateTime 2024/3/18 10:15:03
 * @TODO SM4
 */
export class SM4 {
  /**
   * 生成SM4的对称密钥
   * @returns SM4密钥
   */
  static async generateSM4Key(): Promise<OutDTO<string>> {
    // 创建对称密钥生成器
    let symKeyGenerator = crypto.createSymKeyGenerator('SM4_128');
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseSymKey = await symKeyGenerator.generateSymKey();
    //转换成可以读懂的字符串
    let sb = new StringBuilder();
    promiseSymKey.getEncoded().data.forEach((value) => {
      sb.append(value.toString(16).slice(-2));
    });
    // 获取对称密钥的二进制数据
    return OutDTO.OKByDataRow<string>('生成SM4密钥成功~', sb.toString());
  }
}