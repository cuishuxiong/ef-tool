import { ArrayUtil, IdCardUtil, StrUtil, RandomUtil,DateUtil,JSONUtil } from '@yunkss/efTool'

class Person{
  name:string;
  age:number;
  birth: Date;
}

@Entry
@Component
struct Index {
  @State message: string = '1111'

  aboutToAppear() {
    this.test();
  }

  test() {



    // let p:Person = JSONUtil.parseObject<Person>('{"name":"崔树雄","age":18,"birth":"2024-01-03T09:48:15.316Z" }','yyyy/MM/dd HH:mm:ss')
    //
    // this.message = p.name+p.birth;

    // p.birth = new Date();

    // this.message =  JSONUtil.toJSONString(p)

    // let pArr:Array<Person> = JSONUtil.parseArray<Person>('[{"name":"崔树雄","age":18,"birth":"2023-01-01"},{"name":"111111","age":23,"birth":"2021-01-01 12:12:12" }]',"yyyy/MM/dd HH:mm:ss");
    // pArr.forEach(item=>{
    //   this.message += item.name+"-"+item.birth+"\n";
    // })

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