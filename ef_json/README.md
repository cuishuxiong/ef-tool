# <center>ef_json</center>

# <center>V1.0.3(API12)</center>

--------------------------------------------------------------------------------

## 📚简介

`ef_json`是`eftool`的json相关包.提供了json字符串、json数组等操作

> 你可以引入使用，也可以**拷贝**和修改使用，如需分享扩展
> ### **希望可以注明原出处即可**
> 也希望能把bug及时反馈回来。

> 我努力健全**中文**注释，为源码学习者提供良好地学习环境，争取做到人人都能看得懂。

## 🛠️包含组件

| 模块            | 介绍                        |
|---------------|---------------------------|
| JSONArray     | 提供类Java的JSON数组的系列方法以及相互转换 |
| JSONArrayList | 提供类Java的JSON数组的系列方法以及相互转换 |
| JSONObject    | 提供类Java的JSON对象的系列方法以及相互转换 |
| JSONUtil      | 提供JSON转换一系列判断方法           |
| JSONValue     | 提供eftool中的JSON相关对象的类型定义   |

## 📦安装

### 🍊ohpm

* 执行安装命令

```
ohpm install @yunkss/ef_json
```

* 特殊说明

> ef_json依赖于ef_core,故将依赖引入为dependencies方式,即开发者在使用ef_json时无需自行引入ef_core,ef_json会自动下载对应依赖版本

## 📦使用

### 1.在项目中引入插件

```
import { JSONArray, JSONObject,xxxx} from '@yunkss/ef_json'
```

类按需引入,项目需要使用那个就引入

### 2.ef_json使用API

#### 1.JSONValue的解释

* 定义了JSON相关类的value的取值范围

#### 2.JSONObject的方法

* parse json字符串转换为JSONObject对象

```
    let userList = new Array<User>();
    userList.push(new User('2345', '测试用户1'));
    userList.push(new User('7844', '测试用户2'));
    let person = new Person('测试', 12, true, new Date(), new User("uuid", "打撒吃的是草动次打次"), userList);
    let j = JSONObject.toJSONString(person);
    let f = JSONObject.parse(j);
```

* parseObject json字符串转换为实体对象

```
    let userList = new Array<User>();
    userList.push(new User('2345', '测试用户1'));
    userList.push(new User('7844', '测试用户2'));
    let person = new Person('测试', 12, true, new Date(), new User("uuid", "打撒吃的是草动次打次"), userList);
    let j = JSONObject.toJSONString(person);
    let o = JSONObject.parseObject<Person>(j);
```

* toJSONString Object对象换为json字符串

```
    let userList = new Array<User>();
    userList.push(new User('2345', '测试用户1'));
    userList.push(new User('7844', '测试用户2'));
    let person = new Person('测试', 12, true, new Date(), new User("uuid", "打撒吃的是草动次打次"), userList);
    let j = JSONObject.toJSONString(person);
```

* from 实体对象转换为JSONObject对象

```
    let userList = new Array<User>();
    userList.push(new User('2345', '测试用户1'));
    userList.push(new User('7844', '测试用户2'));
    let person = new Person('测试', 12, true, new Date(), new User("uuid", "打撒吃的是草动次打次"), userList);
    let j = JSONObject.from<Person>(person);
```

* toString 将本对象转换成json字符串

```
    let jsonObj = new JSONObject();
    jsonObj.set("id", "100010");
    jsonObj.set("age", 27);
    jsonObj.set("sex", true);
    jsonObj.set("birth", new Date());
    let user = new JSONObject();
    user.set("uid", "121212");
    user.set("uName", "测试\\\"套对象");
    jsonObj.set("user", user);
    jsonObj.set("test", null);
    jsonObj.set("person", new User('实体id', '实体name'));
    jsonObj.set("name", "test字符串");
    let st = jsonObj.toString();
```

#### 3.JSONArray的方法

* parse json字符串转换为JSONArray对象

