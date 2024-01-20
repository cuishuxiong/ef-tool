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
  PageUtil,
  PageQuery,
  PageResult,
  BASE64,
  MD5,
  RSA,
  AES
} from '@yunkss/eftool'

class Person {
  name: string;
  age: number;
  birth: Date;

  constructor(name: string, age: number, birth: Date) {
    this.birth = birth;
    this.name = name;
    this.age = age;
  }
}

@Entry
@Component
struct Index {
  @State message: string = '11111'

  aboutToAppear() {
    this.test();
  }

  async test() {

    // let a =await AES.testAesGcm();
    // console.error("1111111111:" + a);

    const keyPair = await  AES.generateAesKey("AES128");

    console.log("密钥、；:", keyPair);

    // AES.testConvertAesKey(keyPair);

    await AES.encode("this is  csx test", keyPair, "AES128");

    await AES.decode(keyPair, 'AES128')


    // const originalText = "Hello,World!";
    // const encryptedText = MD5.encrypt(originalText);
    // console.log("原始文本:", originalText);
    // console.log("加密后:", encryptedText);

    // const { publicKey, privateKey } = RSA.generateKeyPair(1024);

    // 加密消息
    // const encryptedMessage = RSA.encrypt(originalText, publicKey);

    // 解密消息
    // const decryptedMessage = RSA.decrypt(encryptedMessage, privateKey);


    // console.error("原始文本:", originalText);
    // console.error("公钥:", publicKey);
    // console.error("私钥:", privateKey);
    // console.error("加密后:", encryptedMessage);
    // console.error("解密后:", decryptedMessage);
    // console.error("加密后:", encryptedMessage.map((value) => value.toString()).join(", "));
    // console.error("解密后:", decryptedMessage);


    // let arr = ArrayUtil.setOrAppend<string>(["1212", "3232", "5345", "645654", "64564564x"], 2, "你好");
    // console.error(JSON.stringify(arr))
    //
    // let arr2 = ArrayUtil.replace<string>(["1212", "3232", "5345", "645654", "64564564x"], 1, "halo");
    // console.error(JSON.stringify(arr2))
    //
    // let source = ["哈哈哈哈哈", 1212, true, new Person("测试", 12, new Date()), "64564564x"];
    // let arr3 = ArrayUtil.clone(source);
    // console.error(JSON.stringify(arr3))
    //
    // let person = new Person("测试", 12, new Date());
    // let p = ArrayUtil.deepClone<Person>(person);
    // console.error(JSON.stringify(p));
    //
    // let pArr: Array<Person> = JSONUtil.parseArray('[{"name":"测试名称1","age":18,"birth":"2023-01-01"},{"name":"测试名称2","age":3,"birth":"2021-11-01 12:12:12" },{"name":"测试名称3","age":34,"birth":"2023-01-01 12:12:12" },{"name":"测试名称4","age":23,"birth":"2021-01-01 12:12:12" }]', DateConst.YMD_HLINE_HMS);
    // let flter = ArrayUtil.filter<Person>(pArr, (item: Person) => item.name.includes("4"));
    // console.error(JSON.stringify(flter))
    //
    // ArrayUtil.reverse<Person>(pArr);
    // console.log(JSONUtil.toJSONString(pArr));
    //
    // console.error(ArrayUtil.min<number>([345, 5, 67, 899076, 3, 2, 143, 17, 65]) + "")
    //
    // console.error(ArrayUtil.max<number>([345, 5, 67, 899076, 3, 2, 143, 17, 65]) + "")
    //
    // let nArr = ArrayUtil.distinct<string, string>(["你", "helo", "哇哈哈哈", "212121", "2222", "哇哈哈哈", "你"], item => item);
    // console.error(JSONUtil.toJSONString(nArr));
    //
    //
    // let province = IdCardUtil.getProvinceCodeByIdCard("142303111111111111");
    // console.info(province.getSuccess() + "--" + province.getDataRow() + "--" + province.getMsg())
    //
    //
    // let city = IdCardUtil.getCityCodeByIdCard("142303111111111111");
    // console.info(city.getSuccess() + "--" + city.getDataRow() + "--" + city.getMsg())
    //
    //
    // let district = IdCardUtil.getDistrictCodeByIdCard("142303111111111111");
    // console.info(district.getSuccess() + "--" + district.getDataRow() + "--" + district.getMsg())
    //
    // console.error(StrUtil.camelCase("Foo Bar")) //输出 fooBar
    // console.error(StrUtil.camelCase("--foo-bar--")) //输出 fooBar
    // console.error(StrUtil.camelCase("__FOO_BAR__")) //输出 fooBar
    //
    // console.error(StrUtil.capitalize("FooBar")) //输出  Foobar
    //
    // console.error(StrUtil.endsWith('abc', 'b', 2) + "") //输出  true
    //
    // console.error(StrUtil.repeat("*", 5)) //输出  *****
    //
    // const str = 'Hello, World';
    //
    // console.log(StrUtil.replace(str, 'Hello', 'Hi')); // 输出：'Hi, World'
    // console.log(StrUtil.replace(str, /world/i, 'Universe')); // 输出：'Hello, Universe'
    // console.log(StrUtil.replace(str, /[aeiou]/ig, 'X')); // 输出：'HXllX, WXXld'
    //
    // console.log(StrUtil.startsWith(str, 'Hello') + ""); // 输出：true
    // console.log(StrUtil.startsWith(str, 'World') + ""); // 输出：false
    // console.log(StrUtil.startsWith(str, 'Hello', 7) + ""); // 输出：false
    // console.log(StrUtil.startsWith(str, 'World', 7) + ""); // 输出：true
    //
    // console.error(StrUtil.toLower('--Foo-Bar--')); //--foo-bar--
    //
    // console.error(StrUtil.toUpper('--Foo-Bar--')); //--FOO-BAR--
    //
    // console.log(StrUtil.truncate(str)); // 输出：'Hello, World'
    // console.log(StrUtil.truncate(str, { length: 5 })); // 输出：'Hello...'
    // console.log(StrUtil.truncate(str, { length: 10, omission: '***' })); // 输出：'Hello, Wo***'
    // console.log(StrUtil.truncate(str, { separator: ',' })); // 输出：'Hello, World'
    //
    // const longStr = 'This is a very long string that needs to be truncated';
    // console.log(StrUtil.truncate(longStr, { length: 10 })); // 输出：'This is a ....'
    // console.log(StrUtil.truncate(longStr, { length: 10, separator: ' ' })); // 输出：'This is a very...'
    //
    //
    // const arr1 = [1, 2, 3];
    // const arr2 = [2, 3, 4];
    // const arr3 = [3, 4, 5];
    //
    // const result = ArrayUtil.union(arr1, arr2, arr3);
    // console.log(JSONUtil.toJSONString(result)); // 输出：[1, 2, 3, 4, 5]
    //
    // const arr11 = [1, 2, 3];
    // const arr22 = ['a', 'b', 'c'];
    // const arr33 = [true, false, 'd'];
    //
    // const result1 = ArrayUtil.zip(arr11, arr22, arr33);
    // console.log(JSONUtil.toJSONString(result1)); // 输出：[[1,"a",true],[2,"b",false],[3,"c","d"]]
    //
    // const qwe = ArrayUtil.unzip(result1);
    // console.error(JSONUtil.toJSONString(qwe)) //输出[[1,2,3],["a","b","c"],[true,false,"d"]]
    //
    //
    // const array = [1, 2, 3, 4, 5];
    // const removed = ArrayUtil.remove(array, (value: number) => value % 2 === 0);
    // console.log(JSONUtil.toJSONString(removed)); // [4,2]
    // console.log(JSONUtil.toJSONString(array)); // [1, 3, 5]
    //
    //
    // console.error(JSONUtil.toJSONString(ArrayUtil.removeEmptyValues([1, "", "ssss", "", true]))) //输出  [1,"ssss",true]
    //
    // const difference = DateUtil.dateDiff(new Date('2023-01-01'), new Date('2023-01-10'));
    // console.log(difference + ""); // 9
    //
    // const diff = DateUtil.strDateDiff('2023-11-01 12:12:12', '2024-01-10 12:12:12');
    // console.log(diff + ""); // 70

    // IdCardUtil.isValidCard18("120102199001015965").getMsg();
    // this.message = IdCardUtil.convert15To18("420106640901234").getDataRow();

    // console.error(IdCardUtil.isValidCard15("420106840901234").getMsg())

    // let n = ArrayUtil.append(["1", "2", "3"], ["4"]);
    // n.forEach(item => {
    //   console.error(item);
    // })

    // let pArr: Array<Person> = JSONUtil.parseArray('[{"name":"测试名称1","age":18,"birth":"2023-01-01"},{"name":"测试名称3","age":3,"birth":"2021-11-01 12:12:12" },{"name":"测试名称4","age":34,"birth":"2023-01-01 12:12:12" },{"name":"测试名称2","age":23,"birth":"2021-01-01 12:12:12" }]', DateConst.YMD_HLINE_HMS);
    //
    // let page = PageUtil.packPageInfo(pArr);
    // page.getRecords().forEach(item => {
    //   console.error(item.name + "----" + item.birth)
    // })
    // console.error(page.getTotal() + "getTotal")
    //
    // console.error(page.getPages() + ":getPages")
    // console.error(page.hasPreviousPage() + "hasPreviousPage")
    // console.error(page.hasNextPage() + "hasNextPage")
    // console.error(page.getPageNumber() + "getPageNumber")
    // console.error(page.getPrePage() + "getPrePage")
    // console.error(page.getNextPage() + "getNextPage")
    // page.getRecords().forEach(item => {
    //   console.error(item.name + "----" + item.birth)
    // })
    // console.error(page.getLastPage() + "getLastPage")
    // page.setPageNumber(4);
    // page.getRecords().forEach(item => {
    //   console.error(item.name + "----" + item.birth)
    // })
    //
    // console.error(JSON.stringify(page.getNavigatePageNumbers()))

    //传入当前页数和每页记录数,默认是1,10
    // const pageQuery = new PageQuery<Person>(2, 20);
    // 定义自己的 queryFunction
    // const queryFunction = async (currentPage: number, pageSize: number): Promise<PageResult<Person>> => {
    //   const total = 100; // 假设总记录数为 100
    //   const records: Person[] = [];
    //   // 模拟循环请求，每次请求返回 pageSize 条记录
    //   for (let i = 0; i < pageSize; i++) {
    //     const id = (currentPage - 1) * pageSize + i + 1;
    //     const person: Person = {
    //       name: `person${id}`,
    //       birth: new Date(),
    //       age: id
    //     };
    //     records.push(person);
    //   }
    //   return {
    //     total: total,
    //     records: records,
    //   };
    // };
    // 调用查询接口
    // await pageQuery.queryData(queryFunction);
    //获取到记录数
    // pageQuery.getRecords().forEach(item => {
    //   console.error(item.name + "--" + item.age + "---" + item.birth)
    // })
    //上一页
    // console.error(pageQuery.prevPage() + "");
    //请求上一页数据
    // await pageQuery.queryData(queryFunction);
    // pageQuery.getRecords().forEach(item => {
    //   console.error(item.name + "--" + item.age + "---" + item.birth)
    // })
    //跳转到指定页码
    // await pageQuery.goToPage(4, queryFunction);
    //获取数据
    // pageQuery.getRecords().forEach(item => {
    //   console.error(item.name + "-|-" + item.age + "-|-" + item.birth)
    // })
    // console.error(ObjectUtil.notEqual("1", "1") + "")

    // console.error(PhoneUtil.isPhone("17111114114").getMsg())
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
          .fontWeight(FontWeight.Bold).onClick(() => {
          this.test();
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}