# <center>ef_core</center>

# <center>V1.0.2(API12)</center>

--------------------------------------------------------------------------------

## 📚简介

`ef_core`是`eftool`的核心基础包.提供了字符串等基础操作

> 你可以引入使用，也可以**拷贝**和修改使用，如需分享扩展
> ### **希望可以注明原出处即可**
> 也希望能把bug及时反馈回来。

> 我努力健全**中文**注释，为源码学习者提供良好地学习环境，争取做到人人都能看得懂。

## 🛠️包含组件

| 模块            | 介绍                 |
|---------------|--------------------|
| OutDTO        | 提供常用的返回实体对象        |
| StringBuilder | 提供字符串拼接方法          |
| CacheUtil     | 提缓存数据并且提取数据操作      |
| GlobalContext | 提供全局网络对象上下文        |
| GlobalThis    | 提供全局UIContext对象上下文 |
| cityJSON      | 提供省市区的的JSON常量      |
| CommonConst   | 提供基础的常量            |
| DateConst     | 提供常用的日期格式化表达式常量    |
| RegexConst    | 提供常用的正则表达式常量       |
| UIConst       | 提供UI常量             |
| ArrayUtil     | 提供对集合的一些常用的方法      |
| Base64Util    | 提供字符串与Base64转换方法   |
| CharUtil      | 提供常用的字符操作          |
| DateUtil      | 提供对日期的一系列封装        |
| IdCardUtil    | 提供对身份证校验系列方法       |
| IdUtil        | 提供生成ID的一系列方法       |
| Logger        | 提供常用的打印日志的方法       |
| ObjectUtil    | 提供对于对象的系列操作方法      |
| PhoneUtil     | 提供常用的手机座机等判断       |
| RandomUtil    | 提供随机数的系列方法         |
| RegUtil       | 提供对于常用正则表达式的方法     |
| StrUtil       | 提供对于字符串的操作方法       |

## 📦安装

### 🍊ohpm

* 执行安装命令

```
ohpm install @yunkss/ef_core
```

## 📦使用

### 1.在项目中引入插件

```
import { CacheUtil, OutDTO, Logger, IdCardUtil,xxxx} from '@yunkss/ef_core'
```

类按需引入,项目需要使用那个就引入

### 2.ef_core使用API

#### 1.OutDTO的方法

* 该对象有五个私有成员变量

```
  //成功失败标识
  private success: boolean;
  //返回提示信息
  private msg: string;
  //响应编码
  private code: string | number;
  //返回单行数据
  private dataRow?: T;
  //返回数据集合
  private dataTable?: Array<T>;
```

* OK 只需要返回成功提示消息时使用

```
    let res:OutDTO = OutDTO.OK("只返回提示消息~");
    console.error(res.getMsg()+"------"+res.getSuccess())
    //输出只返回提示消息~------true  
```

* OKByDataRow 需要返回成功提示消息并且附带单行数据时使用

```
    let p: Person = JSONUtil.parseObject<Person>('{"name":"测试名称","age":18,"birth":"2024-01-03" }', 'yyyy/MM/dd HH:mm:ss')
    let res: OutDTO<Person> = OutDTO.OKByDataRow<Person>('成功过了~', p);
    console.error(res.getMsg() + "------" + res.getSuccess()+"-----"+res.getDataRow())
    //输出   成功过了~------true-----[object Object]
```

* OKByDataTable 需要返回成功提示消息并且附带多行数据时使用

```
    let pArr: Array<Person> = JSONUtil.parseArray('[{"name":"测试名称1","age":18,"birth":"2023-01-01"},{"name":"测试名称2","age":23,"birth":"2021-01-01 12:12:12" }]', DateConst.YMD_HLINE_HMS);
    let res = OutDTO.OKByDataTable<Person>('成功过了11111~', pArr);
    console.error(res.getMsg() + "------" + res.getSuccess()+"-----"+res.getDataTable().length)
    //输出  成功过了11111~------true-----2
```

* Error 只需要返回失败提示消息时使用

