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
| IdUtil     | 提供生成ID的一系列方法                |
| JSONUtil   | 提供对于json对象集合跟json字符串的系列转换方法 |
| ObjectUtil | 提供对于对象的系列操作方法               |
| RandomUtil | 提供随机数的系列操作                  |
| RegUtil    | 提供对于常用正则表达式的方法              |
| StrUtil    | 提供对于字符串的操作方法                |
| RegexConst | 提供常用的正则表达式                  |
| DateConst  | 提供常用的日期格式化表达式               |
| PageUtil   | 提供常用的分页操作                   |
| PhoneUtil  | 提供常用的手机座机等判断                |
| OutDTO     | 提供常用的返回实体对象                 |

-------------------------------------------------------------------------------

## 📦安装

### 🍊ohpm

执行安装命令

```
ohpm i @yunkss/eftool
```

## 📦使用

### 1.在项目中引入插件

```
import { ArrayUtil, CharUtil, StrUtil, RandomUtil,DateUtil,JSONUtil,RegUtil,RegexConst,OutDTO } from '@yunkss/eftool'
```

工具类按需引入,使用那个引入那个

### 2.ArrayUtil的方法

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

* append 将新元素添加到已有数组中 添加新元素会生成一个新的数组，不影响原数组

```
    let n = ArrayUtil.append(["1", "2", "3"], ["4"]);
    n.forEach(item => {
      console.error(item);
    })
    //输出  1 2 3 4
```

### 3.DateUtil的方法

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

### 5.RegUtil的方法

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

### 6.StrUtil的方法

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

### 7.IdUtil的方法

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

### 8.RandomUtil的方法

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

### 9.IdCardUtil的方法

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

### 10.ObjectUtil的方法

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

### 11.OutDTO的方法

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

### 12.PageUtil的方法

* 该对象有四个私有成员变量

```
  //当前页数
  private pageNumber: number = 1;
  //每页记录数
  private pageSize: number = 20;
  //总页数
  private total: number;
  //当前页数据
  private list?: Array<T>;
```

### 13.PhoneUtil的方法

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

## ⭐Star efTool 希望您可以动一动小手点点小⭐

## 👴封装思路来源于Java的工具类HuTool,希望大家如有好的需求踊跃提交，我闲暇时间会扩充