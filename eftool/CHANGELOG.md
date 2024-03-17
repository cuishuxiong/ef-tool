# Changelog

## [v1.1.0] 2024-03

### 🐣新特性

* 全面兼容API11

## [v1.0.10] 2024-03

### 🐣新特性

* 新增CacheUtil全局缓存
* 新增国密SM2[迁移和优化sm-crypto](https://gitee.com/yunkss/ef-tool/issues/I93V9W)
* 新增WsUtil,方便websocket操作
* 新增AuthUtil,封装Hap获取授权相关操作

## [v1.0.9] 2024-03

### 🐣新特性

* AES中新增convertKey方法(传入字符串生成密钥)
* 新增国密SM3,SM4(迁移和优化sm-crypto)

### 🐞Bug修复

* 优化Logger工具类每次使用需要实例化问题
* 去除@ts-nocheck注释(更好兼容API11)
* 优化JSONUtil中的parseObject无法解析嵌套类[issuesI94YTH](https://gitee.com/yunkss/ef-tool/issues/I94YTH)

## [v1.0.8] 2024-02

### 🐣新特性

* 新增省市区级联组件Cascade
* 新增ActionUtil工具类的showActionSheet方法
* 新增ActionUtil工具类的showMenu方法
* 新增StrUtil中的asString方法

## [v1.0.7] 2024-02

### 🐣新特性

* 新增DialogUtil工具类的showAlertDialog方法

## [v1.0.6] 2024-01

### 🐣新特性

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

### 🐞Bug修复

* 优化RSA中文加密后解密乱码问题

## [v1.0.4] 2024-01

### 🐣新特性

* 新增RSA加密,提供了生成密钥,加解密,签名,验签等方法

## [v1.0.3] 2024-01

### 🐣新特性

* 新增ArrayUtil中的removeEmptyValues,remove,,union,zip,unzip等方法
* 新增StrUtil中的camelCase,capitalize,truncate,toUpper,toLower等方法
* 新增DateUtil中的dateDiff,strDateDiff方法

### 🐞Bug修复

* 暂无

## [v1.0.2] 2024-01

### 🐣新特性

* 新增ArrayUtil中的setOrAppend,replace,clone,filter,reverse等方法
* 新增CharUtil中的isAscii,isEmoji等方法
* 新增IdCardUtil中的getProvinceCodeByIdCard，getCityCodeByIdCard等方法

### 🐞Bug修复

* 暂无

## [v1.0.1] 2024-01

### 🐣新特性

* 新增调用后台方法进行分页工具类PageQuery

### 🐞Bug修复

* 优化常量中的注释
* 优化util中的方法
* 优化PageUtil中的默认每页记录数为10条
* 优化PageUtil中的计算方法

## [v1.0.0] 2024-01

### 🐣新特性

* 发布正式版本

### 🐞Bug修复

* 暂无