```
    let res:OutDTO = OutDTO.Error("只返回失败提示消息~");
    console.error(res.getMsg()+"------"+res.getSuccess())
    //输出 只返回失败提示消息~------false
```

* ErrorByDataRow 需要返回失败提示消息并且附带单行数据时使用

```
    let p: Person = JSONUtil.parseObject<Person>('{"name":"测试名称","age":18,"birth":"2024-01-03" }', 'yyyy/MM/dd HH:mm:ss')
    let res: OutDTO = OutDTO.ErrorByDataRow<Person>("只返回失败提示消息~", p);
    console.error(res.getMsg() + "------" + res.getSuccess()+res.getDataRow())
    //输出  只返回失败提示消息~------false[object Object]
```

* getSuccess 获取成功失败标识

* setSuccess 设置成功失败标识

* getMsg 获取提示消息

* setMsg 设置提示消息

* getDataRow 获取单行数据

* setDataRow 设置单行数据

* getDataTable 获取多行数据

* setDataTable 设置多行数据

#### 2.StringBuilder的方法

* 1

```

```

#### 3.CacheUtil的方法

* save 存储指定类型的数据(必须指定类型T) 第一个入参为key,第二个入参为待存入数据

```
    //存入字符串<>中数据类型为必填
    CacheUtil.save<string>("str", "测试存入字符串");
    //存入对象T<>中数据类型为必填
    let person = new Person('测试', 12, new Date(), new User("uuid", "打撒吃的是草动次打次"));
    CacheUtil.save<Person>("tetObj", person);
    //存入对象集合<>中数据类型为必填
    let arrP = Array<Person>();
    arrP[0] = new Person('test1', 1, new Date(), new User("uuid1", "user测试内容1"));
    arrP[1] = new Person('test2', 2, new Date(), new User("uuid2", "user测试内容2"));
    arrP[2] = new Person('test3', 3, new Date(), new User("uuid3", "user测试内容3"));
    CacheUtil.save<Array<Person>>("arrPerson", arrP);
```

* get 根据key获取指定类型的数据(必须指定类型T),入参为存入时的key

```
    //获取字符串<>中数据类型为必填
    this.message = CacheUtil.get<string>("str");
    //获取对象T<>中数据类型为必填
    let p = CacheUtil.get<Person>("tetObj");
    this.message = p.name + p.age + p.user.id;
    //获取对象集合<>中数据类型为必填
    let newStr: string = '';
    let res = CacheUtil.get<Array<Person>>("arrPerson");
    res.forEach(item => {
      newStr += item.age + item.name + item.user.id + item.user.name;
    })
    this.message = newStr;
```

#### 4.GlobalContext的方法

* 1

```

```

#### 5.GlobalThis的方法

* 1

```

```

#### 6.ArrayUtil的方法

* append 将新元素添加到已有数组中 添加新元素会生成一个新的数组，不影响原数组

```
    let n = ArrayUtil.append(["1", "2", "3"], ["4"]);
    n.forEach(item => {
      console.error(item);
    })
    //输出  1 2 3 4
```

* setOrAppend 将元素值设置为数组的某个位置，当给定的index大于数组长度，则追加

```
    let arr = ArrayUtil.setOrAppend<string>(["1212", "3232", "5345", "645654", "64564564x"], 2, "你好");
    console.error(JSON.stringify(arr))
    //输出  ["1212","3232","你好","645654","64564564x"]
```

* replace 将新元素插入到到已有数组中的某个位置

```
    let arr2 = ArrayUtil.replace<string>(["1212", "3232", "5345", "645654", "64564564x"], 1, "halo");
    console.error(JSON.stringify(arr2))
    //输出  ["1212","halo","5345","645654","64564564x"]
```

* filter 通过传入的filter实现来过滤返回需要的元素内容

```
    let pArr: Array<Person> = JSONUtil.parseArray('[{"name":"测试名称1","age":18,"birth":"2023-01-01"},{"name":"测试名称3","age":3,"birth":"2021-11-01 12:12:12" },{"name":"测试名称4","age":34,"birth":"2023-01-01 12:12:12" },{"name":"测试名称2","age":23,"birth":"2021-01-01 12:12:12" }]', DateConst.YMD_HLINE_HMS);
    let flter = ArrayUtil.filter<Person>(pArr, (item: Person) => item.name.includes("4"));
    console.error(JSON.stringify(flter))
    //输出  [{"name":"测试名称4","age":34,"birth":"2023-01-01 12:12:12"}]
```

