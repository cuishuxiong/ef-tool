# <center>ef_rcp</center>

# <center>V1.0.4(API12)</center>

--------------------------------------------------------------------------------

## 📚简介

`ef_rcp`是`eftool`的rcp网络请求相关包.提供了rcp的上传,下载,post,get,cancel,delete,put等操作

> 你可以引入使用，也可以**拷贝**和修改使用，如需分享扩展
> ### **希望可以注明原出处即可**
> 也希望能把bug及时反馈回来。

> 我努力健全**中文**注释，为源码学习者提供良好地学习环境，争取做到人人都能看得懂。

## 🛠️包含组件

| 模块             | 介绍                                   |
|----------------|--------------------------------------|
| efRcp          | 提供针对efRcp的一系列请求相关功能的配置工具类            |
| efRcpConfig    | efRcp所有的相关配置命名空间                     |
| efRcpClientApi | 提供针对于统一post,get,delete,put等请求的灵活封装   |
| EfRcpError     | efRcp的统一异常处理对象,内置toString方法          |
| EfRcpResponse  | efRcp的统一响应对象,成功请求的数据为data异常的结果为error |

## 📦安装

### 🍊ohpm

* 执行安装命令

```
ohpm install @yunkss/ef_rcp
```

* 特殊说明

> ef_rcp依赖于ef_json,故将依赖引入为dependencies方式,即开发者在使用ef_rcp时无需自行引入ef_json,ef_rcp会自动下载对应依赖版本
> 但如果开发者自身业务需要使用JSON相关内容，则仍需要自行引入ef_json

## 📦使用

### 1.在项目中引入插件

```
import { efRcpClientApi, efRcpConfig,xxxx} from '@yunkss/ef_rcp'
```

类按需引入,项目需要使用那个就引入

### 2.ef_rcp使用API

##### 前言

> efRcp封装需要大家共建和提出建议与需求,已完善传post,postForm,put,get,delete,cancel请求,统一上传下载,以及配置证书,期待大家提出宝贵意见

> 后端Demo示例为Java开发,大家自行下载使用与阅读,如有问题请提出Issue

