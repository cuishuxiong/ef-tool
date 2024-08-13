# <center>eftool</center>

# <center>V1.2.3(API12)</center>

--------------------------------------------------------------------------------

## 📚简介

`efTool`是一个功能丰富且易用的`兼容API12`的**HarmonyOS工具库**，通过诸多实用工具类的使用，旨在帮助开发者快速、便捷地完成各类开发任务。
这些封装的工具涵盖了字符串、数字、集合、JSON等一系列操作，
可以满足各种不同的开发需求。本人为Java开发,故封装思路借鉴Java的工具类Hutool，同时扩展了HarmonyOS的UI组件。

> ### <span style='color:red;'> 近期发现有三方库引用eftool的源码但未注明出处,我很欢迎大家进行二次开发以及共建鸿蒙生态，还请大家在引用时注明出处，万分感谢</span>

## 📚后续规划【重点】

> ### `eftool` 自发布到目前已有8个多月,历经3次API版本更新,发布30+版本,从岌岌无名到现在深受大家喜爱,倍感荣幸,感谢各位开发者支持

> ### 随着工具的丰富,目前出现的弊端为体量过大,导入不易,故发布本版本1.2.1正式版本后,将只维护Bug,不再新增需求

> ### 全新2.0版本将预计9月全部拆分完毕,前缀统一为@yunkss/ef_模块名称,如有三方库copy源码提前发布,本人将申请权益保护

### 拆分目录总览

| 模块                | 介绍                   |
|-------------------|----------------------|
| @yunkss/ef_core   | 提供基础工具类如字符串,正则,身份校验等 |
| @yunkss/ef_json   | 提JSON转换相关            |
| @yunkss/ef_crypto | 提供加解密相关              |
| @yunkss/ef_media  | 提供媒体相关               |
| @yunkss/ef_device | 提供设备相关               |
| @yunkss/ef_axios  | 提供网络请求efAxios相关      |
| @yunkss/ef_rcp    | 提供网络请求efRcp相关        |
| @yunkss/ef_ui     | 提供弹窗,级联,Loading等UI相关 |

### 🎁eftool名称的由来

eftool = Efficient + Tool，Efficient是高效的表示，Tool表示工具。

### 🍺eftool理念

`eftool`既是一个工具集，也是一个知识库，我从不自诩代码原创，大多数工具类都是**搬运**而来，因此：

- 你可以引入使用，也可以**拷贝**和修改使用，如需分享扩展**希望可以注明原出处即可**，也希望能把bug及时反馈回来。
- 我努力健全**中文**注释，为源码学习者提供良好地学习环境，争取做到人人都能看得懂。

-------------------------------------------------------------------------------

## 🛠️版本说明【重要】

> - <span style='color:red;'>1.0.x版本系列兼容**API9**</span>

> - <span style='color:red;'>1.1.x版本系列兼容**API11**</span>

> - <span style='color:red;'>1.2.x版本系列兼容**API12**</span>

## 🛠️包含组件

一个HarmonyOS基础工具类，组成各种工具类，同时提供以下七部分组件：

### 1.基础类组件

| 模块         | 介绍               |
|------------|------------------|
| IdCardUtil | 提供对身份证校验系列方法     |
| IdUtil     | 提供生成ID的一系列方法     |
| ArrayUtil  | 提供对集合的一些常用的方法    |
| DateUtil   | 提供对日期的一系列封装      |
| ObjectUtil | 提供对于对象的系列操作方法    |
| RandomUtil | 提供随机数的系列方法       |
| RegUtil    | 提供对于常用正则表达式的方法   |
| StrUtil    | 提供对于字符串的操作方法     |
| PhoneUtil  | 提供常用的手机座机等判断     |
| OutDTO     | 提供常用的返回实体对象      |
| CharUtil   | 提供常用的字符操作        |
| CacheUtil  | 提缓存数据并且提取数据操作    |
| Logger     | 提供常用的打印日志的方法     |
| RegexConst | 提供常用的正则表达式常量     |
| DateConst  | 提供常用的日期格式化表达式常量  |
| AuthUtil   | 提供判断授权拉起授权的系列方法  |
| Base64Util | 提供字符串与Base64转换方法 |

### 2.加密类组件

#### 2.1异步方式

| 模块         | 介绍                                   |
|------------|--------------------------------------|
| RSA        | 提RSA供生成密钥加解密验签等系列方法(基于HarmonyOS API) |
| AES        | 提供AES生成密钥加解密等系列方法(基于HarmonyOS API)   |
| DES        | 提供3DES生成密钥加解密等系列方法(基于HarmonyOS API)  |
| SM2        | 提供SM2生成密钥加解密等系列方法(基于HarmonyOS API)   |
| SM3        | 提供SM3生成摘要,HMAC等系列方法(基于HarmonyOS API) |
| SM4        | 提供SM4生成密钥加解密等系列方法(基于HarmonyOS API)   |
| SHA        | 提供SHA生成摘要,HMAC等系列方法(基于HarmonyOS API) |
| ECDSA      | 提供ECDSA签名验签等系列方法(基于HarmonyOS API)    |
| ECDH       | 提供ecdh动态协商密钥系列方法(基于HarmonyOS API)    |
| X25519     | 提供x25519动态协商密钥等系列方法(基于HarmonyOS API) |
| SM2Convert | 提供SM2ASN1与C1C3C2转换类                  |

#### 2.2同步方式(V1.2.1-rc.1+)

| 模块         | 介绍                                       |
|------------|------------------------------------------|
| RSASync    | 提供RSA同步方式生成密钥加解密验签等系列方法(基于HarmonyOS API) |
| AESSync    | 提供AES同步方式生成密钥加解密等系列方法(基于HarmonyOS API)   |
| DESSync    | 提供3DES同步方式生成密钥加解密等系列方法(基于HarmonyOS API)  |
| SM2Sync    | 提供SM2同步方式生成密钥加解密等系列方法(基于HarmonyOS API)   |
| SM3Sync    | 提供SM3同步方式生成摘要,HMAC等系列方法(基于HarmonyOS API) |
| SM4Sync    | 提供SM4同步方式生成密钥加解密等系列方法(基于HarmonyOS API)   |
| SHASync    | 提供SHA同步方式生成摘要,HMAC等系列方法(基于HarmonyOS API) |
| MD5        | 提供MD5生成摘要等系列方法(基于HarmonyOS API)          |
| ECDSASync  | 提供ECDSA同步方式签名验签等系列方法(基于HarmonyOS API)    |
| ECDHSync   | 提供ecdh同步方式动态协商密钥系列方法(基于HarmonyOS API)    |
| X25519Sync | 提供x25519同步方式动态协商密钥等系列方法(基于HarmonyOS API) |
| SHA1       | 提供SHA1的散列哈希算法                            |

### 3.网络相关类组件(V1.2.1-rc.2+有改动)

| 模块      | 介绍                      |
|---------|-------------------------|
| efAxios | 二次封装axios               |
| efRcp   | 封装rcp请求,提供统一请求响应上传下载拦截等 |
| NetUtil | 提供对网络的方法操作工具类           |

#### 3.1 efAxios

| 模块            | 介绍                              |
|---------------|---------------------------------|
| efAxiosParams | 提供eftool封装axios请求所需的参数          |
| efAxios       | 二次封装axios的产物,提供统一请求响应拦截等        |
| efClientApi   | 提供针对于统一post,get,delete,put等请求封装 |

#### 3.2 efRcp

| 模块                 | 介绍                              |
|--------------------|---------------------------------|
| EfRcpUtil          | 提供rcp的session相关工具类              |
| efRcpParams        | 提供eftool封装rccp请求所需的参数           |
| efRcpSecurityParam | 提供rcp的证书配置参数                    |
| CertificateUtil    | 证书配置相关工具类                       |
| efRcpEventsHandler | efRcp请求事件处理器                    |
| efRcpClientApi     | 提供针对于统一post,get,delete,put等请求封装 |
| RcpInterceptor     | 提供针对于统一请求和响应拦截封装                |

### 4.JSON类组件

| 模块            | 介绍                        |
|---------------|---------------------------|
| JSONValue     | 提供eftool中的JSON相关对象的类型定义   |
| JSONObject    | 提供类Java的JSON对象的系列方法以及相互转换 |
| JSONArray     | 提供类Java的JSON数组的系列方法以及相互转换 |
| JSONArrayList | 提供类Java的JSON数组的系列方法以及相互转换 |
| JSONUtil      | 提供JSON转换一系列判断方法,废弃一部分方法   |

### 5.UI类组件

| 模块               | 介绍               |
|------------------|------------------|
| ToastUtil        | 提供对文本提示的一系列方法    |
| DialogUtil       | 提供对弹出框的一系列方法     |
| ActionUtil       | 提供对操作菜单的一系列方法    |
| LoadingUtil      | 提供全局加载工具类        |
| TipsUtil         | 提供提示弹出工具类        |
| SelectUtil       | 提供选择弹出工具类        |
| ConfirmUtil      | 提供信息确认弹出工具类      |
| AlertUtil        | 提供操作确认弹出工具类      |
| ExceptionUtil    | 提供省市区级联选择组件      |
| Cascade          | 提供省市区级联选择组件      |
| ImmersionUtil    | 提供沉浸式导航设置        |
| WindowUtil       | 提供窗口的创建关闭等功能     |
| NotificationUtil | 提供发送,删除通知等功能     |
| LocationUtil     | 提供获取定位,逆编码等功能    |
| DownloadUtil     | 统一的上传下载按钮工具      |
| PickerUtil       | 调起选择文件、照片、音频等工具类 |
| CameraUtil       | 调起拍照工具类          |
| WinDialogUtil    | 窗口方式弹框工具类        |
| PreviewUtil      | 预览工具类            |
| WinLoadingUtil   | 窗口方式全局加载工具类      |

### 6.媒体相关

| 模块             | 介绍            |
|----------------|---------------|
| FileUtil       | 提供对文件的一系列操作方法 |
| ImageUtil      | 提供对图片的一系列处理方法 |
| ImgPreviewUtil | 图片预览工具类       |

### 7.设备相关

| 模块              | 介绍       |
|-----------------|----------|
| PreUtil         | 首选项工具类   |
| TypeWritingUtil | 自定义键盘工具类 |
| KvUtil          | 数据库工具类   |

## 📦安装

### 🍊ohpm

* 执行安装命令

```
ohpm install @yunkss/eftool
```

* 配套axios版本说明

```
    "dependencies": {
        "@yunkss/eftool":"1.2.1-rc.2",
        "@ohos/axios" :"2.2.2"
    }
    //当前eftool为1.2.1-rc.2版本,内部使用的axios为2.2.2,使用时需注意项目中的axios与eftool中的版本对应关系
```

## 📦使用

### 1.在项目中引入插件

```
import { CacheUtil, OutDTO, Logger, IdCardUtil, ToastUtil, ActionUtil, DialogUtil ,xxxx} from '@yunkss/eftool'
```

类按需引入,项目需要使用那个就引入

### 2.基础组件使用API

#### 1.IdCardUtil的方法

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

#### 2.DateUtil的方法

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

#### 3.RegUtil的方法

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

#### 4.Logger的方法

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

#### 5.ObjectUtil的方法

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

#### 6.AuthUtil的方法

* checkPermissions 校验是否已授权 【异步方法】

```
    //单次校验一个权限,入参为需要校验的权限
    let result = await AuthUtil.checkPermissions('ohos.permission.APPROXIMATELY_LOCATION');
    if (!result) {
     //此处可调用拉起授权方法
     ToastUtil.showToast('用户未授权~');
    } else {
      ToastUtil.showToast('用户已授权~');
    }
```

* reqPermissionsFromUser 拉起单个用户授权 【异步方法】 有callBack

```
     //拉起用户单个权限授权操作,第一个参数为需要授予的权限,第二个参数为用户授权回调
     AuthUtil.reqPermissionsFromUser('ohos.permission.APPROXIMATELY_LOCATION', (index: number) => {
        //用户同意授权index为1,用户拒绝授权index为-1,根据结果进行业务操作
        ToastUtil.showToast(index == 1 ? '授权成功' : '用户取消授权~');
     })
```

* reqPermissions 拉起单个用户授权 【异步方法】 无callBack

```
     //拉起用户单个权限授权操作,用户同意授权code为1,用户拒绝授权code为-1,根据结果进行业务操作
     let code = await AuthUtil.reqPermissions('ohos.permission.APPROXIMATELY_LOCATION');
     if (code<0) {
       //授权失败
       return OutDTO.ErrorByDataRow<string>('获取当前位置失败~', '用户拒绝授权精准定位,获取定位失败~');
     }
```

* reqPermissionsList 拉起组合用户授权 【异步方法】 无callBack

```
     //拉起组合用户授权操作,入参为需要授权的权限集合
     let code = await AuthUtil.reqPermissionsList(['ohos.permission.APPROXIMATELY_LOCATION', 'ohos.permission.LOCATION']);
     //code为true表示权限集合均被授权,为false表示有权限未被授权
     if (!code) {
       //授权失败
       return OutDTO.ErrorByDataRow<string>('获取当前位置失败~', '用户拒绝授权精准定位,获取定位失败~');
     }
```

#### 7.PhoneUtil的方法

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

#### 9.StrUtil的方法

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

#### 10.RandomUtil的方法

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

#### 11.ArrayUtil的方法

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

#### 12.CacheUtil的方法

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

#### 13.IdUtil的方法

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

#### 14.OutDTO的方法

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

#### 15.Base64Util的方法

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

### 3.加密相关组件使用API

#### 3.1 异步方式

##### 1.RSA的方法【返回结果均为OutDTO对象】

* generateRSAKey 生成1024位RSA的非对称密钥

```
    const rsa = await RSA.generateRSAKey();
    console.error("generateRSAKey:" + rsa.getSuccess() + "---" + rsa.getMsg()
    + "\n" + "公钥:" + rsa.getDataRow().publicKey + "私钥:" + rsa.getDataRow().privateKey)
```

* generate2048RSAKey 生成2048位RSA的非对称密钥

```
    const rsa = await RSA.generate2048RSAKey();
    console.error("generateRSAKey:" + rsa.getSuccess() + "---" + rsa.getMsg()
    + "\n" + "公钥:" + rsa.getDataRow().publicKey + "私钥:" + rsa.getDataRow().privateKey)
```

* encodePKCS1 1024位加密

```
    let encode = await RSA.encodePKCS1('测试RSA-PKCS1加密字符串CSX~~', rsa.getDataRow().publicKey);
    this.message = encode.getDataRow();
```

* encodePKCS1Segment 1024位分段加密

```
    let encode = await RSA.encodePKCS1Segment('测试RSA-PKCS1分段加密字符串CSX~~', rsa.getDataRow().publicKey);
    this.message = encode.getDataRow();
```

* encode2048PKCS1 2048位加密

```
    let encode = await RSA.encode2048PKCS1('测试RSA-PKCS12048位加密字符串CSX~~', rsa.getDataRow().publicKey);
    this.message = encode.getDataRow();
```

* encode2048PKCS1Segment 2048位分段加密

```
    let encode = await RSA.encode2048PKCS1Segment('测试RSA-PKCS12048位分段加密字符串CSX~~', rsa.getDataRow().publicKey);
    this.message = encode.getDataRow();
```

* decodePKCS1 1024位解密

```
    let decode = await RSA.decodePKCS1(encode.getDataRow(), rsa.getDataRow().privateKey);
    this.message = decode.getDataRow();
```

* decodePKCS1Segment 1024位分段解密

```
    let decode = await RSA.decodePKCS1Segment(encode.getDataRow(), rsa.getDataRow().privateKey);
    this.message = decode.getDataRow();
```

* decode2048PKCS1 2048位解密

```
    let decode = await RSA.decode2048PKCS1(encode.getDataRow(), rsa.getDataRow().privateKey);
    this.message = decode.getDataRow();
```

* decode2048PKCS1Segment 2048位分段解密

```
    let decode = await RSA.decode2048PKCS1Segment(encode.getDataRow(), rsa.getDataRow().privateKey);
    this.message = decode.getDataRow();
```

* signPKCS1 1024位签名

```
    let sign = await RSA.signPKCS1('这个是RSA的验签字符串~~', rsa.getDataRow().privateKey);
    this.message = sign.getDataRow();
```

* sign2048PKCS1 2048位签名

```
    let sign = await RSA.sign2048PKCS1('这个是RSA的2048位验签字符串~~', rsa.getDataRow().privateKey);
    this.message = sign.getDataRow();
```

* verifyPKCS1 1024位验签

```
    let verify = await RSA.verifyPKCS1(sign.getDataRow(), '这个是RSA的验签字符串~~', rsa.getDataRow().publicKey);
    this.message = verify.getMsg();
```

* verify2048PKCS1 2048位验签

```
    let verify = await RSA.verify2048PKCS1(sign.getDataRow(), '这个是RSA的2048位验签字符串~~', rsa.getDataRow().publicKey);
    this.message = verify.getMsg();
```

* pemToStrKey 将pem文件中的数据转换成公钥字符串支持1024/2048字节

```
    //1024位示例
    //pem中数据支持没有回车符、换行符也支持每行以'\r\n'符结束
    let pubKey = RSA.pemToStrKey(`-----BEGIN PUBLIC KEY-----
                  MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDhoZDHUVp7y2zw7T7SQYDiUQCn
                  ImnsKogqWOF3hBfaBr8xK/7I/PfbLcPV/MrWKPi2uaiXkhmITX+24ZWVBInxELBa
                  4kccFJeZReMRmu7rKZgkVzU6JKyfaH8zMxipEBh0TyS6JVHHjPd4eezzzVDHc59O
                  fYyzs3kM3Z6oczwTDwIDAQAB
                  -----END PUBLIC KEY-----`);
    let encode = await RSA.encodePKCS1('测试RSA-PKCS1加密字符串CSX~~', pubKey);
    this.message = encode.getDataRow();
    let priKey = RSA.pemToStrKey(`-----BEGIN PRIVATE KEY-----
                MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAOGhkMdRWnvLbPDt
                PtJBgOJRAKciaewqiCpY4XeEF9oGvzEr/sj899stw9X8ytYo+La5qJeSGYhNf7bh
                lZUEifEQsFriRxwUl5lF4xGa7uspmCRXNTokrJ9ofzMzGKkQGHRPJLolUceM93h5
                7PPNUMdzn059jLOzeQzdnqhzPBMPAgMBAAECgYEAjJjm5Kz3G0kJ25+ak94pd91N
                8Nfq9TUToH++D4GKc1vc68EkhQ3NTRDZhZB+vLDPOt26BqkNq/fO66DqWu93HEra
                jBE4pZzCxmVmLanuimxiA45Td1DalL0mmd9ab2cusqwXo6LDs3mSU/t7gSBRUCnt
                kv4MBZMgIDA92QSadHECQQD1HZKBIbWQtZ4nDxgaP1MOQC7dKmXlIkCsDbuwaZhj
                RM8/+iqBBtgSkviwOCDWNiFcpzf+nUM1+ba9OE9iTOqTAkEA66Z/ifnKVCNbHiW8
                i6E2K/2NcJH4qsxRrIMs+eyxqC/yEjkxol26OVmemxu22Fjkx/xIOKg6zFJRstXy
                i6P3FQJBAKZ7xINCwxCb2uSKowNI2X/HZk0/u9+qqSRzW3TR8/gQx3eb0fy7Ck1r
                V9BQ/zSfpX9J8IVWiU0C4/SXZ4vL1FMCQQCPaQh9I7NqeQne0wBnyXh6VRhaxbsb
                1rRt1Hbusol73ZHoXT5Dnd7TQCMyKi+ggpjYzEP3lwoRhpeJyoKNUP/xAkB+//w9
                SyKHWOZOCLj47/1/7YZGzKv/Ttb4NVFtqDPl2QtbXqDcP8d5ZI4p37rJIq1XZ0sT
                l2UgKQV+KZkPdL1n
                -----END PRIVATE KEY-----
                `)
    let decode = await RSA.decodePKCS1(encode.getDataRow(), priKey);
    this.message = decode.getDataRow();
```