* reverse 反转数组，会变更原数组

```
    ArrayUtil.reverse<Person>(pArr);
    console.log(JSONUtil.toJSONString(pArr));
    //输出  [{"name":"测试名称4","age":23,"birth":"2021-01-01 12:12:12"},{"name":"测试名称3","age":34,"birth":"2023-01-01 12:12:12"},{"name":"测试名称2","age":3,"birth":"2021-11-01 12:12:12"},{"name":"测试名称1","age":18,"birth":"2023-01-01 00:00:00"}]
```

* min 根据传入的数值字符串日期数组取最小值

```
    console.error(ArrayUtil.min<number>([345, 5, 67, 899076, 3, 2, 143, 17, 65]) + "")
    //输出  2
```

* max 根据传入的数值字符串日期数组取最大值

```
    console.error(ArrayUtil.max<number>([345, 5, 67, 899076, 3, 2, 143, 17, 65]) + "")
    //输出  899076
```

* distinct 去重数组中的元素，去重后生成新的数组，原数组不变

```
    let nArr = ArrayUtil.distinct<string, string>(["你", "helo", "哇哈哈哈", "212121", "2222", "哇哈哈哈", "你"], item => item);
    console.error(JSONUtil.toJSONString(nArr));
    //输出  ["你","helo","哇哈哈哈","212121","2222"]
```

* remove 移除数组中predicate返回为真值的所有元素，并返回移除元素组成的数组

```
    const array = [1, 2, 3, 4, 5];
    const removed = ArrayUtil.remove(array, (value: number) => value % 2 === 0);
    console.log(JSONUtil.toJSONString(removed)); // [4,2]
    console.log(JSONUtil.toJSONString(array)); // [1, 3, 5]
```

* removeEmptyValues 去除集合中的空值

```
    console.error(JSONUtil.toJSONString(ArrayUtil.removeEmptyValues([1, "", "ssss", "", true])))  
    //输出  [1,"ssss",true]
```

* union 创建一个按顺序排列的唯一值的数组（注：arrays（数组）的并集，按顺序返回，返回数组的元素是唯一的）

```
    const arr1 = [1, 2, 3];
    const arr2 = [2, 3, 4];
    const arr3 = [3, 4, 5];
    const result = ArrayUtil.union(arr1, arr2, arr3);
    console.log(JSONUtil.toJSONString(result)); // 输出：[1, 2, 3, 4, 5]
```

* defaultIfEmpty 集合为空时传入默认集合

```
    let str: string[] = [];
    ArrayUtil.defaultIfEmpty(str, ["1", "32"]).forEach(item => {
      this.message += item + "、";
    })
    //输出 1、32
```

* isNotEmpty 集合是否为空集合，不空为true否则false

```
    let str: string[] = [];
    if (ArrayUtil.isNotEmpty(str)) {
      this.message = "不是空的";
    } else {
      this.message = "是空的"
    }
    //输出 是空的
```

* isEmpty 集合是否为空集合,空为true否则false

```
    let str: string[] = [];
    if (ArrayUtil.isEmpty(str)) {
      this.message = "是空的";
    } else {
      this.message = "不是空的"
    }
    //输出 是空的
```

* strValIsEmpty 集合中每个值都为空则返回true,否则返回false

```
    let str: string[] = ["", ""];
    if (ArrayUtil.strValIsEmpty(str)) {
      this.message = "是空的";
    } else {
      this.message = "不是空的"
    }
```

* strValIsNotEmpty 集合中只要有一个值不为空则返回true,否则返回false

```
    let str: string[] = ["1",""];
    if (ArrayUtil.strValIsNotEmpty(str)) {
      this.message = "不是空的";
    } else {
      this.message = "是空的"
    }
    //输出  不是空的
```

#### 7.Base64Util的方法

* encodeToStr 将Uint8Array转化为字符串-异步

