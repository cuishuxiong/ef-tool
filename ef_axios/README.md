# <center>ef_axios</center>

# <center>V1.0.3(API12)</center>

--------------------------------------------------------------------------------

## 📚简介

`ef_axios`是`eftool`的efAxios网络请求相关包.提供了axios二次封装的上传,下载,post,get,delete,put等操作

相比如eftool中未拆分组件而言,去除强绑定返回结果为OutDTO,优化请求入参更灵活,可针对每个请求设置loading文本内容

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
| EfAxiosError  | 提供针对于统一异常的封装                    |
| EfAxiosConst  | 提供针对于统一loading的文本内容常量封装         |

## 📦安装

### 🍊ohpm

* 执行安装命令

```
ohpm install @yunkss/ef_axios
```

* 特殊说明

> ef_axios依赖于ef_json/ef_crypto,故将依赖引入为dependencies方式,即开发者在使用ef_axios时无需自行引入ef_json/ef_crypto,ef_axios会自动下载对应依赖版本
> 但如果开发者自身业务需要使用JSON相关内容或者是加解密组件，则仍需要自行引入ef_json/ef_crypto

## 📦使用

### 1.在项目中引入插件

```
import { efAxiosParams, efClientApi,xxxx} from '@yunkss/ef_axios'
```

类按需引入,项目需要使用那个就引入

### 2.ef_axios使用API

#### 前言

> efAxios封装需要大家共建和提出建议与需求,已完善传输整体加解密,关键字加解密,统一上传下载等,期待大家提出宝贵意见