> 后端Demo示例地址[点此访问](https://gitee.com/yunkss/ef-axios-java)

##### 1.efRcpConfig配置类参数详解(1.0.2有改动)

* timeout 超时对象

```
    /**
     * 允许建立连接的最长时间
     */
    connectMs?: number;
    /**
     * 允许传输数据的最长时间
     */
    transferMs?: number;
```

* sysCodeEvent 系统级别的请求响应码对象(1.0.1有改动)

```
    /**
     * 请求响应码监听-业务自行处理数据
     */
    listener: (code: number) => void = () => {};
```

* businessCodeEvent 业务级别的请求响应码对象(1.0.1+)

```
    /**
     * 业务级别自定义错误编码/异常code字段名称
     */
    businessCodeName: string = '';
    /**
     * 请求响应码监听-业务自行处理数据
     */
    listener: (code: Object | null) => void = () => {
    };
```

* cryptoEvent 请求拦截加解密操作

```
    /**
     * 请求加密操作-业务自行处理数据 - 默认无任何操作直接返回
     */
    requestEncoder: (request: rcp.RequestContext) => rcp.RequestContext =
      (request: rcp.RequestContext): rcp.RequestContext => {
        return request;
      };
    /**
     * 请求解密操作-业务自行处理数据 - 默认无任何操作直接返回
     */
    responseDecoder: (response: rcp.Response) => rcp.Response =
      (response: rcp.Response): rcp.Response => {
        return response;
      };
```

* sessionListener 会话监听器

```
    /**
     * 会话关闭事件回调。会话关闭时调用
     */
    onClosed: () => void = () => {};
    /**
     * 会话取消事件的回调。会话取消时调用
     */
    onCanceled: () => void = () => {};
```

* uploadEvent 上传相关事件

```
    /**
     * 监听上传进度
     */
    onUploadProgress: (progress: number) => void = (progress: number) => {};
```

* downloadEvent 下载相关事件

```
    /**
     * 监听下载进度
     */
    onDownloadProgress: (progress: number) => void = (progress: number) => {};
```

* securityCfg 证书相关配置

```
    /**
     * 证书颁发机构
     */
    remoteValidation?: 'system' | 'skip' | rcp.CertificateAuthority | rcp.ValidationCallback = 'system';
    /**
     * 客户端证书,身份认证
     */
    certificate?: rcp.ClientCertificate;
    /**
     * 安全连接期间的服务器身份验证配置
     */
    serverAuthentication?: rcp.ServerAuthentication
```

* securityUtil 证书工具类

```
    /**
     * 读取证书内容
     * @param certPath 证书地址需要为沙箱环境地址
     * @returns 证书字符串
     */
    static readClientCerts(certPath: string): string;
```

* loading 全局加载对象设置

```
    /**
     * 是否启用 - 默认true
     */
    static enable: boolean = true;
    /**
     * loading提示内容 - 默认为【努力获取数据中,请稍后...】
     */
    static content: string = '努力获取数据中,请稍后...';
    /**
     * 动画builder属性-图片类-只支持gif动图 暂不支持在内部使用状态变量
     */
    static imgBuilder?: WrappedBuilder<[]>;
    /**
     * loading是否为lottie动画
     */
    static enableLottie: boolean = false
    /**
     * lottie动画所需画板 - enableLottie 为true时生效
     */
    static lottieRenderingCtx: CanvasRenderingContext2D =  new CanvasRenderingContext2D(new RenderingContextSettings(true));
```

* token token相关配置

```
    /**
     * 登录成功后的token的key
     */
    static tokenName: string = 'authorization';
    /**
     * 登录成功后的token值
     */
    static tokenValue: string = '';
```

* commonParams 请求公共传参(1.0.2有改动)

```
    /**
    * 基础请求前缀地址 非必填 需要时设置
    */
    baseURL?:string; 
    /**
     * 请求路径 必填
     */
    url: string = '';
    /**
     * 当次请求需要设置的请求头
     */
    headers?: Record<string, string>;
    /**
     * 当次请求需要设置的cookies
     */
    cookies?: Record<string, string>;
    /**
     * 当次请求需要设置的loading文本
     */
    loadingTxt?: string;
```

* requestBaseParams post/put请求所需参数对象 - 继承所有commonParams参数(1.0.2有改动)

```
    /**
     * 请求参数 post/put
     */
     query: Record<string, Object> | rcp.FormFields | rcp.MultipartFormFields | ESObject = {};
    /**
     * 解决post传参但是需要将参数拼接URL情况
     */
    isParams?: boolean;
    
```

* deleteParams delete请求所需参数对象 - 继承所有commonParams参数(1.0.3+)

```
    /**
     * 请求参数 delete
     */
    query: Record<string, Object> | ESObject = {};

```

* uploadParams 上传入参对象 - 继承所有commonParams参数

```
    /**
     * 上传文件字段
     */
    fileInfo: rcp.MultipartFormFields = {};
```

* downloadParams 下载入参对象 - 继承所有commonParams参数

```
    /**
     * 下载文件名
     */
    fileName: string = '';
```

##### 2.efRcp工具类(1.0.2有改动)

* getInstance 懒汉模式获取EfRcp类单例

* create 创建session对象 如业务某些地方需要根据参数重新创建session则可多次调用,默认只需要调用一次

* builder 获取构建后的session对象

* setBaseURL 设置全局请求地址前缀 - 设置后需要调用create重新创建,可批量链式调用后最后再去create

* enableLogInterceptor 是否启用日志拦截器 - 设置后需要调用create重新创建,可批量链式调用后最后再去create

* addCustomInterceptors 添加用户自定义拦截器 - 可添加多个 - 设置后需要调用create重新创建,可批量链式调用后最后再去create

* addCommonHeaders 添加公共的header - 设置后需要调用create重新创建,可批量链式调用后最后再去create

* addCommonCookies 添加公共的cookie - 设置后需要调用create重新创建,可批量链式调用后最后再去create

* setConfig 全部自定义session配置 - 特殊场景如efRcp所有默认配置均不满足开发需求，则全部自定义并设置

  > 注意调用完setConfig后必须调用create方法重新创建session对象,否则配置不生效

* addSysCodeEvent 添加统一的系统框架级别编码拦截操作(1.0.1有改动) - 设置后需要调用create重新创建,可批量链式调用后最后再去create

* addBusinessCodeEvent 添加统一的业务级别编码拦截操作(1.0.1+) - 设置后需要调用create重新创建,可批量链式调用后最后再去create

* addCryptoEvent 添加自定义加解密拦截 - 设置后需要调用create重新创建,可批量链式调用后最后再去create

* setTimeOut 设置超时时间 - 设置后需要调用create重新创建,可批量链式调用后最后再去create

* setSessionListener 设置会话监听 - 设置后需要调用create重新创建,可批量链式调用后最后再去create

* setUploadEvent 设置上传进度操作 - 设置后需要调用create重新创建,可批量链式调用后最后再去create

* setDownLoadEvent 设置下载进度操作 - 设置后需要调用create重新创建,可批量链式调用后最后再去create

* addSecurity 设置证书 - 设置后需要调用create重新创建,可批量链式调用后最后再去create

* disableLoading 禁用全局加载框 - 设置后无需重新创建

* setLoadingContent 更改全局默认loading的提示内容 - 设置后无需重新创建

* setLoadingImg 更改全局默认loading的图片- 全局builder,内容业务自行传入,只支持gif动图,不支持内部使用状态变量

* enableLottie 启用loading加载使用lottie动画 - 设置后无需重新创建

* setLottieAnimation 设置lottie动画 - 设置后无需重新创建

* setDNS 设置DNS相关配置 - 设置后需要调用create重新创建,可批量链式调用后最后再去create

* efRcp 抛出的全局efRcp对象,可链式调用

##### 3.efRcpClientApi工具类(1.0.3有改动)

> 该工具类提供统一简化各种请求方式

* post请求 json格式 async/await 方式

```
    //参数说明
    async post<E>(postParam: efRcpConfig.requestBaseParams, cls?: ClassConstructor<E>,securityCfg?: efRcpConfig.securityCfg): Promise<EfRcpResponse<E>>
    //postParam post请求所需参数,详见efRcpConfig.requestBaseParams
    //cls 需要返回的泛型对象,内部会做类型转换，转换后泛型的方法调用不会报错,嵌套对象时只有第一层生效
    //securityCfg 本次请求是否需要更换证书 - 证书对象,详见efRcpConfig.securityCfg
    //EfRcpResponse<E> 为响应结果对象,请求成功数据存入data字段，请求失败存入error字段，如有场景需要判断系统框架级别error则获取使用

```

* postForm请求 async/await 方式

```
    //参数说明   参数为form格式
    async postForm<E>(postParam: efRcpConfig.requestBaseParams, cls?: ClassConstructor<E>,securityCfg?: efRcpConfig.securityCfg): Promise<EfRcpResponse<E>>
    //postParam post请求所需参数,详见efRcpConfig.requestBaseParams
    //cls 需要返回的泛型对象,内部会做类型转换，转换后泛型的方法调用不会报错,嵌套对象时只有第一层生效
    //securityCfg 本次请求是否需要更换证书 - 证书对象,详见efRcpConfig.securityCfg
    //EfRcpResponse<E> 为响应结果对象,请求成功数据存入data字段，请求失败存入error字段，如有场景需要判断系统框架级别error则获取使用

```

* postMultipartForm请求 async/await 方式 (1.0.2+)

```
    //参数说明   参数为MultipartForm格式
    async postMultipartForm<E>(postParam: efRcpConfig.requestBaseParams, cls?: ClassConstructor<E>,securityCfg?: efRcpConfig.securityCfg): Promise<EfRcpResponse<E>>
    //postParam post请求所需参数,详见efRcpConfig.requestBaseParams
    //cls 需要返回的泛型对象,内部会做类型转换，转换后泛型的方法调用不会报错,嵌套对象时只有第一层生效
    //securityCfg 本次请求是否需要更换证书 - 证书对象,详见efRcpConfig.securityCfg
    //EfRcpResponse<E> 为响应结果对象,请求成功数据存入data字段，请求失败存入error字段，如有场景需要判断系统框架级别error则获取使用
```

* get请求 async/await 方式

```
    //参数说明 格式为  getXXXX/id/name/xxxx
    async get<E>(getParam: efRcpConfig.commonParams, cls?: ClassConstructor<E>,securityCfg?: efRcpConfig.securityCfg): Promise<EfRcpResponse<E>>
    //getParam get请求所需参数,详见efRcpConfig.commonParams
    //cls 需要返回的泛型对象,内部会做类型转换，转换后泛型的方法调用不会报错,嵌套对象时只有第一层生效
    //securityCfg 本次请求是否需要更换证书 - 证书对象,详见efRcpConfig.securityCfg
    //EfRcpResponse<E> 为响应结果对象,请求成功数据存入data字段，请求失败存入error字段，如有场景需要判断系统框架级别error则获取使用

```

* put请求 async/await 方式

```
    //参数说明
    async put<E>(putParam: efRcpConfig.requestBaseParams, cls?: ClassConstructor<E>,securityCfg?: efRcpConfig.securityCfg): Promise<EfRcpResponse<E>>
    //putParam put请求所需参数,详见efRcpConfig.requestBaseParams
    //securityCfg 本次请求是否需要更换证书 - 证书对象,详见efRcpConfig.securityCfg
    //EfRcpResponse<E> 为响应结果对象,请求成功数据存入data字段，请求失败存入error字段，如有场景需要判断系统框架级别error则获取使用

```

* delete请求 async/await 方式(1.0.3有改动)

```
    //参数说明
    async delete<E>(deleteParam: efRcpConfig.deleteParams, cls?: ClassConstructor<E>,securityCfg?: efRcpConfig.securityCfg): Promise<EfRcpResponse<E>>
    //deleteParam delete请求所需参数,详见efRcpConfig.deleteParams
    //cls 需要返回的泛型对象,内部会做类型转换，转换后泛型的方法调用不会报错,嵌套对象时只有第一层生效
    //securityCfg 本次请求是否需要更换证书 - 证书对象,详见efRcpConfig.securityCfg
    //EfRcpResponse<E> 为响应结果对象,请求成功数据存入data字段，请求失败存入error字段，如有场景需要判断系统框架级别error则获取使用

```

* patch请求 async/await 方式

```
    //参数说明
    async patch<E>(patchParam: efRcpConfig.requestBaseParams, cls?: ClassConstructor<E>,securityCfg?: efRcpConfig.securityCfg): Promise<EfRcpResponse<E>>
    //patchParam patch请求所需参数,详见efRcpConfig.requestBaseParams
    //cls 需要返回的泛型对象,内部会做类型转换，转换后泛型的方法调用不会报错,嵌套对象时只有第一层生效
    //securityCfg 本次请求是否需要更换证书 - 证书对象,详见efRcpConfig.securityCfg
    //EfRcpResponse<E> 为响应结果对象,请求成功数据存入data字段，请求失败存入error字段，如有场景需要判断系统框架级别error则获取使用

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
    async uploadFile<E>(uploadParam: efRcpConfig.uploadParams, cls?: ClassConstructor<E>,securityCfg?: efRcpConfig.securityCfg): Promise<EfRcpResponse<E>>
    //uploadParam 上传文件所需参数,详见efRcpConfig.uploadParams
    //cls 需要返回的泛型对象,内部会做类型转换，转换后泛型的方法调用不会报错,嵌套对象时只有第一层生效
    //securityCfg 本次请求是否需要更换证书 - 证书对象,详见efRcpConfig.securityCfg
    //EfRcpResponse<E> 为响应结果对象,请求成功数据存入data字段，请求失败存入error字段，如有场景需要判断系统框架级别error则获取使用

```

* downloadFile 统一的下载请求 async/await 方式

```
    //参数说明
    async downloadFile<E>(downloadParam: efRcpConfig.downloadParams, cls?: ClassConstructor<E>): Promise<EfRcpResponse<E>>
    //downloadParam 下载文件所需参数,详见efRcpConfig.downloadParams
    //cls 需要返回的泛型对象,内部会做类型转换，转换后泛型的方法调用不会报错,嵌套对象时只有第一层生效
    //securityCfg 本次请求是否需要更换证书 - 证书对象,详见efRcpConfig.securityCfg
    //EfRcpResponse<E> 为响应结果对象,请求成功数据存入data字段，请求失败存入error字段，如有场景需要判断系统框架级别error则获取使用

```

* downloadStream 统一的下载请求 async/await 方式

```
    //参数说明
    async downloadStream<E>(downloadParam: efRcpConfig.downloadParams, cls?: ClassConstructor<E>): Promise<EfRcpResponse<E>>
    //downloadParam 下载文件所需参数,详见efRcpConfig.downloadParams
    //cls 需要返回的泛型对象,内部会做类型转换，转换后泛型的方法调用不会报错,嵌套对象时只有第一层生效
    //securityCfg 本次请求是否需要更换证书 - 证书对象,详见efRcpConfig.securityCfg
    //EfRcpResponse<E> 为响应结果对象,请求成功数据存入data字段，请求失败存入error字段，如有场景需要判断系统框架级别error则获取使用

```

* 初始化参数配置示例

> 请求相关的参数配置建议在Ability的onWindowStageCreate方法中配置部分已知的固定类型的

> 其余如拦截器等在使用时灵活配置即可,下方代码示例中有详细配置步骤,请查阅

> 可使用BuildProfile获取到当前运行的还是debug/qa/test/release等 然后设置不同的请求信息

```
  if(运行环境===debug){
    //关于rcp的配置
    efRcp
       //设置请求路径
      .setBaseURL("http://aliyunmr.com:18088")
      //启用打印日志
      .enableLogInterceptor()
      //更改loading文本
      .setLoadingContent('充值有大礼包...')
      //设置一部分不需要从接口获取的常量公共头
      .addCommonHeaders({
        "platform": "HarmonyOS",
        "version": "V1.0.0"
      })
      //设置loading为gif图片
      // .setLoadingImg(wrapBuilder(loadingImg))
      //启动lottie  与setLoadingImg互斥不可同事使用
      .enableLottie()
      //创建session对象,需要再设置为一系列操作后再调用，否则设置不生效,可在特殊情况处设置其他操作后重新创建session
      .create();
  }
  if(运行环境===qa){
    //关于rcp的配置
    efRcp
       //设置请求路径
      .setBaseURL("http://aliyunmr.com:18088")
      //更改loading文本
      .setLoadingContent('正式环境的loading...')
      //设置公共头
      .addCommonHeaders({
        "platform": "HarmonyOS",
        "version": "V1.0.1"
      })
      .enableLogInterceptor(false)  设置为false即可关闭
      //设置loading为gif图片
      .setLoadingImg(wrapBuilder(loadingImg))
      //创建session对象,需要再设置为一系列操作后再调用，否则设置不生效,可在特殊情况处设置其他操作后重新创建session
      .create();
  }
```

* 登录示例

```
  async login() {
    //此处模拟系统第一次调用接口,设置lottie加载动画
    //设置动画必须要加100ms的timer,原因为官方需要再canvas的onready方法后再设置动画
    //而点击时才创建窗口,故需要等窗口的dom原始绘制完，再进行动画创建
    setTimeout(() => {
      efRcp
        .setLottieAnimation((ctx: CanvasRenderingContext2D) => {
          lottie.destroy('2016');
          lottie.loadAnimation({
            container: ctx, // 渲染上下文
            renderer: 'canvas', // 渲染方式
            loop: true, // 是否循环播放,默认true
            autoplay: true, // 是否自动播放，默认true
            name: '2016', // 动画名称
            contentMode: 'Contain', // 填充的模式
            frameRate: 20, //设置animator的刷帧率为20
            //此处的动画只能是动画内容json格式，故需要将xxx.json放入rawfile中读取内容设置
            animationData: JSON.parse(this.lottieStr)
          })
        });
    }, 100)
    //登录  如果需要转换类型,则post后可不写类型,将类型传入到post方法的第二个入参
    let dto = await efRcpClientApi.post({
      url: '/api/eftool/login',
      query: {
        'account': 'efadmin',
        'pwd': '123456'
      },
      loadingTxt: '小的正在努力奋斗...'
    }, OutDTO<UserDTO>);//OutDTO<UserDTO>表示需要将返回结果转换为OutDTO<UserDTO>类型,则OutDTO的方法可以调用
    if (dto.data) {
      //dto.data.getXXX()  getXXX 方法此处不会报错
      //请求成功后将token存储在efRcpParams.tokenValue
      efRcpConfig.token.tokenValue = dto.data.getDataRow().token;
      efRcpConfig.token.tokenName = "Authorization";
      this.message = JSON.stringify(dto.data.getDataRow());
    }
    //else部分如果业务需要判断该系统异常则加,否则只判断dto.data即可
    else {
      this.message = dto.error?.message;
    }
```

* 切换baseURL示例(1.0.2+)

```
  async testChangeBaseURL() {
    let dto = await efRcpClientApi.get<string>({
      baseURL: 'https://gitee.com',
      url: '/yunkss/ef-tool/access/add_access_log',
    });
    this.message = JSON.stringify(dto);
  }
```

* post示例 json格式

```
   async postJSON() {
    let dto = await efRcpClientApi.post <OutDTO<UserDTO>>({
      url: '/api/eftool/post',
      isParams: true, //此处模拟虽然是post,但是需要将参数拼接url的特例
      query: {
        "nickName": "旺旺崔冰冰",
        "account": 'yunkss@163.com',
        "age": 12,
        "hobby": ["吃", "喝", "敲代码"],
        "sex": true
      }
    });
    this.message = JSON.stringify(dto);
  }
```

* post示例 form格式 - 附带重新设置某些参数如追加公共headers

```
  async postForm() {
    //此处演示某些场景需要获取到一些数据后再次设置session的配置
    efRcp
      .addCommonHeaders({
        //如此处需要从接口中获取公共参数如sign,后再去设置公共请求头
        "csxChange": "HarmonyOS1.1.1",
        "sign":"从接口获取的sign值"
      })
      .addSysCodeEvent({
        listener: (code: number) => {
          Logger.debug("---------addSysCodeEvent监听事件-----", code + "")
        }
      })
      .addBusinessCodeEvent({
        businessCodeName: 'csxErrorCode',
        listener: (codeValue) => {
          Logger.debug('---------addBusinessCodeEvent监听-----------', codeValue as string)
        }
      })
      //切记需要调用create重新创建session否则设置不生效
      .create();
    //登录
    let dto = await efRcpClientApi.postForm<OutDTO<UserDTO>>({
      url: '/api/eftool/postFormData',
      query: {
        "nickName": "旺旺崔冰冰",
        "account": 'yunkss@163.com',
        "age": 12,
        "hobby": ["吃", "喝", "敲代码"],
        "sex": true
      }
    });
    this.message = JSON.stringify(dto);
  }
```

* get示例

```
  async testGet() {
    let dto = await efRcpClientApi.get<OutDTO<string>>({
      url: '/api/eftool/get/122341',
      headers: {
        "testHeader": "111"
      },
      cookies: {
        "testCookie": "csx"
      }
    });
    this.message = JSON.stringify(dto);
  }
```

* put示例

```
  async testPUT() {
    let dto = await efRcpClientApi.put<OutDTO<string>>({
      url: '/api/eftool/put',
      query: {
        "nickName": "旺旺崔冰冰",
        "account": 'yunkss@163.com',
        "age": 12,
        "hobby": ["吃", "喝", "敲代码"],
        "sex": true
      }
    });
    this.message = JSON.stringify(dto);
  }
```

* delete示例

```
  async testDelete() {
    let dto = await efRcpClientApi.delete<OutDTO<string>>({
      url: '/api/eftool/delete/5345345'
    });
    this.message = JSON.stringify(dto);
  }
```

```
  async testDeleteBody() {
    let dto = await efRcpClientApi.delete<OutDTO<string>>({
      url: '/api/eftool/deleteBody',
      query: {
        "id": "1111111"
      }
    });
    this.message = JSON.stringify(dto);
  }
```

* cancel示例

```
  async testCancel() {
    let dto = await efRcpClientApi.post <OutDTO<UserDTO>>({
      url: '/api/eftool/post',
      query: {
        "nickName": "旺旺崔冰冰",
        "account": 'yunkss@163.com',
        "age": 12,
        "hobby": ["吃", "喝", "敲代码"],
        "sex": true
      }
    });
    await efRcpClientApi.cancel('/api/eftool/post');
  }
```

* patch 示例

```
  async testPATCH() {
    let dto = await efRcpClientApi.patch<OutDTO<string>>({
      url: '/api/eftool/patch/12306',
      query: {
        "nickName": "旺旺崔冰冰",
        "account": 'yunkss@163.com',
        "age": 12,
        "hobby": ["吃", "喝", "敲代码"],
        "sex": true
      }
    });
    this.message = JSON.stringify(dto);
  }
```

* 上传示例

```
    上传进度在如下处
    .setUploadEvent({
        onUploadProgress: (progress) => {
          Logger.debug("---------测试上传进度----------", progress + "%")
        }
    })
```

```
  //此处演示需要使用上传进度时再去设置,全局只需要设置一次即可
   efRcp
   .setUploadEvent({
     onUploadProgress: (progress) => {
       Logger.debug("---------测试上传进度----------", progress + "%")
     }
   })
   //切记需要调用create重新创建session否则设置不生效
   .create();
   let arr = getContext().resourceManager.getMediaContentSync($r("app.media.abc").id);
    //上传
    let dto =
      await efRcpClientApi.uploadFile<OutDTO<string>>({
        url: '/api/eftool/upload',
        fileInfo: {
          "file": {
            contentType: 'multipart/form-data',
            remoteFileName: 'newRcp.png',
            contentOrPath: {
              content: buffer.from(arr).buffer
            }
          }
        }
      });
    this.message = JSON.stringify(dto);
```

* 下载示例

```
    下载进度在如下处
    .setDownLoadEvent({
        onDownloadProgress: (progress) => {
          Logger.debug("---------测试下载进度----------", progress + "%")
        }
    })
```

```
  //此处演示需要使用下载进度时再去设置,全局只需要设置一次即可
  efRcp
  .setDownLoadEvent({
    onDownloadProgress: (progress) => {
      Logger.debug("---------测试下载进度----------", progress + "%")
    }
  })
  //切记需要调用create重新创建session否则设置不生效
  .create();
  async testDownloadStream() {
    let dto =
      await efRcpClientApi.downloadStream<OutDTO<string>>({
        url: '/api/eftool/download/13c79c32-c291-429b-a1a9-e6ae2cb0b635-IMG_010.png',
        fileName: 'abc.jpg'
      });
    this.message = JSON.stringify(dto);
  }
```

```
  async testDownloadFile() {
    let dto =
      await efRcpClientApi.downloadFile<OutDTO<string>>({
        url: '/api/eftool/download/ddbab76c-6d73-4ba8-8efc-9e5264ade01a-newRcp.png',
        fileName: 'csx1.png'
      })
    this.message = JSON.stringify(dto);
  }
```

##### 4.EfRcpError工具类

* 字段

```
  /**
   * 编码
   */
  code: number;
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

* toString 转换成json字符串

* getCode 获取错误码

* getName 获取错误名称

* getMessage 获取错误提示

##### 5.EfRcpResponse工具类

```
  /**
   * 请求成功返回的数据
   */
  data?: E;

  /**
   * 请求失败返回的系统框架级错误信息 - 如连接超时,400，401，403，500等
   */
  error?: EfRcpError;
  
  //如果系统不关注系统级别的异常,则调用接口只需要判断data不为空则请求成功即可
```

## [eftool](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Feftool)工具类ohpm地址

## star `ef_rcp` 希望您可以动一动小手点点小⭐⭐

## 👴希望大家如有好的需求踊跃提交,如有问题请前往gitee提交issue，我闲暇时间会扩充与修复优化