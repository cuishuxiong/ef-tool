import { PageResult } from './PageResult';
/**
 * @Author csx
 * @DateTime 2024/1/8 19:58
 * @TODO PageQuery 分页查询对象
 */
export class PageQuery<T> {
  //当前页码
  currentPage: number;
  //每页记录数
  pageSize: number;
  //总数
  total: number;
  //记录数
  records: T[];

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
  async queryData(queryFunction: (currentPage: number, pageSize: number) => Promise<PageResult<T>>) {
    const result = await queryFunction(this.currentPage, this.pageSize);
    this.total = result.total;
    this.records = result.records;
  }

  /**
   * 获取总记录数
   * @returns
   */
  get totalPage(): number {
    return Math.ceil(this.total / this.pageSize);
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
   * 跳转到指定页码
   * @param pageNumber
   * @returns
   */
  async goToPage(pageNumber: number) {
    if (pageNumber >= 1 && pageNumber <= this.totalPage && pageNumber !== this.currentPage) {
      this.currentPage = pageNumber;
      await this.queryData;
      return true;
    }
    return false;
  }
}