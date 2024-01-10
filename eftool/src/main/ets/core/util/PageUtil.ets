/**
 * @Author csx
 * @DateTime 2024/1/7 16:09
 * @TODO PageUtil  分页工具类
 */
export class PageUtil<T = any> {
  //当前页数
  private pageNumber: number = 1;
  //每页记录数
  private pageSize: number = 10;
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
    //设置总数
    pageInfo.setTotal(list.length);
    //设置所有记录
    pageInfo.setList(list);
    //设置总页数
    pageInfo.setPages(pageInfo.totalPage());
    //设置导航集合
    pageInfo.setNavigatePageNumbers();
    return pageInfo;
  }


  /**
   * 根据总数计算总页数
   *
   * @param totalCount 总数
   * @param pageSize   每页数
   * @return 总页数
   */
  private totalPage(): number {
    return Math.ceil(this.total / this.pageSize);
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
    const start: number = (this.pageNumber - 1) * this.pageSize; // 计算起始位置
    const end: number = start + this.pageSize; // 计算结束位置
    this.records = this.list.slice(start, end);
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
      this.pageNumber--;
      return this.getPageNumber();
    }
    return this.getPageNumber();
  }

  public getNextPage(): number {
    if (this.hasNextPage()) {
      this.pageNumber++;
      return this.getPageNumber();
    }
    return this.getPageNumber();
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


  public setNavigatePageNumbers() {
    const generateNumberArray = (n: number): number[] => Array.from({ length: n }, (_, index) => index + 1);
    this.navigatePageNumbers = generateNumberArray(this.pages);
  }

  public getNavigatePageNumbers(): number[] {
    return this.navigatePageNumbers;
  }
}