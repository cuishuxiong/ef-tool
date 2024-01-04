/**
 * @Author csx
 * @DateTime 2023/12/29 20:07
 * @TODO IdCardUtil  身份证工具类
 */
import { OutDTO } from '../base/OutDTO'
import { RegexConst } from '../const/RegexConst'
import { RegUtil } from './RegUtil'

export class IdCardUtil {

  /**
   * 中国公民身份证号码最小长度。
   */
  static CHINA_ID_MIN_LENGTH: number = 15;
  /**
   * 中国公民身份证号码最大长度。
   */
  static CHINA_ID_MAX_LENGTH: number = 18;
  /**
   * 每位加权因子
   */
  static POWER: number[] = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
  /**
   * 省市代码表
   */
  static CITY_CODES: Map<String, String> = new Map<String, String>();
  /**
   * 台湾身份首字母对应数字
   */
  static TW_FIRST_CODE: Map<String, Number> = new Map<String, Number>();


  /**
   * 初始化数据
   */
  static init(): void {
    IdCardUtil.CITY_CODES.set("11", "北京")
    IdCardUtil.CITY_CODES.set("12", "天津")
    IdCardUtil.CITY_CODES.set("13", "河北")
    IdCardUtil.CITY_CODES.set("14", "山西")
    IdCardUtil.CITY_CODES.set("15", "内蒙古")
    IdCardUtil.CITY_CODES.set("21", "辽宁")
    IdCardUtil.CITY_CODES.set("22", "吉林")
    IdCardUtil.CITY_CODES.set("23", "黑龙江")
    IdCardUtil.CITY_CODES.set("31", "上海")
    IdCardUtil.CITY_CODES.set("32", "江苏")
    IdCardUtil.CITY_CODES.set("33", "浙江")
    IdCardUtil.CITY_CODES.set("34", "安徽")
    IdCardUtil.CITY_CODES.set("35", "福建")
    IdCardUtil.CITY_CODES.set("36", "江西")
    IdCardUtil.CITY_CODES.set("37", "山东")
    IdCardUtil.CITY_CODES.set("41", "河南")
    IdCardUtil.CITY_CODES.set("42", "湖北")
    IdCardUtil.CITY_CODES.set("43", "湖南")
    IdCardUtil.CITY_CODES.set("44", "广东")
    IdCardUtil.CITY_CODES.set("45", "广西")
    IdCardUtil.CITY_CODES.set("46", "海南")
    IdCardUtil.CITY_CODES.set("50", "重庆")
    IdCardUtil.CITY_CODES.set("51", "四川")
    IdCardUtil.CITY_CODES.set("52", "贵州")
    IdCardUtil.CITY_CODES.set("53", "云南")
    IdCardUtil.CITY_CODES.set("54", "西藏")
    IdCardUtil.CITY_CODES.set("61", "陕西")
    IdCardUtil.CITY_CODES.set("62", "甘肃")
    IdCardUtil.CITY_CODES.set("63", "青海")
    IdCardUtil.CITY_CODES.set("64", "宁夏")
    IdCardUtil.CITY_CODES.set("65", "新疆")
    IdCardUtil.CITY_CODES.set("71", "台湾")
    IdCardUtil.CITY_CODES.set("81", "香港")
    IdCardUtil.CITY_CODES.set("82", "澳门")
    IdCardUtil.CITY_CODES.set("83", "台湾")
    IdCardUtil.CITY_CODES.set("91", "国外")
    IdCardUtil.TW_FIRST_CODE.set('A', 10)
    IdCardUtil.TW_FIRST_CODE.set('B', 11)
    IdCardUtil.TW_FIRST_CODE.set('C', 12)
    IdCardUtil.TW_FIRST_CODE.set('D', 13)
    IdCardUtil.TW_FIRST_CODE.set('E', 14)
    IdCardUtil.TW_FIRST_CODE.set('F', 15)
    IdCardUtil.TW_FIRST_CODE.set('G', 16)
    IdCardUtil.TW_FIRST_CODE.set('H', 17)
    IdCardUtil.TW_FIRST_CODE.set('J', 18)
    IdCardUtil.TW_FIRST_CODE.set('K', 19)
    IdCardUtil.TW_FIRST_CODE.set('L', 20)
    IdCardUtil.TW_FIRST_CODE.set('M', 21)
    IdCardUtil.TW_FIRST_CODE.set('N', 22)
    IdCardUtil.TW_FIRST_CODE.set('P', 23)
    IdCardUtil.TW_FIRST_CODE.set('Q', 24)
    IdCardUtil.TW_FIRST_CODE.set('R', 25)
    IdCardUtil.TW_FIRST_CODE.set('S', 26)
    IdCardUtil.TW_FIRST_CODE.set('T', 27)
    IdCardUtil.TW_FIRST_CODE.set('U', 28)
    IdCardUtil.TW_FIRST_CODE.set('V', 29)
    IdCardUtil.TW_FIRST_CODE.set('X', 30)
    IdCardUtil.TW_FIRST_CODE.set('Y', 31)
    IdCardUtil.TW_FIRST_CODE.set('W', 32)
    IdCardUtil.TW_FIRST_CODE.set('Z', 33)
    IdCardUtil.TW_FIRST_CODE.set('I', 34)
    IdCardUtil.TW_FIRST_CODE.set('O', 35)
  }