```
    let a = await Base64Util.encodeToStr(new Uint8Array(buffer.from([12, 32, 54, 65, 74]).buffer));
```

* decode 将字符串转换为Uint8Array数组-异步

```
    let c = await Base64Util.decode(a);
```

* encodeToStrSync 将Uint8Array转化为字符串-同步

```
    let b = Base64Util.encodeToStrSync(new Uint8Array(buffer.from([12, 32, 54, 65, 74]).buffer));
```

* decodeSync 将字符串转换为Uint8Array数组-同步

```
    let d = Base64Util.decodeSync(b);
```

* encodeHexStr2base64 hex格式字符串转base64-同步(1.2.1-rc.1+)

```
    let d = Base64Util.encodeHexStr2base64(b);
```

#### 8.CharUtil的方法

* isEmoji 判断是否为emoji表情符

```
    console.error(CharUtil.isEmoji(38)+"")
    // 输出 true
```

* isAscii 判断字符是否为ascii码

```
    console.error(CharUtil.isAscii("你")+"")
    // 输出 false
```

#### 9.DateUtil的方法

* parse 将输入的日期字符串转换为Date日期类型

```
    console.error(DateUtil.parse("2023-01-01"))
    //输出  Sun Jan 01 2023 08:00:00 GMT+0800
```

* formatDate 将传入的日期字符串按照传入的format进行格式化输出,不传默认为yyyy-MM-dd,日期格式化年月日时分秒为y-M-d H:m:s

```
    console.error(DateUtil.formatDate("2023/1/1"))
    //输出  2023-01-01
    console.error(DateUtil.formatDate("2023/1/1",'yyyy-MM-dd HH:mm:ss'))
    //输出  2023-01-01 00:00:00
```

* format 将日期类型的Date根据传入的format格式化成日期字符串(format必传)

```
    console.error(DateUtil.format(new Date,'yyyy-MM-dd HH:mm:ss'))
    // 输出 2024-01-03 20:25:58
    console.error(DateUtil.format(new Date,'HH:mm:ss'))
    // 输出 20:27:06
```

* dateDiff 计算两个Date的日期差单位为天

```
    const difference = DateUtil.dateDiff(new Date('2023-01-01'), new Date('2023-01-10'));
    console.log(difference + ""); //输出 9
```

* strDateDiff 计算两个字符串日期的差单位为天

```
    const diff = DateUtil.strDateDiff('2023-11-01 12:12:12', '2024-01-10 12:12:12');
    console.log(diff + ""); //输出 70
```

#### 10.IdCardUtil的方法

* isValidCard18 严格校验18位身份证号是否正确,校验规则如下

```
   /**
   * 排列顺序从左至右依次为：六位数字地址码，八位数字出生日期码，三位数字顺序码和一位数字校验码。
   * 顺序码: 表示在同一地址码所标识的区域范围内，对同年、同月、同 日出生的人编定的顺序号，顺序码的奇数分配给男性，偶数分配 给女性。
   * <li>第1、2位数字表示：所在省份的代码</li>
   * <li>第3、4位数字表示：所在城市的代码</li>
   * <li>第5、6位数字表示：所在区县的代码</li>
   * <li>第7~14位数字表示：出生年、月、日</li>
   * <li>第15、16位数字表示：所在地的派出所的代码</li>
   * <li>第17位数字表示性别：奇数表示男性，偶数表示女性</li>
   * <li>第18位数字是校检码，用来检验身份证的正确性。校检码可以是0~9的数字，有时也用x表示</li>
   * 第十八位数字(校验码)的计算方法为：
   * <li>将前面的身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2</li>
   * <li>将这17位数字和系数相乘的结果相加</li>
   * <li>用加出来和除以11，看余数是多少</li>
   * <li>余数只可能有0 1 2 3 4 5 6 7 8 9 10这11个数字。其分别对应的最后一位身份证的号码为1 0 X 9 8 7 6 5 4 3 2</li>
   * <li>通过上面得知如果余数是2，就会在身份证的第18位数字上出现罗马数字的Ⅹ。如果余数是10，身份证的最后一位号码就是2</li>
   * @param idcard 待验证的身份证
   * @return 是否有效的18位身份证，忽略x的大小写
   */
    console.error(IdCardUtil.isValidCard18("781111199407190143").getMsg())
    //输出  省份代码不正确:78
```