```
    //2048位示例
    //pem中数据支持没有回车符、换行符也支持每行以'\r\n'符结束
    let pubKey = RSA.pemToStrKey(`-----BEGIN PUBLIC KEY-----
                MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1nwHtqSbMNwjHKutrLUI
                +dMBCtoRb/SSY00ujBMsNPFdERxaizxgWVZbypVqgj3/4ZsZw9R65OyQu6oLqjA9
                Wk2nVLpPRtZNjwJgNRB4pYKf+RmLn35UdpIQC9/1+UUeoelboLEMCamCeXPCT5dv
                xqVheO+S6IOLiN6XGbkNZM2VBNtmAhIUVDLct2yH5YbD6plC8Tg+iMbiigG7r7Cs
                JE+Go5tb3BZjUYiF8fJ5ZKYCATkK4lO39rsXU8AAnw0duAq7LHk6xacwjyUA57S8
                0S3LFHcOyP7UoNfQ+cbV/z+72sYJV4RwO6AeE2Muz8jYR1GlcCW1wYBGNOpyRVKg
                4QIDAQAB
                -----END PUBLIC KEY-----`);
    let encode = await RSA.encode2048PKCS1('测试2048位RSA-PKCS1加密字符串CSX~~', pubKey);
    this.message = encode.getDataRow();
    //2048位pem私钥
    let priKey = RSA.pemToStrKey(`-----BEGIN RSA PRIVATE KEY-----
                MIIEpAIBAAKCAQEA1nwHtqSbMNwjHKutrLUI+dMBCtoRb/SSY00ujBMsNPFdERxa
                izxgWVZbypVqgj3/4ZsZw9R65OyQu6oLqjA9Wk2nVLpPRtZNjwJgNRB4pYKf+RmL
                n35UdpIQC9/1+UUeoelboLEMCamCeXPCT5dvxqVheO+S6IOLiN6XGbkNZM2VBNtm
                AhIUVDLct2yH5YbD6plC8Tg+iMbiigG7r7CsJE+Go5tb3BZjUYiF8fJ5ZKYCATkK
                4lO39rsXU8AAnw0duAq7LHk6xacwjyUA57S80S3LFHcOyP7UoNfQ+cbV/z+72sYJ
                V4RwO6AeE2Muz8jYR1GlcCW1wYBGNOpyRVKg4QIDAQABAoIBAB2ckhQNNb/RJKfY
                q+mkNNEI6KPu52llgrBi/4InQ3srt4WdPILsmwC6g4G8jy/cD2++UhhPRYhFgNXn
                7CRa9J17CxcPgdJt09dipJWu6HkxR5TEihpC/rZABCcfjH4VpN0FsrjEuLy8wl6y
                NKl4Zt4uBv8DVGz1fFYxJPtQKSE5YBSbvMD1thhViKOSyYp/pQfu00oz7/XK6iDE
                oHAhcdTBcBl9YW2WaXCnuX02FQkO5h8kjJbQd6pW4EfLLUxKjwcxcJ61DswcAaPw
                PN4+bgiwMak8H3IFrZVP24qs4ZOT3Yh7dl75OZXw7XcuBxsR/eCDlIe5VSSS+MId
                JCc42uECgYEA8jbvO07ESaVYvdij21knF+5Tdjg5rG2q0qsocWlxsE+8IkjzRAgF
                oovXqwoyDkhFJ/1N/PEnBqiQngbUhRSst49ICCQVv+fzRX2WjUNg4k2FtLO0jwgL
                Z+E6grMkMkv7VDIxyWlY5rYUC1yw6USFjgyMGQaWps8o4+JLsGJd9PsCgYEA4rER
                ecoYZndLRGmqMtmGZATDyNh6jGXzGF4XgHahnbhqgw3+7aTDXpA9W1TdGeBI4cQ9
                HQMjroJ+X/yx2JWysimnFxMXuU4eXZo3vMuebXB3lRe2QcloO1HobeSdUCosJ3qa
                Ks+f3UtN9Q8ZiPb5P0tA/fIbe6cwwQTQ1FLbQtMCgYEA0DpD3lOv0bRRHxygeVEi
                l6Muo0Jg6oh5Q5UbNqy0rSNPFJZsc/8FgSEBrqwcLkUZFvDf2+UhbMr7UK+Egkgs
                171Y6o7DF/D7JbF6/USAhOyqVpfrUM9UpuBs4bHKG2dQ0Kg6PvHPGMBNaRsth8x9
                mInW4yjT2OHdQFPqR9+48IMCgYBJXXkEa21+K/mGCJR2pIOj9w7N/5GZwpzsM/dz
                MfGYM8j05SCuFHbOMexJlKuB5l5wAqysqQlxPvZbZlLAf6I3mtdi1mEFLc0SCgkj
                5to9HPr2m5f2rpI3MIkCl8x510w28qzWUh+w5OA0AVEITLXZ0CcWiLZwTGmw7jgP
                n0kq1QKBgQDWDHZaEGCAYPxytix3tTCG3EIly8+fQJGt1lc0vgiiFcS0cW2pBbko
                rVvbu1gSJnmvj0dIObp55wwFBs30xEiMfli+83srOur6nxYUDgn9rqGcufn6hOeH
                ++y1uOHhOenfUTy51Gy1Dlv+maJ3LZ0ZnqPnbBdhZ1RtXFnczVKeFg==
                -----END RSA PRIVATE KEY-----`)
    let decode = await RSA.decode2048PKCS1(encode.getDataRow(), priKey);
```

##### 2.AES的方法【返回结果均为OutDTO对象】

* generateAESKey 生成AES的对称密钥

```
    const aes = await  AES.generateAESKey();
    console.error("是否成功:" + aes.getSuccess() + "消息===:" + aes.getMsg() + "密钥======:", aes.getDataRow());
```

* generateAESKey128 生成128位AES的对称密钥

```
    const aes = await  AES.generateAESKey128();
    console.error("是否成功:" + aes.getSuccess() + "消息===:" + aes.getMsg() + "密钥======:", aes.getDataRow());
```

* encodeGCM 加密-GCM模式

```
    let encodeGCM = await AES.encodeGCM('测试加密字符串Test!', aes.getDataRow());
    this.message = encodeGCM.getDataRow();
```

* decodeGCM 解密-GCM模式

```
    let decodeGCM = await AES.decodeGCM(encodeGCM.getDataRow(), aes.getDataRow());
    this.message = decodeGCM.getDataRow();
```

* encodeCBC 加密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
    let encode = await AES.encodeCBC('测试CBC加密字符串Test!', aes.getDataRow(), iv.getDataRow());
    this.message = encode.getDataRow();
```

* decodeCBC 解密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
    let decode = await AES.decodeCBC(encode.getDataRow(),aes.getDataRow(), iv.getDataRow());
    this.message = decode.getDataRow();
```

* encodeCBC128 加密-CBC模式-128位 需要传入iv偏移量字符串(IV生成详见RandomUtil)(1.1.13+)

```
    let encode = await AES.encodeCBC128('测试CBC加密字符串Test!','TESTsdiloia20230','ass3[2K8%fw68sw7');
    this.message = encode.getDataRow();
```

* decodeCBC128 解密-CBC模式-128位 需要传入iv偏移量字符串(IV生成详见RandomUtil)(1.1.13+)

```
    let decode = await AES.decodeCBC128(encode.getDataRow(),'TESTsdiloia20230','ass3[2K8%fw68sw7');
    this.message = decode.getDataRow();
```

* encodeECB 加密-ECB模式

```
    let encode = await AES.encodeECB('此处为共享密钥加密的数据~~~~~~', aesKey);
    this.message = encode.getDataRow();
```

* decodeECB 解密-ECB模式

```
    let decode = await AES.decodeECB(encode.getDataRow(), aesKey);
    this.message = decode.getDataRow();
```

* encodeECB128 加密-ECB模式-128位

```
    let encode = await AES.encodeECB128('此处为共享密钥加密的数据~~~~~~', aesKey);
    this.message = encode.getDataRow();
```

* decodeECB128 解密-ECB模式-128位

```
    let decode = await AES.decodeECB128(encode.getDataRow(), aesKey);
    this.message = decode.getDataRow();
```

##### 3.3DES的方法【返回结果均为OutDTO对象】

* generate3DESKey 生成3DES的对称密钥

```
    let des = await DES.generate3DESKey();
    console.error("是否成功:" + des.getSuccess() + "消息===:" + des.getMsg() + "密钥======:", des.getDataRow());
```

* encodeECB 加密-ECB模式

```
    let encodeECB = await DES.encodeECB('测试3DES-ECB加密字符串Test!', des.getDataRow());
    this.message = encodeECB.getDataRow();
```

* decodeECB 解密-ECB模式

```
    let decodeECB = await DES.decodeECB(encodeECB.getDataRow(), des.getDataRow());
    this.message = decodeECB.getDataRow();
```

* encodeCBC 加密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
    let encodeCBC = await DES.encodeCBC('测试3DES-CBC加密字符串Test!', des.getDataRow(), iv.getDataRow());
    this.message = encodeCBC.getDataRow();
```

* decodeCBC 解密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
    let decodeCBC = await DES.decodeCBC(encodeCBC.getDataRow(), des.getDataRow(), iv.getDataRow());
    this.message = decodeCBC.getDataRow();
```

##### 4.SM2的方法【返回结果均为OutDTO对象】

* generateSM2Key 生成SM2的非对称密钥

```
    let sm2 = await SM2.generateSM2Key();
    console.error("generateSM2Key:" + sm2.getSuccess() + "---" + sm2.getMsg()
    + "\n" + "公钥:" + sm2.getDataRow().publicKey + "私钥:" + sm2.getDataRow().privateKey)
```

* encode 加密

```
    let encode = await SM2.encode('测试SM2加密字符串CSX~~', sm2.getDataRow().publicKey);
    this.message = encode.getDataRow();
```

* decode 解密

```
    let decode = await SM2.decode(encode.getDataRow(), sm2.getDataRow().privateKey);
    this.message = decode.getDataRow();
```

* sign 签名

```
    let sign = await SM2.sign('这个是SM2的验签字符串~~', sm2.getDataRow().privateKey);
    this.message = sign.getDataRow();
```

* verify 验签

```
    let verify = await SM2.verify(sign.getDataRow(), '这个是SM2的验签字符串~~', sm2.getDataRow().publicKey);
    this.message = verify.getMsg();
```

* convertSM2PubKey 将服务器端生成的16进制的长度为130位的04开头的C1C3C2格式的SM2公钥转换为前端所需的ASN

```
    //C1C3C2格式的公钥字符串
    let pk = '04ba3bc3c5834d9ad1a7d81c4b49cf1209d2f28e4a97c73b75d6561792a2bfafe811e0284692006b0ce1b51f8aadfd65241d80eb979365048253408f5d705ec17b';
    //转换后的ASN.1格式的字符串
    let s = await SM2.convertSM2PubKey(pk);
    let code = await SM2.encode('加密字符~~~~~', s.getDataRow());
    let ddd = code.getDataRow();
```

* convertSM2PriKey 将服务器端生成的16进制的长度为64位的C1C3C2格式的SM2私钥转换为前端所需的ASN

```
    //C1C3C2格式的私钥字符串
    let pik = '7713d336bcbbffb8b7f9cab8db984a5c989a0b07697f569a06d5cd38e1351d07';
    //转换后的ASN.1格式的字符串
    let dc = await SM2.convertSM2PriKey(pik);
    let aaaa = await SM2.decode(ddd, dc.getDataRow());
    this.message = aaaa.getDataRow();
```

##### 5.SM3的方法【返回结果均为OutDTO对象】

* digest SM3摘要

```
    let sm3 = await SM3.digest('使用SM3进行摘要数据~~~');
    this.message = sm3.getDataRow();
```

* hmac 消息认证码计算

```
    let hmac1 = await SM3.hmac('这个是SM3的HMAC~~~');
    this.message = hmac1.getDataRow();
```

##### 6.SM4的方法【返回结果均为OutDTO对象】

* generateSM4Key 生成SM4的对称密钥

```
    let sm4 = await SM4.generateSM4Key();
    console.error("是否成功:" + sm4.getSuccess() + "消息===:" + sm4.getMsg() + "密钥======:", sm4.getDataRow());
```

* encodeECB 加密-ECB模式

```
    let encodeECB = await SM4.encodeECB('测试SM4加密字符串Test!', sm4.getDataRow());
    this.message = encodeECB.getDataRow();
```

* decodeECB 解密-ECB模式

```
    let decodeECB = await SM4.decodeECB(encodeECB.getDataRow(), sm4.getDataRow());
    this.message = decodeECB.getDataRow();
```

* encodeCBC 加密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
    let encodeCBC = await SM4.encodeCBC('测试SM4的CBC加密字符串Test!', sm4.getDataRow(), iv.getDataRow());
    this.message = encodeCBC.getDataRow();
```

* decodeCBC 解密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
    let decodeCBC = await SM4.decodeCBC(encodeCBC.getDataRow(), sm4.getDataRow(), iv.getDataRow());
    this.message = decodeCBC.getDataRow();
```

##### 7.SHA的方法【返回结果均为OutDTO对象】

* digest 摘要方法

```
    let digest = await SHA.digest('这个是SHA的摘要方法~~');
    this.message = digest.getDataRow();
```

* digestSHA1 SHA1摘要

```
    let digest = await SHA.digestSHA1('这个是SHA的摘要方法~~');
    this.message = digest.getDataRow();
```

* digestSHA224 SHA224摘要

```
    let digest = await SHA.digestSHA224('这个是SHA的摘要方法~~');
    this.message = digest.getDataRow();
```

* digestSHA384 SHA384摘要

```
    let digest = await SHA.digestSHA384('这个是SHA的摘要方法~~');
    this.message = digest.getDataRow();
```

* digestSHA512 SHA512摘要

```
    let digest = await SHA.digestSHA512('这个是SHA的摘要方法~~');
    this.message = digest.getDataRow();
```

* hmac 消息认证码计算

```
    let hmac2 = await SHA.hmac('这个是SHA的HMAC');
    this.message = hmac2.getDataRow();
```

##### 8.ECDSA的方法【返回结果均为OutDTO对象】

* generateECDSAKey 生成ECDSA的非对称密钥

```
    let ecdsa = await ECDSA.generateECDSAKey();
    console.error("generateECDSAKey:" + ecdsa.getSuccess() + "---" + ecdsa.getMsg()
    + "\n" + "公钥:" + ecdsa.getDataRow().publicKey + "私钥:" + ecdsa.getDataRow().privateKey)
```

* sign 签名

```
    let sign = await ECDSA.sign('这个是ECDSA的验签字符串~~', ecdsa.getDataRow().privateKey);
    this.message = sign.getDataRow();
```

* verify 验签

```
    let verify = await ECDSA.verify(sign.getDataRow(), '这个是ECDSA的验签字符串~~', ecdsa.getDataRow().publicKey);
    this.message = verify.getMsg();
```

##### 9.ECDH的方法【返回结果均为OutDTO对象】

* ecdh 动态协商密钥,要求密钥长度为256位的非对称密钥

```
    //1.测试随机生成的一种256长度的字符串公私钥秘钥
    let ecdsa = await ECDSA.generateECDSAKey();
    //将对方的公钥和自己的私钥传入生成256位的共享秘钥
    let symKey = await ECDH.ecdh(ecdsa.getDataRow().publicKey, ecdsa.getDataRow().privateKey);
    //可以进行对称加密 注意对称加解密也需要为256位
    let encode = await CryptoUtil.encodeECB('测试共享密钥加密数据~~~', symKey.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = encode.getDataRow();
    //对称解密
    let decode = await CryptoUtil.decodeECB(encode.getDataRow(), symKey.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = decode.getDataRow();
    
```

```
    //2.测试随机生成的一种256长度的字节流Uint8Array形式的公私钥秘钥
    // 创建非对称密钥生成器
    let rsaGenerator = crypto.createAsyKeyGenerator('ECC256');
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseKeyPair = await rsaGenerator.generateKeyPair();
    // 转换成可以读懂的公私钥字符串
    let pubKey = promiseKeyPair.pubKey.getEncoded().data;
    let priKey = promiseKeyPair.priKey.getEncoded().data;
    //获取到贡献密钥
    let symKey = await ECDH.ecdh(pubKey, priKey);
    //可以进行对称加密 注意对称加解密也需要为256位
    let encode = await CryptoUtil.encodeECB('测试共享密钥加密数据~~~', symKey.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = encode.getDataRow();
    //对称解密
    let decode = await CryptoUtil.decodeECB(encode.getDataRow(), symKey.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = decode.getDataRow();
```

##### 10.X25519的方法【返回结果均为OutDTO对象】

* x25519 X25519动态协商密钥,要求密钥长度为256位的非对称密钥

```
    //1.测试随机生成的一种256长度的字符串公私钥秘钥
    let x25519Key = await CryptoUtil.generateCryptoKey('X25519');
    //将对方的公钥和自己的私钥传入生成256位的共享秘钥
    let x25519 = await X25519.x25519(x25519Key.getDataRow().publicKey, x25519Key.getDataRow().privateKey);
    this.message = x25519.getDataRow();
    //可以进行对称加密 注意对称加解密也需要为256位
    let encode = await CryptoUtil.encodeECB('测试共享密钥加密数据~~~', x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = encode.getDataRow();
    //对称解密
    let decode = await CryptoUtil.decodeECB(encode.getDataRow(), x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = decode.getDataRow();
```

```
    //2.测试随机生成的一种256长度的字节流Uint8Array形式的公私钥秘钥
    let rsaGenerator = crypto.createAsyKeyGenerator('X25519');
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseKeyPair = await rsaGenerator.generateKeyPair();
    // 转换成可以读懂的公私钥字符串
    let pubKey = promiseKeyPair.pubKey.getEncoded().data;
    let priKey = promiseKeyPair.priKey.getEncoded().data;
    let x25519 = await X25519.x25519(pubKey, priKey);
    //可以进行对称加密 注意对称加解密也需要为256位
    let encode = await CryptoUtil.encodeECB('测试共享密钥加密数据~~~', x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = encode.getDataRow();
    //对称解密
    let decode = await CryptoUtil.decodeECB(encode.getDataRow(), x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = decode.getDataRow();
```

#### 3.2 同步方式(v1.2.1-rc.1+)

##### 1.RSASync的方法【返回结果均为OutDTO对象】

* generateRSAKey 生成1024位RSA的非对称密钥

```
   /**
   * 生成RSA的非对称密钥
   * @param resultCoding 生成RSA秘钥的字符串格式(hex/base64)-默认不传为base64格式
   * @returns RSA密钥{publicKey:公钥,privateKey:私钥}
   */
   let key = RSASync.generateRSAKey();  //base64格式
   let keyHex = RSASync.generateRSAKey('hex');   //hex格式

```

* generate2048RSAKey 生成2048位RSA的非对称密钥

```
   /**
   * 生成2048位RSA的非对称密钥
   * @param resultCoding 生成RSA秘钥的字符串格式(hex/base64)-默认不传为base64格式
   * @returns 2048位RSA密钥{publicKey:2048位公钥,privateKey:2048位私钥}
   */
   let key = RSASync.generate2048RSAKey();  //base64格式
   let keyHex = RSASync.generate2048RSAKey('hex');   //hex格式
```

* encodePKCS1 1024位加密

```
   /**
   * 1024位加密
   * @param str  待加密的字符串
   * @param pubKey  RSA公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   */
   
   //key为base64格式，加密后生成为base64
   let encode1024 = RSASync.encodePKCS1('测试RSA1024加密~~~', key.getDataRow().publicKey, 'base64');
   //key为hex格式,加密后生成默认为base64
   let encodeHex = RSASync.encodePKCS1('测试RSA1024-HEX加密~~~', keyHex.getDataRow().publicKey, 'hex');
   //key为hex格式,加密后生成格式为hex
   let encodeHex = RSASync.encodePKCS1('测试RSA1024-HEX加密~~~', keyHex.getDataRow().publicKey, 'hex', 'hex');
   
   //pem格式的key
   let pemPubKey = `-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDOKeI9M56EDZ7yLJB56lKWb180
eGfPrYiAG9IbjEEK8FfNvZuDrCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQC
HMy+lrOq3rpeDfFiiT7zwvXft2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1
eTXVu7hjXEqmrGXmgwIDAQAB
-----END PUBLIC KEY-----`;
   //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //加密后生成内容为hex格式
   let encodePem = RSASync.encodePKCS1('测试pem格式的1024位RSA加密~~', pemPubKey, 'base64', 'hex', true);
   
```

* encodePKCS1Segment 1024位分段加密

