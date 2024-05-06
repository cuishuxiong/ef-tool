/**
 * @Author csx
 * @DateTime 2024/3/18 10:39:03
 * @TODO SM2Sequence   SM2转换序列
 */
export class SM2Sequence {
  private c1x: string = "";

  public set C1x(value: string) {
    this.c1x = value;
  }

  public get C1x(): string {
    return this.c1x;
  }

  private c1y: string = "";

  public set C1y(value: string) {
    this.c1y = value;
  }

  public get C1y(): string {
    return this.c1y;
  }

  private c2: string = "";

  public set C2(value: string) {
    this.c2 = value;
  }

  public get C2(): string {
    return this.c2;
  }

  private c3: string = "";

  public set C3(value: string) {
    this.c3 = value;
  }

  public get C3(): string {
    return this.c3;
  }

  public toString(): string {
    return JSON.stringify(this);
  }
}