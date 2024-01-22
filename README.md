# <center>efTool</center>

-------------------------------------------------------------------------------

## 📚简介

`efTool`是一个功能丰富且易用的**OpenHarmony/HarmonyOS工具库**，通过诸多实用工具类的使用，旨在帮助开发者快速、便捷地完成各类开发任务。
这些封装的工具涵盖了字符串、数字、集合、JSON等一系列操作，
可以满足各种不同的开发需求。本人为Java开发,故封装思路借鉴Java的工具类Hutool扩展。

### 🎁efTool名称的由来

efTool = Efficient + Tool，Efficient是高效的表示，Tool表示工具。

### 🍺efTool理念

`efTool`既是一个工具集，也是一个知识库，我从不自诩代码原创，大多数工具类都是**搬运**而来，因此：

- 你可以引入使用，也可以**拷贝**和修改使用，而**不必标注任何信息**，只是希望能把bug及时反馈回来。
- 我努力健全**中文**注释，为源码学习者提供良好地学习环境，争取做到人人都能看得懂。

-------------------------------------------------------------------------------

## 🛠️包含组件

一个OpenHarmony/HarmonyOS基础工具类，组成各种Util工具类，同时提供以下组件：

| 模块         | 介绍                          |
|------------|-----------------------------|
| ArrayUtil  | 提供对集合的一些常用的判断               |
| DateUtil   | 提供对日期的一系列封装                 |
| IdCardUtil | 提供对身份证校验系列方法                |
| RSA        | 提供生成密钥加解密验签等系列方法            |
| IdUtil     | 提供生成ID的一系列方法                |
| JSONUtil   | 提供对于json对象集合跟json字符串的系列转换方法 |
| ObjectUtil | 提供对于对象的系列操作方法               |
| RandomUtil | 提供随机数的系列操作                  |
| RegUtil    | 提供对于常用正则表达式的方法              |
| StrUtil    | 提供对于字符串的操作方法                |
| RegexConst | 提供常用的正则表达式                  |
| DateConst  | 提供常用的日期格式化表达式               |
| PageUtil   | 提供常用的纯前端分页操作                |
| PhoneUtil  | 提供常用的手机座机等判断                |
| OutDTO     | 提供常用的返回实体对象                 |
| PageQuery  | 提供常用的后端获取分页数据操作             |
| CharUtil   | 提供常用的字符操作                   |

-------------------------------------------------------------------------------

## 📦安装

### 🍊ohpm

执行安装命令

```
ohpm install @yunkss/eftool
```

## 📦使用

### 1.在项目中引入插件

```
import { ArrayUtil, CharUtil, StrUtil, RandomUtil,DateUtil,JSONUtil,RegUtil,RegexConst,OutDTO } from '@yunkss/eftool'
```

工具类按需引入,使用那个引入那个

### 2.IdCardUtil的方法

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

### 3.RSA的方法【返回结果均为OutDTO对象】

* generateRsaKey 生成AES的非对称密钥

```
    const keyPair = await RSA.generateRsaKey();
    console.error("generateRsaKey结果:" + keyPair.getSuccess() + "---" + keyPair.getMsg()
    + "\n" + "公钥:" + keyPair.getDataRow().publicKey + "私钥:" + keyPair.getDataRow().privateKey)
```

* encode 加密

```
    const encode = await RSA.encode('this is csx RSA!', keyPair.getDataRow().publicKey);
    console.error("encode结果:" + encode.getSuccess() + "---" + encode.getMsg() + "---加密字符串:" + encode.getDataRow());
```

* decode 解密

```
    const decode = await RSA.decode(encode.getDataRow(), keyPair.getDataRow().privateKey);
    console.error("decode结果:" + decode.getSuccess() + "---" + decode.getMsg() + "---解密字符串:" + decode.getDataRow());
```

* sign 签名

```
    const sign = await RSA.sign('this is csx RSA', keyPair.getDataRow().privateKey);
    console.error("sign结果:" + sign.getSuccess() + "---" + sign.getMsg() + "---签名字符串:" + sign.getDataRow());
```

* verify 验签

```
    const result = await RSA.verify(sign.getDataRow(), 'this is csx RSA', keyPair.getDataRow().publicKey);
    console.error("verify结果:" + result.getSuccess() + "---" + result.getMsg());
```

### 4.JSONUtil的方法

* toJSONString 将传入的json对象格式化成json字符串