```
   /**
   * 加密-分段
   * @param str  待加密的字符串
   * @param pubKey  RSA公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   */
   
   //key为base64格式，加密后生成为base64
   let encode1024 = RSASync.encodePKCS1Segment('测试RSA1024加密~~~', key.getDataRow().publicKey, 'base64');
   //key为hex格式,加密后生成默认为base64
   let encodeHex = RSASync.encodePKCS1Segment('测试RSA1024-HEX加密~~~', keyHex.getDataRow().publicKey, 'hex');
   //key为hex格式,加密后生成格式为hex
   let encodeHex = RSASync.encodePKCS1Segment('测试RSA1024-HEX加密~~~', keyHex.getDataRow().publicKey, 'hex', 'hex');
   
   //pem格式的key
   let pemPubKey = `-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDOKeI9M56EDZ7yLJB56lKWb180
eGfPrYiAG9IbjEEK8FfNvZuDrCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQC
HMy+lrOq3rpeDfFiiT7zwvXft2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1
eTXVu7hjXEqmrGXmgwIDAQAB
-----END PUBLIC KEY-----`;
   //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //加密后生成内容为hex格式
   let encodePem = RSASync.encodePKCS1Segment('测试pem格式的1024位RSA加密~~', pemPubKey, 'base64', 'hex', true);
   
```

* encode2048PKCS1 2048位加密

```
   /**
   * 2048位加密
   * @param str  待加密的字符串
   * @param pubKey  2048位RSA公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   */
   
   //key为base64格式，加密后生成为base64
   let encode1024 = RSASync.encode2048PKCS1('测试RSA1024加密~~~', key.getDataRow().publicKey, 'base64');
   //key为hex格式,加密后生成默认为base64
   let encodeHex = RSASync.encode2048PKCS1('测试RSA1024-HEX加密~~~', keyHex.getDataRow().publicKey, 'hex');
   //key为hex格式,加密后生成格式为hex
   let encodeHex = RSASync.encode2048PKCS1('测试RSA1024-HEX加密~~~', keyHex.getDataRow().publicKey, 'hex', 'hex');
   
   //pem格式的key
   let pemPubKey = `-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDOKeI9M56EDZ7yLJB56lKWb180
eGfPrYiAG9IbjEEK8FfNvZuDrCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQC
HMy+lrOq3rpeDfFiiT7zwvXft2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1
eTXVu7hjXEqmrGXmgwIDAQAB
-----END PUBLIC KEY-----`;
   //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //加密后生成内容为hex格式
   let encodePem = RSASync.encode2048PKCS1('测试pem格式的1024位RSA加密~~', pemPubKey, 'base64', 'hex', true);
   
```

* encode2048PKCS1Segment 2048位分段加密

```
   /**
   * 2048位加密-分段
   * @param str  待加密的字符串
   * @param pubKey  2048位RSA公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   */
    
    //key为base64格式，加密后生成为base64
   let encode1024 = RSASync.encode2048PKCS1Segment('测试RSA1024加密~~~', key.getDataRow().publicKey, 'base64');
   //key为hex格式,加密后生成默认为base64
   let encodeHex = RSASync.encode2048PKCS1Segment('测试RSA1024-HEX加密~~~', keyHex.getDataRow().publicKey, 'hex');
   //key为hex格式,加密后生成格式为hex
   let encodeHex = RSASync.encode2048PKCS1Segment('测试RSA1024-HEX加密~~~', keyHex.getDataRow().publicKey, 'hex', 'hex');
   
   //pem格式的key
   let pemPubKey = `-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDOKeI9M56EDZ7yLJB56lKWb180
eGfPrYiAG9IbjEEK8FfNvZuDrCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQC
HMy+lrOq3rpeDfFiiT7zwvXft2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1
eTXVu7hjXEqmrGXmgwIDAQAB
-----END PUBLIC KEY-----`;
   //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //加密后生成内容为hex格式
   let encodePem = RSASync.encode2048PKCS1Segment('测试pem格式的1024位RSA加密~~', pemPubKey, 'base64', 'hex', true);
```

* decodePKCS1 1024位解密

```
   /**
   * 解密
   * @param decodeStr  待解密的字符串
   * @param priKey    RSA私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   */
    
    //key为base64,待解密内容不传默认为base64格式
    let decode1024 = RSASync.decodePKCS1(encode1024.getDataRow(), key1024.getDataRow().privateKey, 'base64');
    //key为hex,待解密内容不传默认为base64格式
    let decode1024Hex = RSASync.decodePKCS1(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex');
    //key为hex,待解密内容为hex格式
    let decode1024Hex = RSASync.decodePKCS1(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex', 'hex');
    
    //pem格式的key
    let pemPriKey = `-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDOKeI9M56EDZ7yLJB56lKWb180eGfPrYiAG9IbjEEK8FfNvZuD
rCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQCHMy+lrOq3rpeDfFiiT7zwvXf
t2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1eTXVu7hjXEqmrGXmgwIDAQAB
AoGAS/36S67kRi6zIPc2RgoOaS8iO7gKI+4GO5qFpuva6cpPwyGZ2j4vpnooLlgC
GqBe+Z7AhGzB90D45TQXlexwJ6xrXDN/9w0mCPItTfe5QxtvK2i0z9unoYXJcNwN
rSbbv1mBzJHybXcZgt9J2zFnsohAFPWGKVZrhDfyiecS0pkCQQD3WMY+hZVX5CLD
ojfUrfiSXDh+qd+aeo6dMYDYaOhW23oJ0OHNm6vYKZ+xiEf3OB0BduZofSWHALim
qVFF1bg1AkEA1WBGYd+/FHku+t17G6xRnWuDWI6A3ZyVuGv3wfRL5W8hKiJ1Urk3
ftllxQ4YVEIgaeET/0xSQ9H5KB2px+Gq1wJAGjJHxMVnHMjnuaqLmTXXtsCXpyqc
qQLD6fgdOk5aFSDnmvSJhbowCBPYevgBDzjdMZODMZvXhqXX6KbUGb5Z5QJBAJ+R
OdEjtA+peFqemtvdB8PDjRwCpZgU61pZU5S2DrPrYU/TKQ3N+RRhm1u76LHKKddE
POIkvzh8o+k+FaOmvU0CQBNhCHc2ufGNc88MZmTwxHpGom177f9p/YPiYcg5w3Ej
8xL+hatfA2Ls3Wg/P3gfm8raHbWzC3ge/JSk/LC/ygk=
-----END RSA PRIVATE KEY-----`;
    //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //加密后生成内容为hex格式
    let decodePem = RSASync.decodePKCS1(encodePem.getDataRow(), pemPriKey, 'base64', 'hex', true);
```

* decodePKCS1Segment 1024位分段解密

```
   /**
   * 解密-分段
   * @param decodeStr  待解密的字符串
   * @param priKey    RSA私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   */
   
   //key为base64,待解密内容不传默认为base64格式
    let decode1024 = RSASync.decodePKCS1Segment(encode1024.getDataRow(), key1024.getDataRow().privateKey, 'base64');
    //key为hex,待解密内容不传默认为base64格式
    let decode1024Hex = RSASync.decodePKCS1Segment(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex');
    //key为hex,待解密内容为hex格式
    let decode1024Hex = RSASync.decodePKCS1Segment(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex', 'hex');
    
    //pem格式的key
    let pemPriKey = `-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDOKeI9M56EDZ7yLJB56lKWb180eGfPrYiAG9IbjEEK8FfNvZuD
rCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQCHMy+lrOq3rpeDfFiiT7zwvXf
t2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1eTXVu7hjXEqmrGXmgwIDAQAB
AoGAS/36S67kRi6zIPc2RgoOaS8iO7gKI+4GO5qFpuva6cpPwyGZ2j4vpnooLlgC
GqBe+Z7AhGzB90D45TQXlexwJ6xrXDN/9w0mCPItTfe5QxtvK2i0z9unoYXJcNwN
rSbbv1mBzJHybXcZgt9J2zFnsohAFPWGKVZrhDfyiecS0pkCQQD3WMY+hZVX5CLD
ojfUrfiSXDh+qd+aeo6dMYDYaOhW23oJ0OHNm6vYKZ+xiEf3OB0BduZofSWHALim
qVFF1bg1AkEA1WBGYd+/FHku+t17G6xRnWuDWI6A3ZyVuGv3wfRL5W8hKiJ1Urk3
ftllxQ4YVEIgaeET/0xSQ9H5KB2px+Gq1wJAGjJHxMVnHMjnuaqLmTXXtsCXpyqc
qQLD6fgdOk5aFSDnmvSJhbowCBPYevgBDzjdMZODMZvXhqXX6KbUGb5Z5QJBAJ+R
OdEjtA+peFqemtvdB8PDjRwCpZgU61pZU5S2DrPrYU/TKQ3N+RRhm1u76LHKKddE
POIkvzh8o+k+FaOmvU0CQBNhCHc2ufGNc88MZmTwxHpGom177f9p/YPiYcg5w3Ej
8xL+hatfA2Ls3Wg/P3gfm8raHbWzC3ge/JSk/LC/ygk=
-----END RSA PRIVATE KEY-----`;
    //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //加密后生成内容为hex格式
    let decodePem = RSASync.decodePKCS1Segment(encodePem.getDataRow(), pemPriKey, 'base64', 'hex', true);
```

* decode2048PKCS1 2048位解密

```
   /**
   * 2048位解密
   * @param decodeStr  待解密的字符串
   * @param priKey    2048位RSA私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   */
   
   //key为base64,待解密内容不传默认为base64格式
    let decode1024 = RSASync.decode2048PKCS1(encode1024.getDataRow(), key1024.getDataRow().privateKey, 'base64');
    //key为hex,待解密内容不传默认为base64格式
    let decode1024Hex = RSASync.decode2048PKCS1(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex');
    //key为hex,待解密内容为hex格式
    let decode1024Hex = RSASync.decode2048PKCS1(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex', 'hex');
    
    //pem格式的key
    let pemPriKey = `-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDOKeI9M56EDZ7yLJB56lKWb180eGfPrYiAG9IbjEEK8FfNvZuD
rCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQCHMy+lrOq3rpeDfFiiT7zwvXf
t2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1eTXVu7hjXEqmrGXmgwIDAQAB
AoGAS/36S67kRi6zIPc2RgoOaS8iO7gKI+4GO5qFpuva6cpPwyGZ2j4vpnooLlgC
GqBe+Z7AhGzB90D45TQXlexwJ6xrXDN/9w0mCPItTfe5QxtvK2i0z9unoYXJcNwN
rSbbv1mBzJHybXcZgt9J2zFnsohAFPWGKVZrhDfyiecS0pkCQQD3WMY+hZVX5CLD
ojfUrfiSXDh+qd+aeo6dMYDYaOhW23oJ0OHNm6vYKZ+xiEf3OB0BduZofSWHALim
qVFF1bg1AkEA1WBGYd+/FHku+t17G6xRnWuDWI6A3ZyVuGv3wfRL5W8hKiJ1Urk3
ftllxQ4YVEIgaeET/0xSQ9H5KB2px+Gq1wJAGjJHxMVnHMjnuaqLmTXXtsCXpyqc
qQLD6fgdOk5aFSDnmvSJhbowCBPYevgBDzjdMZODMZvXhqXX6KbUGb5Z5QJBAJ+R
OdEjtA+peFqemtvdB8PDjRwCpZgU61pZU5S2DrPrYU/TKQ3N+RRhm1u76LHKKddE
POIkvzh8o+k+FaOmvU0CQBNhCHc2ufGNc88MZmTwxHpGom177f9p/YPiYcg5w3Ej
8xL+hatfA2Ls3Wg/P3gfm8raHbWzC3ge/JSk/LC/ygk=
-----END RSA PRIVATE KEY-----`;
    //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //加密后生成内容为hex格式
    let decodePem = RSASync.decode2048PKCS1(encodePem.getDataRow(), pemPriKey, 'base64', 'hex', true);
```

* decode2048PKCS1Segment 2048位分段解密

```
   /**
   * 2048位解密-分段
   * @param decodeStr  待解密的字符串
   * @param priKey    2048位RSA私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   */
   
   //key为base64,待解密内容不传默认为base64格式
    let decode1024 = RSASync.decode2048PKCS1Segment(encode1024.getDataRow(), key1024.getDataRow().privateKey, 'base64');
    //key为hex,待解密内容不传默认为base64格式
    let decode1024Hex = RSASync.decode2048PKCS1Segment(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex');
    //key为hex,待解密内容为hex格式
    let decode1024Hex = RSASync.decode2048PKCS1Segment(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex', 'hex');
    
    //pem格式的key
    let pemPriKey = `-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDOKeI9M56EDZ7yLJB56lKWb180eGfPrYiAG9IbjEEK8FfNvZuD
rCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQCHMy+lrOq3rpeDfFiiT7zwvXf
t2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1eTXVu7hjXEqmrGXmgwIDAQAB
AoGAS/36S67kRi6zIPc2RgoOaS8iO7gKI+4GO5qFpuva6cpPwyGZ2j4vpnooLlgC
GqBe+Z7AhGzB90D45TQXlexwJ6xrXDN/9w0mCPItTfe5QxtvK2i0z9unoYXJcNwN
rSbbv1mBzJHybXcZgt9J2zFnsohAFPWGKVZrhDfyiecS0pkCQQD3WMY+hZVX5CLD
ojfUrfiSXDh+qd+aeo6dMYDYaOhW23oJ0OHNm6vYKZ+xiEf3OB0BduZofSWHALim
qVFF1bg1AkEA1WBGYd+/FHku+t17G6xRnWuDWI6A3ZyVuGv3wfRL5W8hKiJ1Urk3
ftllxQ4YVEIgaeET/0xSQ9H5KB2px+Gq1wJAGjJHxMVnHMjnuaqLmTXXtsCXpyqc
qQLD6fgdOk5aFSDnmvSJhbowCBPYevgBDzjdMZODMZvXhqXX6KbUGb5Z5QJBAJ+R
OdEjtA+peFqemtvdB8PDjRwCpZgU61pZU5S2DrPrYU/TKQ3N+RRhm1u76LHKKddE
POIkvzh8o+k+FaOmvU0CQBNhCHc2ufGNc88MZmTwxHpGom177f9p/YPiYcg5w3Ej
8xL+hatfA2Ls3Wg/P3gfm8raHbWzC3ge/JSk/LC/ygk=
-----END RSA PRIVATE KEY-----`;
    //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //加密后生成内容为hex格式
    let decodePem = RSASync.decode2048PKCS1Segment(encodePem.getDataRow(), pemPriKey, 'base64', 'hex', true);
```

* signPKCS1 1024位签名

```
   /**
   * 签名-PKCS1
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   * @returns OutDTO<string> 签名对象
   */
   
   //pem格式的key
   let pemPriKey = `-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDOKeI9M56EDZ7yLJB56lKWb180eGfPrYiAG9IbjEEK8FfNvZuD
rCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQCHMy+lrOq3rpeDfFiiT7zwvXf
t2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1eTXVu7hjXEqmrGXmgwIDAQAB
AoGAS/36S67kRi6zIPc2RgoOaS8iO7gKI+4GO5qFpuva6cpPwyGZ2j4vpnooLlgC
GqBe+Z7AhGzB90D45TQXlexwJ6xrXDN/9w0mCPItTfe5QxtvK2i0z9unoYXJcNwN
rSbbv1mBzJHybXcZgt9J2zFnsohAFPWGKVZrhDfyiecS0pkCQQD3WMY+hZVX5CLD
ojfUrfiSXDh+qd+aeo6dMYDYaOhW23oJ0OHNm6vYKZ+xiEf3OB0BduZofSWHALim
qVFF1bg1AkEA1WBGYd+/FHku+t17G6xRnWuDWI6A3ZyVuGv3wfRL5W8hKiJ1Urk3
ftllxQ4YVEIgaeET/0xSQ9H5KB2px+Gq1wJAGjJHxMVnHMjnuaqLmTXXtsCXpyqc
qQLD6fgdOk5aFSDnmvSJhbowCBPYevgBDzjdMZODMZvXhqXX6KbUGb5Z5QJBAJ+R
OdEjtA+peFqemtvdB8PDjRwCpZgU61pZU5S2DrPrYU/TKQ3N+RRhm1u76LHKKddE
POIkvzh8o+k+FaOmvU0CQBNhCHc2ufGNc88MZmTwxHpGom177f9p/YPiYcg5w3Ej
8xL+hatfA2Ls3Wg/P3gfm8raHbWzC3ge/JSk/LC/ygk=
-----END RSA PRIVATE KEY-----`;
   //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //签名后的内容格式为base64
   let sign = RSASync.signPKCS1('待签名的RSA的pem格式的字符串~', pemPriKey, 'base64', 'base64', true);

```

* sign2048PKCS1 2048位签名

```
   /**
   * 2048位签名-PKCS1
   * @param str  需要签名的字符串
   * @param priKey  2048位私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   * @returns OutDTO<string> 签名对象
   */
   
   //pem格式的key
   let pemPriKey = `-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDOKeI9M56EDZ7yLJB56lKWb180eGfPrYiAG9IbjEEK8FfNvZuD
rCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQCHMy+lrOq3rpeDfFiiT7zwvXf
t2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1eTXVu7hjXEqmrGXmgwIDAQAB
AoGAS/36S67kRi6zIPc2RgoOaS8iO7gKI+4GO5qFpuva6cpPwyGZ2j4vpnooLlgC
GqBe+Z7AhGzB90D45TQXlexwJ6xrXDN/9w0mCPItTfe5QxtvK2i0z9unoYXJcNwN
rSbbv1mBzJHybXcZgt9J2zFnsohAFPWGKVZrhDfyiecS0pkCQQD3WMY+hZVX5CLD
ojfUrfiSXDh+qd+aeo6dMYDYaOhW23oJ0OHNm6vYKZ+xiEf3OB0BduZofSWHALim
qVFF1bg1AkEA1WBGYd+/FHku+t17G6xRnWuDWI6A3ZyVuGv3wfRL5W8hKiJ1Urk3
ftllxQ4YVEIgaeET/0xSQ9H5KB2px+Gq1wJAGjJHxMVnHMjnuaqLmTXXtsCXpyqc
qQLD6fgdOk5aFSDnmvSJhbowCBPYevgBDzjdMZODMZvXhqXX6KbUGb5Z5QJBAJ+R
OdEjtA+peFqemtvdB8PDjRwCpZgU61pZU5S2DrPrYU/TKQ3N+RRhm1u76LHKKddE
POIkvzh8o+k+FaOmvU0CQBNhCHc2ufGNc88MZmTwxHpGom177f9p/YPiYcg5w3Ej
8xL+hatfA2Ls3Wg/P3gfm8raHbWzC3ge/JSk/LC/ygk=
-----END RSA PRIVATE KEY-----`;
   //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //签名后的内容格式为base64
   let sign = RSASync.sign2048PKCS1('待签名的RSA的pem格式的字符串~', pemPriKey, 'base64', 'base64', true);
```

* verifyPKCS1 1024位验签

```
   /**
   * 验签-PKCS1
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  RSA公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
   
   //pem格式的key
   let pemPubKey = `-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDOKeI9M56EDZ7yLJB56lKWb180
eGfPrYiAG9IbjEEK8FfNvZuDrCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQC
HMy+lrOq3rpeDfFiiT7zwvXft2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1
eTXVu7hjXEqmrGXmgwIDAQAB
-----END PUBLIC KEY-----`;
   //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //待验签的内容为base64 
   let verify =RSASync.verifyPKCS1(sign.getDataRow(), '待签名的RSA的pem格式的字符串~', pemPubKey, 'base64', 'base64', true);

```

* verify2048PKCS1 2048位验签

```
   /**
   * 2048位验签-PKCS1
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  2048位RSA公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
   
   //pem格式的key
   let pemPubKey = `-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDOKeI9M56EDZ7yLJB56lKWb180
eGfPrYiAG9IbjEEK8FfNvZuDrCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQC
HMy+lrOq3rpeDfFiiT7zwvXft2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1
eTXVu7hjXEqmrGXmgwIDAQAB
-----END PUBLIC KEY-----`;
   //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //待验签的内容为base64 
   let verify =RSASync.verify2048PKCS1(sign.getDataRow(), '待签名的RSA的pem格式的字符串~', pemPubKey, 'base64', 'base64', true);
```

* <s>pemToStrKey 将pem文件中的数据转换成公钥字符串支持1024/2048字节(RSASync中的加解密方法已经支持pem格式密钥)</s>

##### 2.AESSync的方法【返回结果均为OutDTO对象】

* generateAESKey 生成AES的对称密钥

