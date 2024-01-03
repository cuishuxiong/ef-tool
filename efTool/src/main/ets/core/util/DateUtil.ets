/**
 * @Author csx
 * @DateTime 2023/12/29 23:42
 * @TODO DateUtil 日期工具类
 */

export class DateUtil {

  static parse(dateString: string): Date {
    return new Date(dateString);
  }

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