* convert15To18 将15位身份证号码转换成18位

```
    console.error(IdCardUtil.convert15To18("420106640901234").getDataRow());
    //输出 420106194201062348
```

* isValidCard15 校验15位身份证号码是否正确

```
    console.error(IdCardUtil.isValidCard15("420106640901234").getMsg());
    //输出 身份证格式正确
```

* getProvinceCodeByIdCard 根据身份编号获取户籍省份编码，只支持15或18位身份证号码

```
    let province = IdCardUtil.getProvinceCodeByIdCard("142303111111111111");
    console.info(province.getSuccess() + "--" + province.getDataRow() + "--" + province.getMsg())
    //输出 true--140000--山西省
```

* getCityCodeByIdCard 根据身份编号获取地市级编码，只支持15或18位身份证号码

```
    let city = IdCardUtil.getCityCodeByIdCard("142303111111111111");
    console.info(city.getSuccess() + "--" + city.getDataRow() + "--" + city.getMsg())
    //输出 true--142300--吕梁地区
```

* getDistrictCodeByIdCard 根据身份编号获取区县级编码，只支持15或18位身份证号码

```
    let district = IdCardUtil.getDistrictCodeByIdCard("142303111111111111");
    console.info(district.getSuccess() + "--" + district.getDataRow() + "--" + district.getMsg())
    //输出 true--142303--汾阳市
```

#### 11.IdUtil的方法

* simpleUUID 生成32为UUID不带-

```
    console.error(IdUtil.simpleUUID())
    //输出   076bb3b9db6f4ecb885dbdbdd2c29080
```

* fastUUID 生成36为UUID带-

```
    console.error(IdUtil.fastUUID())
    //输出  628128FC-55CA-48B7-8EA0-5162848FDCEF
```

* fastSimpleUUID 生成32为UUID带-

```
    console.error(IdUtil.fastSimpleUUID())
    //输出  56703FA1-0BB-503-D93-00E94A28422
```

* randomUUID 生成36为UUID带-,小写

```
    console.error(IdUtil.randomUUID())
    //输出  600cddfb-1e88-4798-8987-bfb703be76ff
```

#### 12.Logger的方法

* init 初始化第一个入参为应用名,第二个为域可不填

```
    Logger.init('测试应用')   建议将该初始化方式写在EntryAbility.ets的onWindowStageCreate方法中
```

* debug debug级别日志【入参为两个字符串,第一个为提示消息,第二个为错误原因】绿色

```
    Logger.debug("debug错误原因为:", 'xxxxxxxxxxxx')
```

* info info级别日志【入参为两个字符串,第一个为提示消息,第二个为错误原因】黄色

```
    Logger.info("info错误原因为:", 'xxxxxxxxxxxx')
```

* warn warn级别日志【入参为两个字符串,第一个为提示消息,第二个为错误原因】 白色

```
    Logger.warn("warn错误原因为:", 'xxxxxxxxxxxx')
```

* error error级别日志【入参为两个字符串,第一个为提示消息,第二个为错误原因】 红色

```
    Logger.error("error错误原因为:", 'xxxxxxxxxxxx')
```

#### 13.ObjectUtil的方法

* equal 判断两个传入的数值或者是字符串是否相等

```
    console.error(ObjectUtil.equal("1", "1") + "")
    //输出 true
```

* notEqual 判断两个传入的数值或者是字符串是否不相等

```
    console.error(ObjectUtil.notEqual("1", "1") + "")
    //输出 false
```

#### 14.PhoneUtil的方法

* isMobile 验证是否为手机号码（中国）

```
    console.error(PhoneUtil.isMobile("17111114114").getMsg())
    // 输出 手机号为中国号码
```

* isMobileHk 验证是否为手机号码（香港）

```
    console.error(PhoneUtil.isMobileHk("111111").getMsg())
    // 输出 手机号非中国香港号码,请检查
```

