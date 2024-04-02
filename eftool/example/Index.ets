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
  AES,
  Logger,
  ToastUtil,
  DialogUtil,
  ActionUtil,
  Cascade,
  CacheUtil,
  SM2,
  SM4,
  SM3,
  pcaJSON
} from '@yunkss/eftool'
import util from '@ohos.util';
import { sm3 } from '@yunkss/eftool/src/main/ets/core/crypto/sm/sm2/SM3';

class Person {
  name: string;
  age: number;
  birth: Date;
  sex: boolean;
  user: User;
  list: Array<User>;

  constructor(name: string, age: number, sex: boolean, birth: Date, user: User, list: Array<User>) {
    this.birth = birth;
    this.name = name;
    this.age = age;
    this.sex = sex;
    this.user = user;
    this.list = list;
  }
}

class User {
  id: string;
  name: string;

  constructor(id: string, name: string) {
    this.name = name;
    this.id = id;
  }
}


/**
 * 选择器所需的数据
 */
class City {
  name: string;
  code: string;
  children: Array<City>;

  constructor(name, code) {
    this.name = name;
    this.code = code;
  }
}


@Entry
@Component
struct Index {
  @State message: string = '11111'
  @State show: boolean = false
  @State callCity: string = ''

  aboutToAppear() {
    this.test();
  }

  can() {
    const obj = { 'key': 'this is value' } // key的值类型为 string | undefined
    const test = StrUtil.asString(obj['key'])
    ToastUtil.showToast('点击了确定:' + test)
  }

  two() {
    ToastUtil.showToast('点击了取消')
  }

