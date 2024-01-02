/**
 * @Author csx
 * @DateTime 2023/12/29 23:42
 * @TODO DateUtil 日期工具类
 */
import { StrUtil } from './StrUtil';

export class DateUtil {
  static parse(dateString: string, formatString: string): Date {
    const date = new Date(dateString);
    const options: Intl.DateTimeFormatOptions = {};
    if (formatString.includes("YYYY")) {
      options.year = "numeric";
    }
    if (formatString.includes("MM")) {
      options.month = "2-digit";
    }
    if (formatString.includes("DD")) {
      options.day = "2-digit";
    }
    const formatter = new Intl.DateTimeFormat(undefined, options);
    const formattedDate = formatter.format(date);
    return new Date(formattedDate);
  }

  static year(date) {
    const yearPrefix = new Date().getFullYear().toString().slice(0, 2);
    const yearSuffix = date.getFullYear().toString().slice(2);
    const fullYear = yearPrefix + yearSuffix;
    return parseInt(fullYear, 10);
  }
}