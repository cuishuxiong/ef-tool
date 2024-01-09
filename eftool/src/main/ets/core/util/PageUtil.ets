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
  //总记录数
  private total: number;
  //总页数
  private pages: number;
  //当前页数据
  private list?: Array<T>;
  //当前页记录集合
  private records?: Array<T>;
  //导航页码数
  private navigatePages: number;
  //所有导航页号
  private navigatePageNumbers: number[];

  /**
   * 包装分页对象
   * @param list  所有数据集
   */
  static packPageInfo<T>(list: Array<T>): PageUtil<T> {
    let pageInfo: PageUtil<T> = new PageUtil<T>();
    pageInfo.setTotal(list.length);
    pageInfo.setPages(pageInfo.totalPage(pageInfo.getTotal(), pageInfo.getPageSize()));
    pageInfo.setList(list);
    const start: number = (pageInfo.getPageNumber() - 1) * pageInfo.getPageSize(); // 计算起始位置
    const end: number = start + pageInfo.getPageSize(); // 计算结束位置
    pageInfo.setRecords(pageInfo.getList().slice(start, end));
    return pageInfo;
  }


  /**
   * 根据总数计算总页数
   *
   * @param totalCount 总数
   * @param pageSize   每页数
   * @return 总页数
   */
  private totalPage(totalCount: number, pageSize: number): number {
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

  public setRecords(records: Array<T>) {
    this.records = records;
  }

  public getRecords(): Array<T> {
    return this.records;
  }

  public setList(list: Array<T>) {
    this.list = list;
  }

  public getList(): Array<T> {
    return this.list;
  }

  public setPages(pages: number) {
    this.pages = pages;
  }

  public getPages(): number {
    return this.pages;
  }


  public getPrePage(): number {
    if (this.hasPreviousPage()) {
      return this.pageNumber--;
    }
    return -1;
  }

  public getNextPage(): number {
    if (this.hasNextPage()) {
      return this.pageNumber++;
    }
    return -1;
  }


  public getLastPage(): number {
    return this.pages;
  }

  public isFirstPage(): boolean {
    return this.pageNumber == 1;
  }

  public isLastPage(): boolean {
    return this.pageNumber == this.pages;
  }


  public hasPreviousPage(): boolean {
    return this.pageNumber > 1;
  }

  public hasNextPage(): boolean {
    return this.pageNumber < this.pages;
  }

  public setNavigatePages(navigatePages: number) {
    this.navigatePages = navigatePages;
  }

  public getNavigatePages(): number {
    return this.navigatePages;
  }


  public setNavigatePageNumbers(navigatePageNumbers: number[]) {
    this.navigatePageNumbers = navigatePageNumbers;
  }

  public getNavigatePageNumbers(): number[] {
    return this.navigatePageNumbers;
  }
}