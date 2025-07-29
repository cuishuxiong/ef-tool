# Changelog

## [v1.0.12] 2025-07

### 🐞Bug修复

* 优化某些情况请求入参非JSON字符串时判断错误情况[issuesICLZA4](https://gitee.com/yunkss/ef-tool/issues/ICLZA4)

## [v1.0.11] 2025-07

### 🐞Bug修复

* 优化post请求中的param类型判断[issuesICLZA4](https://gitee.com/yunkss/ef-tool/issues/ICLZA4)

## [v1.0.10] 2025-07

### 🐞Bug修复

* 根据插件市场要求优化

## [v1.0.9] 2025-07

### 🐣新特性

* 新增putForm请求方式[issuesIBRM39](https://gitee.com/yunkss/ef-tool/issues/IBRM39)

### 🐞Bug修复

* 优化响应非json或字符串时解析异常问题
* 添加插件市场唯一编码
* 优化SSL peer certificate or SSH remote key was not
  OK问题[issuesIBKNZ6](https://gitee.com/yunkss/ef-tool/issues/IBKNZ6)

## [v1.0.8] 2024-11

### 🐣新特性

* 新增支持自定义Loading[issuesIB2P5J](https://gitee.com/yunkss/ef-tool/issues/IB2P5J)
* 新增系统以及自定义编码共存拦截器

### 🐞Bug修复

* 修复方法内的Loading参数优先级[issuesIB3PAS](https://gitee.com/yunkss/ef-tool/issues/IB3PAS)

## [v1.0.7] 2024-11

### 🐞Bug修复

* 修复Loading弹框失效问题

## [v1.0.6] 2024-10

### 🐣新特性

* 新增上传文件支持断点续传

### 🐞Bug修复

* 优化全局弹框透明背景色可自定义配置[issuesIARAM8](https://gitee.com/yunkss/ef-tool/issues/IARAM8)
* 优化get方法支持record方式入参
* 优化全局Loading支持开关[issuesIAZAT7](https://gitee.com/yunkss/ef-tool/issues/IAZAT7)
* 优化单个方法支持临时启用或关闭Loading[issuesIAZAT7](https://gitee.com/yunkss/ef-tool/issues/IAZAT7)

## [v1.0.5] 2024-09

### 🐞Bug修复

* 优化拦截器异常后提示内容[issuesIASVO3](https://gitee.com/yunkss/ef-tool/issues/IASVO3)

## [v1.0.4] 2024-09

### 🐞Bug修复

* 优化enableLogInterceptor支持入参开关日志打印[issuesIAS3WI](https://gitee.com/yunkss/ef-tool/issues/IAS3WI)

## [v1.0.3] 2024-08

### 🐞Bug修复

* 优化请求中使用as转换导致调用泛型方法报错
* 优化Loading的content设置空不生效问题[issuesIANKDF](https://gitee.com/yunkss/ef-tool/issues/IANKDF)
* 优化delete支持body传参[issuesIANBVZ](https://gitee.com/yunkss/ef-tool/issues/IANBVZ)

## [v1.0.2] 2024-08

### 🐣新特性

* 新增DNS相关配置
* 新增postMultipartForm方法，可实现附件和表单字段提交

### 🐞Bug修复

* 优化单个请求支持重新设置baseURL
* 去除efRcpConfig中的baseURL参数
* 优化入参为特殊类型时报错为[issuesIAMATB](https://gitee.com/yunkss/ef-tool/issues/IAMATB)
* 完善文档中的demo

## [v1.0.1] 2024-08

### 🐣新特性

* 新增EfRcpResponse对象统一返回结果与异常
* 新增业务code监听事件

### 🐞Bug修复

* 优化post请求但是入参需要拼接url的特殊请求

## [v1.0.0] 2024-08

### 🐣新特性

* 发布正式版本

### 🐞Bug修复

* 暂无