```
    let p: Person = JSONUtil.parseObject<Person>('{"name":"测试名称","age":18,"birth":"2024-01-03" }', 'yyyy-MM-dd HH:mm:ss')
    console.error(JSONUtil.toJSONString(p))
    //输出  {"name":"测试名称","age":18,"birth":"2024-01-03 00:00:00"}
```

* parse 将传入的json字符串格式化为Object对象

```
    JSONUtil.parse('{"name":"测试名称","age":18,"birth":"2024-01-03" }')
```

* parseObject 将传入的json字符串格式化为指定的实体对象,如果实体中有日期类型可以传入格式化format,不传默认为yyyy-MM-dd

```
    let p: Person = JSONUtil.parseObject<Person>('{"name":"测试名称","age":18,"birth":"2024-01-03" }', 'yyyy-MM-dd HH:mm:ss')
    console.error(p.name+":"+p.birth)
    //输出  测试名称:2024-01-03 00:00:00
```

* parseArray 将传入的json字符串格式化为指定的实体对象集合，如果实体中有日期类型可以传入格式化format,不传默认为yyyy-MM-dd

```
    let pArr: Array<Person> = JSONUtil.parseArray('[{"name":"测试名称1","age":18,"birth":"2023-01-01"},{"name":"测试名称2","age":23,"birth":"2021-01-01 12:12:12" }]',DateConst.YMD_HLINE_HMS) ;
    pArr.forEach(item => {
      console.error(item.name + "---" + item.birth);
    })
    //输出
    //测试名称1---2023-01-01 00:00:00
    //测试名称2---2021-01-01 12:12:12

```

### 5.OutDTO的方法

* 该对象有四个私有成员变量

```
  //成功失败标识
  private success: boolean;
  //返回提示信息
  private msg: string;
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
    let res: OutDTO<Person> = OutDTO.OKByDataRow('成功过了~', p);
    console.error(res.getMsg() + "------" + res.getSuccess()+"-----"+res.getDataRow())
    //输出   成功过了~------true-----[object Object]
```

* OKByDataTable 需要返回成功提示消息并且附带多行数据时使用

```
    let pArr: Array<Person> = JSONUtil.parseArray('[{"name":"测试名称1","age":18,"birth":"2023-01-01"},{"name":"测试名称2","age":23,"birth":"2021-01-01 12:12:12" }]', DateConst.YMD_HLINE_HMS);
    let res = OutDTO.OKByDataTable('成功过了11111~', pArr);
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
    let res: OutDTO = OutDTO.ErrorByDataRow("只返回失败提示消息~", p);
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

### 6.PageUtil的方法

* 该对象有如下私有成员变量

```
  //当前页数
  private pageNumber: number = 1;
  //每页记录数
  private pageSize: number = 20;
  //总记录数
  private total: number;
  //总页数
  private pages: number;
  //当前页数据
  private list?: Array<T>;
  //当前页记录集合
  private records?: Array<T>;
```

* packPageInfo 包装分页对象

```
    let page: PageUtil = PageUtil.packPageInfo(后台获取的全量数据);
```

* getPrePage 获取上一页页码

```
     const prePage:number = page.getPrePage();
```

* getNextPage 获取下一页页码

```
    const nextPage:number = page.getNextPage();
```

* getLastPage 获取最后一页页码

```
    const lastPage:number = page.getLastPage();
```

* isFirstPage 是否第一页

```
    const isFirstPage:boolean = page.isFirstPage();
```

* isLastPage 是否最后一页

```
    const isLastPage:boolean = page.isLastPage();
```

* hasPreviousPage 是否有上一页

```
    const hasPreviousPage:boolean = page.hasPreviousPage();
```

* hasNextPage 是否有下一页

```
    const hasNextPage:boolean = page.hasNextPage();
```

* getRecords 获取当前页记录数

```
    const records:Array<T> = page.getRecords();
```

### 7.ArrayUtil的方法

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

* clone 克隆数组(深拷贝)

```
    let source = ["哈哈哈哈哈", 1212, true, new Person("测试", 12, new Date()), "64564564x"];
    let arr3 = ArrayUtil.clone(source);
    console.error(JSON.stringify(arr3))
    //输出  ["哈哈哈哈哈",1212,true,{"birth":"2024-01-11T12:49:44.517Z","name":"测试","age":12},"64564564x"]
```

* deepClone 深拷贝对象T

```
    let person = new Person("测试", 12, new Date());
    let p = ArrayUtil.deepClone<Person>(person);
    console.error(JSON.stringify(p));
    //输出  {"birth":"2024-01-11T12:49:44.517Z","name":"测试","age":12}
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