* isMobileTw 验证是否为手机号码（台湾）

```
    console.error(PhoneUtil.isMobileTw("17111114114").getMsg())
    // 输出 手机号非中国台湾号码,请检查
```

* isMobileMo 验证是否为手机号码（澳门）

```
    console.error(PhoneUtil.isMobileMo("17111114114").getMsg())
    // 输出 手机号非中国澳门号码,请检查
```

* isTel 验证是否为座机号码（中国）

```
    console.error(PhoneUtil.isTel("17111114114").getMsg())
    // 输出 号码非中国座机,请检查
```

* isTel400800 验证是否为座机号码（中国）+ 400 + 800

```
    console.error(PhoneUtil.isTel400800("17111114114").getMsg())
    // 输出 号码非400800格式的座机,请检查
```

* isPhone 验证是否为座机号码+手机号码+ 400 + 800电话 + 手机号号码（香港）

```
    console.error(PhoneUtil.isPhone("17111114114").getMsg())
    // 输出 手机号为中国号码
```

#### 15.RandomUtil的方法

* randomStrBySize 根据传入的大小生成随机字符串

```
    RandomUtil.randomStrBySize(16);
```

* randomUnitBySize 根据传入的大小生成随机Uint8Array字节流

```
    RandomUtil.randomUnitBySize(16);
```

* generateIV 生成CBC模式的iv(1.2.1-rc.2+有变动)

```
   /**
   * 生成CBC模式的iv
   * @param resultCoding  返回结果的编码格式(utf8/hex/base64)-不传默认为base64
   * @returns iv字符串
   */
    let iv = await RandomUtil.generateIV();  //生成为base64格式
    let iv = await RandomUtil.generateIV('hex');  //生成为16进制hex格式
    let iv = await RandomUtil.generateIV('utf8');  //生成为16位普通字符串
```

* randomBoolean 随机生成一个布尔值

```
    console.error(RandomUtil.randomBoolean()+"")
    //输出  true/false
```

* randomChinese 随机生成一个汉字

```
    console.error(RandomUtil.randomChinese())
    //输出  趐
```

* randomNumber 获得指定范围内的随机数,包含最小值，不包含最大值

```
    console.error(RandomUtil.randomNumber(1000,10000)+"")
    //输出  3184
```

* randomInt 获得随机数number值

```
    console.error(RandomUtil.randomInt()+"")
    //输出  842905298955385
```

* randomLimit 获得指定范围内的随机数 [0,limit) 不包括limit

```
    console.error(RandomUtil.randomLimit(100)+"")
    //输出  54
```

#### 16.RegUtil的方法

* isMatch 给定内容是否匹配正则

```
    let res: OutDTO = RegUtil.isMatch(RegexConst.EMAIL, '111111');
    console.error(res.getSuccess() + "---" + res.getMsg());
    //输出 false---验证字符串格式不正确,请检查
```

* isEmailMatch 给定邮箱是否匹配正则

```
    let res: OutDTO = RegUtil.isEmailMatch('13191191111@163.com');
    console.error(res.getSuccess() + "---" + res.getMsg());
    //输出  true---邮箱格式正确
```

* isMobileMatch 给定手机号是否匹配正则

```
    let res: OutDTO = RegUtil.isMobileMatch('21212');
    console.error(res.getSuccess() + "---" + res.getMsg());
    //输出  false---手机号码格式不正确,请检查
```

* isIdCardMatch 给定身份证号是否匹配正则

```
    let res: OutDTO = RegUtil.isIdCardMatch('21212');
    console.error(res.getSuccess() + "---" + res.getMsg());
    //输出  false---身份证号格式不正确,请检查
```

#### 17.StrUtil的方法

* isBlank 判断字符串是否为空白符(空白符包括空格、制表符、全角空格和不间断空格)true为空，否则false

```
    console.error(StrUtil.isBlank(' ')+"")
    //输出  true
```

* asString 将传入的值转换为字符串类型

```
    const obj:Record<string,string> = {'key': 'this is value'} // key的值类型为 string | undefined
    const test = StrUtil.asString(obj)
```