  test() {

    let userList = new Array<User>();
    userList.push(new User('2345', '测试用户1'));
    userList.push(new User('7844', '测试用户2'));
    let person = new Person('测试', 12, true, new Date(), new User("uuid", "打撒吃的是草动次打次"), userList);

    let str1 = JSONUtil.toJSONString(person,DateConst.YMD_HLINE_HMS);

    Logger.error(str1, "11111111111")



    let p = JSONUtil.parseObject<Person>(str1,DateConst.YMD_HLINE_HMS);

    Logger.debug(p.name, p.user.name + p.list[0].name);


    let listStr = JSONUtil.toJSONString(userList);

    let uList = JSONUtil.parseArray<User>(listStr);
    uList.forEach(item => {
      Logger.error(item.id, item.name);
    })

    // const msg = 'hello world! 我是 xxxx.' // 可以为 utf8 串或字节数组
    // const key = SM4.generateKey().hexString;


    // let encryptData = SM4.encrypt(msg, key) // 加密，默认输出 16 进制字符串，默认使用 pkcs#7 填充（传 pkcs#5 也会走 pkcs#7 填充）
    // let encryptData1 = SM4.encrypt(msg, key, { padding: 'none' }) // 加密，不使用 padding
    // let encryptData2 = SM4.encrypt(msg, key, { padding: 'none', output: 'array' }) // 加密，不使用 padding，输出为字节数组
    // let encryptData3 = SM4.encrypt(msg, key, { mode: 'cbc', iv: 'fedcba98765432100123456789abcdef' }) // 加密，cbc 模式

    // console.log(encryptData)
    // console.log(encryptData1)
    // console.log(encryptData2)
    // console.log(encryptData3)


    // let decryptData = SM4.decrypt(encryptData, key) // 解密，默认输出 utf8 字符串，默认使用 pkcs#7 填充（传 pkcs#5 也会走 pkcs#7 填充）
    // let decryptData1 = SM4.decrypt(encryptData1, key, { padding: 'none' }) // 解密，不使用 padding
    // let decryptData2 = SM4.decrypt(encryptData2, key, { padding: 'none', output: 'array' }) // 解密，不使用 padding，输出为字节数组
    // let decryptData3 = SM4.decrypt(encryptData3, key, {
    //   mode: 'cbc',
    //   iv: 'fedcba98765432100123456789abcdef'
    // }) // 解密，cbc 模式

    // console.log(decryptData)
    // console.log(decryptData1)
    // console.log(decryptData2)
    // console.log(decryptData3)

    // let hashData = SM3('abc') // 杂凑
    // console.log(hashData)

    // hmac
    // hashData = SM3('abc', {
    //   key: 'daac25c1512fe50f79b0e4526b93f5c0e1460cef40b6dd44af13caec62e8c60e0d885f3c6d6fb51e530889e6fd4ac743a6d332e68a0f2a3923f42585dceb93e9', // 要求为 16 进制串或字节数组
    // })
    // console.log(hashData)

    // let sm2 = new SM2();

    // let {publicKey,privateKey} = sm2.generateKeyPairHex()

    // console.log(publicKey + "---" + privateKey)

    // 默认生成公钥 130 位太长，可以压缩公钥到 66 位
    // const compressedPublicKey = sm2.compressPublicKeyHex(publicKey) // compressedPublicKey 和 publicKey 等价
    // sm2.comparePublicKeyHex(publicKey, compressedPublicKey) // 判断公钥是否等价

    // 自定义随机数，参数会直接透传给 jsbn 库的 BigInteger 构造器
    // 注意：开发者使用自定义随机数，需要自行确保传入的随机数符合密码学安全
    // let keypair2 = sm2.generateKeyPairHex('123123123123123')
    // let keypair3 = sm2.generateKeyPairHex(256, SecureRandom)

    // let verifyResult = sm2.verifyPublicKey(publicKey) // 验证公钥
    // verifyResult = sm2.verifyPublicKey(compressedPublicKey) // 验证公钥
    //
    // sm2.doEncrypt('dsdsdsds', publicKey, 1)

    // let base64 = BASE64.create();
    // let a = base64.toByteArray('测试BASE64')
    //
    // let b = base64.fromByteArray(a);


    // ToastUtil.showToast('使用默认参数');
    // ToastUtil.showToast('这个是工具生成提示', { duration: 4000, bottom: '50vp' });

    // const keyPair1 = await RSA.generateRsaKey();
    // console.error("generateRsaKey结果:" + keyPair1.getSuccess() + "---" + keyPair1.getMsg()
    // + "\n" + "公钥:" + keyPair1.getDataRow().publicKey + "私钥:" + keyPair1.getDataRow().privateKey)
    //
    // const encode = await RSA.encode('从API version 7开始支持，从API version 9开始废弃，建议使用decodeWithStream9+替代。', keyPair1.getDataRow()
    //   .publicKey);
    // console.error("encode结果:" + encode.getSuccess() + "---" + encode.getMsg() + "---加密字符串:" + encode.getDataRow());
    //
    //
    // const decode = await RSA.decode(encode.getDataRow(), keyPair1.getDataRow().privateKey);
    // console.error("decode结果:" + decode.getSuccess() + "---" + decode.getMsg() + "---解密字符串:" + decode.getDataRow());
    //
    //
    // const sign = await RSA.sign('测试中文 RSA!', keyPair1.getDataRow().privateKey);
    // console.error("sign结果:" + sign.getSuccess() + "---" + sign.getMsg() + "---签名字符串:" + sign.getDataRow());
    //
    // const result = await RSA.verify(sign.getDataRow(), '测试中文 RSA!', keyPair1.getDataRow().publicKey);
    // console.error("verify结果:" + result.getSuccess() + "---" + result.getMsg());
    //
    // this.message = "验签结果:" + JSON.stringify(result);

    Logger.warn("warn错误原因为:", 'xxxxxxxxxxxx')

    // const key = await  AES.convertKey('abcdefgabcdefg12');
    // console.error("是否成功:" + key.getSuccess() + "消息===:" + key.getMsg() + "密钥======:", key.getDataRow());
    //
    // const keyPair = await  AES.generateAesKey("AES128");
    // console.error("是否成功:" + keyPair.getSuccess() + "消息===:" + keyPair.getMsg() + "密钥======:", keyPair.getDataRow());
    //
    // const encodeStr = await AES.encode("测试中文自定义Key加解密!", key.getDataRow());
    // console.error("是否成功:" + encodeStr.getSuccess() + "消息===:" + encodeStr.getMsg() + "加密后的字符串======:", encodeStr.getDataRow());
    //
    // this.message = "加密:" + encodeStr.getDataRow();

    // const decodeStr = await AES.decode(encodeStr.getDataRow(), key.getDataRow());
    // console.error("是否成功:" + decodeStr.getSuccess() + "消息===:" + decodeStr.getMsg() + "加密后的字符串======:", decodeStr.getDataRow());

    // this.message = "解密:" + decodeStr.getDataRow();
    //
    // let md5 = await MD5.digest('这个是测试MD5摘要字符串~');
    // console.error("是否成功:" + md5.getSuccess() + "消息===:" + md5.getMsg() + "摘要字符串======:", md5.getDataRow());
    //
    // let logger = new Logger('吃嘛');
    // logger.error("error错误原因为:", 'xxxxxxxxxxxx')
    // logger.debug("debug错误原因为:", 'xxxxxxxxxxxx')
    // logger.info("info错误原因为:", 'xxxxxxxxxxxx')
    // logger.warn("warn错误原因为:", 'xxxxxxxxxxxx')

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


    // let person = new Person('测试', 12, new Date(), new User("101291021", "打撒吃的是草动次打次"));
    // CacheUtil.save<Person>("csx", person);

    // let p = CacheUtil.get<Person>("csx");
    // let str = JSONUtil.toJSONString(p);

    // Logger.error(str);

    // CacheUtil.save<string>("str", str);

    // let st = CacheUtil.get<string>("str");

    // let a = CacheUtil.get<string>("xxx");

    // Logger.error(a);


    // let p = JSONUtil.parseObject<Person>(str, 'yyyy/MM/dd HH:mm:ss')
    // let res: OutDTO<Person> = OutDTO.OKByDataRow('成功过了~', p);
    // console.error(res.getMsg() + "------" + res.getSuccess() + "-----" + res.getDataRow())

    // let json = JSONUtil.parseArray<City>(JSONUtil.toJSONString(pcaJSON));

    // console.info(json.length + "")

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
    // let pArr: Array<Person> = JSONUtil.parseArrayDT('[{"name":"测试名称1","age":18,"birth":"2023-01-01"},{"name":"测试名称2","age":23,"birth":"2021-01-01 12:12:12" }]', DateConst.YMD_HLINE_HMS);
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
        Text(this.callCity)
        Button("默认toast").margin({ bottom: '10vp' }).onClick(() => {
          ToastUtil.showToast('duration:2000,bottom:10vp');
          this.test()
        })
        Button("toast修改参数").margin({ bottom: '10vp' }).onClick(() => {
          ToastUtil.showToast('duration:4000,bottom:50vp', { duration: 4000, bottom: '50vp' });
        })
        Button("dialog").margin({ bottom: '10vp' }).onClick(() => {
          DialogUtil.showDialog({
            title: '修改',
            okText: 'ok',
            cancelText: 'cancel',
            msg: '这是一个弹框提示',
            okCallBack: this.can,
            cancelCallBack: this.two
          });
        })
        Button("action").margin({ bottom: '10vp' }).onClick(() => {
          ActionUtil.showActionMenu({ title: '修改后的标题', btn: [
            { text: '测试1', color: '#cdcdcd', btnCallBack: this.can },
            { text: '测试2', color: '#108ee9', btnCallBack: this.two }
          ] });
        })
        Button("action默认标题").margin({ bottom: '10vp' }).onClick(() => {
          ActionUtil.showActionMenu({ btn: [
            { text: '测试1', color: '#cdcdcd', btnCallBack: this.can },
            { text: '测试2', color: '#108ee9', btnCallBack: this.two }
          ] });
        })
        Button("actionMenu默认标题").margin({ bottom: '10vp' }).onClick(() => {
          ActionUtil.showMenu({ btn: ["菜单1", "菜单2"], clickCallBack: (data) => {
            ToastUtil.showToast(data);
          } })
        })
        Button("actionMenu修改标题").margin({ bottom: '10vp' }).onClick(() => {
          ActionUtil.showMenu({ title: '修改了菜单标题', btn: ["菜单1", "菜单2"], clickCallBack: (data) => {
            ToastUtil.showToast(data);
          } })
        })
        Button("alertDialog默认值").margin({ bottom: '10vp' }).onClick(() => {
          DialogUtil.showAlertDialog("这个是一个，默认警告弹框");
        })
        Button("alertDialog修改值").margin({ bottom: '10vp' }).onClick(() => {
          DialogUtil.showAlertDialog("这个是一个警告弹框", {
            title: '标题',
            alignment: DialogAlignment.Top,
            buttons: [
              { callBack: this.can },
              { callBack: this.two }
            ] });
        })
        Button("列表选择弹窗默认参数").margin({ bottom: '10vp' }).onClick(() => {
          ActionUtil.showActionSheet({
            sheets: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
            clickCallBack: (data: string) => {
              ToastUtil.showToast(data);
            } });
        })
        Button("列表选择弹窗修改参数").margin({ bottom: '10vp' }).onClick(() => {
          ActionUtil.showActionSheet({
            title: '弹框的标题',
            msg: '弹框的消息',
            alignment: DialogAlignment.Top,
            sheets: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
            clickCallBack: (data: string) => {
              ToastUtil.showToast(data);
            }
          });
        })
        Button("级联菜选择器").margin({ bottom: '10vp' }).onClick(() => {
          this.show = !this.show;
        })
        Cascade({ show: $show, callCity: $callCity })
      }
      .width('100%')
    }
    .height('100%')
  }
}