* zip 创建一个分组元素的数组，数组的第一个元素包含所有给定数组的第一个元素，数组的第二个元素包含所有给定数组的第二个元素，以此类推

```
    const arr11 = [1, 2, 3];
    const arr22 = ['a', 'b', 'c'];
    const arr33 = [true, false, 'd'];
    const result1 = ArrayUtil.zip(arr11, arr22, arr33);
    console.log(JSONUtil.toJSONString(result1)); 
    // 输出：[[1,"a",true],[2,"b",false],[3,"c","d"]]
```

* unzip 这个方法类似于zip除了它接收分组元素的数组，并且创建一个数组，分组元素到打包前的结构(
  返回数组的第一个元素包含所有的输入数组的第一元素，第一个元素包含了所有的输入数组的第二元素，依此类推)

```
    const qwe = ArrayUtil.unzip(result1);
    console.error(JSONUtil.toJSONString(qwe)) 
    //输出[[1,2,3],["a","b","c"],[true,false,"d"]]
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

### 8.DateUtil的方法

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

### 9.RegUtil的方法

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

### 10.StrUtil的方法

* isBlank 判断字符串是否为空白符(空白符包括空格、制表符、全角空格和不间断空格)true为空，否则false

```
    console.error(StrUtil.isBlank(' ')+"")
    //输出  true
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

### 11.IdUtil的方法

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

### 12.RandomUtil的方法

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

### 13.ObjectUtil的方法

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

### 14.PhoneUtil的方法

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

### 15.PageQuery的方法

```
    有如下私有属性
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
```

* queryData 查询分页数据 传入一个返回类型为Promise<PageResult<T>>)且入参类型为(currentPage: number, pageSize: number)
  的Function

```
    const queryFunction = async (currentPage: number, pageSize: number): Promise<PageResult<Person>> => {
      const total = 100; // 假设总记录数为 100
      const records: Person[] = [];
      // 模拟循环请求，每次请求返回 pageSize 条记录
      for (let i = 0; i < pageSize; i++) {
        const id = (currentPage - 1) * pageSize + i + 1;
        const person: Person = {
          name: `person${id}`,
          birth: new Date(),
          age: id
        };
        records.push(person);
      }
      return {
        total: total,
        records: records,
      };
    };
```

* totalPage 获取总记录数

* hasNext 是否有下一页

* hasPrev 是否有上一个页

* nextPage 下一页页码

* prevPage 上一页码

* getRecords 获取记录数

* goToPage 跳转到指定页码

```
     //完整示例如下
     //传入当前页数和每页记录数,默认是1,10
     const pageQuery = new PageQuery<Person>(2, 20);
     // 定义自己的 queryFunction
     const queryFunction = async (currentPage: number, pageSize: number): Promise<PageResult<Person>> => {
       const total = 100; // 假设总记录数为 100
       const records: Person[] = [];
       // 模拟循环请求，每次请求返回 pageSize 条记录
       for (let i = 0; i < pageSize; i++) {
         const id = (currentPage - 1) * pageSize + i + 1;
         const person: Person = {
           name: `person${id}`,
           birth: new Date(),
           age: id
         };
         records.push(person);
       }
       return {
         total: total,
         records: records,
       };
     };
     // 调用查询接口
     await pageQuery.queryData(queryFunction);
     //获取到记录数
     pageQuery.getRecords().forEach(item => {
       console.error(item.name + "--" + item.age + "---" + item.birth)
     })
     //上一页
     console.error(pageQuery.prevPage() + "");
     //请求上一页数据
     await pageQuery.queryData(queryFunction);
     pageQuery.getRecords().forEach(item => {
       console.error(item.name + "--" + item.age + "---" + item.birth)
     })
     //跳转到指定页码
     await pageQuery.goToPage(4, queryFunction);
     //获取数据
     pageQuery.getRecords().forEach(item => {
       console.error(item.name + "-|-" + item.age + "-|-" + item.birth)
     })

```

### 16.CharUtil的方法

* isEmoji 判断是否为emoji表情符

```
    console.error(CharUtil.isEmoji(38)+"")
    // 输出 true
```

* isAscii isAscii

```
    console.error(CharUtil.isAscii("你")+"")
    // 输出 false
```

## ⭐Star efTool 希望您可以动一动小手点点小⭐

## 👴封装思路来源于Java的工具类HuTool,希望大家如有好的需求踊跃提交，我闲暇时间会扩充