  /**
   * <p>
   * 判断18位身份证的合法性
   * </p>
   * 根据〖中华人民共和国国家标准GB11643-1999〗中有关公民身份号码的规定，公民身份号码是特征组合码，由十七位数字本体码和一位数字校验码组成。<br>
   * 排列顺序从左至右依次为：六位数字地址码，八位数字出生日期码，三位数字顺序码和一位数字校验码。
   * <p>
   * 顺序码: 表示在同一地址码所标识的区域范围内，对同年、同月、同 日出生的人编定的顺序号，顺序码的奇数分配给男性，偶数分配 给女性。
   * </p>
   * <ol>
   * <li>第1、2位数字表示：所在省份的代码</li>
   * <li>第3、4位数字表示：所在城市的代码</li>
   * <li>第5、6位数字表示：所在区县的代码</li>
   * <li>第7~14位数字表示：出生年、月、日</li>
   * <li>第15、16位数字表示：所在地的派出所的代码</li>
   * <li>第17位数字表示性别：奇数表示男性，偶数表示女性</li>
   * <li>第18位数字是校检码，用来检验身份证的正确性。校检码可以是0~9的数字，有时也用x表示</li>
   * </ol>
   * <p>
   * 第十八位数字(校验码)的计算方法为：
   * <ol>
   * <li>将前面的身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2</li>
   * <li>将这17位数字和系数相乘的结果相加</li>
   * <li>用加出来和除以11，看余数是多少</li>
   * <li>余数只可能有0 1 2 3 4 5 6 7 8 9 10这11个数字。其分别对应的最后一位身份证的号码为1 0 X 9 8 7 6 5 4 3 2</li>
   * <li>通过上面得知如果余数是2，就会在身份证的第18位数字上出现罗马数字的Ⅹ。如果余数是10，身份证的最后一位号码就是2</li>
   * </ol>
   * @param idcard 待验证的身份证
   * @return 是否有效的18位身份证，忽略x的大小写
   */
  static isValidCard18(idCard: string): OutDTO {
    this.init();

    if (IdCardUtil.CHINA_ID_MAX_LENGTH != idCard.length) {
      return OutDTO.Error("身份证长度不足18位");
    }

    // 省份
    let proCode: string = idCard.substring(0, 2);
    if (null == IdCardUtil.CITY_CODES.get(proCode)) {
      return OutDTO.Error("省份代码不正确:" + proCode);
    }

    //校验生日
    if (false == this.isBirthday(idCard.substring(6, 14))) {
      return OutDTO.Error("生日格式不正确:" + idCard.substring(6, 14));
    }

    // 前17位
    let code17: string = idCard.substring(0, 17);
    if (RegUtil.isMatch(RegexConst.NUMBERS, code17)) {
      // 获取校验位
      let val = this.getCheckCode18(code17);
      // 第18位
      if (idCard.charAt(17).toLowerCase() === val) {
        return OutDTO.OK("身份证格式正确");
      }
      return OutDTO.Error("校验码不匹配");
    }
    return OutDTO.Error("身份证校验失败");
  }

  private static getCheckCode18(idCard: string): string {
    const checkDigits: string[] = ['1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'];

    if (!/^\d{17}$/.test(idCard)) {
      throw new Error('Invalid ID card number');
    }

    let sum: number = 0;
    for (let i = 0; i < 17; i++) {
      sum += parseInt(idCard.charAt(i), 10) * IdCardUtil.POWER[i];
    }

    const checkCodeIndex: number = sum % 11;
    return checkDigits[checkCodeIndex];
  }

  private static isBirthday(str: string): boolean {
    const reg = /^(\d{4})(\d{2})(\d{2})$/;
    const match = str.match(reg);
    if (!match) {
      return false; // 不符合日期格式
    }
    const [, yearStr, monthStr, dayStr] = match;
    const year = parseInt(yearStr);
    const month = parseInt(monthStr) - 1; // 月份从0开始，需减1
    const day = parseInt(dayStr);
    const date = new Date(year, month, day); // 构造日期对象
    if (date.getFullYear() !== year || date.getMonth() !== month || date.getDate() !== day) {
      return false; // 日期不合法
    }
    return true; // 符合生日日期格式
  }
}