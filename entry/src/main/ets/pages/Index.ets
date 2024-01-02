import { ArrayUtil, IdCardUtil, StrUtil, RandomUtil,DateUtil } from '@yunkss/efTool'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  aboutToAppear() {
    this.test();
  }

  test() {


    // let str: string[] = [];
    // if (ArrayUtil.strValIsEmpty(str)) {
    //   this.message = "是空的";
    // } else {
    //   this.message = "不是空的"
    // }
    // ArrayUtil.defaultIfEmpty(str, ["1", "32"]).forEach(item => {
    //   this.message += item;
    // })
    // this.message = RandomUtil.randomUUID();
    // this.message = DateUtil.parse("2021-1-1","yyyy-MM-dd")
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}