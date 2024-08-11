# <center>ef_axios</center>

# <center>V1.0.0(API12)</center>

--------------------------------------------------------------------------------

## 📚简介

`ef_axios`是`eftool`的efAxios网络请求相关包.提供了axios二次封装的上传,下载,post,get,delete,put等操作

> 你可以引入使用，也可以**拷贝**和修改使用，如需分享扩展
> ### **希望可以注明原出处即可**
> 也希望能把bug及时反馈回来。

> 我努力健全**中文**注释，为源码学习者提供良好地学习环境，争取做到人人都能看得懂。

## 🛠️包含组件

| 模块            | 介绍                              |
|---------------|---------------------------------|
| efAxiosParams | 提供eftool封装axios请求所需的参数          |
| efAxios       | 二次封装axios的产物,提供统一请求响应拦截等        |
| efClientApi   | 提供针对于统一post,get,delete,put等请求封装 |

## 📦安装

### 🍊ohpm

* 执行安装命令

```
ohpm install @yunkss/ef_axios
```

* 特殊说明

> ef_axios依赖于ef_json/ef_crypto,故将依赖引入为dependencies方式,即开发者在使用ef_axios时无需自行引入ef_json/ef_crypto,ef_axios会自动下载对应依赖版本

## 📦使用

### 1.在项目中引入插件

```
import { efAxiosParams, efClientApi,xxxx} from '@yunkss/ef_axios'
```

类按需引入,项目需要使用那个就引入

### 2.ef_axios使用API

#### 前言

> efAxios封装需要大家共建和提出建议与需求,已完善传输整体加解密,关键字加解密,统一上传下载等,期待大家提出宝贵意见

> 接到大部分开发者反馈需要有一个统一的请求全局加载loading,故在本版本默认集成,后续可能会有样式优化(V1.2.1-rc.1+)

- 效果图  
  [![loading.th.jpg](https://z4a.net/images/2024/07/20/loading.png)](https://z4a.net/image/jReQM0)

> 后端Demo示例为Java开发,大家自行下载使用与阅读,如有问题请提出Issue

> 后端Demo示例地址[点此访问](https://gitee.com/yunkss/ef-axios-java)


#### 1.efAxiosParams类参数详解

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
   * 是否开启全局请求loading弹框,默认为true
   */
  static isLoading: boolean = true;
  /**
   * 全局loading的加载内容,默认值为[努力获取数据中,请稍后...]
   */
  static loadingTxt: string = '努力获取数据中,请稍后...';
  /**
   * 是否开启日志
   */
  static isLogger: boolean = true;
```

#### 2.AxiosUtil工具类

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
> 如果efAxiosParams.isConvertDTO=true,则所有的异常均转换成OutDTO对象返回

> 如果efAxiosParams.isConvertDTO=false,则所有异常返回为AxiosError业务自行处理

#### 3.EfClientApi工具类

> 该工具类提供统一简化各种请求方式,入参为json格式内部进行转换为所需对象

* post请求 json格式 async/await 方式

```
    //参数说明
    async post<F, E>(url: string, query: Record<string, Object>, headers?: Record<string, Object>): Promise<E> 
    //url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+url 组合而成
    //F 为请求入参对象,具体参照示例中的写法
    //E 为响应结果对象,格式为OutDTO<T> T为业务自定义对象
    //headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //query 为JSON格式的请求参数key需要为字符串类型必须使用引号包裹 在方法内会将JSON转换为请求对象F,业务无需关心
```

* post请求 formData格式 async/await 方式

```
    //参数说明
    async postFormData<E>(url: string, formData: FormData, headers?: Record<string, Object>): Promise<E>
    //url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+url 组合而成
    //formData 业务传入的formData数据
    //E 为响应结果对象,格式为OutDTO<T> T为业务自定义对象
    //headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
```

* get请求 async/await 方式

```
    //参数说明 格式为  getXXXX/id/name/xxxx
    async get<E>(url: string, headers?: Record<string, Object>): Promise<E>
    //url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+url 组合而成
    //headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //注意demo中的get请求为rest方式,即入参无需?param1=value,而是 get方法/param1/param2 以此类推
    //E 为响应结果对象,格式为OutDTO<T> T为业务自定义对象
```

* getByParams请求 async/await 方式

```
    //参数说明   参数为json格式
    async getByParams<E>(url: string, params: Record<string, Object>, headers?: Record<string, Object>): Promise<E>
    //url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+url 组合而成
    //headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //params表示get请求的入参妇科key:value格式
    //E 为响应结果对象,格式为OutDTO<T> T为业务自定义对象
    
```

* delete请求 async/await 方式

```
    //参数说明
    async delete<E>(url: string, headers?: Record<string, Object>): Promise<E>
    //url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+url 组合而成
    //headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //注意demo中的delete请求为rest方式,即入参方式为 delete方法/param1/param2 以此类推
    //E 为响应结果对象,格式为OutDTO<T> T为业务自定义对象
```

* put请求 async/await 方式

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

## [eftool](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Feftool)工具类ohpm地址

## star `ef_axios` 希望您可以动一动小手点点小⭐⭐

## 👴希望大家如有好的需求踊跃提交,如有问题请前往gitee提交issue，我闲暇时间会扩充与修复优化