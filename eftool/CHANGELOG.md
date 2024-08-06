# Changelog


## [v1.2.1] 2024-08

### 🐣新特性(API12)

* 新增kvUtil数据持久化工具类
* 发布1.2.1正式版

### 🐞功能优化

* 优化JSONObject.parse如果是Array不达预期问题[issuesIAI911](https://gitee.com/yunkss/ef-tool/issues/IAI911)
* 新增getGeoLocationAll获取定位返回信息更全面[issuesIAI83G](https://gitee.com/yunkss/ef-tool/issues/IAI83G)


### 🐞功能优化

* 优化rcp请求异常无法抛出问题[issuesIAHYF3](https://gitee.com/yunkss/ef-tool/issues/IAHYF3)
* 优化rcp下载方法证书校验

## [v1.2.1-rc.3] 2024-08

### 🐞功能优化

* 优化rcp请求异常无法抛出问题[issuesIAHYF3](https://gitee.com/yunkss/ef-tool/issues/IAHYF3)
* 优化rcp下载方法证书校验

## [v1.2.1-rc.2] 2024-08

### 🐣新特性(API12)

* 新增efRcpInstance远场通信
* 新增efRcpClientApi组件,支持post,put,get,delete,cancel等请求
* 新增efRcpClientApi统一上传下载方法
* 新增efRcpClientApi开启日志，全局loading,证书校验等功能
* 新增NetUtil网络工具类
* 新增场景化按钮ButtonUtil

### 🐞功能优化

* JSONObject,JSONArray,JSONArrayList中parse,parseXXX方法如字符串中有\r\n报错问题[issuesIAESIG](https://gitee.com/yunkss/ef-tool/issues/IAESIG)
* 优化RandomUtil.generateIV支持生成utf8格式的字符串iv
* 优化efAxios请求全局loading开关,以及可设置loading提示内容
* efClientApi中新增postFormData方法[issuesIACLR2](https://gitee.com/yunkss/ef-tool/issues/IACLR2)
* 优化支持efAxios打印日志开关[issuesIAGVA1](https://gitee.com/yunkss/ef-tool/issues/IAGVA1)
* 优化手机号正则问题[issuesIAGBI0](https://gitee.com/yunkss/ef-tool/issues/IAGBI0)
* 优化efAxios下载带有目录时报错[issuesIAHLU5](https://gitee.com/yunkss/ef-tool/issues/IAHLU5)
* 升级axios为2.2.2正式版

## [v1.2.1-rc.1] 2024-07

### 🐣新特性(API12)

* 新增AESSync工具类,AES操作更改为同步,并且支持灵活指定密钥以及加密输出的字符格式(hex/base64)等
* 新增DESSync工具类,3DES操作更改为同步,并且支持灵活指定密钥以及加密输出的字符格式(hex/base64)等
* 新增ECDSASync工具类,ECDSA操作更改为同步,并且支持灵活指定密钥以及加密输出的字符格式(hex/base64)等
* 新增RSASync工具类,RSA操作更改为同步,并且支持灵活指定密钥以及加密输出的字符格式(hex/base64)等
* 新增SHASync工具类,SHA操作更改为同步,并且支持灵活指定密钥以及加密输出的字符格式(hex/base64)等
* 新增SM2Sync工具类,SM2操作更改为同步,并且支持灵活指定密钥以及加密输出的字符格式(hex/base64)等
* 新增SM3Sync工具类,SM3操作更改为同步,并且支持灵活指定密钥以及加密输出的字符格式(hex/base64)等
* 新增SM4Sync工具类,SM4操作更改为同步,并且支持灵活指定密钥以及加密输出的字符格式(hex/base64)等
* 新增ECDHSync工具类,ECDH操作更改为同步,并且支持灵活指定密钥以及加密输出的字符格式(hex/base64)等
* 新增X25519Sync工具类,X25519操作更改为同步,并且支持灵活指定密钥以及加密输出的字符格式(hex/base64)等
* Base64Util新增hex字符串转base64方法
* 新增自定义键盘(由幻凡提供)
* 新增首选项工具类PrefUtil(由幻凡提供)
* 新增图片预览工具类(由幻凡提供)
* AESSync新增192位加解密

### 🐞功能优化

* efClientApi中上传下载支持传入header[issuesIAA5PI](https://gitee.com/yunkss/ef-tool/issues/IAA5PI)
* 优化efAxios响应拦截后将响应code和异常消息返回
* 优化WinDialogUtil中this指向问题[issuesIAAAUQ](https://gitee.com/yunkss/ef-tool/issues/IAAAUQ)
* 优化MD5的base64格式hash补充符问题[issuesIABMQI](https://gitee.com/yunkss/ef-tool/issues/IABMQI)
* 优化ImageUtil中打开文件方式[issuesIAB6EG](https://gitee.com/yunkss/ef-tool/issues/IAB6EG)
* 优化Cascade选择器可传入字体大小[issuesIADJ86](https://gitee.com/yunkss/ef-tool/issues/IADJ86)
* efAxios的请求响应中添加全局loading弹框
* 升级axios版本为2.2.1正式版

## [v1.2.1-rc.1-rc.0] 2024-06

### 🐣新特性(API12)

* 升级axios为2.2.1-rc.2
* MD5新增散列算法以及hmac算法
* 新增SHA1的散列算法

### 🐞功能优化

* 优化UI组件中弹出类型的背景色为透明,如Alert,Confirm,Loading,Tips等

## [v1.2.0] 2024-06

### 🐣新特性(API12)

* 新增图片处理工具类ImageUtil
* 新增Base64Util工具类
* PreviewUtil新增判断是否uri可预览方法
* 新增文件处理工具类FileUtil
* 新增WinLoadingUtil以窗口方式实现全局loading工具类
* 新增AES的CBC加解密支持128位
* MD5新增散列算法以及HMAC算法
* 新增SHA1散列算法类

### 🐞功能优化

* 优化WinDialogUtil弹窗支持同时弹出多个[issuesI9TC0S](https://gitee.com/yunkss/ef-tool/issues/I9TC0S)
* 优化转json时候，数值转换错误[issuesI9V6JS](https://gitee.com/yunkss/ef-tool/issues/I9V6JS)
* 优化SM4字符串key包含大写字母时加密报错[issuesI9V8P2](https://gitee.com/yunkss/ef-tool/issues/I9V8P2)
* 优化LoadingUtil动态修改content，LoadingUtil弹窗会一直闪[issuesIA67N3](https://gitee.com/yunkss/ef-tool/issues/IA67N3)

## [v1.1.12-1] 2024-06

### 🐞功能优化

* 优化AES.encodeECB128加解密与在线网站不一致[issuesI9SX4O](https://gitee.com/yunkss/ef-tool/issues/I9SX4O)
* 优化3DES.encode有特殊字符的加解密不成功[issuesI9TON5](https://gitee.com/yunkss/ef-tool/issues/I9TON5)
* 优化上传下载demo整体完整性流程

## [v1.1.12] 2024-05

### 🐣新特性(API11)

* JSONArray新增parseArray方法将json字符串转换为Array<T>
* JSONArrayList新增parseArrayList方法将json字符串转换为ArrayList<T>
* 新增PreviewUtil
* 新增WinDialogUtil,以Window方式弹出Alert
* AES新增128位密钥生成,加解密方法

### 🐞功能优化

* 优化AES中encodeECB方法使用16位密钥加密失败[issuesI9R8QA](https://gitee.com/yunkss/ef-tool/issues/I9R8QA)
* 优化解析报错JSONArrayList.parse解析为空[issuesI9R181](https://gitee.com/yunkss/ef-tool/issues/I9R181)

## [v1.1.11] 2024-05

### 🐣新特性(API11)

* 封装CameraUtil相机工具类
* 封装PickerUtil调起选择工具类

## [v1.1.10] 2024-05

### 🐣新特性(API11)

* 封装axios统一上传下载方法
* 封装页面统一上传下载UI

### 🐞功能优化

* 优化IdCardUtil.isValidCard18校验尾号为x的身份证时，失败[issuesI9MW72](https://gitee.com/yunkss/ef-tool/issues/I9MW72)
* 优化JSONArray嵌套JSONObject转为字符串异常[issuesI9NEIZ](https://gitee.com/yunkss/ef-tool/issues/I9NEIZ)

## [v1.1.9] 2024-05

### 🐣新特性(API11)

* 封装axios的整体传输加解密
* 封装axios的关键字传输加解密
* 封装JSON功能,提供JSONObject/JSONArray

### 🐞功能优化

* efClientApi支持get请求的params方式
* efClientApi支持post请求更改请求头参数[issuesI9JGTC](https://gitee.com/yunkss/ef-tool/issues/I9JGTC)
* 优化SM2转换密钥方法,新增C1C3C2格式密钥转换为ASN1格式方法
* 优化SM2加解密显示字符串ASN1和C1C3C2格式开关
* 优化efAxios响应数据封装OutDTO转换开关
* 调整API文档结构

## [v1.1.8] 2024-04

### 🐣新特性(API11)

* 二次封装Axios
* 封装axios统一请求和响应
* 简化post,get,put,delete等请求方式

### 🐞功能优化

* 优化RSA支持2048位密钥生成、加解密以及签名验签[issuesI9HH01](https://gitee.com/yunkss/ef-tool/issues/I9HH01)
* 优化RSA支持1024/2048位分段加解密[issuesI9H74A](https://gitee.com/yunkss/ef-tool/issues/I9H74A)
* 优化ECDH动态协商
* 优化AES新增ECB加密模式

## [v1.1.7] 2024-04

### 🐣新特性(API11)

* 新增位置工具类LocationUtil,包含方法getGeoLocation,address2Location等
* 优化AuthUtil新增批量获取权限reqPermissions,reqPermissionsList方法等

## [v1.1.6] 2024-04

### 🐣新特性(API11)

* 新增窗口工具类WindowUtil
* 新增通知管理类NotificationUtil

## [v1.1.5] 2024-04

### 🐣新特性(API11)

* 新增RSA支持pem文件内容转换为加解密字符串[issuesI9DDMM](https://gitee.com/yunkss/ef-tool/issues/I9DDMM)
* 新增沉浸式导航工具类ImmersionUtil
* 新增权限以及授权工具类AuthUtil

## [v1.1.4] 2024-04

### 🐣新特性(API11)

* 新增异常工具类ExceptionUtil

### 🐞Bug修复

* JSONUtil兼容API11[issuesI9CC7N](https://gitee.com/yunkss/ef-tool/issues/I9CC7N)
* Cascade兼容API11

## [v1.1.3] 2024-03

### 🐣新特性(API11)

* 新增提示工具类TipsUtil
* 新增选择弹出框工具类SelectUtil
* 新增信息提示弹出框工具类ConfirmUtil
* 新增操作确认弹出框工具类AlertUtil

## [v1.1.2] 2024-03

### 🐣新特性(API11)

* 新增全局加载工具类LoadingUtil

### 🐞Bug修复

* 优化DialogUtil支持单个按钮[Issues-I9B8VP](https://gitee.com/yunkss/ef-tool/issues/I9B8VP)

## [v1.1.1] 2024-03

### 🐣新特性(API11)

* AES兼容API11,并新增GCM,CBC等加解密方法
* 3DES新增ECB,CBC等加解密方法
* ECDSA新增生成密钥,签名和验签等方法
* MD5新增摘要方法
* RSA新增PKCS1方式的加解密，签名和验签等方法
* SHA新增摘要和hmac等方法
* SM2新增加解密，签名和验签等方法
* SM3新增摘要和hmac等方法
* SM4新增ECB,CBC等加解密方法
* RandomUtil新增生成IV等方法

## [v1.1.0] 2024-03

### 🐣新特性(API11)

* 全面兼容API11

## [v1.0.9] 2024-03

### 🐣新特性(API9)

* AES中新增convertKey方法(传入字符串生成密钥)
* 新增国密SM3,SM4(迁移和优化sm-crypto)

### 🐞Bug修复

* 优化Logger工具类每次使用需要实例化问题
* 去除@ts-nocheck注释(更好兼容API11)
* 优化JSONUtil中的parseObject无法解析嵌套类[issuesI94YTH](https://gitee.com/yunkss/ef-tool/issues/I94YTH)

## [v1.0.8] 2024-02

### 🐣新特性(API9)

* 新增省市区级联组件Cascade
* 新增ActionUtil工具类的showActionSheet方法
* 新增ActionUtil工具类的showMenu方法
* 新增StrUtil中的asString方法

## [v1.0.7] 2024-02

### 🐣新特性(API9)

* 新增DialogUtil工具类的showAlertDialog方法

## [v1.0.6] 2024-01

### 🐣新特性(API9)

* 新增AES加密,提供了生成密钥,加密,解密等方法
* 新增MD5摘要方法
* 新增ToastUtil工具类showToast方法
* 新增DialogUtil工具类showDialog方法
* 新增ActionUtil工具类showActionMenu方法
* 新增base64工具类create,byteLength,toByteArray,fromByteArray等方法
* 新增Logger日志工具类

### 🐞Bug修复

* 优化JSONUtil中toJSONString方法在API10中转换map问题

## [v1.0.5] 2024-01

### 🐞Bug修复(API9)

* 优化RSA中文加密后解密乱码问题

## [v1.0.4] 2024-01

### 🐣新特性(API9)

* 新增RSA加密,提供了生成密钥,加解密,签名,验签等方法

## [v1.0.3] 2024-01

### 🐣新特性(API9)

* 新增ArrayUtil中的removeEmptyValues,remove,,union,zip,unzip等方法
* 新增StrUtil中的camelCase,capitalize,truncate,toUpper,toLower等方法
* 新增DateUtil中的dateDiff,strDateDiff方法

### 🐞Bug修复

* 暂无

## [v1.0.2] 2024-01

### 🐣新特性(API9)

* 新增ArrayUtil中的setOrAppend,replace,clone,filter,reverse等方法
* 新增CharUtil中的isAscii,isEmoji等方法
* 新增IdCardUtil中的getProvinceCodeByIdCard，getCityCodeByIdCard等方法

### 🐞Bug修复

* 暂无

## [v1.0.1] 2024-01

### 🐣新特性(API9)

* 新增调用后台方法进行分页工具类PageQuery

### 🐞Bug修复

* 优化常量中的注释
* 优化util中的方法
* 优化PageUtil中的默认每页记录数为10条
* 优化PageUtil中的计算方法

## [v1.0.0] 2024-01

### 🐣新特性(API9)

* 发布正式版本

### 🐞Bug修复

* 暂无