- 效果图  
  [![loading.th.jpg](https://z4a.net/images/2024/07/20/loading.png)](https://z4a.net/image/jReQM0)

> 后端Demo示例为Java开发,大家自行下载使用与阅读,如有问题请提出Issue

> 后端Demo示例地址[点此访问](https://gitee.com/yunkss/ef-axios-java)

#### 使用经验(1.0.3有改动)

> 针对于efAxios的统一设置，如全局请求loading文本,是否加解密，是否显示日志，请求前缀等，建议在Ability中初始化,如下

> 请求相关的参数配置建议在Ability的onWindowStageCreate方法中配置

> 可使用BuildProfile获取到当前运行的还是debug/qa/test/release等 然后设置不同的请求信息

```
    onWindowStageCreate(windowStage: window.WindowStage): void {
      if(运行环境===debug){
        //关于efAxios的配置
        efAxiosParams.baseURL = 'http://192.168.0.100:18088';
        efAxiosParams.isAllEncrypt = false;
        efAxiosParams.isLogger = true;
        efAxiosParams.isLoading = false;
        //设置公共请求头(1.0.3+)
        efAxiosParams.headers = {
          "appVersion": 'HarmonyOS',
          "timestamp": new Date().getTime()
        }
      }
      if(运行环境===product){
        //关于efAxios的配置
        efAxiosParams.baseURL = 'http://192.168.0.111:18088';
        efAxiosParams.isAllEncrypt = true;
        efAxiosParams.isLogger = false;
        efAxiosParams.sm2PubKey = '04ba3bc3c5834d9ad1a7d81c4b49cf1209d2f28e4a97c73b75d6561792a2bfafe811e0284692006b0ce1b51f8aadfd65241d80eb979365048253408f5d705ec17b';
        EfAxiosConst.loadingTxt = '正式环境的loading...';
      }
    }
```

#### 1.efAxiosParams类参数详解(1.0.3有改动)

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
  /**
   *  公共请求头
   */
  static headers?: Record<string, Object>;
```

#### 2.efClientParams类参数详解(1.0.3有改动)

> 优化后所有的请求方法入参均为efClientParams,当不需要query时,入参T传入null即可

```
export class efClientParams<T> {
  /**
   * 请求基地址
   */
  baseUrl?: string;
  /**
   * 请求路径
   */
  url: string = '';
  /**
   *  post/put请求参数所需
   */
  query?: T;
  /**
   *  get入参
   */
  params?: Record<string, Object>;
  /**
   *  请求头
   */
  headers?: Record<string, Object>;
  /**
   * formData数据
   */
  formData?: FormData;
  /**
   * 文件路径
   */
  filePath?: string;
  /**
   * 文件上传时-是否为uri标识
   */
  isUri?: boolean;
  /**
   * 文件上传时的文件流
   */
  data?: ArrayBuffer;
  /**
   * 文件上传时的uri
   */
  uri?: string;
  /**
   * 文件上传时的后端key名称
   */
  keyName?: string;
  /**
   * 单个请求需要更改的loading提示
   */
  loadingTxt?: string;
}
```

#### 3.EfAxiosError异常详解

> 在efAxios的每个请求中默认返回的异常均为EfAxiosError,且返回数据如下

```
  return new EfAxiosError(Number(e.code), e.name, e.message, e.stack);
```

```
  字段及注释
  /**
   * 编码
   */
  code: number;
  /**
   * 数据
   */
  data?: void | undefined;
  /**
   * 名称
   */
  name: string;
  /**
   * 消息
   */
  message: string;
  /**
   * 堆栈信息
   */
  stack?: string | undefined;
```

#### 4.EfAxiosConst常量

```
  /**
   * 默认的loading文字
   */
  static readonly loadingTxt: string = '努力获取数据中,请稍后...';
```

#### 5.AxiosUtil工具类

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

#### 6.EfClientApi工具类(1.0.3有改动)

> 该工具类提供统一简化各种请求方式,入参为json格式内部进行转换为所需对象

* appendHeader 私有方法 构造请求头

* post请求 json格式 async/await 方式

```
    //参数说明
    async post<F, E>(efClientParams: efClientParams<F>): Promise<E | EfAxiosError>  
    //efClientParams为优化后的请求入参对象,具体参数详见上方2.efClientParams类参数详解
    //当前请求需要传入efClientParams.url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+efClientParams.url 组合而成
    //efClientParams.query 为请求入参对象
    //efClientParams.baseURL 为单独接口需要更换基地址时设置(1.0.3+)
    //F  为请求入参对象,具体参照示例中的写法
    //E 为响应结果对象
    //efClientParams.headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //当前请求需要传入efClientParams.query 为F类型的对象
    //注意返回结果如未报错则是E类型，否则为EfAxiosError
```

* post请求 formData格式 async/await 方式

```
    //参数说明
    async postFormData<E>(efClientParams: efClientParams<null>): Promise<E | EfAxiosError>
    //efClientParams为优化后的请求入参对象,具体参数详见上方2.efClientParams类参数详解
    //当前请求需要传入efClientParams.url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+efClientParams.url 组合而成
    //efClientParams.formData 业务传入的formData数据
    //efClientParams.baseURL 为单独接口需要更换基地址时设置(1.0.3+)
    //E 为响应结果对象
    //efClientParams.headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //注意返回结果如未报错则是E类型，否则为EfAxiosError
```

* get请求 async/await 方式

```
    //参数说明 格式为  getXXXX/id/name/xxxx
    async get<E>(efClientParams: efClientParams<null>): Promise<E | EfAxiosError>
    //efClientParams为优化后的请求入参对象,具体参数详见上方2.efClientParams类参数详解
    //当前请求需要传入efClientParams.url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+efClientParams.url 组合而成
    //E 为响应结果对象
    //efClientParams.headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //efClientParams.baseURL 为单独接口需要更换基地址时设置(1.0.3+)
    //注意返回结果如未报错则是E类型，否则为EfAxiosError
    //注意demo中的get请求为rest方式,即入参无需?param1=value,而是 get方法/param1/param2 以此类推
```

* getByParams请求 async/await 方式

```
    //参数说明   参数为json格式
    async getByParams<E>(efClientParams: efClientParams<null>): Promise<E | EfAxiosError>
    //efClientParams为优化后的请求入参对象,具体参数详见上方2.efClientParams类参数详解
    //当前请求需要传入efClientParams.url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+efClientParams.url 组合而成
    //E 为响应结果对象
    //efClientParams.headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //efClientParams.baseURL 为单独接口需要更换基地址时设置(1.0.3+)
    //efClientParams.params表示get请求的入参符合key:value格式
    //注意返回结果如未报错则是E类型，否则为EfAxiosError
    
```

* delete请求 async/await 方式

```
    //参数说明
    async delete<E>(efClientParams: efClientParams<null>): Promise<E | EfAxiosError> 
    //efClientParams为优化后的请求入参对象,具体参数详见上方2.efClientParams类参数详解
    //当前请求需要传入efClientParams.url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+efClientParams.url 组合而成
    //E 为响应结果对象
    //efClientParams.headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //efClientParams.baseURL 为单独接口需要更换基地址时设置(1.0.3+)
    //注意返回结果如未报错则是E类型，否则为EfAxiosError
    //注意demo中的delete请求为rest方式,即入参方式为 delete方法/param1/param2 以此类推
```

* put请求 async/await 方式

```
    //参数说明
    async put<F, E>(efClientParams: efClientParams<F>): Promise<E | EfAxiosError>
    //efClientParams为优化后的请求入参对象,具体参数详见上方2.efClientParams类参数详解
    //当前请求需要传入efClientParams.url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+efClientParams.url 组合而成
    //efClientParams.query 为请求入参对象
    //efClientParams.baseURL 为单独接口需要更换基地址时设置(1.0.3+)
    //E 为响应结果对象
    //F 为请求入参对象,具体参照示例中的写法
    //efClientParams.headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //注意返回结果如未报错则是E类型，否则为EfAxiosError
```

* all 批量获取请求

```
    //参数说明
    async all(requestList: Promise<AxiosResponse>[]): Promise<ArrayList<string> | EfAxiosError>
    //requestList需要传入的请求集合
    //返回ArrayList<string>,请求结果转换为字符串的数组
    //注意返回结果如未报错则是ArrayList<string>类型，否则为EfAxiosError
    
```

* upload 统一的上传请求 async/await 方式

```
    //参数说明
    async upload(efClientParams: efClientParams<null>, progressCallBack: (process: number) => void): Promise<Object>
    //efClientParams为优化后的请求入参对象,具体参数详见上方2.efClientParams类参数详解
    //当前请求需要传入efClientParams.url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+efClientParams.url 组合而成
    //efClientParams.isUri  是否为uri文件
    //efClientParams.data  isUri=false时传入 表示上传的文件为ArrayBuffer格式
    //efClientParams.uri   isUri=true时传入  表示上传的文件为uri格式
    //efClientParams.keyName  上传时后端接收的key,默认为file
    //efClientParams.headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //efClientParams.baseURL 为单独接口需要更换基地址时设置(1.0.3+)
    
    //progressCallBack 上传进度回调,具体参照示例中的写法
```

* download 统一的下载请求 async/await 方式

```
    //参数说明
    async download(efClientParams: efClientParams<null>, progressCallBack: (process: number) => void): Promise<Object>
    //efClientParams为优化后的请求入参对象,具体参数详见上方2.efClientParams类参数详解
    //当前请求需要传入efClientParams.url 为请求方法的url 全路径应该为 efAxiosParams.baseURL+efClientParams.url 组合而成
    //efClientParams.filePath  下载文件名称 如下载png图片后希望名称为girl.png
    //efClientParams.headers  提供给如果当前请求需要额外设置headers请求头参数时使用,保持json格式
    //efClientParams.baseURL 为单独接口需要更换基地址时设置(1.0.3+)
    //progressCallBack 上传进度回调,具体参照示例中的写法
```

#### 7.使用示例

* 登录示例/post

```
  async login() {
    //登录
    let dto = await efClientApi.post<User, OutDTO<UserDTO>>({
      url: '/api/eftool/login',
      query: new User(this.account, this.pwd),
      headers: {
        "efAxiosHeader": '旺旺崔冰冰'
      },
      loadingTxt: 'eftool登录中...',
      // baseUrl:''  如有需要则自行设置
    })
    //此处如果异常报错则类型为EfAxiosError
    if (!(dto instanceof EfAxiosError) && dto) {
      //请求成功后将token存储在efRcpParams.tokenValue
      efAxiosParams.tokenValue = dto["dataRow"].token;
      efAxiosParams.tokenName = "Authorization";
    }
    this.message = JSON.stringify(dto);
  }
```

* postForm示例

```
  async postForm() {
    //模拟测试post-formData请求
    let formData = new FormData();
    formData.append("account", "1234QQQ");
    formData.append("nickName", "旺旺崔冰冰");
    formData.append("pwd", "1111111");
    const dto = await efClientApi.postFormData<OutDTO<Record<string, Object>>>({
      url: '/api/eftool/postFormData',
      formData: formData,
      headers: {
        "formData": "csx"
      },
      loadingTxt: '模拟form请求...',
      // baseUrl:''  如有需要则自行设置
    });
    this.message = JSON.stringify(dto);
  }
```

* get示例

```
  async get() {
    //模拟测试get请求
    const dto = await efClientApi.get<OutDTO<Record<string, Object>>>({
      url: '/api/eftool/get/11111111',
      // baseUrl:''  如有需要则自行设置
    });
    this.message = JSON.stringify(dto);
  }
```

* getParams示例

```
 async getParams() {
    //模拟测试get请求
    let dto = await efClientApi.getByParams<OutDTO<Record<string, Object>>>({
      url: '/api/eftool/getNew',
      params: {
        "key_csx": '测试get',
        "key_cc": '第二个参数'
      },
      // baseUrl:''  如有需要则自行设置
    })
    this.message = JSON.stringify(dto);
  }
```

* put示例

```
  async put() {
    //模拟put
    let dto = await efClientApi.put<User, OutDTO<UserDTO>>({
      url: '/api/eftool/put',
      query: new User('put请求', 'xxxxxxxxx'),
      headers: {
        "efAxiosHeader": '旺旺崔冰冰'
      },
      // baseUrl:''  如有需要则自行设置
    })
    this.message = JSON.stringify(dto);
  }
```

* delete示例

```
  async delete() {
    //模拟测试delete请求
    const dto = await efClientApi.delete<OutDTO<Record<string, Object>>>({
      url: '/api/eftool/delete/1212133',
      // baseUrl:''  如有需要则自行设置
    });
    this.message = JSON.stringify(dto);
  }
```

* all 示例

```
  async all() {
    //请求1
    const get1 = (): Promise<AxiosResponse> => {
      return efAxios.get<OutDTO<Record<string, Object>>, AxiosResponse, null>('/api/eftool/get/11111111');
    }
    //请求2
    const get2 = (): Promise<AxiosResponse> => {
      return efAxios.get<OutDTO<Record<string, Object>>, AxiosResponse, null>('/api/eftool/get/2222222222');
    }
    let result = await efClientApi.all([get1(), get2()]);
    this.message = JSON.stringify(result);
  }
```

* 上传示例

```
  async upload() {
    let imgArr = getContext().resourceManager.getMediaContentSync($r("app.media.startIcon").id);
    let buf = buffer.from(imgArr).buffer;
    let res = await efClientApi.upload({
      url: '/api/eftool/upload',
      isUri: false,
      data: buf,
      // baseUrl:''  如有需要则自行设置
    }, (progress: number) => {
      this.message = "上传进度:" + progress;
    });
    this.message = JSON.stringify(res)
  }
```

* 下载示例

```
  async download() {
    let res = await efClientApi.download({
      url: '/api/eftool/download/133cbf14-af0b-4764-8201-24b4b53f7e10-IMG_003.jpg',
      filePath: 'csx.jpg',
      headers: {
        "efAxiosHeader": '旺旺崔冰冰'
      },
      // baseUrl:''  如有需要则自行设置
    }, (progress: number) => {
      this.message = "下载进度:" + progress;
    });
    this.message = JSON.stringify(res);
  }
```

## [eftool](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Feftool)工具类ohpm地址

## 特别鸣谢

* [感谢coffey提供pull Request](https://gitee.com/coffey)

## star `ef_axios` 希望您可以动一动小手点点小⭐⭐

## 👴希望大家如有好的需求踊跃提交,如有问题请前往gitee提交issue，我闲暇时间会扩充与修复优化