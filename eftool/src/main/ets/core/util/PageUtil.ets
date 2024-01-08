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
  //第一页
  private firstPage: number;
  //前一页
  private prePage: number;
  //下一页
  private nextPage: number;
  //最后一页
  private lastPage: number;
  //是否为第一页
  private isFirstPage: boolean = false;
  //是否为最后一页
  private isLastPage: boolean = false;
  //是否有前一页
  private hasPreviousPage: boolean = false;
  //是否有下一页
  private hasNextPage: boolean = false;
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

    return pageInfo;

  }

  /**
   * 根据总数计算总页数
   *
   * @param totalCount 总数
   * @param pageSize   每页数
   * @return 总页数
   */
  totalPage(totalCount: number, pageSize: number): number {
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

  public setPages(pages: number) {
    this.pages = pages;
  }

  public getPages(): number {
    return this.pages;
  }

  public setFirstPage(firstPage: number) {
    this.pages = firstPage;
  }

  public getFirstPage(): number {
    return this.firstPage;
  }

  public setPrePage(prePage: number) {
    this.pages = prePage;
  }

  public getPrePage(): number {
    return this.prePage;
  }

  public setNextPage(nextPage: number) {
    this.pages = nextPage;
  }

  public getNextPage(): number {
    return this.nextPage;
  }

  public setLastPage(lastPage: number) {
    this.pages = lastPage;
  }

  public getLastPage(): number {
    return this.lastPage;
  }

  public setIsFirstPage(isFirstPage: boolean) {
    this.isFirstPage = isFirstPage;
  }

  public getIsFirstPage(): boolean {
    return this.isFirstPage;
  }

  public setIsLastPage(isLastPage: boolean) {
    this.isLastPage = isLastPage;
  }

  public getIsLastPage(): boolean {
    return this.isLastPage;
  }

  public setHasPreviousPage(hasPreviousPage: boolean) {
    this.hasPreviousPage = hasPreviousPage;
  }

  public getHasPreviousPage(): boolean {
    return this.hasPreviousPage;
  }

  public setHasNextPage(hasNextPage: boolean) {
    this.hasNextPage = hasNextPage;
  }

  public getHasNextPage(): boolean {
    return this.hasNextPage;
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