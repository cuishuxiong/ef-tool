import {
  ArrayUtil,
  IdCardUtil,
  StrUtil,
  RandomUtil,
  DateUtil,
  JSONUtil,
  RegUtil,
  OutDTO,
  CharUtil,
  DateConst,
  RegexConst,
  IdUtil,
  ObjectUtil,
  PhoneUtil,
  PageUtil
} from '@yunkss/eftool'

class Person {
  name: string;
  age: number;
  birth: Date;
}

@Entry
@Component
struct Index {
  @State message: string = '11111'

  aboutToAppear() {
    this.test();
  }

  test() {

    let page: PageUtil = PageUtil.packPageInfo([]);

    page.hasPreviousPage();

    page.getRecords();

    // IdCardUtil.isValidCard18("120102199001015965").getMsg();
    this.message = IdCardUtil.convert15To18("420106640901234").getDataRow();

    console.error(IdCardUtil.isValidCard15("420106840901234").getMsg())

    let n = ArrayUtil.append(["1", "2", "3"], ["4"]);
    n.forEach(item => {
      console.error(item);
    })


    console.error(ObjectUtil.notEqual("1", "1") + "")

    console.error(PhoneUtil.isPhone("17111114114").getMsg())
    // this.message = IdCardUtil.isValidCard18("420106194201062348").getMsg();

    // console.error(StrUtil.hasBlank("", "232323") + "")

    // console.error(StrUtil.isEmpty(' ')+"")

    // let res:OutDTO = OutDTO.OK("只返回提示消息~");
    // console.error(res.getMsg()+"------"+res.getSuccess())

    // console.error(StrUtil.isNotBlank('222')+"")

    // console.error(StrUtil.trim([" 你好 "," hi","hello "]).join("----"))

    // console.error()

    // this.message = DateUtil.parse("2023-01-01")+"";

    // console.error(DateUtil.formatDate("2023/1/1",'yyyy-MM-dd HH:mm:ss'))

    // console.error(DateUtil.format(new Date,'HH:mm:ss'))

    // if (CharUtil.isBlankChar(0xFEFF)) {
    //   this.message = "111"
    // } else {
    //   this.message = "222"
    // }

    // let res: OutDTO = RegUtil.isMatch(RegexConst.EMAIL, '111111');
    // console.error(res.getSuccess() + "---" + res.getMsg());

    // let res: OutDTO = RegUtil.isEmailMatch('13191191111@163.com');
    // console.error(res.getSuccess() + "---" + res.getMsg());

    // this.message = RegUtil.isIdCardMatch('111111111111111111').getMsg();

    // this.message = RegUtil.isEmailMatch('13191191111').getMsg();

    // this.message = RegUtil.isMobileMatch('13191191111').getMsg();

    // this.message =  DateUtil.parse('2024-01-03T09:48:15.316Z')+"";

    // this.message = DateUtil.format(new Date(),'yyyy/MM/dd HH:mm:ss')

    // let str = 'yyyy/MM/dd HH:mm:ss';
    // console.error(str)

    // JSONUtil.parse('{"name":"测试名称","age":18,"birth":"2024-01-03" }')
    // console.error(p.name+":"+p.birth)
    // this.message = p.name+p.birth;

    // let p: Person = JSONUtil.parseObject<Person>('{"name":"测试名称","age":18,"birth":"2024-01-03" }', 'yyyy/MM/dd HH:mm:ss')
    // let res: OutDTO<Person> = OutDTO.OKByDataRow('成功过了~', p);
    // console.error(res.getMsg() + "------" + res.getSuccess()+"-----"+res.getDataRow())

    // this.message = result.getMsg();

    // this.message =  result.getDataRow().name+result.getDataRow().age

    // p.birth = new Date();

    // this.message = JSONUtil.toJSONString(p)
    // let p: Person = JSONUtil.parseObject<Person>('{"name":"测试名称","age":18,"birth":"2024-01-03" }', 'yyyy/MM/dd HH:mm:ss')
    // let res: OutDTO = OutDTO.ErrorByDataRow("只返回失败提示消息~", p);
    // console.error(res.getMsg() + "------" + res.getSuccess()+res.getDataRow())


    // pArr.forEach(item => {
    //   console.error(item.name + "---" + item.birth);
    // })
    // let pArr: Array<Person> = JSONUtil.parseArray('[{"name":"测试名称1","age":18,"birth":"2023-01-01"},{"name":"测试名称2","age":23,"birth":"2021-01-01 12:12:12" }]', DateConst.YMD_HLINE_HMS);
    // let res = OutDTO.OKByDataTable('成功过了11111~', pArr);
    // console.error(res.getMsg() + "------" + res.getSuccess()+"-----"+res.getDataTable().length)
    // // this.message += result.getMsg() + "\n";
    // result.getDataTable().forEach(item => {
    //   this.message += item.name + "\n";
    // })

    // let str: string[] = ["1",""];
    // if (ArrayUtil.strValIsNotEmpty(str)) {
    //   this.message = "不是空的";
    // } else {
    //   this.message = "是空的"
    // }
    // if (ArrayUtil.isEmpty(str)) {
    //   this.message = "是空的";
    // } else {
    //   this.message = "不是空的"
    // }


    // ArrayUtil.defaultIfEmpty(str, ["1", "32"]).forEach(item => {
    //   this.message += item + "、";
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