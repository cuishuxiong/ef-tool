/**
 * @Author csx
 * @DateTime 2023/12/29 23:42
 * @TODO DateUtil 日期工具类
 */

export class DateUtil {

  /**
   *将输入的日期字符串转换为Date日期类型
   * @param dateString
   * @returns
   */
  static parse(dateString: string): Date {
    return new Date(dateString);
  }

  /**
   *将传入的日期字符串按照传入的format进行格式化输出,不传默认为yyyy-MM-dd,日期格式化年月日时分秒为y-M-d H:m:s
   * @param value
   * @param format  格式化字符串
   * @returns
   */
  static formatDate(value: string, format: string = 'yyyy-MM-dd'): string {
    const date = new Date(value);
    if (value.split(' ').length <= 1 && value.split('T').length <= 1) {
      date.setHours(0);
      date.setMinutes(0);
      date.setSeconds(0);
    }
    const year = date.getFullYear();
    const month = this.padZero(date.getMonth() + 1);
    const day = this.padZero(date.getDate());
    const hours = this.padZero(date.getHours());
    const minutes = this.padZero(date.getMinutes());
    const seconds = this.padZero(date.getSeconds());
    let formattedDate = format.replace("yyyy", year.toString());
    formattedDate = formattedDate.replace("MM", month);
    formattedDate = formattedDate.replace("dd", day);
    formattedDate = formattedDate.replace("HH", hours);
    formattedDate = formattedDate.replace("mm", minutes);
    formattedDate = formattedDate.replace("ss", seconds);
    return formattedDate;
  }

  /**
   *将日期类型的Date根据传入的format格式化成日期字符串(format必传)
   * @param date
   * @param formatString  格式化字符串
   * @returns
   */
  static format(date: Date, formatString: string): string {
    const year = date.getFullYear();
    const month = this.padZero(date.getMonth() + 1);
    const day = this.padZero(date.getDate());
    const hours = this.padZero(date.getHours());
    const minutes = this.padZero(date.getMinutes());
    const seconds = this.padZero(date.getSeconds());

    let formattedDate = formatString.replace("yyyy", year.toString());
    formattedDate = formattedDate.replace("MM", month);
    formattedDate = formattedDate.replace("dd", day);
    formattedDate = formattedDate.replace("HH", hours);
    formattedDate = formattedDate.replace("mm", minutes);
    formattedDate = formattedDate.replace("ss", seconds);

    return formattedDate;
  }

  private static padZero(num: number): string {
    return num.toString().padStart(2, "0");
  }
}