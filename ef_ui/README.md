# <center>ef_ui</center>

# <center>V1.0.0(API12)</center>

--------------------------------------------------------------------------------

## 📚简介

`ef_ui`是`eftool`的UI组件相关包.封装了常用的通知、拍照、定位、预览、全局loading、toast、alert、confirm等,提供丰富的UI组件.

> 你可以引入使用，也可以**拷贝**和修改使用，如需分享扩展
> ### **希望可以注明原出处即可**
> 也希望能把bug及时反馈回来。

> 我努力健全**中文**注释，为源码学习者提供良好地学习环境，争取做到人人都能看得懂。

## 🛠️包含组件

| 模块               | 介绍               |
|------------------|------------------|
| AuthUtil         | 提供判断授权拉起授权的系列方法  |
| ButtonUtil       | 提供场景化按钮一系列方法     |
| CameraUtil       | 调起拍照工具类          |
| DownloadUtil     | 统一的上传下载按钮工具      |
| ImmersionUtil    | 提供沉浸式导航设置        |
| LocationUtil     | 提供获取定位,逆编码等功能    |
| NotificationUtil | 提供发送,删除通知等功能     |
| PickerUtil       | 调起选择文件、照片、音频等工具类 |
| PreviewUtil      | 预览工具类            |
| WindowUtil       | 提供窗口的创建关闭等功能     |
| ActionUtil       | 提供对操作菜单的一系列方法    |
| AlertUtil        | 提供操作确认弹出工具类      |
| ConfirmUtil      | 提供信息确认弹出工具类      |
| DialogUtil       | 提供对弹出框的一系列方法     |
| ExceptionUtil    | 提供省市区级联选择组件      |
| LoadingUtil      | 提供全局加载工具类        |
| TipsUtil         | 提供提示弹出工具类        |
| ToastUtil        | 提供对文本提示的一系列方法    |
| WinDialogUtil    | 窗口方式弹框工具类        |
| WinLoadingUtil   | 窗口方式全局加载工具类      |
| Cascade          | 提供省市区级联选择组件      |
| SelectUtil       | 提供选择弹出工具类        |

## 📦安装

### 🍊ohpm

* 执行安装命令

```
ohpm install @yunkss/ef_ui
```

* 特殊说明

> ef_ui依赖于ef_json,故将依赖引入为dependencies方式,即开发者在使用ef_ui时无需自行引入ef_json,ef_ui会自动下载对应依赖版本

## 📦使用

### 1.在项目中引入插件

```
import { CasCade, ToastUtil,TipsUtil,xxx} from '@yunkss/ef_ui'
```

类按需引入,项目需要使用那个就引入

### 2.ef_ui使用API

#### 1.AuthUtil的方法

#### 2.ButtonUtil的方法

#### 3.CameraUtil 调起拍照工具类(1.1.11+)

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

#### 4.DownloadUtil上传下载工具类

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

#### 5.ImmersionUtil沉浸式导航工具类

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

#### 6.LocationUtil位置工具类(V1.2.1+有改动)

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

#### 7.NotificationUtil通知工具类

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

#### 8.PickerUtil 调起选择工具类(1.1.11+)

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

#### 9.PreviewUtil 预览工具类

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

#### 10.WindowUtil窗口工具类

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

#### 11.ActionUtil的方法

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

#### 12.AlertUtil的方法

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

#### 13.ConfirmUtil的方法

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

#### 14.DialogUtil的方法

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

#### 15.ExceptionUtil的方法

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

#### 16.LoadingUtil的方法

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

#### 17.TipsUtil的方法

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

#### 18.ToastUtil的方法

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

#### 19.WinDialogUtil 以窗口方式弹出框工具类

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

#### 21.Cascade省市区级联

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

#### 22.SelectUtil的方法

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

## [eftool](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Feftool)工具类ohpm地址

## star `ef_ui` 希望您可以动一动小手点点小⭐⭐

## 👴希望大家如有好的需求踊跃提交,如有问题请前往gitee提交issue，我闲暇时间会扩充与修复优化