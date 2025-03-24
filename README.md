# <center>eftool</center>

# <center>V2.0.3(API12)</center>

--------------------------------------------------------------------------------

## 📚简介

`efTool`是一个功能丰富且易用的`兼容API12`的**HarmonyOS工具库**，通过诸多实用工具类的使用，旨在帮助开发者快速、便捷地完成各类开发任务。
这些封装的工具涵盖了字符串、数字、集合、JSON等一系列操作，
可以满足各种不同的开发需求。本人为Java开发,故封装思路借鉴Java的工具类Hutool，同时扩展了HarmonyOS的UI组件。

> ### 我很欢迎大家进行二次开发以及共建鸿蒙生态，如需二次开发,还请大家在引用时注明出处，万分感谢

> 你可以引入使用，也可以**拷贝**和修改使用，如需分享扩展
> ### **希望可以注明原出处即可**
> 也希望能把bug及时反馈回来。

> 全新2.0版本进行了模块化拆分,详细使用手册已迁移至各个模块

### 子模块目录总览

| 模块                         | 介绍                   |
|----------------------------|----------------------|
| @yunkss/ef_core(已发布)       | 提供基础工具类如字符串,正则,身份校验等 |
| @yunkss/ef_json(已发布)       | 提JSON转换相关            |
| @yunkss/ef_crypto(已发布)     | 提供加解密相关解耦结果去除OutDTO  |
| @yunkss/ef_crypto_dto(已发布) | 提供加解密相关保结果为OutDTO    |
| @yunkss/ef_media           | 提供媒体相关               |
| @yunkss/ef_audio(已发布)      | 提供音频相关               |
| @yunkss/ef_device          | 提供设备相关               |
| @yunkss/ef_axios(已发布)      | 提供网络请求efAxios相关      |
| @yunkss/ef_rcp(已发布)        | 提供网络请求efRcp相关        |
| @yunkss/ef_ui(已发布)         | 提供弹窗,级联,Loading等UI相关 |

### 🎁eftool名称的由来

eftool = Efficient + Tool，Efficient是高效的表示，Tool表示工具。

-------------------------------------------------------------------------------

## 📦安装

### 🍊ohpm

* 执行安装命令

```
ohpm install @yunkss/eftool
```

## 升级说明

> 2.0.0版本升级改动较大,升级需要保持充足时间

## 升级内容

1.去除强绑定OutDTO

2.efAxios增加统一异常处理

3.efRcp全面重构

* 特殊说明

> eftool拆分后默认保持全量包

> eftool依赖的子模块均无需自行下载,eftool会自动下载对应依赖版本

## 🛠️版本说明【重要】

> - <span style='color:red;'>2.0.x版本系列兼容**API12**</span>

> - <span style='color:red;'>1.2.x版本系列兼容**API12**</span>

> - <span style='color:red;'>1.1.x版本系列兼容**API11**</span>

> - <span style='color:red;'>1.0.x版本系列兼容**API9**</span>

## 🛠️包含组件

### 暂未拆分组件

| 模块             | 介绍            |
|----------------|---------------|
| FileUtil       | 提供对文件的一系列操作方法 |
| ImageUtil      | 提供对图片的一系列处理方法 |
| ImgPreviewUtil | 图片预览工具类       |
| PreUtil        | 首选项工具类        |
| KvUtil         | 数据库工具类        |
| NetUtil        | 提供对网络的方法操作工具类 |

### 已拆分组件

一个HarmonyOS基础工具类，组成各种工具类，同时提供以下七部分组件：

### @yunkss/ef_core eftool的核心基础包[地址](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_core)

### @yunkss/ef_json eftool的JSON相关包[地址](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_json)

### @yunkss/ef_crypto eftool的加密封装包(解耦了OutDTO)[地址](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_crypto)

### @yunkss/ef_crypto_dto eftool的加密封装包(与1.2.x版本保持一致,返回结果为OutDTO)[地址](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_crypto_dto)

### @yunkss/ef_axios eftool的efAxios网络请求封装包[地址](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_axios)

### @yunkss/ef_rcp eftool的rcp网络请求封装包[地址](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_rcp)

[//]: # (### @yunkss/ef_device eftool的设备相关工具包[地址]&#40;&#41;)

[//]: # (### @yunkss/ef_media eftool的媒体相关工具包[地址]&#40;&#41;)

### @yunkss/ef_ui eftool的UI组件封装包[地址](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_ui)

## 特别鸣谢

### [幻凡ss](https://blog.csdn.net/q2158798)

* 提供自定义键盘工具类
* 提供首选项工具类
* 提供图片预览工具类

## star`eftool`希望您可以动一动小手点点小⭐⭐

## eftool公众号现已开通，保持初心做最能帮助鸿蒙开发者的公众号

![eftool.jpg](https://z4a.net/images/2024/11/13/eftool.jpg)

## 鸿蒙开发交流群现已有2群,HarmonyOS开发者可积极交流

![qrcode.jpg](https://z4a.net/images/2025/03/24/_20250324082219.md.jpg)

## 👴希望大家如有好的需求踊跃提交,如有问题请前往gitee提交issue，我闲暇时间会扩充与修复优化