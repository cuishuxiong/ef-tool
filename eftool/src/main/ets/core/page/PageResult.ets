/**
 * @Author csx
 * @DateTime 2024/1/8 19:57
 * @TODO PageResult 分页返回结果对象
 */
export interface PageResult<T> {
  //总数
  total: number;
  //结果
  records: T[];
}