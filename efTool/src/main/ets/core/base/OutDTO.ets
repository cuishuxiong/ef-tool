/**
 * @Author csx
 * @DateTime 2023/12/29 22:45
 * @TODO OutDTO  输出对象
 */
export class OutDTO<T> {
  //成功失败标识
  private success: boolean;
  //返回提示信息
  private msg: string;
  //返回单行数据
  private dataRow: T;
  //返回数据集合
  private dataTable: Array<T>;

  // @ts-ignore
  static OK(msg: string): OutDTO {
    let dto = new OutDTO();
    dto.setSuccess(true);
    dto.setMsg(msg);
    return dto;
  }

  // @ts-ignore
  static Error(msg: string): OutDTO {
    let dto = new OutDTO();
    dto.setSuccess(false);
    dto.setMsg(msg);
    return dto;
  }

  public getSuccess(): boolean {
    return this.success;
  }

  public setSuccess(success: boolean) {
    this.success = success;
  }

  public getMsg(): string {
    return this.msg;
  }

  public setMsg(msg: string) {
    this.msg = msg;
  }

  public getDataRow(): T {
    return this.dataRow;
  }

  public setDataRow(dataRow: T) {
    this.dataRow = dataRow;
  }

  public getDataTable(): Array<T> {
    return this.dataTable;
  }

  public setDataTable(dataTable: Array<T>) {
    this.dataTable = dataTable;
  }
}