```
    let userList = new Array<User>();
    userList.push(new User('2345', '测试用户1'));
    userList.push(new User('7844', '测试用户2'));
    userList.push(new User('1314', '测试用户3'));
    userList.push(new User('5210', '测试用户4'));
    let s = JSONArray.toJSONString(userList);
    let jsArr = JSONArray.parse(s);
```

* toJSONString 集合对象转换为json字符串

```
    let userList = new Array<User>();
    userList.push(new User('2345', '测试用户1'));
    userList.push(new User('7844', '测试用户2'));
    userList.push(new User('1314', '测试用户3'));
    userList.push(new User('5210', '测试用户4'));
    let s = JSONArray.toJSONString(userList);
```

* from 实体集合转换为JSONArray对象

```
    let userList = new Array<User>();
    userList.push(new User('2345', '测试用户1'));
    userList.push(new User('7844', '测试用户2'));
    userList.push(new User('1314', '测试用户3'));
    userList.push(new User('5210', '测试用户4'));
    let jarr = JSONArray.from(userList);
```

* toString 将本对象转换成json字符串

```
    let arr = new JSONArray();
    arr.push(1);
    arr.push("cccc");
    arr.push("123");
    arr.push("aaaaa\\\"34343434");
    arr.push("2223\"dasdass");
    arr.push(new Date());
    arr.push(true);
    arr.push(null);
    arr.push(new User("10010", "实体数据"));
    let str = arr.toString();
```

* parseArray json字符串转换为实体对象集合

```
    class TestDDD {
      threeMonthRate?: string;
      moduleName?: string;
      productName?: string;
      marketPatter?: string;
      labelListJson?: site;
    }
    class site {
      site1?: site1;
    }
    class site1 {
      labelType?: string;
      labelValue?: string;
      labelName?: string;
      labelLocation?: string;
    }
    let str1 = '[{"threeMonthRate":null,"moduleName":"loan","productName":"网E贷","marketPatter":"随借随还，最高20万，利率低至8折起","labelListJson":{"site1":{"labelType":0,"labelValue":"网E贷","labelName":"产品名称:123","labelLocation":true}}},{"threeMonthRate":null,"moduleName":"loan","productName":"烟草贷","marketPatter":"无需抵押，无需担保，当天放款，随借随还","labelListJson":{"site1":{"labelType":12,"labelValue":"烟草贷","labelName":"产品名称","labelLocation":false}}}]';
    let array = JSONArray.parseArray<TestDDD>(str1);
    array.forEach(item => {
      this.msg += item.labelListJson?.site1?.labelName + " ";
    })
```

#### 4.JSONArrayList的方法

* parse json字符串转换为JSONArrayList对象

```
    let userList = new ArrayList<User>();
    userList.add(new User('2345', '测试用户1'));
    userList.add(new User('7844', '测试用户2'));
    userList.add(new User('1314', '测试用户3'));
    userList.add(new User('5210', '测试用户4'));
    let s = JSONArrayList.toJSONString(userList);
    let jsArr = JSONArrayList.parse(s);
```

* toJSONString 集合对象转换为json字符串

```
    let userList = new ArrayList<User>();
    userList.add(new User('2345', '测试用户1'));
    userList.add(new User('7844', '测试用户2'));
    userList.add(new User('1314', '测试用户3'));
    userList.add(new User('5210', '测试用户4'));
    let s = JSONArrayList.toJSONString(userList);
```

* from 实体集合转换为JSONArrayList对象

```
    let userList = new ArrayList<User>();
    userList.add(new User('2345', '测试用户1'));
    userList.add(new User('7844', '测试用户2'));
    userList.add(new User('1314', '测试用户3'));
    userList.add(new User('5210', '测试用户4'));
    let jarr = JSONArrayList.from(userList);
```

* toString 将本对象转换成json字符串

```
    let arr = new JSONArrayList();
    arr.add(1);
    arr.add("cccc");
    arr.add("123");
    arr.add("aaaaa\\\"34343434");
    arr.add("2223\"dasdass");
    arr.add(new Date());
    arr.add(true);
    arr.add(null);
    arr.add(new User("10010", "实体数据"));
    let str = arr.toString();
```

