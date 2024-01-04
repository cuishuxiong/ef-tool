/**
 * @Author csx
 * @DateTime 2023/12/29 20:08
 * @TODO RandomUtil  随机数工具类
 */
export class RandomUtil {


  /**
   * 获得随机Boolean值
   *
   * @return true or false
   */
  static randomBoolean(): boolean {
    return Math.random() < 0.5;
  }


  /**
   * 随机汉字（'\u4E00'-'\u9FFF'）
   *
   * @return 随机的汉字字符
   */
  static randomChinese(): string {
    const start = parseInt('4e00', 16); // 第一个汉字的 Unicode 编码
    const end = parseInt('9fa5', 16); // 最后一个汉字的 Unicode 编码
    const randomCode = Math.floor(Math.random() * (end - start) + start);
    return String.fromCharCode(randomCode);
  }

  /**
   * 获得指定范围内的随机数
   *
   * @param min 最小数（包含）
   * @param max 最大数（不包含）
   * @return 随机数
   */
  static randomNumber(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min) + min);
  }

  /**
   * 获得随机数number值
   *
   * @return 随机数
   */
  static randomInt(): number {
    return Math.floor(Math.random() * Number.MAX_SAFE_INTEGER);
  }

  /**
   * 获得指定范围内的随机数 [0,limit)
   *
   * @param limit 限制随机数的范围，不包括这个数
   * @return 随机数
   */
  static randomLimit(limit: number): number {
    return Math.floor(Math.random() * limit);
  }
}