* isBlankIfStr 判断传入的对象是否是空格

```
    const a = StrUtil.isBlankIfStr(obj);
```

* isEmptyIfStr 判断传入的对象是否是空

```
    const a = StrUtil.isEmptyIfStr(obj);
```

* isNotBlank 判断字符串是否为非空白符(空白符包括空格、制表符、全角空格和不间断空格)true为非空，否则false

```
    console.error(StrUtil.isNotBlank('222')+"")
    //输出  true
```

* trim 去除传入集合的每个值的前后空格

```
    console.error(StrUtil.trim([" 你好 "," hi","hello "]).join("----"))
    //输出 你好----hi----hello
```

* hasBlank 判断传入的字符串中是否包含有空值,只要有一个则返回true,否则false

```
    console.error(StrUtil.hasBlank("","232323")+"")
    //输出  true
```

* isEmpty 判断传入的字符串是否为空,空白符判断为非空

```
    console.error(StrUtil.isEmpty(' ')+"")
    //输出  false
```

* camelCase 将字符串转换为驼峰

```
    console.error(StrUtil.camelCase("Foo Bar"))  //输出 fooBar
    console.error(StrUtil.camelCase("--foo-bar--"))  //输出 fooBar
    console.error(StrUtil.camelCase("__FOO_BAR__"))  //输出 fooBar
```

* capitalize 转换字符串首字母为大写，剩下为小写

```
     console.error(StrUtil.capitalize("FooBar"))  //输出  Foobar
```

* endsWith 检查字符串是否以给定的字符串结尾

```
    console.error(StrUtil.endsWith('abc', 'b', 2) + "")  //输出  true
```

* repeat 重复 N 次给定字符串

```
    console.error(StrUtil.repeat("*", 5))  //输出  *****
```

* replace 替换字符串中匹配的正则为给定的字符串

```
    const str = 'Hello, World';
    console.log(StrUtil.replace(str, 'Hello', 'Hi')); // 输出：'Hi, World'
    console.log(StrUtil.replace(str, /world/i, 'Universe')); // 输出：'Hello, Universe'
    console.log(StrUtil.replace(str, /[aeiou]/ig, 'X')); // 输出：'HXllX, WXXld'
```

* startsWith 检查字符串是否以给定的字符串卡头

```
    const str = 'Hello, World';
    console.log(StrUtil.startsWith(str, 'Hello') + ""); // 输出：true
    console.log(StrUtil.startsWith(str, 'World') + ""); // 输出：false
    console.log(StrUtil.startsWith(str, 'Hello', 7) + ""); // 输出：false
    console.log(StrUtil.startsWith(str, 'World', 7) + ""); // 输出：true
```

* toLower 转换整个字符串的字符为小写

```
    console.error(StrUtil.toLower('--Foo-Bar--')); //--foo-bar--
```

* toUpper 转换整个字符串的字符为大写

```
    console.error(StrUtil.toUpper('--Foo-Bar--')); //--FOO-BAR--
```

* truncate 截断字符串，如果字符串超出了限定的最大值。 被截断的字符串后面会以 omission 代替，omission 默认是 "..."

```
    const str = 'Hello, World';
    console.log(StrUtil.truncate(str)); // 输出：'Hello, World'
    console.log(StrUtil.truncate(str, { length: 5 })); // 输出：'Hello...'
    console.log(StrUtil.truncate(str, { length: 10, omission: '***' })); // 输出：'Hello, Wo***'
    console.log(StrUtil.truncate(str, { separator: ',' })); // 输出：'Hello, World'

    const longStr = 'This is a very long string that needs to be truncated';
    console.log(StrUtil.truncate(longStr, { length: 10 })); // 输出：'This is a ....'
    console.log(StrUtil.truncate(longStr, { length: 10, separator: ' ' })); // 输出：'This is a very...'
```

## [eftool](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Feftool)工具类ohpm地址

## star `ef_core` 希望您可以动一动小手点点小⭐⭐

## 👴希望大家如有好的需求踊跃提交,如有问题请前往gitee提交issue，我闲暇时间会扩充与修复优化