```
    /**
    * 生成AES的对称密钥-默认base64
    * @param resultCoding 生成AES秘钥的字符串格式(hex/base64)-默认不传为base64格式
    * @returns AES密钥
    */
    //默认生成base64格式
    let key = AESSync.generateAESKey();
    //生成hex格式
    let keyHex = AESSync.generateAESKey('hex');
```

* generateAESKey128 生成128位AES的对称密钥

```
    /**
    * 生成AES的对称密钥-128位-默认base64
    * @param resultCoding 生成AES秘钥的字符串格式(hex/base64)-默认不传为base64格式
    * @returns AES密钥-128位
    */ 
    //默认生成base64格式
    let key = AESSync.generateAESKey128();
    //生成hex格式
    let keyHex = AESSync.generateAESKey128('hex');
```

* generateAESKey192 生成192位AES的对称密钥

```
    /**
    * 生成AES的对称密钥-192位-默认base64
    * @param resultCoding 生成AES秘钥的字符串格式(hex/base64)-默认不传为base64格式
    * @returns AES密钥-192位
    */ 
    //默认生成base64格式
    let key = AESSync.generateAESKey192();
    //生成hex格式
    let keyHex = AESSync.generateAESKey192('hex');
```

* encodeGCM 加密-GCM模式

```
   /**
   * 加密-GCM模式
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   //key为base64格式,返回结果格式不传默认为base64
    let gcmEncode = AESSync.encodeGCM('测试AES-GCM加密~~~~', key.getDataRow(), 'base64');
```

* decodeGCM 解密-GCM模式

```
   /**
   * 解密-GCM模式
   * @param str  加密的字符串
   * @param aesKey  AES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   */
   //key为base64格式,待解密数据格式不传默认为base64
   let gcmDecode = AESSync.decodeGCM(gcmEncode.getDataRow(), key.getDataRow(), 'base64');
```

