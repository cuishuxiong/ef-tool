# <center>ef_rcp</center>

# <center>V1.0.0(API12)</center>

--------------------------------------------------------------------------------

## 📚简介

`ef_rcp`是`eftool`的rcp网络请求相关包.提供了rcp的上传,下载,post,get,cancel,delete,put等操作

> 你可以引入使用，也可以**拷贝**和修改使用，如需分享扩展
> ### **希望可以注明原出处即可**
> 也希望能把bug及时反馈回来。

> 我努力健全**中文**注释，为源码学习者提供良好地学习环境，争取做到人人都能看得懂。

## 🛠️包含组件

| 模块                 | 介绍                              |
|--------------------|---------------------------------|
| EfRcpUtil          | 提供rcp的session相关工具类              |
| efRcpParams        | 提供eftool封装rcp请求所需的参数            |
| efRcpSecurityParam | 提供rcp的证书配置参数                    |
| CertificateUtil    | 证书配置相关工具类                       |
| efRcpEventsHandler | efRcp请求事件处理器                    |
| efRcpClientApi     | 提供针对于统一post,get,delete,put等请求封装 |
| RcpInterceptor     | 提供针对于统一请求和响应拦截封装                |

## 📦安装

### 🍊ohpm

* 执行安装命令

```
ohpm install @yunkss/ef_rcp
```

* 特殊说明

> ef_rcp依赖于ef_json,故将依赖引入为dependencies方式,即开发者在使用ef_rcp时无需自行引入ef_json,ef_rcp会自动下载对应依赖版本

## 📦使用

### 1.在项目中引入插件

```
import { efRcpClientApi, efRcpParams,xxxx} from '@yunkss/ef_rcp'
```

类按需引入,项目需要使用那个就引入

### 2.ef_rcp使用API

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


## [eftool](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Feftool)工具类ohpm地址

## star `ef_rcp` 希望您可以动一动小手点点小⭐⭐

## 👴希望大家如有好的需求踊跃提交,如有问题请前往gitee提交issue，我闲暇时间会扩充与修复优化