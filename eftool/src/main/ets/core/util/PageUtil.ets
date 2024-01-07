/**
 * @Author csx
 * @DateTime 2024/1/7 16:09
 * @TODO PageUtil  分页工具类
 */
export class PageUtil<T = any> {
  //当前页数
  private pageNumber: number = 1;
  //每页记录数
  private pageSize: number = 20;
  //总页数
  private total: number;
  //当前页数据
  private list?: Array<T>;

  /**
   * 根据总数计算总页数
   *
   * @param totalCount 总数
   * @param pageSize   每页数
   * @return 总页数
   */
  static totalPage(totalCount: number, pageSize: number): number {
    if (pageSize == 0) {
      return 0;
    }
    return totalCount % pageSize == 0 ? (totalCount / pageSize) : (totalCount / pageSize + 1);
  }

  public setPageNumber(pageNumber: number) {
    this.pageNumber = pageNumber;
  }

  public getPageNumber(): number {
    return this.pageNumber;
  }

  public setPageSize(pageSize: number) {
    this.pageSize = pageSize;
  }

  public getPageSize(): number {
    return this.pageSize;
  }

  public setTotal(total: number) {
    this.total = total;
  }

  public getTotal(): number {
    return this.total;
  }

  public setList(list: Array<T>) {
    this.list = list;
  }

  public getList(): Array<T> {
    return this.list;
  }
}