* encodeCBC 加密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
   /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @param iv   iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   //key为base64格式,返回格式默认不传为base64
   let encodeCBC = AESSync.encodeCBC('测试AES-CBC加密~~~~', key.getDataRow(), iv.getDataRow(), 'base64');
   //key为hex格式，返回格式为hex
   let encodeCBC = AESSync.encodeCBC('测试AES-CBC加密~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
   //key为hex格式,返回格式默认不传为base64
   let encodeCBC = AESSync.encodeCBC('测试AES-CBC加密~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   //key为普通字符串utf8格式,返回格式默认不传为base64
   let encode2 = AESSync.encodeCBC("测试AES外部传入key/iv加密~~~", "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8');
   //key为普通字符串utf8格式,返回格式为hex
   let encode2 = AESSync.encodeCBC("测试AES外部传入key/iv加密~~~", "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8', 'hex');
```

* decodeCBC 解密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
   /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey AES密钥
   * @param iv  iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
   //key为base64,待解密格式不传默认为base64
   let decode = AESSync.decodeCBC(encode.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64');
   //key为hex格式,待解密格式为hex
   let decodeHex = AESSync.decodeCBC(encodeHex.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
   //key为hex,待解密格式不传默认为base64
   let decodeBase64 = AESSync.decodeCBC(encodeBase64.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   //key为普通字符串utf8,待解密格式不传默认为base64
   let decode2 = AESSync.decodeCBC(encode2.getDataRow(), "TESTsdiloia20230ass3[2K8%fw68sw7", "ass3[2K8%fw68sw7", 'utf8');
   
```

* encodeCBC128 加密-CBC模式-128位 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
   /**
   * 加密-CBC模式-128位
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @param iv   iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   //key为base64格式,返回格式默认不传为base64
   let encodeCBC = AESSync.encodeCBC128('测试AES-128-CBC加密~~~~', key.getDataRow(), iv.getDataRow(), 'base64');
   //key为hex格式，返回格式为hex
   let encodeCBC = AESSync.encodeCBC128('测试AES-128-CBC加密~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
   //key为hex格式,返回格式默认不传为base64
   let encodeCBC = AESSync.encodeCBC128('测试AES-128-CBC加密~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   //key为普通字符串utf8格式,返回格式默认不传为base64
   let encode2 = AESSync.encodeCBC128("测试AES外部传入-128key/iv加密~~~", "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8');
   //key为普通字符串utf8格式,返回格式为hex
   let encode2 = AESSync.encodeCBC128("测试AES外部传入-128key/iv加密~~~", "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8', 'hex');
```

* decodeCBC128 解密-CBC模式-128位 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
   /**
   * 解密-CBC模式-128位
   * @param str  加密的字符串
   * @param aesKey AES密钥
   * @param iv  iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
   //key为base64,待解密格式不传默认为base64
   let decode = AESSync.decodeCBC128(encode.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64');
   //key为hex格式,待解密格式为hex
   let decodeHex = AESSync.decodeCBC128(encodeHex.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
   //key为hex,待解密格式不传默认为base64
   let decodeBase64 = AESSync.decodeCBC128(encodeBase64.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   //key为普通字符串utf8,待解密格式不传默认为base64
   let decode2 = AESSync.decodeCBC128(encode2.getDataRow(), "TESTsdiloia20230ass3[2K8%fw68sw7", "ass3[2K8%fw68sw7", 'utf8');
  
```

* encodeCBC192 加密-CBC模式-192位 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
   /**
   * 加密-CBC模式-192位
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @param iv   iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   //key为base64格式,返回格式默认不传为base64
   let encodeCBC = AESSync.encodeCBC192('测试AES-192-CBC加密~~~~', key.getDataRow(), iv.getDataRow(), 'base64');
   //key为hex格式，返回格式为hex
   let encodeCBC = AESSync.encodeCBC192('测试AES-192-CBC加密~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
   //key为hex格式,返回格式默认不传为base64
   let encodeCBC = AESSync.encodeCBC192('测试AES-192-CBC加密~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   //key为普通字符串utf8格式,返回格式默认不传为base64
   let encode2 = AESSync.encodeCBC192("测试AES外部传入-192key/iv加密~~~", "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8');
   //key为普通字符串utf8格式,返回格式为hex
   let encode2 = AESSync.encodeCBC192("测试AES外部传入-192key/iv加密~~~", "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8', 'hex');
```

* decodeCBC192 解密-CBC模式-192位 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
   /**
   * 解密-CBC模式-192位
   * @param str  加密的字符串
   * @param aesKey AES密钥
   * @param iv  iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
   
   //key为base64,待解密格式不传默认为base64
   let decode = AESSync.decodeCBC192(encode.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64');
   //key为hex格式,待解密格式为hex
   let decodeHex = AESSync.decodeCBC192(encodeHex.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
   //key为hex,待解密格式不传默认为base64
   let decodeBase64 = AESSync.decodeCBC192(encodeBase64.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   //key为普通字符串utf8,待解密格式不传默认为base64
   let decode2 = AESSync.decodeCBC192(encode2.getDataRow(), "TESTsdiloia20230ass3[2K8%fw68sw7", "ass3[2K8%fw68sw7", 'utf8');
  
```

* encodeECB 加密-ECB模式

```
   /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   //key为base64,输出格式不传默认为base64
   let ecbEncode = AESSync.encodeECB('测试AES-ECB加密~', keyHex.getDataRow(), 'base64');
   //key为hex,输出格式为hex
   let ecbEncodeHex = AESSync.encodeECB('测试AES-ECB加密~', keyHex.getDataRow(), 'hex', 'hex');
   //key为hex,输出格式不传默认为base64
   let ecbEncodeBase64 = AESSync.encodeECB('测试AES-ECB加密~', keyHex.getDataRow(), 'hex');
   //key为普通字符串utf8,输出格式不传默认为base64
   let encode1 = AESSync.encodeECB('测试AES外部传入key加密~~~~', '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
   
```

* decodeECB 解密-ECB模式

```
    /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param aesKey AES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
   //key为base64,待解密数据格式不传默认为base64
   let ecbDecode = AESSync.decodeECB(ecbEncode.getDataRow(), keyHex.getDataRow(), 'base64');
   //key为hex,待解密数据格式为hex
   let ecbDecodeHex = AESSync.decodeECB(ecbEncodeHex.getDataRow(), keyHex.getDataRow(), 'hex', 'hex');
   //key为hex,待解密数据格式不传默认为base64
   let ecbDecodBase64 = AESSync.decodeECB(ecbEncodeBase64.getDataRow(), keyHex.getDataRow(), 'hex');
   //key为普通字符串utf8,待解密数据格式不传默认为base64
   let decode1 = AESSync.decodeECB(encode1.getDataRow(), '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
```

* encodeECB128 加密-ECB模式-128位

```
    /**
   * 加密-ECB模式-128位
   * @param str  待加密的字符串
   * @param aesKey   AES密钥-128位
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   //key为base64,输出格式不传默认为base64
   let ecbEncode = AESSync.encodeECB128('测试AES-ECB加密~', keyHex.getDataRow(), 'base64');
   //key为hex,输出格式为hex
   let ecbEncodeHex = AESSync.encodeECB128('测试AES-ECB加密~', keyHex.getDataRow(), 'hex', 'hex');
   //key为hex,输出格式不传默认为base64
   let ecbEncodeBase64 = AESSync.encodeECB128('测试AES-ECB加密~', keyHex.getDataRow(), 'hex');
   //key为普通字符串utf8,输出格式不传默认为base64
   let encode1 = AESSync.encodeECB128('测试AES外部传入key加密~~~~', '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
   
```

* decodeECB128 解密-ECB模式-128位

```
   /**
   * 解密-ECB模式-128位
   * @param str  加密的字符串
   * @param aesKey AES密钥-128位
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
   //key为base64,待解密数据格式不传默认为base64
   let ecbDecode = AESSync.decodeECB128(ecbEncode.getDataRow(), keyHex.getDataRow(), 'base64');
   //key为hex,待解密数据格式为hex
   let ecbDecodeHex = AESSync.decodeECB128(ecbEncodeHex.getDataRow(), keyHex.getDataRow(), 'hex', 'hex');
   //key为hex,待解密数据格式不传默认为base64
   let ecbDecodBase64 = AESSync.decodeECB128(ecbEncodeBase64.getDataRow(), keyHex.getDataRow(), 'hex');
   //key为普通字符串utf8,待解密数据格式不传默认为base64
   let decode1 = AESSync.decodeECB128(encode1.getDataRow(), '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
```

* encodeECB192 加密-ECB模式-192位

```
   /**
   * 加密-ECB模式-192位
   * @param str  待加密的字符串
   * @param aesKey   AES密钥-192位
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   //key为base64,输出格式不传默认为base64
   let ecbEncode = AESSync.encodeECB192('测试AES-ECB加密~', keyHex.getDataRow(), 'base64');
   //key为hex,输出格式为hex
   let ecbEncodeHex = AESSync.encodeECB192('测试AES-ECB加密~', keyHex.getDataRow(), 'hex', 'hex');
   //key为hex,输出格式不传默认为base64
   let ecbEncodeBase64 = AESSync.encodeECB192('测试AES-ECB加密~', keyHex.getDataRow(), 'hex');
   //key为普通字符串utf8,输出格式不传默认为base64
   let encode1 = AESSync.encodeECB192('测试AES外部传入key加密~~~~', '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
   
```

* decodeECB192 解密-ECB模式-192位

```
   /**
   * 解密-ECB模式-192位
   * @param str  加密的字符串
   * @param aesKey AES密钥-192位
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
   //key为base64,待解密数据格式不传默认为base64
   let ecbDecode = AESSync.decodeECB192(ecbEncode.getDataRow(), keyHex.getDataRow(), 'base64');
   //key为hex,待解密数据格式为hex
   let ecbDecodeHex = AESSync.decodeECB192(ecbEncodeHex.getDataRow(), keyHex.getDataRow(), 'hex', 'hex');
   //key为hex,待解密数据格式不传默认为base64
   let ecbDecodBase64 = AESSync.decodeECB192(ecbEncodeBase64.getDataRow(), keyHex.getDataRow(), 'hex');
   //key为普通字符串utf8,待解密数据格式不传默认为base64
   let decode1 = AESSync.decodeECB192(encode1.getDataRow(), '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
```

##### 3.3DESSync的方法【返回结果均为OutDTO对象】

* generate3DESKey 生成3DES的对称密钥

```
   /**
   * 生成3DES的对称密钥
   * @param resultCoding 生成3DES秘钥的字符串格式(hex/base64)-默认不传为base64格式
   * @returns 3DES密钥
   */
   //默认生成base64格式
   let key = DESSync.generate3DESKey();
   //生成hex格式
   let keyHex = DESSync.generate3DESKey('hex');
```

* encodeECB 加密-ECB模式

```
   /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param desKey   3DES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   let encodeEcb = DESSync.encodeECB('', key.getDataRow(), 'base64');
   let encodeEcbH = DESSync.encodeECB('', key.getDataRow(), 'base64', 'hex');
   let encodeEcbHex = DESSync.encodeECB('', keyHex.getDataRow(), 'hex');
   let encodeEcbHexH = DESSync.encodeECB('', keyHex.getDataRow(), 'hex', 'hex');
```

* decodeECB 解密-ECB模式

```
   /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param desKey  3DES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   */
   let decodeEcb = DESSync.decodeECB(encodeEcb.getDataRow(), key.getDataRow(), 'base64');
   let decodeEcbH = DESSync.decodeECB(encodeEcbH.getDataRow(), key.getDataRow(), 'base64', 'hex');
   let decodeEcbHex = DESSync.decodeECB(encodeEcbHex.getDataRow(), keyHex.getDataRow(), 'hex');
   let decodeEcbHexH = DESSync.decodeECB(encodeEcbHexH.getDataRow(), keyHex.getDataRow(), 'hex', 'hex');
```

* encodeCBC 加密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
    /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param aesKey   3DES密钥
   * @param iv   iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   let encodeCbc = DESSync.encodeCBC('', key.getDataRow(), iv.getDataRow(), 'base64');
   let encodeCbcH = DESSync.encodeCBC('', key.getDataRow(), iv.getDataRow(), 'base64', 'hex');
   let encodeCbcHex = DESSync.encodeCBC('', keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   let encodeCbcHexH = DESSync.encodeCBC('', keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
```

* decodeCBC 解密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
    /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey 3DES密钥
   * @param iv  iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
   let decodeCbc = DESSync.decodeCBC(encodeCbc.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64');
    let decodeCbcH = DESSync.decodeCBC(encodeCbcH.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64', 'hex');
    let decodeCbcHex = DESSync.decodeCBC(encodeCbcHex.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
    let decodeCbcHexH = DESSync.decodeCBC(encodeCbcHexH.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
```

##### 4.SM2Sync的方法【返回结果均为OutDTO对象】

* generateSM2Key 生成SM2的非对称密钥

```
   /**
   * 生成SM2的非对称密钥
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns SM2密钥{publicKey:公钥,privateKey:私钥}
   */
   let key = SM2Sync.generateSM2Key();
```

* encode 加密

```
   /**
   * 加密
   * @param encodeStr  待加密的字符串
   * @param pubKey  SM2公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   */
   let encode = SM2Sync.encode('测试SM2的加密~~~~', key.getDataRow().publicKey, 'base64');
   let encode = SM2Sync.encode('测试SM2的加密~~~~', key.getDataRow().publicKey, 'base64', 'hex');
```

* decode 解密

```
   /**
   * 解密
   * @param decodeStr  待解密的字符串
   * @param priKey    SM2私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   */
   let decode = SM2Sync.decode(encode.getDataRow(), key.getDataRow().privateKey, 'base64');
   let decode = SM2Sync.decode(encode.getDataRow(), key.getDataRow().privateKey, 'base64', 'hex');
```

* sign 签名

```
   /**
   * 签名
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns OutDTO<string> 签名对象
   */
   let sign = SM2Sync.sign('测试SM2的加密~~~~', key.getDataRow().privateKey, 'base64');
```

* verify 验签

```
   /**
   * 验签
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  SM2公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
   let verify = SM2Sync.verify(sign.getDataRow(), '测试SM2的加密~~~~', key.getDataRow().publicKey, 'base64');
```

* convertSM2PubKey 将服务器端生成的16进制的长度为130位的04开头的C1C3C2格式的SM2公钥转换为前端所需的ASN

```
    //C1C3C2格式的公钥字符串
    let pk = '04ba3bc3c5834d9ad1a7d81c4b49cf1209d2f28e4a97c73b75d6561792a2bfafe811e0284692006b0ce1b51f8aadfd65241d80eb979365048253408f5d705ec17b';
    //转换后的ASN.1格式的字符串
    let s = await SM2.convertSM2PubKey(pk);
    let code = await SM2.encode('加密字符~~~~~', s.getDataRow());
    let ddd = code.getDataRow();
```

* convertSM2PriKey 将服务器端生成的16进制的长度为64位的C1C3C2格式的SM2私钥转换为前端所需的ASN

```
    //C1C3C2格式的私钥字符串
    let pik = '7713d336bcbbffb8b7f9cab8db984a5c989a0b07697f569a06d5cd38e1351d07';
    //转换后的ASN.1格式的字符串
    let dc = await SM2.convertSM2PriKey(pik);
    let aaaa = await SM2.decode(ddd, dc.getDataRow());
    this.message = aaaa.getDataRow();
```

##### 5.SM3Sync的方法【返回结果均为OutDTO对象】

* digest SM3摘要

```
   /**
   * SM3摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
   let digest = SM3Sync.digest('测试SM3的digest~~~~');
```

* hmac 消息认证码计算

```
   /**
   * 消息认证码计算
   * @param str  计算字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns
   */
   let hmac = SM3Sync.hmac('测试SM3的hmac~~~~');
```

##### 6.SM4Sync的方法【返回结果均为OutDTO对象】

* generateSM4Key 生成SM4的对称密钥

```
   /**
   * 生成SM4的对称密钥
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns SM4密钥
   */
   let key = SM4Sync.generateSM4Key();
   let keyHex = SM4Sync.generateSM4Key('hex');
```

* encodeECB 加密-ECB模式

```
   /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param sm4Key   SM4密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns
   */
   let ecbEncode = SM4Sync.encodeECB('测试SM4-ECB加密-base64~', key.getDataRow(), 'base64');
   let ecbEncodeHex = SM4Sync.encodeECB('测试SM4-ECB加密-hex~', keyHex.getDataRow(), 'hex', 'hex');
   let ecbEncodeBase64 = SM4Sync.encodeECB('测试SM4-ECB加密-hex-base64~', keyHex.getDataRow(), 'hex');
   let encode1 = SM4Sync.encodeECB('测试SM4外部传入key加密~~~~', '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
```

* decodeECB 解密-ECB模式

```
   /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param sm4Key  SM4密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   */
   let ecbDecode = SM4Sync.decodeECB(ecbEncode.getDataRow(), key.getDataRow(), 'base64');
   let ecbDecodeHex = SM4Sync.decodeECB(ecbEncodeHex.getDataRow(), keyHex.getDataRow(), 'hex', 'hex');
   let ecbDecodBase64 = SM4Sync.decodeECB(ecbEncodeBase64.getDataRow(), keyHex.getDataRow(), 'hex');
   decode1 = SM4Sync.decodeECB(encode1.getDataRow(), '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
```

* encodeCBC 加密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
   /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param aesKey   SM4密钥
   * @param iv   iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
   let encode = SM4Sync.encodeCBC('测试SM4-CBC加密~~~~', key.getDataRow(), iv.getDataRow(), 'base64');
   let encodeHex = SM4Sync.encodeCBC('测试SM4-CBC加密-hex~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
   let encodeBase64 = SM4Sync.encodeCBC('测试SM4-CBC加密-base64~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   let encode2 = SM4Sync.encodeCBC("测试SM4外部传入key/iv加密~~~", "TESTsdiloia20230ass3[2K8%fw68sw7","ass3[2K8%fw68sw7", 'utf8');
   
```

* decodeCBC 解密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
   /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey SM4密钥
   * @param iv  iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns
   */
   let decode = SM4Sync.decodeCBC(encode.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64');
   let decodeHex = SM4Sync.decodeCBC(encodeHex.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
   let decodeBase64 = SM4Sync.decodeCBC(encodeBase64.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   let decode2 = SM4Sync.decodeCBC(encode2.getDataRow(), "TESTsdiloia20230ass3[2K8%fw68sw7", "ass3[2K8%fw68sw7", 'utf8');
```

##### 7.SHASync的方法【返回结果均为OutDTO对象】

* digest 摘要方法

```
   /**
   * SHA256摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
   let digest = SHASync.digest('测试SHASync~~~~~');
```

* digestSHA1 SHA1摘要

```
   /**
   * SHA1摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
   let digest = SHASync.digestSHA1('这个是SHA的摘要方法~~');
   this.message = digest.getDataRow();
```

* digestSHA224 SHA224摘要

```
   /**
   * SHA224摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
   let digest = SHASync.digestSHA224('这个是SHA的摘要方法~~');
   this.message = digest.getDataRow();
```

* digestSHA384 SHA384摘要

```
   /**
   * SHA384摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
   let digest = SHASync.digestSHA384('这个是SHA的摘要方法~~');
   this.message = digest.getDataRow();
```

* digestSHA512 SHA512摘要

```
   /**
   * SHA512摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
   let digest = SHASync.digestSHA512('这个是SHA的摘要方法~~');
   this.message = digest.getDataRow();
```

* hmac 消息认证码计算

```
   /**
   * 消息认证码计算
   * @param str  计算字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns
   */
   let hmac2 = SHASync.hmac('这个是SHA的HMAC');
   this.message = hmac2.getDataRow();
```

##### 8.MD5的方法【返回结果均为OutDTO对象】

* digest 摘要方法

```
   /**
   * MD5摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-不传默认为base64
   * @returns 摘要后的字符串
   */
   let md5 = MD5Sync.digest('使用MD5进行摘要~~~');
   this.message = md5.getDataRow();
```

* hash 散列哈希算法

```
   //默认不传编码格式为hex
   let hash = MD5.hash('测试MD5散列算法hex~~~');
   if (hash.getSuccess()) {
     this.msg = hash.getDataRow();
   }
   //传入base64表示生成的为base64的散列值
   let hash64 = MD5.hash('测试MD5散列算法base64~~~', 'base64');
   if (hash64.getSuccess()) {
     this.msg = hash64.getDataRow();
   }
```

* hmac hmac

```
  //生成16位的key
  let key = RandomUtil.generateIV();

  //默认不传编码格式为hex
  let hmac = MD5.hmac(key.getDataRow(), '测试MD5-hmac算法hex~~~~~');
  if (hmac.getSuccess()) {
    this.msg = hmac.getDataRow();
  }
  //传入base64表示生成的为base64的hmac值
  let hmac64 = MD5.hmac(key.getDataRow(), '测试MD5-hmac算法base64~~~~~', 'base64');
  if (hmac64.getSuccess()) {
    this.msg = hmac64.getDataRow();
  }
```

##### 9.ECDSASync的方法【返回结果均为OutDTO对象】

* generateECDSAKey 生成ECDSA的非对称密钥

```
   /**
   * 生成ECDSA的非对称密钥
   * @param resultCoding 生成ECDSA秘钥的字符串格式-默认不传为base64格式
   * @returns ECDSA密钥{publicKey:公钥,privateKey:私钥}
   */
   let ecdsa = ECDSASync.generateECDSAKey();
   console.error("generateECDSAKey:" + ecdsa.getSuccess() + "---" + ecdsa.getMsg()
   + "\n" + "公钥:" + ecdsa.getDataRow().publicKey + "私钥:" + ecdsa.getDataRow().privateKey)
```

* sign 签名

```
   /**
   * 签名
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64) - 不传默认为base64
   * @returns OutDTO<string> 签名对象
   */
   let sign = ECDSASync.sign('这个是ECDSA的验签字符串~~', ecdsa.getDataRow().privateKey);
   this.message = sign.getDataRow();
```

* verify 验签

```
   /**
   * 验签
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
   let verify = ECDSASync.verify(sign.getDataRow(), '这个是ECDSA的验签字符串~~', ecdsa.getDataRow().publicKey);
   this.message = verify.getMsg();
```

##### 10.ECDHSync的方法【返回结果均为OutDTO对象】

* ecdh 动态协商密钥,要求密钥长度为256位的非对称密钥

```
   /**
   * ecdh动态协商密钥,要求密钥长度为256位的非对称密钥
   * @param pubKey  符合256位的非对称密钥的公钥字符串或Uint8Array字节流  【一般为外部传入】
   * @param priKey  符合256位的非对称密钥的私钥字符串或Uint8Array字节流  【一般为本项目】
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns ECC256共享密钥
   */
```

```
    //1.测试随机生成的一种256长度的字符串公私钥秘钥
    //模拟当前项目的公钥
    let sm2Key = CryptoSyncUtil.generateCryptoKey('ECC256', 'base64');
    //模拟外部传入的私钥
    let eccKey = CryptoSyncUtil.generateCryptoKey('ECC256', 'base64');
    //动态协商
    let shareKey = ECDHSync.ecdh(sm2Key.getDataRow().publicKey, eccKey.getDataRow().privateKey, 'base64', 'base64');
    this.msg = "生成的共享密钥为:" + shareKey.getDataRow();

    //模拟加密
    let shareEncode = AESSync.encodeECB('使用ECDH共享密钥加密数据测试~~~~', shareKey.getDataRow(), 'base64');
    this.msg = shareEncode.getDataRow();
    //动态协商解密key
    let decodeKey = ECDHSync.ecdh(eccKey.getDataRow().publicKey, sm2Key.getDataRow().privateKey, 'base64', 'base64');
    //解密
    let shareDecode = AESSync.decodeECB(shareEncode.getDataRow(), decodeKey.getDataRow(), 'base64');
    this.msg = "共享密钥解密结果为:" + shareDecode.getDataRow();
    
```

```
    //2.测试随机生成的一种256长度的字节流Uint8Array形式的公私钥秘钥
    // 创建非对称密钥生成器
    let rsaGenerator = crypto.createAsyKeyGenerator('ECC256');
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseKeyPair = await rsaGenerator.generateKeyPair();
    // 转换成可以读懂的公私钥字符串
    let pubKey = promiseKeyPair.pubKey.getEncoded().data;
    let priKey = promiseKeyPair.priKey.getEncoded().data;
    //获取到贡献密钥
    let shareKey = ECDHSync.ecdh(pubKey, priKey);
    
    //模拟加密
    let shareEncode = AESSync.encodeECB('使用ECDH共享密钥加密数据测试~~~~', shareKey.getDataRow(), 'base64');
    this.msg = shareEncode.getDataRow();
    
    //解密
    let shareDecode = AESSync.decodeECB(shareEncode.getDataRow(), decodeKey.getDataRow(), 'base64');
    this.msg = "共享密钥解密结果为:" + shareDecode.getDataRow();
    
```

##### 11.X25519Sync的方法【返回结果均为OutDTO对象】

* x25519 X25519动态协商密钥,要求密钥长度为256位的非对称密钥

```
    /**
   * X25519动态协商密钥,要求密钥长度为256位的非对称密钥
   * @param pubKey  符合非对称密钥的公钥字符串或Uint8Array字节流  【一般为外部传入】
   * @param priKey  符合非对称密钥的私钥字符串或Uint8Array字节流  【一般为本项目】
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 256位共享密钥字符串
   */
```

```
    //1.测试随机生成的一种256长度的字符串公私钥秘钥
    let x25519Key = await CryptoUtil.generateCryptoKey('X25519');
    //将对方的公钥和自己的私钥传入生成256位的共享秘钥
    let x25519 = X25519Sync.x25519(x25519Key.getDataRow().publicKey, x25519Key.getDataRow().privateKey);
    this.message = x25519.getDataRow();
    //可以进行对称加密 注意对称加解密也需要为256位
    let encode = await CryptoUtil.encodeECB('测试共享密钥加密数据~~~', x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = encode.getDataRow();
    //对称解密
    let decode = await CryptoUtil.decodeECB(encode.getDataRow(), x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = decode.getDataRow();
```

```
    //2.测试随机生成的一种256长度的字节流Uint8Array形式的公私钥秘钥
    let rsaGenerator = crypto.createAsyKeyGenerator('X25519');
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseKeyPair = await rsaGenerator.generateKeyPair();
    // 转换成可以读懂的公私钥字符串
    let pubKey = promiseKeyPair.pubKey.getEncoded().data;
    let priKey = promiseKeyPair.priKey.getEncoded().data;
    let x25519 = await X25519Sync.x25519(pubKey, priKey);
    //可以进行对称加密 注意对称加解密也需要为256位
    let encode = await CryptoUtil.encodeECB('测试共享密钥加密数据~~~', x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = encode.getDataRow();
    //对称解密
    let decode = await CryptoUtil.decodeECB(encode.getDataRow(), x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = decode.getDataRow();
```

##### 12.SHA1的方法【返回结果均为OutDTO对象】(1.2.1-rc.1-rc.0+)

* hash 散列哈希算法

```
  let sha1 = SHA1.hash('测试SHA1散列算法~~~~~~~');
  if (sha1.getSuccess()) {
    this.msg = sha1.getDataRow();
  }
```

### 4.JSON相关组件使用API

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

### 5.网络相关类组件使用API(V1.2.1-rc.2+有改动)

#### 5.1 efAxios

##### 前言

> efAxios封装需要大家共建和提出建议与需求,已完善传输整体加解密,关键字加解密,统一上传下载等,期待大家提出宝贵意见

> 接到大部分开发者反馈需要有一个统一的请求全局加载loading,故在本版本默认集成,后续可能会有样式优化(V1.2.1-rc.1+)

- 效果图  
  [![loading.th.jpg](https://z4a.net/images/2024/07/20/loading.png)](https://z4a.net/image/jReQM0)

> 后端Demo示例为Java开发,大家自行下载使用与阅读,如有问题请提出Issue

> 后端Demo示例地址[点此访问](https://gitee.com/yunkss/ef-axios-java)

##### 1.efAxiosParams类参数详解

```
  /**
   * 是否整体传输加密 与关键字加密isAllEncrypt互斥 二者只能有其一为true
   */
  static isAllEncrypt: boolean = false;
  /**
   * 是否部分关键字传输加密 与整体传输加密互斥 二者只能有其一为true
   */
  static isPartEncrypt: boolean = false;
  /**
   * 关键字加密时的关键字集合
   */
  static keyWordsList: Array<string> = new Array<string>();
  /**
   * 用户自定义token的Key,默认为Authorization 
   */
  static tokenName: string = 'Authorization';
  /**
   * 登录成功后的token值
   */
  static tokenValue: string = '';
  /**
   * 服务器 URL
   */
  static baseURL: string = '';
  /**
   * 请求头加密的SM2公钥
   */
  static sm2PubKey: string = '';
   /**
   *加解密接口忽略集合
   */
  static ignoreEncryptList: Array<string> = new Array<string>();
  /**
   * 是否将响应数据转换为OutDTO对象,默认为true,如业务后台返回无法转换则关闭
   */
  static isConvertDTO: boolean = true;
  /**
   * 是否开启全局请求loading弹框,默认为true(1.2.1-rc.2+)
   */
  static isLoading: boolean = true;
  /**
   * 全局loading的加载内容,默认值为[努力获取数据中,请稍后...](1.2.1-rc.2+)
   */
  static loadingTxt: string = '努力获取数据中,请稍后...';
  /**
   * 是否开启日志(1.2.1-rc.2+)
   */
  static isLogger: boolean = true;
```

##### 2.AxiosUtil工具类(V1.2.1-rc.2有改动)

* efAxios 全局对象

```
  该变量为抛出的全局二次封装的全局axios对象,默认超时时间为10s
```

* convertRequestInfo 封装的针对于统一请求的处理

```
   //1.统一给请求头添加nonce防篡改校验因子,业务自行实现,如有需求也可在后续demo中完善
   //2.统一给请求头添加timestamp防重放的随机数因子,业务自行实现,如有需求也可在后续demo中完善
   //3.设置默认请求类型 application/json
   //4.添加统一的isAllEncrypt=true时整体加密
   //5.添加统一的isPartEncrypt=true时根据关键字加密
   //6.添加统一的请求头签名sign字段
```

* convertResponseInfo 封装的针对于统一响应的处理 【统一返回OutDTO<T>】

```
  //新增efAxiosParams.isConvertDTO来根据业务需要自行决定是否开启封装返回数据为OutDTO
  //目前只对返回数据格式做了统一的OutDTO转换   
  //要求后端返回的数据格式包含OutDTO中的success,msg   
  //dataRow和dataTable业务数据自行选择,非必填
```

> 在V1.2.1-rc.1中增加了统一的全局loading,并且针对于请求异常做了统一编码的返回

> 如果efAxiosParams.isConvertDTO=true,则所有的异常均转换成OutDTO对象返回

> 如果efAxiosParams.isConvertDTO=false,则所有异常返回为AxiosError业务自行处理

##### 3.EfClientApi工具类(V1.2.1-rc.2有改动)

> 该工具类提供统一简化各种请求方式,入参为json格式内部进行转换为所需对象

* post请求 json格式 async/await 方式

> V1.2.1-rc.1中将异常抛出给上级如果使用了转换为OutDTO则抛出异常为OutDTO,否则为AxiosError

```
    //参数说明
    async post<F, E>(url: string, query: Record<string, Object>, headers?: Record<string, Object>): Promise<E> 
    //url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+url 组合而成
    //F 为请求入参对象,具体参照示例中的写法
    //E 为响应结果对象,格式为OutDTO<T> T为业务自定义对象
    //headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //query 为JSON格式的请求参数key需要为字符串类型必须使用引号包裹 在方法内会将JSON转换为请求对象F,业务无需关心
```

* post请求 formData格式 async/await 方式(V1.2.1-rc.2+)

> V1.2.1-rc.2中将异常抛出给上级如果使用了转换为OutDTO则抛出异常为OutDTO,否则为AxiosError

```
    //参数说明
    async postFormData<E>(url: string, formData: FormData, headers?: Record<string, Object>): Promise<E>
    //url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+url 组合而成
    //formData 业务传入的formData数据
    //E 为响应结果对象,格式为OutDTO<T> T为业务自定义对象
    //headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
```

* get请求 async/await 方式

> V1.2.1-rc.1中将异常抛出给上级如果使用了转换为OutDTO则抛出异常为OutDTO,否则为AxiosError

```
    //参数说明 格式为  getXXXX/id/name/xxxx
    async get<E>(url: string, headers?: Record<string, Object>): Promise<E>
    //url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+url 组合而成
    //headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //注意demo中的get请求为rest方式,即入参无需?param1=value,而是 get方法/param1/param2 以此类推
    //E 为响应结果对象,格式为OutDTO<T> T为业务自定义对象
```

* getByParams请求 async/await 方式

> V1.2.1-rc.1中将异常抛出给上级如果使用了转换为OutDTO则抛出异常为OutDTO,否则为AxiosError

```
    //参数说明   参数为json格式
    async getByParams<E>(url: string, params: Record<string, Object>, headers?: Record<string, Object>): Promise<E>
    //url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+url 组合而成
    //headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //params表示get请求的入参妇科key:value格式
    //E 为响应结果对象,格式为OutDTO<T> T为业务自定义对象
    
```

* delete请求 async/await 方式

> V1.2.1-rc.1中将异常抛出给上级如果使用了转换为OutDTO则抛出异常为OutDTO,否则为AxiosError

```
    //参数说明
    async delete<E>(url: string, headers?: Record<string, Object>): Promise<E>
    //url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+url 组合而成
    //headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //注意demo中的delete请求为rest方式,即入参方式为 delete方法/param1/param2 以此类推
    //E 为响应结果对象,格式为OutDTO<T> T为业务自定义对象
```

* put请求 async/await 方式

> V1.2.1-rc.1中将异常抛出给上级如果使用了转换为OutDTO则抛出异常为OutDTO,否则为AxiosError

```
    //参数说明
    async put<F, E>(url: string, query: Record<string, Object>,headers?: Record<string, Object>): Promise<E>
    //url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+url 组合而成
    //query 为JSON格式的请求参数key需要为字符串类型必须使用引号包裹 在方法内会将JSON转换为请求对象F,业务无需关心
    //headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //F 为请求入参对象,具体参照示例中的写法
    //E 为响应结果对象,格式为OutDTO<T> T为业务自定义对象
```

* upload 统一的上传请求 async/await 方式

> V1.2.1-rc.1-rc.1中将异常抛出给上级如果使用了转换为OutDTO则抛出异常为OutDTO,否则为AxiosError

```
    //参数说明
    async upload(url: string, isUri: boolean, progressCallBack: (process: number) => void,data?: ArrayBuffer, uri?: string, keyName?: string, headers?: Record<string, Object>)
    //url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+url 组合而成
    //isUri  是否为uri文件
    //progressCallBack 上传进度回调,具体参照示例中的写法
    //data  isUri=false时传入 表示上传的文件为ArrayBuffer格式
    //uri   isUri=true时传入  表示上传的文件为uri格式
    //keyName  上传时后端接收的key,默认为file
    //headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
```

* download 统一的下载请求 async/await 方式

> V1.2.1-rc.1-rc.1中将异常抛出给上级如果使用了转换为OutDTO则抛出异常为OutDTO,否则为AxiosError

```
    //参数说明
    async download(url: string, filePath: string, progressCallBack: (process: number) => void, headers?: Record<string, Object>)
    //url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+url 组合而成
    //filePath  下载文件名称 如下载png图片后希望名称为girl.png
    //progressCallBack  下载进度回调方法
    //headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
```

* 登录示例

```
    //如不需要全局loading则如下设置
    efAxiosParams.isLoading = false;
    //如需更改loading提示则如下设置
    efAxiosParams.loadingTxt = '小的快马加鞭...';
    //如果不需要响应数据转换为OutDTO则将efAxiosParams.isConvertDTO设置为false
    efAxiosParams.isConvertDTO = false;
    const loginNoDTO = await efClientApi.post<UserQuery,UserDTO>('/api/eftool/login', {
      'account': 'efadmin',
      'pwd': '123456'
    }, {
      'csxTest': '1212121212'
    });
    if (loginNoDTO.token) {
      ToastUtil.showToast('登录成功,token为:'+loginNoDTO.token);
    }
```

```
    //1.先设置统一的请求后端前缀 具体时机业务自行决定,Ability中也可
    efAxiosParams.baseURL = 'http://192.168.1.126:18088';
    //2.调用接口
    //模拟登录 UserQuery为请求参数,OutDTO<UserDTO>为响应的结果,OutDTO中的对象为业务自己创建
    const login = await efClientApi.post<UserQuery, OutDTO<UserDTO>>('/api/eftool/login', {
      'account': 'efadmin',
      'pwd': '123456'
    }, { 
      'testAddHeader': '1212121212'   //此处表示当前请求会额外将testAddHeader添加到请求头中
    });
    //登录成功
    if (login.getSuccess()) {
      //登录成功将token赋值，后续需要,默认token的key为Authorization
      //如果需要更换业务调用efAxiosParams.tokenName = '业务自定义的token名称'
      efAxiosParams.tokenName = '如此处更换为efToken';
      efAxiosParams.tokenValue = login.getDataRow().token;
    } else {
      //登录失败
      ToastUtil.showToast(login.getMsg());
    }
```

* post示例

```
      //模拟测试post请求  此时的请求头中已经存在token字段
      //UserQuery为请求参数,OutDTO<Record<string, Object>>为响应的结果,OutDTO中的对象为业务自己创建
      const post = await efClientApi.post<UserQuery, OutDTO<Record<string, Object>>>('/api/eftool/post', {
        'nickName': 'post请求参数',
        'name': '测试入参'
      });
      if (post.getSuccess()) {
        ToastUtil.showToast(JSONUtil.toJSONString(post.getDataRow()));
      }
```

* get示例

```
      //模拟测试get请求
      //OutDTO<Record<string, Object>>为响应的结果,OutDTO中的对象为业务自己创建
      const get = await efClientApi.get<OutDTO<Record<string, Object>>>('/api/eftool/get/11111111');
      if (get.getSuccess()) {
        ToastUtil.showToast(JSONUtil.toJSONString(get.getDataRow()));
      }
```

* put示例

```
      //模拟测试put请求
      //UserQuery为请求参数,OutDTO<Record<string, Object>>为响应的结果,OutDTO中的对象为业务自己创建
      const put = await efClientApi.put<UserQuery, OutDTO<Record<string, Object>>>('/api/eftool/put', {
        'id': '11111'
      });
      if (put.getSuccess()) {
        ToastUtil.showToast(JSONUtil.toJSONString(put.getDataRow()));
      }
```

* delete示例

```
      //模拟测试delete请求
      //OutDTO<Record<string, Object>>为响应的结果,OutDTO中的对象为业务自己创建
      const del = await efClientApi.delete<OutDTO<Record<string, Object>>>('/api/eftool/delete/1212133');
      if (del.getSuccess()) {
        ToastUtil.showToast(JSONUtil.toJSONString(del.getDataRow()));
      }
```

* 上传示例

```
      //模拟文件上传
      async testUpload() {
          this.showDownBtn = Visibility.Visible;
          efAxiosParams.baseURL = 'http://192.168.1.126:18088';
          let ctx = getContext() as common.UIAbilityContext;
          let imageArray = await ctx.resourceManager.getMediaContent($r('app.media.notice').id);
          let imageResource = imageArray.buffer as ArrayBuffer;
          let res = await efClientApi.upload('/api/eftool/upload', false, (progress: number) => {
            if (progress >= 100) {
              this.showDownBtn = Visibility.None;
            }
            this.process = progress;
          }, imageResource);
          this.msg = res ? res["dataRow"] : '';
     }
```

* 下载示例

```
      //模拟测试文件下载
      async testDownload() {
        efAxiosParams.baseURL = 'http://192.168.1.126:18088';
        this.showDownBtn = Visibility.Visible;
        let res = await efClientApi.download('/api/eftool/download/0d6a25e4-f61b-48eb-8a12-53f82c5b957d-default1715324534920.png', 'girl.png', (progress: number) => {
          if (progress >= 100) {
            this.showDownBtn = Visibility.None;
          }
          this.process = progress;
        });
        this.msg = res ? res["msg"] : '';
      }
```

#### 5.2 efRcp (V1.2.1-rc.2+)

##### 前言

> efRcp封装需要大家共建和提出建议与需求,已完善传post,postForm,put,get,delete,cancel请求,统一上传下载,以及配置证书,期待大家提出宝贵意见

> 后端Demo示例为Java开发,大家自行下载使用与阅读,如有问题请提出Issue

> 后端Demo示例地址[点此访问](https://gitee.com/yunkss/ef-axios-java)

##### 1.efRcpParams类参数详解

```
  /**
   * 登录成功后的token的key
   */
  static tokenName: string = 'authorization';
  /**
   * 登录成功后的token值
   */
  static tokenValue: string = '';
  /**
   * 是否将响应数据转换为OutDTO对象,默认为true,如业务后台返回无法转换则关闭
   */
  static isConvertDTO: boolean = true;
  /**
   * 服务器 URL
   */
  static baseURL: string;
  /**
   * 是否开启全局请求loading弹框,默认为true
   */
  static isLoading: boolean = true;
  /**
   * 全局loading的加载内容,默认值为[努力获取数据中,请稍后...]
   */
  static loadingTxt: string = '努力获取数据中,请稍后...';
  /**
   * 允许建立连接的最长时间
   */
  static connectMs: number = 5000;
  /**
   * 允许传输数据的最长时间
   */
  static transferMs: number = 10000;
  /**
   * 会话session请求取消事件回调
   */
  static cancelCallBack?: () => void;
  /**
   *  会话session关闭事件回调
   */
  static closeCallBack?: () => void;
  /**
   * 是否开启证书加密,默认为false
   */
  static isSecurity: boolean = false;
  /**
   * 是否开启全局日志打印,默认为true
   */
  static isLogger: boolean = true;
```

##### 2.EfRcpUtil工具类

* efRcpInstance 全局rcp的session对象

```
  该变量为抛出封装的全局rcp对象,默认超时时间为10s
```

* getRcp 封装创建rcp实例方法

```
   //1.统一拦截器
   //2.设置默认请求类型 application/json
   //3.设置默认传输超时时间为10s
   //4.设置默认连接超时时间为5s
   //5.设置此会话中允许的最大同时为80
```

##### 3.EfRcpClientApi工具类

> 该工具类提供统一简化各种请求方式

* buildRequest 私有方法 构建Request请求

* buildResponse 私有方法 构建Response响应对象

* post请求 json格式 async/await 方式

```
    //参数说明
    async post<E>(url: string, query: Record<string, Object>, headers?: Record<string, string>,cookies?: Record<string, string>, loadingTxt?: string, isSecurity?: boolean): Promise<E>
    //url 为请求方法的url 全路径应该为 efRcpParams.baseURL+url 组合而成
    //query 业务传入的请求数据
    //headers 提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //cookies 自定义cookie
    //loadingTxt 是否覆写loading文本
    //isSecurity 是否开启证书加密
    //E 为响应结果对象
```

* postForm请求 async/await 方式

```
    //参数说明   参数为json格式
    async postForm<E>(url: string, query: rcp.FormFields, headers?: Record<string, string>,cookies?: Record<string, string>, loadingTxt?: string, isSecurity?: boolean): Promise<E>
    //url 为请求方法的url 全路径应该为 efRcpParams.baseURL+url 组合而成
    //query 业务传入的FormFields请求数据
    //headers 提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //cookies 自定义cookie
    //loadingTxt 是否覆写loading文本
    //isSecurity 是否开启证书加密
    //E 为响应结果对象
    
```

* get请求 async/await 方式

```
    //参数说明 格式为  getXXXX/id/name/xxxx
    async get<E>(url: string, headers?: Record<string, string>,cookies?: Record<string, string>, loadingTxt?: string, isSecurity?: boolean): Promise<E>
    //url 为请求方法的url 全路径应该为 efRcpParams.baseURL+url 组合而成
    //headers 提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //cookies 自定义cookie
    //loadingTxt 是否覆写loading文本
    //isSecurity 是否开启证书加密
    //E 为响应结果对象
```

* put请求 async/await 方式

```
    //参数说明
    async put<E>(url: string, query: Record<string, Object>, headers?: Record<string, string>,cookies?: Record<string, string>, loadingTxt?: string, isSecurity?: boolean): Promise<E>
    //url 为请求方法的url 全路径应该为 efRcpParams.baseURL+url 组合而成
    //query 业务传入的请求数据
    //headers 提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //cookies 自定义cookie
    //loadingTxt 是否覆写loading文本
    //isSecurity 是否开启证书加密
    //E 为响应结果对象
```

* delete请求 async/await 方式

```
    //参数说明
    async delete<E>(url: string, headers?: Record<string, string>,cookies?: Record<string, string>, loadingTxt?: string, isSecurity?: boolean): Promise<E>
    //url 为请求方法的url 全路径应该为 efRcpParams.baseURL+url 组合而成
    //headers 提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //cookies 自定义cookie
    //loadingTxt 是否覆写loading文本
    //isSecurity 是否开启证书加密
    //E 为响应结果对象
```

* cancel请求 async/await 方式

```
    //参数说明
    async cancel(url: string)
    //url 为取消请求方法的url 全路径应该为 efRcpParams.baseURL+url 组合而成
```

* uploadFile 统一的上传请求MultipartFormFields形式 async/await 方式

```
    //参数说明
    async uploadFile<E>(url: string, fileInfo: rcp.MultipartFormFields, progressCallBack: (progress: number) => void,headers?: Record<string, string>,cookies?: Record<string, string>, loadingTxt?: string, isSecurity?: boolean): Promise<E>
    //url 为请求方法的url 全路径应该为 efRcpParams.baseURL+url 组合而成
    //fileInfo  需要上传的文件MultipartFormFields对象
    //headers 提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //cookies 自定义cookie
    //loadingTxt 是否覆写loading文本
    //isSecurity 是否开启证书加密
    //E 为响应结果对象
```

* downloadFile 统一的下载请求 async/await 方式

```
    //参数说明
    async downloadFile<E>(url: string, fileName: string, progressCallBack: (progress: number) => void,loadingTxt?: string, isSecurity?: boolean)
    //url 为请求方法的url 全路径应该为 efRcpParams.baseURL+url 组合而成
    //fileName  下载文件名称 如下载png图片后希望名称为girl.png
    //progressCallBack  下载进度回调方法
    //loadingTxt 是否覆写loading文本
    //isSecurity 是否开启证书加密
```

* downloadStream 统一的下载请求 async/await 方式

```
    //参数说明
    async downloadStream<E>(url: string, fileName: string, progressCallBack: (progress: number) => void,loadingTxt?: string, isSecurity?: boolean)
    //url 为请求方法的url 全路径应该为 efRcpParams.baseURL+url 组合而成
    //fileName  下载文件名称 如下载png图片后希望名称为girl.png
    //progressCallBack  下载进度回调方法
    //loadingTxt 是否覆写loading文本
    //isSecurity 是否开启证书加密
```

* 初始化参数配置示例

> 请求相关的参数配置建议在Ability的onWindowStageCreate方法中配置

> 可使用BuildProfile获取到当前运行的还是debug/qa/test/release等 然后设置不同的请求信息

```
  if(运行环境===debug){
    //关于rcp的配置
    efRcpParams.baseURL = "http://192.168.0.101:18088";
    efRcpParams.loadingTxt = '小的快马加鞭...';
    efRcpParams.isLogger = true;
    efRcpParams.isLoading = false;
  }
  if(运行环境===qa){
    //关于rcp的配置
    efRcpParams.baseURL = "http://192.168.0.222:18088";
    efRcpParams.loadingTxt = '正在努力加载...';
    //设置证书内容
    efRcpSecurityParam.certContent = '111111111';
    efRcpParams.isLogger = false;
    efRcpParams.isLoading = true;
  }
```

* 登录示例

```
  async testLogin() {
    let dto = await efRcpClientApi.post <OutDTO<UserDTO>>('/api/eftool/login', {
      'account': 'efadmin',
      'pwd': '123456'
    }, {}, {}, '更改了请求loading内容...');
    if (dto.getSuccess()) {
      let res = JSONObject.toJSONString(dto);
      ToastUtil.showToast(res);
      this.message = res;
      //请求成功后将token存储在efRcpParams.tokenValue
      efRcpParams.tokenValue = dto.getDataRow().token;
    } else {
      ToastUtil.showToast(JSONObject.toJSONString(dto));
    }
  }
```

* post示例 json格式

```
  async testPostJSON() {
    let dto = await efRcpClientApi.post <OutDTO<UserDTO>>('/api/eftool/post', {
      "nickName": "旺旺崔冰冰",
      "account": 'yunkss@163.com',
      "age": 12,
      "hobby": ["吃", "喝", "敲代码"],
      "sex": true
    });
    if (dto.getSuccess()) {
      let res = JSONObject.toJSONString(dto);
      ToastUtil.showToast(res);
      this.message = res;
    } else {
      ToastUtil.showToast(JSONObject.toJSONString(dto));
    }
  }
```

* post示例 form格式

```
  async testPostForm() {
    let dto = await efRcpClientApi.postForm<OutDTO<string>>('/api/eftool/postFormData', {
      "nickName": "旺旺崔冰冰",
      "account": 'yunkss@163.com',
      "age": 12,
      "hobby": ["吃", "喝", "敲代码"],
      "sex": true
    });
    if (dto.getSuccess()) {
      let res = JSONObject.toJSONString(dto);
      ToastUtil.showToast(res);
      this.message = res;
    } else {
      ToastUtil.showToast(JSONObject.toJSONString(dto));
    }
  }
```

* get示例

```
  async testGet() {
    let dto = await efRcpClientApi.get<OutDTO<string>>('/api/eftool/get/122341', {
      "testHeader": "111"
    }, {
      "testCookie": "csx"
    });
    if (dto.getSuccess()) {
      let res = JSONObject.toJSONString(dto);
      ToastUtil.showToast(res);
      this.message = res;
    } else {
      ToastUtil.showToast(JSONObject.toJSONString(dto));
    }
  }
```

* put示例

```
  async testPUT() {
    let dto = await efRcpClientApi.put<OutDTO<string>>('/api/eftool/put', {
      "nickName": "旺旺崔冰冰",
      "account": 'yunkss@163.com',
      "age": 12,
      "hobby": ["吃", "喝", "敲代码"],
      "sex": true
    });
    if (dto.getSuccess()) {
      let res = JSONObject.toJSONString(dto);
      ToastUtil.showToast(res);
      this.message = res;
    } else {
      ToastUtil.showToast(JSONObject.toJSONString(dto));
    }
  }
```

* delete示例

```
  async testDelete() {
    let dto = await efRcpClientApi.delete<OutDTO<string>>('/api/eftool/delete/5345345');
    if (dto.getSuccess()) {
      let res = JSONObject.toJSONString(dto);
      ToastUtil.showToast(res);
      this.message = res;
    } else {
      ToastUtil.showToast(JSONObject.toJSONString(dto));
    }
  }
```

* cancel示例

```
  async testCancel() {
    let dto = await efRcpClientApi.post <OutDTO<UserDTO>>('/api/eftool/post', {
      "nickName": "旺旺崔冰冰",
      "account": 'yunkss@163.com',
      "age": 12,
      "hobby": ["吃", "喝", "敲代码"],
      "sex": true
    });
    await efRcpClientApi.cancel('/api/eftool/post');
  }
```

* 上传示例

```
  async testUploadFile() {
    //拉起选中照片
    let result = await PickerUtil.selectPhotoVideo();
    //判断是否成功
    if (result.getSuccess()) {
      let list = result.getDataTable();
      //获取选中照片uri
      let item = list[0];
      //创建文件信息
      let fileUriObject = new fileUri.FileUri(item);
      //获取文件名
      let name = fileUriObject.name;
      //获取流
      let bufferImg = FileUtil.getBufferByURI(item);
      this.btnCtx = "正在上传中...";
      this.showDownBtn = Visibility.Visible;
      //上传
      let dto =
        await efRcpClientApi.uploadFile<OutDTO<string>>('/api/eftool/upload', {
          "file": {
            contentType: 'multipart/form-data',
            remoteFileName: name,
            contentOrPath: {
              content: bufferImg.getDataRow()
            }
          }
        }, (progress) => {
          if (progress >= 100) {
            this.showDownBtn = Visibility.None;
            this.process = 0;
          } else {
            this.process = progress;
          }
        });
      let res = JSONObject.toJSONString(dto);
      ToastUtil.showToast(res);
      this.message = res;
    }
  }
```

* 下载示例

```
  async testDownloadStream() {
    this.btnCtx = "正在下载中...";
    this.showDownBtn = Visibility.Visible;
    let dto =
      await efRcpClientApi.downloadStream<OutDTO<string>>('/api/eftool/download/a89d3c16-1dba-4a41-909f-1214f52d3466-IMG_20240214_212821.jpg',
        'abc.jpg', (progress) => {
          if (progress >= 100) {
            this.showDownBtn = Visibility.None;
            this.process = 0;
          } else {
            this.process = progress;
          }
        });
    //获取文件路径
    let url = FileUtil.getFilesDirPath('', 'abc.jpg');
    //转换成uri
    let uri = fileUri.getUriFromPath(url);
    //预览
    await PreviewUtil.previewImage(uri);
    this.message = JSONObject.toJSONString(dto);
  }
```

```
  async testDownloadFile() {
    this.btnCtx = "正在下载中...";
    this.showDownBtn = Visibility.Visible;
    let dto =
      await efRcpClientApi.downloadFile<OutDTO<string>>('/api/eftool/download/7626f4b1-9835-4eb4-8660-ae299ba4733a-IMG_20240214_212933.jpg',
        'csx.jpg', (progress) => {
          if (progress >= 100) {
            this.showDownBtn = Visibility.None;
            this.process = 0;
          } else {
            this.process = progress;
          }
        })
    //获取文件路径
    let url = FileUtil.getFilesDirPath('', 'csx.jpg');
    //转换成uri
    let uri = fileUri.getUriFromPath(url);
    //预览
    await PreviewUtil.previewImage(uri);
    this.message = JSONObject.toJSONString(dto);
  }
```

##### 5.CertificateUtil工具类

* readClientCerts 读取指定文件中的证书内容

* getRcpSecurityCfg 获取组装的rcp安全校验配置

#### 5.3 NetUtil网络工具类(V1.2.1-rc.2+)

* getAllNets 获取所有处于连接状态的网络列表

* hasDefaultNet 检查默认数据网络是否激活

* getAppNet 获取App绑定的网络信息

* isWiFi 判断当前网络是否是WiFi

* register 注册网络监听

* unregister 取消注册

### 6.UI组件相关使用API

#### 1.ToastUtil的方法

* showToast 弹出文本消息提示框

```
  入参
  msg:提示消息
  options: {
    duration:'',
    bottom:'',
    showMode:0
  }  提示参数duration为显示时长，bottom为距离底部位置,showMode设置弹窗是否显示在应用之上0内,1上
  示例
  ToastUtil.showToast('提示信息');//使用默认参数
  ToastUtil.showToast('duration:4000,bottom:50vp', { duration: 4000, bottom: '50vp', showMode: 1 });//修改参数
```

#### 2.DialogUtil的方法

* showDialog 弹出一个Dialog提示框

```
    入參
    options: {
     title:标题默认为温馨提示,
     msg:提示消息,
     okText:确定按钮文本,
     cancelText:取消按钮文本,
     alignment:弹窗在竖直方向上的对齐方式,
     maskRect:弹窗遮蔽层区域,
     isModal:弹窗是否为模态窗口,
     offset:弹窗相对alignment所在位置的偏移量,
     okCallBack:确定按钮事件,
     cancelCallBack:取消按钮事件,不传入cancelCallBack则显示一个按钮
    }
    Button("dialog").margin({ bottom: '10vp' }).onClick(() => {
     DialogUtil.showDialog({
        msg: '这是一个弹框提示~~~~',
        okCallBack: this.ok,
        okText: '揍你',
        cancelText: '去吧',
        cancelCallBack: this.cancel
      });
    })
    Button("dialog一个按钮").margin({ bottom: '10vp' }).onClick(() => {
      DialogUtil.showDialog({
        msg: '不写cancelCallBack则显示一个按钮',
        okCallBack: this.test   //调用方法无需小括号()
      });
    })
    Button("dialog修改参数").margin({ bottom: '10vp' }).onClick(() => {
      DialogUtil.showDialog({
        msg: '这是一个弹框提示',
        okText: '同意',
        okCallBack: this.test, //调用方法无需小括号()
        cancelCallBack: this.cancel
      });
    })
```

* showAlertDialog 弹出一个警告提示框

```
    入參
    options
    {
     msg:警告消息,
     title:提示标题默认为(警告提示),
     subtitle:副标题,
     autoCancel:点击遮罩是否自动关闭默认为(false),
     alignment:弹框对齐方式默认为(底部Bottom),
     gridCount:宽度所占用栅格数默认为10,
     offset:弹窗相对alignment所在位置的偏移量,
     buttons:弹框按钮集合,
     maskRect:弹窗遮蔽层区域
    }
    buttons:AlertDialogBtn 弹框按钮类只允许有两个第一个为确认按按,第二个为取消按钮
    buttons的类型
    [
      {
        value:确定按钮文本默认为确定,
        fontColor:文本颜色默认为#fff,
        backgroundColor:背景颜色默认值为#409eff,
        callBack:确定按钮回调事件,
        enabled:点击Button是否响应,
        defaultFocus:设置Button是否是默认焦点,
        style:设置Button的风格样式
      },//确定按钮
      {
        value:取消按钮文本默认为取消,
        fontColor:文本颜色默认为#fff,
        backgroundColor:背景颜色默认值为#dcdfe6,
        callBack:取消按钮回调事件,
        enabled:点击Button是否响应,
        defaultFocus:设置Button是否是默认焦点,
        style:设置Button的风格样式
      }//取消按钮
    ]
    //使用默认参数
    DialogUtil.showAlertDialog({
      msg: "这个是一个，默认警告弹框",
      buttons: [
        { callBack: this.ok }
      ]
    });
    //使用自定义参数
   DialogUtil.showAlertDialog({
     msg: "这个是一个警告弹框",
     title: '标题',
     alignment: DialogAlignment.Top,
     buttons: [
       { callBack: this.ok, style: DialogButtonStyle.HIGHLIGHT },
       { callBack: this.cancel }
     ]
   });
```

#### 3.ActionUtil的方法

* showActionMenu 显示操作菜单

```
    入參
    options: {
      title:标题 默认为温馨提示,
      btn:需要显示的菜单项,最大支持6个,
      showInSubWindow:某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗,
      isModal:弹窗是否为模态窗口，模态窗口有蒙层，非模态窗口无蒙层
    }
    Buttons:{
      text:菜单项标题
      color:菜单项颜色
      btnCallBack:点击菜单项对应触发的事件
    }
    //使用默认参数
    ActionUtil.showActionMenu({ btn: [
      { text: '测试1', color: '#cdcdcd', btnCallBack: this.can },
      { text: '测试2', color: '#108ee9', btnCallBack: this.two }
    ]});
    //使用自定义参数
    ActionUtil.showActionMenu({ title: '修改后的标题', btn: [
      { text: '测试1', color: '#cdcdcd', btnCallBack: this.can },
      { text: '测试2', color: '#108ee9', btnCallBack: this.two }
    ] });
```

* showMenu 显示操作菜单便捷操作

```
    入參
    options: {
      title:标题,
      btn:菜单字符串数组 最多6个,
      clickCallBack:点击菜单回调函数，默认传回当前点击菜单项,
      showInSubWindow:某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗
      isModal:弹窗是否为模态窗口，模态窗口有蒙层，非模态窗口无蒙层
    }
    //使用默认参数
    Button("actionMenu默认标题").margin({ bottom: '10vp' }).onClick(() => {
      ActionUtil.showMenu({btn:["菜单1","菜单2"],clickCallBack:(data)=>{
        ToastUtil.showToast(data);
      }})
    })
    //使用自定义参数
    Button("actionMenu修改标题").margin({ bottom: '10vp' }).onClick(() => {
      ActionUtil.showMenu({title:'修改了菜单标题',btn:["菜单1","菜单2"],clickCallBack:(data)=>{
        ToastUtil.showToast(data);
      }})
    })
```

* showActionSheet 显示一个列表选择弹窗

```
    入參
    options: {
      title:提示可不填,
      msg:内容可不填,
      subtitle:副标题,
      autoCancel:点击遮障层时，是否关闭弹窗,
      offset:弹窗相对alignment所在位置的偏移量,
      maskRect:弹窗遮蔽层区域，在遮蔽层区域内的事件不透传，在遮蔽层区域外的事件透传,
      showInSubWindow:某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗,
      isModal:弹窗是否为模态窗口，模态窗口有蒙层，非模态窗口无蒙层,
      alignment:弹框对齐方式默认为(底部Bottom),
      sheets:列表项字符串数组,
      clickCallBack:点击列表项回调事件,默认传回选中的当前项,
      backgroundColor:弹窗背板颜色,
      backgroundBlurStyle:弹窗背板模糊材质
    }
    //使用默认参数
     Button("列表选择弹窗默认参数").margin({ bottom: '10vp' }).onClick(() => {
       ActionUtil.showActionSheet({
         sheets: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
         clickCallBack: (data: string) => {
           ToastUtil.showToast(data);
         } });
     })
    //使用自定义参数
    Button("列表选择弹窗修改参数").margin({ bottom: '10vp' }).onClick(() => {
      ActionUtil.showActionSheet({
        title:'弹框的标题',
        msg:'弹框的消息',
        subtitle:'副标题',
        alignment:DialogAlignment.Top,
        sheets: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
        clickCallBack: (data: string) => {
          ToastUtil.showToast(data);
        } });
    })
```

#### 4.LoadingUtil的方法

* 入参介绍

```
    LoadOptions 全局加载入参实体
    options:{
        show:是否显示默认false,
        content:加载提示内容默认正在拼命加载中,请稍后...,
        showInSubWindow:是否显示在主窗口之外默认false,
        alignment:弹窗在竖直方向上的对齐方式默认Center,
        offset:弹窗相对alignment所在位置的偏移量默认Bottom相关y:-20,Top相关y:50
    }
```

* 初始化

```
    @State showLoading: boolean = false;
    在build中初始化该组件,show接收一个@State修饰符修饰的boolean变量
    LoadingUtil({
       options: { show: this.showLoading, alignment: DialogAlignment.Top, content: '更改了加载提示...' }
    });
```

* show 显示加载框

```
    在需要显示的地方更改变量值,如发起一个axios请求时
    this.showLoading = true;
```

* close 关闭加载框

```
    在需要关闭的地方更改变量值,如axios请求成功返回结果时
    this.showLoading = false;
```

* 演示

```
    Button("显示全局loading").margin({ bottom: '10vp' }).onClick(() => {
       this.showLoading = true;
       setTimeout(() => {
         this.showLoading = false;
       }, 3000);
    })
```

#### 5.TipsUtil的方法

* 入参介绍

```
    TipsOptions 提示框入参实体
    options:{
        show:是否显示默认false,
        title:提示框标题默认温馨提示,
        content:提示框内容,
        checkTips:checkbox的提示内容默认不再提醒,
        btnList:按钮字符串数组默认['同意','取消']
        clickCallBack:点击弹框按钮回调函数,
        alignment:弹窗在竖直方向上的对齐方式默认Center,
        offset:弹窗相对alignment所在位置的偏移量默认Bottom相关y:-20,Top相关y:50
    }
```

* 初始化

```
    @State showTips: boolean = false;
    在build中初始化该组件,show接收一个@State修饰符修饰的boolean变量
    TipsUtil({
      options: {
        show: this.showTips,
        content: '请仔细阅读请仔细阅读请仔细阅读请仔细阅读请仔细阅读请仔细阅读请仔细阅读请仔细阅读请仔细阅读xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
        clickCallBack: (index, isChecked) => {
          ToastUtil.showToast(index === 0 ? '点击了第一个按钮' + isChecked : '点击了第二个按钮' + isChecked);
          this.showTips = false;
        }
      }
    });
    clickCallBack中的两个入参
    1.index为点击按钮的下标,0为点击第一个按钮,1为点击第二个按钮
    2.isChecked为checkbox是否选中,选中为true
```

* 显示提示框

```
    在需要显示的地方更改变量值,如提示用户授权
    this.showTips = true;
```

* 关闭提示框

```
    在回调成功事件中关闭
    clickCallBack: (index, isChecked) => {
       this.showTips = false;
    }
```

* 演示

```
    Button("显示Tips").margin({ bottom: '10vp' }).onClick(() => {
      this.showTips = true;
    })
```

#### 6.SelectUtil的方法

* 入参介绍

```
    SelectOptions 选择框入参实体
    options:{
        show:是否显示默认false,
        title:选择弹出框标题,
        content:选择弹出框内容,
        btnTxt:按钮字符串,
        ctxList:选项内容数组
        clickCallBack:点击弹框按钮回调函数,
        alignment:弹窗在竖直方向上的对齐方式默认Center,
        offset:弹窗相对alignment所在位置的偏移量默认Bottom相关y:-20,Top相关y:50
    }
```

* 初始化

```
    @State showSelect: boolean = false;
    在build中初始化该组件,show接收一个@State修饰符修饰的boolean变量
    SelectUtil({
      options: {
        show: this.showSelect,
         ctxList: ['苹果', '香蕉', '梨', '哈密瓜','凤梨','西瓜','火龙果','伊丽莎白'],
         clickCallBack: (selectData) => {
           //点击按钮时也会触发该回调,返回值为'',故需要判断当返回值不为空时进行业务操作
           if (selectData) {
             ToastUtil.showToast('选择了' + selectData);
           }
           this.showSelect = false;
         }
      }
    })
    clickCallBack中的入参
    1.selectData为点击选择的内容项
```

* 显示选中框

```
    在需要显示的地方更改变量值,如提示用户授权
    this.showSelect = true;
```

* 关闭选择框

```
    在回调成功事件中关闭
    clickCallBack: (selectData) => {
       //点击按钮时也会触发该回调,返回值为'',故需要判断当返回值不为空时进行业务操作
       if (selectData) {
         ToastUtil.showToast('选择了' + selectData);
       }
       this.showSelect = false;
    }
```

* 演示

```
    Button("显示Select").margin({ bottom: '10vp' }).onClick(() => {
      this.showSelect = true;
    })
```

#### 7.ConfirmUtil的方法

* 入参介绍

```
    ConfirmOptions 信息确认框入参实体
    options:{
        show:是否显示默认false,
        title:提示框标题默认操作确认,
        content:提示框内容,
        checkTips:checkbox的提示内容默认禁止后不再提醒,
        btnList:按钮字符串数组默认['禁止','允许']
        clickCallBack:点击弹框按钮回调函数,
        alignment:弹窗在竖直方向上的对齐方式默认Center,
        offset:弹窗相对alignment所在位置的偏移量默认Bottom相关y:-20,Top相关y:50
    }
```

* 初始化

```
    @State showConfirm: boolean = false;
    在build中初始化该组件,show接收一个@State修饰符修饰的boolean变量
    ConfirmUtil({
      options: {
        show: this.showConfirm,
        title: '这个是提示',
        content: '确认要禁止定位权限么?',
        clickCallBack: (index, isChecked) => {
          ToastUtil.showToast(index === 0 ? '点击了第一个按钮' + isChecked : '点击了第二个按钮' + isChecked);
          this.showConfirm = false;
        }
      }
    })
    clickCallBack中的两个入参
    1.index为点击按钮的下标,0为点击第一个按钮,1为点击第二个按钮
    2.isChecked为checkbox是否选中,选中为true
```

* 显示提示框

```
    在需要显示的地方更改变量值,如提示用户授权
    this.showConfirm = true;
```

* 关闭提示框

```
    在回调成功事件中关闭
    clickCallBack: (index, isChecked) => {
       this.showConfirm = false;
    }
```

* 演示

```
    Button("显示Conform").margin({ bottom: '10vp' }).onClick(() => {
      this.showConfirm = true;
    })
```

#### 8.AlertUtil的方法

* 入参介绍

```
    AlertOptions 操作确认框入参实体
    options:{
        show:是否显示默认false,
        content:提示框内容,
        btnList:按钮字符串数组默认['确认','取消']
        clickCallBack:点击弹框按钮回调函数,
        alignment:弹窗在竖直方向上的对齐方式默认Center,
        offset:弹窗相对alignment所在位置的偏移量默认Bottom相关y:-20,Top相关y:50
    }
```

* 初始化

```
    @State showAlert: boolean = false;
    在build中初始化该组件,show接收一个@State修饰符修饰的boolean变量
    AlertUtil({
      options: {
        show: this.showAlert,
        content: '这是一个警告弹出框',
        clickCallBack: (index) => {
          ToastUtil.showToast(index === 0 ? '点击了第一个按钮' : '点击了第二个按钮');
          this.showAlert = false;
        }
      }
    })
    clickCallBack中的入参
    1.index为点击按钮的下标,0为点击第一个按钮,1为点击第二个按钮
```

* 显示提示框

```
    在需要显示的地方更改变量值,如提示用户授权
    this.showAlert = true;
```

* 关闭提示框

```
    在回调成功事件中关闭
    clickCallBack: (index) => {
       this.showAlert = false;
    }
```

* 演示

```
    Button("显示Alert").margin({ bottom: '10vp' }).onClick(() => {
      this.index = true;
    })
```

#### 9.ExceptionUtil的方法

* 入参介绍

```
    PromOptions 异常提示框入参实体
    options:{
        show:是否显示默认false,
        content:提示框内容,
        actionText:指定当前异常提示的右侧图标按钮的文字,
        clickCallBack:点击弹框按钮回调函数
    }
```

* 初始化

```
    @State showException: boolean = false;
    在build中初始化该组件,show接收一个@State修饰符修饰的boolean变量
    ExceptionUtil({
      options: {
        show: this.showException,
        clickCallBack: (index) => {
          //index为0表示点击了左侧文字,为1表示点击了右侧图标,根据情况进行业务处理
          ToastUtil.showToast("点击了" + index);
          this.showException = false;
        }
      }
    })
    clickCallBack中的入参
    1.index为0表示点击了左侧文字,为1表示点击了右侧图标,根据情况进行业务处理
```

* 显示提示框

```
    在需要显示的地方更改变量值,如网络异常
    this.showException = true;
```

* 关闭提示框

```
    在回调成功事件中关闭
    clickCallBack: (index) => {
       this.showException = false;
    }
```

* 演示

```
    Button("显示Exception").margin({ bottom: '10vp' }).onClick(() => {
      this.showException = true;
    })
```

#### 10.Cascade省市区级联

```
  入参  
  show  是否显示级联框(TRUE显示FALSE关闭)  
  callCity 反回选择的省市区数据
  titleFontSize 顶部已选择省市区的字体大小-默认为16(V1.2.1-rc.1-rc.1+)
  //使用demo
  Button("级联菜选择器").margin({ bottom: '10vp' }).onClick(() => {
      this.show = !this.show;
  })
  Cascade({ show: $show, callCity: $callCity, titleFontSize: 12 }).zIndex(999)
  //$callCity为调用页面传入给子组件的用于接收返回的值
```

- 效果图  
  [![cascade1.th.jpg](https://z4a.net/images/2024/02/21/cascade1.th.jpg)](https://z4a.net/image/jPZx5r)

#### 11.ImmersionUtil沉浸式导航工具类

* 初始化

```
  在EntryAbility中的onWindowStageCreate中进行初始化和设置
  onWindowStageCreate(windowStage: window.WindowStage): void {
    //1.初始化
    let imm = new ImmersionUtil();
    windowStage.loadContent('pages/Index', (err, data) => {
      //2.调用沉浸式设置方法
      imm.immersiveWindow(windowStage);
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }
```

* immersiveWindow 设置

```
   //参数详解
   {
    windowStage:窗口对象,
    isLayoutFullScreen:是否开启全屏显示,默认true,
    hiddenBar:是否隐藏底部导航,默认false,当为true时页面无需避让,
    color:窗口背景颜色,默认值为白色
   }
```

* 示例

```
  //本示例主要讲解hiddenBar为false时避让区设置
  //在初始化时已经向AppStorage中存入了变量bottomHeight,作为避让高度
  //在需要避让的页面中获取存入的值设置bottom即可
  //获取存入的应用变量
  bottomRectHeight: string = AppStorage.get<number>('bottomHeight') + 'px';
  //设置给对应的外层容器组件即可
  .margin({ bottom: this.bottomRectHeight })
```

#### 12.WindowUtil窗口工具类

* 入参介绍

```
    WinOptions 窗口工具入参实体
    options:{
        name:窗口名称默认eftool,
        windowType:窗口类型默认TYPE_DIALOG,
        contentRouter:窗口要显示的路由如:pages/Welcome需要在main_pages.json中声明,
        bgColor:窗口背景颜色默认#33606266,
        callBack:窗口创建回调函数
    }
```

* createWindow 创建window

```
  在需要弹出窗口的页面创建弹出方法
  async openWin() {
    await WindowUtil.createWindow({
      contentRouter: 'pages/Welcome',
      callBack:()=>{
          //此处如果创建完窗口有业务需求则自定义
        ToastUtil.showToast('窗口已创建~');
      }
    })
  }
```

* closeWindow 关闭window

```
   //在需要关闭弹窗的时候调用，如在弹窗内处理完需求后关闭
   WindowUtil.closeWindow();
```

* 示例

```
  Button("打开窗口").margin({ bottom: '10vp' }).onClick(() => {
    this.openWin();
  })
  
  //Welcome页面
  Button('关闭弹窗').margin({ top: 20 }).onClick(() => {
    WindowUtil.closeWindow();
  })
```

#### 13.NotificationUtil通知工具类

* 入参介绍

```
    NoticeOptions 通知入参实体类
    options:{
        id:通知ID默认生成,
        isOngoing:是否进行时通知默认true,
        isStopwatch:是否显示已用时间默认true,
        label:通知标签默认eftool,
        title:通知标题默认来自eftool通知,
        text:通知内容,
        additionalText:通知附加内容默认'',
        longText:通知的长文本/多行的文本用英文逗号分割(多行文本时记得用逗号分隔),
        briefText:通知概要内容默认概要内容,
        expandedTitle:通知展开时的标题默认展开标题,
        picture:图片,
        callBack:业务回调函数
    }
```

* authorizeNotification 校验是否已授权通知服务

```
  在需要发送通知的业务中调用  index为-1表示禁止，1表示已授权
  await NotificationUtil.authorizeNotification((index: number) => {
    ToastUtil.showToast(index > 0 ? '已经授予通知权限' : '用户禁止授权,请用户在设置中操作');
  });
```

* publishBasic 推送普通文本通知

```
   //在需要推送普通通知时调用,具体参数如图,下方为全量参数,具体根据业务自行选择,text为必填,其余均有默认值
   await NotificationUtil.publishBasic({
     text: '推送通知内容！！！！！！！！！！！！！！！！！！！！',
     title: '抢票时间到',
     additionalText: '这个是additionalText',
     isOngoing:true,
     isStopwatch:true,
     label:'普通通知',
     callBack: (noticeId: number) => {
       ToastUtil.showToast('通知推送成功:' + noticeId);
     }
   })
```

* publishMultiLine 推送多文本通知

```
   //在需要推送多文本通知时调用,具体参数如图,下方为全量参数,具体根据业务自行选择,longText为必填,其余均有默认值用英文逗号分隔
   await NotificationUtil.publishMultiLine({
     text: '推送通知内容！！！！！！！！！！！！！！！！！！！！',
     title: '抢票时间到',
     additionalText: '这个是additionalText',
     expandedTitle: '多文本的展开',
     briefText: '多文本的概要',
     longText: '第一行的内容,第二行的内容,第三行的内容,第四行的内容,第无行的内容',
     isOngoing:true,
     isStopwatch:true,
     label:'普通通知',
     callBack: (noticeId: number) => {
       ToastUtil.showToast('通知推送成功:' + noticeId);
     }
   })
```

* publishLongText 推送长文本通知

```
   //在需要推送长文本通知时调用,具体参数如图,下方为全量参数,具体根据业务自行选择,longText为必填,其余均有默认值
   await NotificationUtil.publishLongText({
     text: '推送长文本内容！！！！！！！！！！！！！！！！！！！！',
     title: '抢票时间到11111111111',
     longText: '展出差出差出差出差展出差出差出差出差展出差出差出差出差展出差出差出差出差展出差出差出差出差展出差出差出差出差展出差出差出差出差展出差出差出差出差展出差出差出差出差展出差出差出差出差展出差出差出差出差',
     expandedTitle: '展开的副标题',
     briefText: '这个是概要',
     isOngoing:true,
     isStopwatch:true,
     label:'长文本通知',
     callBack: (noticeId: number) => {
       ToastUtil.showToast('通知推送成功:' + noticeId);
     }
   })
```

* publishPicture 推送带有图片的通知(暂时未见到图片通知,不知是否为BUG)

```
   //在需要推送长文本通知时调用,具体参数如图,下方为全量参数,具体根据业务自行选择,均有默认值
   await NotificationUtil.publishPicture({
     text: '222222',
     title: '抢票时间到',
     expandedTitle: '多文本的展开',
     briefText: '多文本的概要',
     isOngoing: true,
     isStopwatch: true,
     label: '图片通知',
     picture: await image.createImageSource((getContext(this) as common.UIAbilityContext).resourceManager.getMediaContentSync($r("app.media.startIcon"))
       .buffer).createPixelMap(),
     callBack: (noticeId: number) => {
       ToastUtil.showToast('通知推送成功:' + noticeId);
     }
   })
```

* readOrRemoveNotice 读取或清除通知后重置角标

```
   NotificationUtil.readOrRemoveNotice(want);
```

* cancelNotice 取消通知

```
   //在需要取消的时候调用，传入通知id
   NotificationUtil.cancelNotice(10011, () => {
     ToastUtil.showToast('取消通知成功~');
   });
```

* clearBadge 重置角标

```
   NotificationUtil.clearBadge();
```

* clearNotice 清理所所有通知

```
   NotificationUtil.clearNotice();
```

* 当点击通知时默认调起当前Ability,清除时也需要重新设置应用角标

```
  //角标更新需要在UIAbility的onNewWant中处理,默认的为EntryAbility页面中
  /**
   * 监听通知传入的want
   * @param want
   * @param launchParam
   */
  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    NotificationUtil.readOrRemoveNotice(want);
  }
```

#### 14.LocationUtil位置工具类(V1.2.1+有改动)

* getGeoLocation 获取用户当前定位-逆编码后的位置(会申请APPROXIMATELY_LOCATION和LOCATION权限) 【返回OutDTO对象】

```
  //注意APPROXIMATELY_LOCATION和LOCATION权限需要配置到项目的module.json5文件的requestPermissions中
  //需要获取用户当前定位的中文位置信息时调用,返回格式如北京市海淀区xxx街道xxxx号
  let result = await LocationUtil.getGeoLocation();
  this.message = result.getDataRow();
```


* getGeoLocationAll 获取用户当前定位-逆编码后的位置(会申请APPROXIMATELY_LOCATION和LOCATION权限) 【返回全部信息】

```
  //注意APPROXIMATELY_LOCATION和LOCATION权限需要配置到项目的module.json5文件的requestPermissions中
  //需要获取用户当前定位的中文位置信息时调用,返回格式如北京市海淀区xxx街道xxxx号
  let result = await LocationUtil.getGeoLocationAll();
  this.message = result.getDataRow();
```

* address2Location 地理逆编码,将地理描述转换为具体坐标-无需申请定位权限 【返回OutDTO对象】

```
   //已有详细地址需要编码为坐标信息时调用
   let res = await LocationUtil.address2Location('北京市顺义区后沙峪裕祥花园');
   this.message = res.getDataRow().latitude + '-------' + res.getDataRow().longitude;
```

* geoConvert 地理逆编码,转换为中文-无需申请定位权限

```
   //已知经纬度，需要获取中文地理位置描述时调用
   let result = await LocationUtil.geoConvert(40.102248232795134, 116.54190501929297);
   if (result.placeName) {
     this.message = result.placeName;
   }
```

* getCountryCode 获取当前的国家码-无需申请定位权限 【返回OutDTO对象】

```
   //在需要获取当前国家编码时调用
   let res = await LocationUtil.getCountryCode();
   this.message = res.getDataRow();
```

* 示例

```
  //方法
  async geoLocation() {
    let result = await LocationUtil.getGeoLocation();
    this.message = result.getDataRow();
  }
  async add2location() {
    let res = await LocationUtil.address2Location('北京市顺义区后沙峪裕祥花园');
    this.message = res.getDataRow().latitude + '-------' + res.getDataRow().longitude;
  }
  async geoConvert() {
    let result = await LocationUtil.geoConvert(40.102248232795134, 116.54190501929297);
    if (result.placeName) {
      this.message = result.placeName;
    }
  }
  async getCountryCode() {
    let res = await LocationUtil.getCountryCode();
    this.message = res.getDataRow();
  }
  //UI
  Button('获取当前定位').margin({ bottom: '10vp' }).onClick(() => {
    this.geoLocation();
  })
  Button('根据经纬度获取Location信息').margin({ bottom: '10vp' }).onClick(() => {
    this.geoConvert();
  })
  Button('根据地理位置获取定位信息').margin({ bottom: '10vp' }).onClick(() => {
    this.add2location();
  })
  Button('获取国家码').margin({ bottom: '10vp' }).onClick(() => {
    this.getCountryCode();
  })
```

#### 15.DownloadUtil上传下载工具类

* 示例

```
  //入参介绍
  progressState:是否显示进度按钮
  halfProgress:当前下载进度
  ctx:进度按钮文字提示
  //UI中引入
  DownloadUtil({
    progressState: this.showDownBtn,
    halfProgress: this.process,
    ctx: this.btnCtx
  })
```

* 上传

```
  Button('上传文件').margin({ top: 20 }).onClick(() => {
    this.btnCtx = '上传文件中...';
    this.testUpload();
  })
  
  async testUpload() {
    //显示进度按钮
    this.showDownBtn = Visibility.Visible;
    
    let res = await efClientApi.upload('/api/eftool/upload', false, (progress: number) => {
      if (progress >= 100) {
        //上传完毕隐藏进度按钮
        this.showDownBtn = Visibility.None;
      }
      //设置当前进度
      this.process = progress;
    }, imageResource);
  }
  
```

* 下载

```
  Button('下载文件').margin({ top: 20 }).onClick(() => {
    this.btnCtx = '下载文件中...';
    this.testDownload();
  })
  
  async testDownload() {
    //显示进度按钮
    this.showDownBtn = Visibility.Visible;
    let res = await efClientApi.download('/api/eftool/download/0d6a25e4-f61b-48eb-8a12-53f82c5b957d-default1715324534920.png', 'girl.png', (progress: number) => {
      if (progress >= 100) {
        //下载完毕隐藏进度按钮
        this.showDownBtn = Visibility.None;
      }
      //设置当前进度
      this.process = progress;
    });
  }
```

#### 16.PickerUtil 调起选择工具类(1.1.11+)

* efPickerOptions picker选择入参实体

```
    options: {
     suffixList:选择文件的后缀类型,【只在选择文档时需要】
     maxNumber:选择文档的最大数目,【在选择文档和照片时需要】
     selectMode:选择模式是文件还是目录,【只在选择文档时需要】
     isMultiSelect:是否多选联系人,【只在选择联系人时需要】
     selectCallBack:选择完成回调【回调方式方法时需要】
    }
```

* selectFileCallBack 拉起picker选择文件 - 回调方式

```
     let bufferImg: ArrayBuffer = new ArrayBuffer(40960000);
     //拉起选择文件
     await PickerUtil.selectFile({
      selectCallBack:(list)=>{
        //此处只是举例操作
        list.forEach(item => {
          let fileUriObject = new fileUri.FileUri(item);
          name = fileUriObject.name;
          let file = fs.openSync(item, fs.OpenMode.READ_ONLY);
          let readLen = fs.readSync(file.fd, bufferImg);
          fs.closeSync(file);
        })
      }
    });
```

* selectFile 拉起picker选择文件 - 返回值方式

```
    //拉起选择文件
    let result = await PickerUtil.selectFile();
    let bufferImg: ArrayBuffer = new ArrayBuffer(40960000);
    //判断是否成功
    if (result.getSuccess()) {
      let list = result.getDataTable();
      list.forEach(item => {
        //此处只是举例操作
        let fileUriObject = new fileUri.FileUri(item);
        name = fileUriObject.name;
        let file = fs.openSync(item, fs.OpenMode.READ_ONLY);
        let readLen = fs.readSync(file.fd, bufferImg);
        fs.closeSync(file);
      })
    }
```

* selectPhotoVideoCallBack 拉起照片和视频选择 - 回调方式

```
    let bufferImg: ArrayBuffer = new ArrayBuffer(40960000);
    //拉起照片和视频选择
    await PickerUtil.selectAudioCallBack({
      selectCallBack:(list)=>{
        //此处只是举例操作
        list.forEach(item => {
          let fileUriObject = new fileUri.FileUri(item);
          name = fileUriObject.name;
          let file = fs.openSync(item, fs.OpenMode.READ_ONLY);
          let readLen = fs.readSync(file.fd, bufferImg);
          fs.closeSync(file);
        })
      }
    });
```

* selectPhotoVideo 拉起照片和视频选择 -返回值方式

```
    //拉起选中照片
    let result = await PickerUtil.selectPhotoVideo();
    let bufferImg: ArrayBuffer = new ArrayBuffer(40960000);
    //判断是否成功
    if (result.getSuccess()) {
      let list = result.getDataTable();
      list.forEach(item => {
        //此处只是举例操作
        let fileUriObject = new fileUri.FileUri(item);
        name = fileUriObject.name;
        let file = fs.openSync(item, fs.OpenMode.READ_ONLY);
        let readLen = fs.readSync(file.fd, bufferImg);
        fs.closeSync(file);
      })
    }
```

* selectAudioCallBack 拉起picker选择音频 - 回调方式

```
      //拉起选择音频picker
      let bufferImg: ArrayBuffer = new ArrayBuffer(409600000);
      await PickerUtil.selectAudioCallBack({
      selectCallBack:(list)=>{
        //此处只是举例操作
        list.forEach(item => {
          let fileUriObject = new fileUri.FileUri(item);
          name = fileUriObject.name;
          let file = fs.openSync(item, fs.OpenMode.READ_ONLY);
          let readLen = fs.readSync(file.fd, bufferImg);
          fs.closeSync(file);
        })
      }
    })
```

* selectAudio 拉起picker选择音频 - 返回值方式

```
    /拉起选择音频
    let result = await PickerUtil.selectAudio();
    let bufferImg: ArrayBuffer = new ArrayBuffer(409600000);
    //判断是否成功
    if (result.getSuccess()) {
      let list = result.getDataTable();
      list.forEach(item => {
        //此处只是举例操作
        let fileUriObject = new fileUri.FileUri(item);
        name = fileUriObject.name;
        let file = fs.openSync(item, fs.OpenMode.READ_ONLY);
        let readLen = fs.readSync(file.fd, bufferImg);
        fs.closeSync(file);
      })
    }
```

* selectContact 拉起picker选择联系人 - 返回值方式

```
    //拉起选择联系人picker 默认多选
    let result = await PickerUtil.selectContact();
    if (result.getSuccess()) {
      let list = result.getDataTable();
      let str = JSONArray.toJSONString(list);
      this.msg = str;
    }
```

#### 17.CameraUtil 调起拍照工具类(1.1.11+)

* picker 调起照相和录屏

```
    let bufferImg = new ArrayBuffer(40960000);
    //调起拍照
    let res = await CameraUtil.picker();
    if (res.getSuccess()) {
      //此处只是举例操作
      let str = res.getDataRow().resultUri;
      let fileUriObject = new fileUri.FileUri(str);
      let name = fileUriObject.name;
      let file = fs.openSync(str, fs.OpenMode.READ_ONLY);
      fs.closeSync(file);
    }
```

#### 18.WinDialogUtil 以窗口方式弹出框工具类

* 入参介绍

```
    efAlertOptions 弹出框入参实体
    options:{
        title:提醒标题默认为温馨提示,
        content:提示框内容,
        okText:确认文本默认为确认,
        cancelText:取消文本默认为取消,
        okCallBack:确认回调函数, //如果isAutoClose为false时,将返回当前弹窗的唯一编码winName,用于后续手动关闭
        cancelCallBack:取消回调函数,
        isAutoClose?: 是否自动关闭弹框默认为true(1.1.13+)
    }
```

* 显示提示框(支持弹出多个1.1.13+)

```
    在需要显示的地方调用
    await WinDialogUtil.showAlert({
      title: 'ef温馨提示',
      content: '只设置了内容，其他都默认~~~~~',
      okCallBack:this.aes,
      cancelCallBack:this.testJSONObject
    });
```

* 关闭提示框(支持用户选择是否自动关闭1.1.13+)

```
    点击确认和取消按钮均会自动关闭提示框
    自动调用时传入弹框id
    WinDialogUtil.closeAlert(winName);
```

* 示例(弹出两个窗体)

```
    Button('打开弹窗').margin({ top: 20 }).onClick(() => {
      //打开第一个弹窗
      this.openAlert();
    })
    
    //第一个弹窗方法
    async openAlert() {
      //此处需要特别注意,弹出多个弹窗时需要缓存this,否则内部弹窗的this指向将被覆盖
      let _that = this;
      await WinDialogUtil.showAlert({
        title: 'ef温馨提示',
        content: '只设置了内容，其他都默认~~~~~',
        isAutoClose: false,//设置为用户自己触发关闭弹窗
        okCallBack: (winName?: string) => {
          //winName为当前弹窗的名称
          _that.openAlertTwo(winName)
        },
        cancelCallBack: (winName?: string) => {
          _that.testJSONObject();
          if (winName) {
            //用户处理完业务需求后自行关闭弹窗
            WinDialogUtil.closeAlert(winName);
          }
        }
    });
    
    //打开第二个弹窗
    async openAlertTwo(winName?: string) {
      if (winName) {
        //将当前窗体名称存储在需要时关闭
        this.alertWinName = winName;
      }
      await WinDialogUtil.showAlert({
        title: '测试第二个弹框',
        content: '第二个弹框内容',
        okCallBack: () => {
          this.aes()
        },
        cancelCallBack: () => {
          this.testJSONArray()
        }
      });
    }
  
    //第二个弹窗的确认回调函数
    async aes() {
      let encode = await AES.encodeECB('123456', '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588');
      this.msg = encode.getDataRow();
      let decode = await AES.decodeECB(encode.getDataRow(), '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588');
      this.msg = decode.getDataRow();
      //关闭第一个窗体
      if (this.alertWinName) {
        WinDialogUtil.closeAlert(this.alertWinName);
      }
    }
```

#### 19.PreviewUtil 预览工具类

* previewTxt 预览文本

```
    //拉起选择文件
    let result = await PickerUtil.selectFile();
    //判断是否成功
    if (result.getSuccess()) {
      let list = result.getDataTable();
      let item = list[0];
      await PreviewUtil.previewTxt(item);
    }
```

* previewHtml 预览网页

```
    //拉起选择文件
    let result = await PickerUtil.selectFile();
    //判断是否成功
    if (result.getSuccess()) {
      let list = result.getDataTable();
      let item = list[0];
      await PreviewUtil.previewHtml(item);
    }
```

* previewImage 预览图片

```
    //拉起选择文件
    let result = await PickerUtil.selectPhotoVideo();
    //判断是否成功
    if (result.getSuccess()) {
      let list = result.getDataTable();
      let item = list[0];
      await PreviewUtil.previewImage(item);
    }
```

* previewVideo 预览视频

```
    //拉起选择文件
    let result = await PickerUtil.selectPhotoVideo();
    //判断是否成功
    if (result.getSuccess()) {
      let list = result.getDataTable();
      let item = list[0];
      await PreviewUtil.previewVideo(item);
    }
```

* previewAudio 预览音频

```
    //拉起选择文件
    let result = await PickerUtil.selectAudio();
    //判断是否成功
    if (result.getSuccess()) {
      let list = result.getDataTable();
      let item = list[0];
      await PreviewUtil.previewAudio(item);
    }
```

* canPreview 判断传入uri是否可以预览

```
  let res = await PreviewUtil.canPreview('http://124.71.72.144:8801/mbank/dist/121.gif');
  //res.success为true表示可以预览,否则为不可预览,注意预览的为文件uri地址,而非网络地址
  this.msg = res.getMsg();
```

#### 20.WinLoadingUtil 窗口方式全局弹框

* ImgLayout 图片文字布局枚举

```
  export enum ImgLayout {
  /**
   * 图片在文字上方
   */
  TOP,
  /**
   * 图片在文字下方
   */
  BOTTOM,
  /**
   * 图片在文字左侧
   */
  LEFT,
  /**
   * 图片在文字右侧
   */
  RIGHT
}
```

* LoadingShape 弹框形状布局

```
  export enum LoadingShape {
    /**
     * 正方形
     */
    SQUARE,
    /**
     * 矩形
     */
    RECTANGLE
  }
```

* efLoadingOptions 窗口loading方式入参实体

```
  @Observed
  export class efLoadingOptions {
    /**
     * 加载内容
     */
    @Track content: string = '';
    /**
     * loading位置
     */
    @Track position?: Alignment;
    /**
     * 图片布局方式
     */
    @Track imgLayout?: ImgLayout;
    /**
     * 弹框形状
     */
    @Track layoutShape?: LoadingShape;
  
    constructor() {
      this.content = '小的正在努力加载中...';
    }
  }
```

* 打开弹窗

```
  WinLoadingUtil.showLoading(this.loadingOps);
```

* 关闭弹窗

```
  WinLoadingUtil.closeLoading();
```

* 使用示例

```
  
  @State loadingOps: efLoadingOptions = new efLoadingOptions();
  //设置图片与文字排布方式
  this.loadingOps.imgLayout = ImgLayout.BOTTOM;
  //设置文字内容
  this.loadingOps.content = "小的努力加载" + this.count;
  //设置弹框垂直位置
  this.loadingOps.position = Alignment.Top;
  //设置弹框形状
  this.loadingOps.layoutShape = LoadingShape.SQUARE;
  //打开弹窗
  WinLoadingUtil.showLoading(this.loadingOps);
  //业务处理完后关闭，如请求接口成功后
  WinLoadingUtil.closeLoading();
  
```

### 7.媒体相关类组件使用API

#### 1.FileUtil 文件处理工具类

* getFilesDirPath 获取文件目录下的文件夹路径或文件路径

```
 //后续添加
```

* getCacheDirPath 获取缓存目录下的文件夹路径或文件路径

```
//后续添加
```

* getTempDirPath 获取临时目录下的文件夹路径或文件路径

```
//后续添加
```

* hasDirPath 判断是否是完整路径

```
//后续添加
```

* getFileName 通过URI或路径获取文件名

```
//后续添加
```

* getFilePath 通过URI或路径获取文件路径

```
//后续添加
```

* getParentUri 通过URI或路径获取对应文件父目录的URI

```
//后续添加
```

* getParentPath 通过URI或路径获取对应文件父目录的路径名

```
//后续添加
```

* getFileExtention 根据文件名获取文件后缀

```
//后续添加
```

* isFile 判断文件是否是普通文件

```
//后续添加
```

* isDirectory 判断文件是否是目录

```
//后续添加
```

* mkdir 创建目录

```
//后续添加
```

* mkdirSync 创建目录以同步方法

```
//后续添加
```

* writeEasy 将数据写入文件并关闭文件

```
//后续添加
```

* getFormatFileSize 格式化文件大小

```
//后续添加
```

* getRawFileContentSync 获取resources/rawfile目录下对应的rawfile文件内容

```
//后续添加
```

* getRawFileContent 获取resources/rawfile目录下对应的rawfile文件内容

```
//后续添加
```

#### 2.ImageUtil 图片处理工具类(返回类型均为OutDTO)

* pickerSave 将buffer图片保存到选择路径

```
    let array = getContext().resourceManager.getMediaContentSync($r("app.media.notice").id);
    let res = await ImageUtil.pickerSave(buffer.from(array).buffer);
```

* pickerSaveGallery 保存图片到图库

```
  //需要配合安全控件使用
    SaveButton({
      icon: SaveIconStyle.FULL_FILLED,
      buttonType: ButtonType.Capsule,
      text: SaveDescription.SAVE_IMAGE
    })
      .onClick(async (event: ClickEvent, result: SaveButtonOnClickResult) => {
        if (result == SaveButtonOnClickResult.SUCCESS) {
          try {
            let array = getContext().resourceManager.getMediaContentSync($r("app.media.notice").id);
            let result = await ImageUtil.pickerSaveGallery(buffer.from(array).buffer);
            if (result.getSuccess()) {
              ToastUtil.showToast(result.getMsg());
            }
          } catch (error) {
            console.error("error is " + JSON.stringify(error));
          }
        }
      })
```

* base64ToPixelMap 图片base64字符串转PixelMap

```
//后续添加
```

* arrayBuffer2PixelMap buffer转PixelMap

```
//后续添加
```

* pixelMap2Base64Str PixelMap转图片base64字符串

```
//后续添加
```

* savePixelMap 保存pixelMap到本地

```
//后续添加
```

* saveImageSource 保存ImageSource到本地

```
//后续添加
```

* createImageSource 创建图片源实例

```
//后续添加
```

* pack2FileFromPixelMap 将PixelMap图片写入文件

```
//后续添加
```

* packingFromPixelMap PixelMap转ArrayBuffer

```
//后续添加
```

* pack2FileFromImageSource 将ImageSource图片写入文件

```
//后续添加
```

* getPixelMapFromMedia 获取resource目录下media中的图片转换成PixelMap

```
//后续添加
```

---------------------------------------------------------------------------------

### 8.设备类相关组件使用API(V1.2.1+)

#### 1.KvUtil

* init 初始化

> 建议在Ability中进行初始化操作

```
 在Ability的  方法中进行初始化
 
   onWindowStageCreate(windowStage: window.WindowStage): void {
        //构造函数内异步调用里init方法
        let kvUtil = new KvUtil(this.context);
         //希望全局可以调用，通过GlobalContext来解决,目的是保证init异步初始化完成后，存入GlobalContext
         windowStage.loadContent('pages/Login', (err, data) => {
           GlobalContext.getContext().setT<KvUtil>("kvUtil", kvUtil);
         }
   }
```

* put  存入数据——会进行权限校验

```
        Button("kv存储")
          .margin({ top: 20 })
          .onClick(async () => {
            //从全局中获取
            let kvUtil = GlobalContext.getContext().getT<KvUtil>("kvUtil");
            //调用方法
            this.msg = await kvUtil.put("csx", true);
        })
```

* get  获取数据——会进行权限校验

```
        Button("kv获取")
          .margin({ top: 20 })
          .onClick(async () => {
            let kvUtil = GlobalContext.getContext().getT<KvUtil>("kvUtil");
            this.msg = await kvUtil.get<boolean>("csx", false) + "";
        })
```

* delete  删除数据——会进行权限校验


```
        Button("kv删除")
          .margin({ top: 20 })
          .onClick(async () => {
            let kvUtil = GlobalContext.getContext().getT<KvUtil>("kvUtil");
            this.msg = await kvUtil.delete("csx");
        })
```


## 特别鸣谢

### [幻凡ss](https://blog.csdn.net/q2158798)

* 提供自定义键盘工具类
* 提供首选项工具类
* 提供图片预览工具类

## star`eftool`希望您可以动一动小手点点小⭐⭐

## 👴希望大家如有好的需求踊跃提交,如有问题请前往gitee提交issue，我闲暇时间会扩充与修复优化