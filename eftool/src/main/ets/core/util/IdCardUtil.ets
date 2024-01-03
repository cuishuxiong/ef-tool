/**
 * @Author csx
 * @DateTime 2023/12/29 20:07
 * @TODO IdCardUtil  身份证工具类
 */
import { StringBuilder } from '../base/StringBuilder'
import { RegexConst } from '../const/RegexConst'
import { DateUtil } from './DateUtil'
import { RegUtil } from './RegUtil'
import { StrUtil } from './StrUtil'

export class IdCardUtil {

  /**
   * 初始化数据
   */
  public IdCardUtil() {
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
   * 中国公民身份证号码最小长度。
   */
  private static CHINA_ID_MIN_LENGTH: number = 15;
  /**
   * 中国公民身份证号码最大长度。
   */
  private static CHINA_ID_MAX_LENGTH: number = 18;
  /**
   * 每位加权因子
   */
  private static POWER: number[] = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
  /**
   * 省市代码表
   */
  private static CITY_CODES: Map<String, String> = new Map<String, String>();
  /**
   * 台湾身份首字母对应数字
   */
  private static TW_FIRST_CODE: Map<String, Number> = new Map<String, Number>();
}