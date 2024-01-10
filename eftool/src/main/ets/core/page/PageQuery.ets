import { PageResult } from './PageResult';
/**
 * @Author csx
 * @DateTime 2024/1/8 19:58
 * @TODO PageQuery 分页查询对象
 */
export class PageQuery<T> {
  //当前页码
  private currentPage: number;
  //每页记录数
  private pageSize: number;
  //总数
  private total: number;
  //总页数
  private totalPages: number;
  //记录数
  private records: T[];

  constructor(currentPage = 1, pageSize = 10) {
    this.currentPage = currentPage;
    this.pageSize = pageSize;
    this.total = 0;
    this.records = [];
  }

  /**
   * 查询分页数据
   * @param queryFunction
   */
  async queryData(queryFunction: (currentPage: number, pageSize: number) => Promise<PageResult<T>>): Promise<void> {
    const result = await queryFunction(this.currentPage, this.pageSize);
    this.total = result.total;
    this.records = result.records;
    this.totalPages = Math.ceil(this.total / this.pageSize); // 计算总页数
  }

  /**
   * 获取总记录数
   * @returns
   */
  get totalPage(): number {
    return this.totalPages;
  }

  /**
   * 是否有下一页
   * @returns
   */
  get hasNext(): boolean {
    return this.currentPage < this.totalPage;
  }

  /**
   * 是否有上一个页
   * @returns
   */
  get hasPrev(): boolean {
    return this.currentPage > 1;
  }

  /**
   * 下一页页码
   * @returns
   */
  nextPage(): boolean {
    if (this.hasNext) {
      this.currentPage++;
      return true;
    }
    return false;
  }

  /**
   * 上一页码
   * @returns
   */
  prevPage(): boolean {
    if (this.hasPrev) {
      this.currentPage--;
      return true;
    }
    return false;
  }

  /**
   * 获取记录数
   * @returns
   */
  getRecords(): T[] {
    return this.records;
  }

  /**
   * 跳转到指定页码
   * @param pageNumber
   * @returns
   */
  async goToPage(pageNumber: number, queryFunction: (currentPage: number, pageSize: number) => Promise<PageResult<T>>): Promise<void> {
    // 检查页码是否有效
    if (pageNumber < 1 || pageNumber > this.totalPages || pageNumber === this.currentPage) {
      return;
    }
    // 更新当前页码
    this.currentPage = pageNumber;
    // 执行查询
    await this.queryData(queryFunction);
  }
}