* parseArrayList json字符串转换为实体对象集合

```
    class TestDDD {
      threeMonthRate?: string;
      moduleName?: string;
      productName?: string;
      marketPatter?: string;
      labelListJson?: site;
    }
    class site {
      site1?: site1;
    }
    class site1 {
      labelType?: string;
      labelValue?: string;
      labelName?: string;
      labelLocation?: string;
    }
    let str1 = '[{"threeMonthRate":null,"moduleName":"loan","productName":"网E贷","marketPatter":"随借随还，最高20万，利率低至8折起","labelListJson":{"site1":{"labelType":0,"labelValue":"网E贷","labelName":"产品名称:123","labelLocation":true}}},{"threeMonthRate":null,"moduleName":"loan","productName":"烟草贷","marketPatter":"无需抵押，无需担保，当天放款，随借随还","labelListJson":{"site1":{"labelType":12,"labelValue":"烟草贷","labelName":"产品名称","labelLocation":false}}}]';
    let array = JSONArrayList.parseArrayList<TestDDD>(str1);
    array.forEach(item => {
      this.msg += item.labelListJson?.site1?.labelName + " ";
    })
```

#### 5.JSONUtil的方法

* <s>toJSONString
  将传入的json对象格式化成json字符串,第二个参数为如果数据有日期类型时是否传入转换格式,不传默认为yyyy-MM-dd</s>

```
    let userList = new Array<User>();
    userList.push(new User('2345', '测试用户1'));
    userList.push(new User('7844', '测试用户2'));
    let person = new Person('测试', 12, true, new Date(), new User("uuid", "打撒吃的是草动次打次"), userList);
    //第二个参数为如果数据有日期类型时是否传入转换格式,不传默认为yyyy-MM-dd
    let str1 = JSONUtil.toJSONString(person,DateConst.YMD_HLINE_HMS);
```

* <s>parse 将传入的json字符串格式化为Object对象</s>

```
    let person = new Person('测试', 12, new Date(), new User("101291021", "打撒吃的是草动次打次"));
    let str = JSONUtil.toJSONString(person);
    console.log(str)
    JSONUtil.parse(str);
```

* <s>parseObject
  将传入的json字符串格式化为指定的实体对象,如果实体中有日期类型可以传入格式化format,不传默认为yyyy-MM-dd</s>

```
    let userList = new Array<User>();
    userList.push(new User('2345', '测试用户1'));
    userList.push(new User('7844', '测试用户2'));
    let person = new Person('测试', 12, true, new Date(), new User("uuid", "打撒吃的是草动次打次"), userList);
    //第二个参数为如果数据有日期类型时是否传入转换格式,不传默认为yyyy-MM-dd
    let str1 = JSONUtil.toJSONString(person,DateConst.YMD_HLINE_HMS);
    let p = JSONUtil.parseObject<Person>(str1,DateConst.YMD_HLINE_HMS);
```

* <s>parseArray
  将传入的json字符串格式化为指定的实体对象集合,如果实体中有日期类型可以传入格式化format,不传默认为yyyy-MM-dd</s>

```
     let listStr = JSONUtil.toJSONString(userList);
     let uList = JSONUtil.parseArray<User>(listStr);
     uList.forEach(item => {
       Logger.error(item.id, item.name);
     })
```

* parseStringArray 将字符串格式Array转换成Array数组

* isBoolean 判断传入的字符串是否是布尔类型

* isJSONStringArray 判断是否是字符串格式Array

* isJSONString 判断是否是字符串格式json

* isNumber 是否是字符串

## [eftool](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Feftool)工具类ohpm地址

## star `ef_core` 希望您可以动一动小手点点小⭐⭐

## 👴希望大家如有好的需求踊跃提交,如有问题请前往gitee提交issue，我闲暇时间会扩充与修复优化