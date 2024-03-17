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

  /**
   * 构造函数
   * @param success  是否成功标识
   * @param msg   提示消息
   * @param dataRow  单行数据
   * @param dataTable   多行数据集合
   */
  constructor(success: boolean, msg: string, dataRow: T, dataTable: Array<T>) {
    this.msg = msg;
    this.success = success;
    this.dataRow = dataRow;
    this.dataTable = dataTable;
  }

  /**
   * 成功-只包含消息
   * @param msg   提示消息
   * @returns
   */
  static OK(msg: string): OutDTO<string> {
    let outDTO = new OutDTO<string>(true, msg, '', []);
    return outDTO;
  }

  /**
   * 成功-包含单行数据
   * @param msg  提示消息
   * @param dataRow  单行数据
   * @returns
   */
  static OKByDataRow<T>(msg: string, dataRow: T): OutDTO<T> {
    let dto = new OutDTO<T>(true, msg, dataRow, []);
    return dto;
  }

  /**
   * 成功-包含多行数据
   * @param msg  提示消息
   * @param dataTable  多行数据
   * @param dataRow 单行数据(不传)
   * @returns
   */
  static OKByDataTable<T>(msg: string, dataTable: Array<T>, dataRow?: T): OutDTO<T> {
    if (!dataRow) {
      dataRow = Object as T;
    }
    let dto = new OutDTO<T>(true, msg, dataRow, dataTable);
    return dto;
  }

  /**
   * 失败-包含提示消息
   * @param msg 提示消息
   * @returns
   */
  static Error(msg: string): OutDTO<string> {
    let dto = new OutDTO<string>(false, msg, '', []);
    return dto;
  }

  /**
   * 失败-包含单行数据
   * @param msg 提示消息
   * @param dataRow 单行数据
   * @returns
   */
  static ErrorByDataRow<T>(msg: string, dataRow: T): OutDTO<T> {
    let dto = new OutDTO<T>(false, msg, dataRow, []);
    return dto;
  }

  public getSuccess(): boolean {
    return this.success;
  }


  public getMsg(): string {
    return this.msg;
  }


  public getDataRow(): T {
    return this.dataRow;
  }


  public getDataTable(): Array<T> {
    return this.dataTable;
  }
}