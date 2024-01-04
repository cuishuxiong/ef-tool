# <center>efTool</center>

-------------------------------------------------------------------------------

## 📚简介

`efTool`是一个功能丰富且易用的**OpenHarmony工具库**，通过诸多实用工具类的使用，旨在帮助开发者快速、便捷地完成各类开发任务。
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

一个OpenHarmony基础工具类，组成各种Util工具类，同时提供以下组件：

| 模块         | 介绍                          |
|------------|-----------------------------|
| ArrayUtil  | 提供对集合的一些常用的判断               |
| DateUtil   | 提供对日期的一系列封装                 |
| IdCardUtil | 提供对身份证校验系列方法(暂未开发)          |
| IdUtil     | 提供生成ID的一系列方法                |
| JSONUtil   | 提供对于json对象集合跟json字符串的系列转换方法 |
| ObjectUtil | 提供对于对象的系列操作方法(暂未开发)         |
| RandomUtil | 提供随机数的系列操作(暂未开发)            |
| RegUtil    | 提供对于常用正则表达式的方法              |
| StrUtil    | 提供对于字符串的操作方法                |
| RegexConst | 提供常用的正则表达式                  |
| DateConst  | 提供常用的日期格式化表达式               |
| OutDTO     | 提供常用的返回实体对象                 |

-------------------------------------------------------------------------------

## 📦安装

### 🍊ohpm

在项目model中的oh-package.json5的dependencies中加入以下内容:

```
"dependencies": {
    "@yunkss/efTool":'^1.0.0'
 }
```

执行安装命令

```
ohpm install
```

## 📦使用

1.在项目中引入插件

```
import { ArrayUtil, CharUtil, StrUtil, RandomUtil,DateUtil,JSONUtil,RegUtil,RegexConst,OutDTO } from '@yunkss/efTool'
```

工具类按需引入,使用那个引入那个

2.ArrayUtil的方法

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

4.DateUtil的方法

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

5.JSONUtil的方法

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

6.RegUtil的方法

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

8.StrUtil的方法

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

9.IdUtil的方法

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

10.OutDTO的方法

* 该对象有四个私有成员变量
  //成功失败标识
  private success: boolean;
  //返回提示信息
  private msg: string;
  //返回单行数据
  private dataRow?: T;
  //返回数据集合
  private dataTable?: Array<T>;

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

## ⭐Star efTool 希望您可以动一动小手点点小⭐

## 👴封装思路来源于Java的工具类HuTool,希望大家如有好的需求踊跃提交，我闲暇时间会扩充
