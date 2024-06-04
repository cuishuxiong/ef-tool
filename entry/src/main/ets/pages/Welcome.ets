/**
 * @Author csx
 * @DateTime 2024/4/3 10:24:04
 * @TODO Welcome
 */
import {
  AES,
  AudioCapturerUtil,
  CameraUtil,
  DES,
  DownloadUtil,
  efAxiosParams,
  efClientApi,
  IdCardUtil,
  JSONArray,
  JSONArrayList,
  JSONObject,
  PickerUtil,
  PreviewUtil,
  SHA,
  SM2,
  SM2Convert,
  ToastUtil,
  WinDialogUtil,
} from '@yunkss/eftool'
import { ArrayList, buffer, util } from '@kit.ArkTS';
import { common } from '@kit.AbilityKit';
import fs from '@ohos.file.fs';
import fileUri from "@ohos.file.fileuri";
import { cryptoFramework } from '@kit.CryptoArchitectureKit';

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

class User {
  id?: string;
  name?: string;

  constructor(id: string, name: string) {
    this.name = name;
    this.id = id;
  }
}

class Person {
  name: string;
  age: number;
  birth: Date;
  sex: boolean;
  user: User;
  list?: Array<User>;

  constructor(name: string, age: number, sex: boolean, birth: Date, user: User, list?: Array<User>) {
    this.birth = birth;
    this.name = name;
    this.age = age;
    this.sex = sex;
    this.user = user;
    this.list = list;
  }
}

@Entry
@Component
struct Welcome {
  @State msg: string = 'csx';
  private alertWinName: string = '';

  /**
   * 初始化请求参数
   */
  aboutToAppear(): void {
    //请求地址前缀
    efAxiosParams.baseURL = 'http://aliyunmr.com:18088';
    //是否开启传输整体加密
    efAxiosParams.isAllEncrypt = true;
    //加密的SM2key
    efAxiosParams.sm2PubKey = '04ba3bc3c5834d9ad1a7d81c4b49cf1209d2f28e4a97c73b75d6561792a2bfafe811e0284692006b0ce1b51f8aadfd65241d80eb979365048253408f5d705ec17b';
  }

  testJSONArrayList() {
    // let arr = new JSONArrayList();
    // arr.add(1);
    // arr.add("cccc");
    // arr.add("123");
    // arr.add("aaaaa\\\"34343434");
    // arr.add("2223\"dasdass");
    // arr.add(new Date());
    // arr.add(true);
    // arr.add(null);
    // arr.add(new User("10010", "实体数据"));
    // let str = arr.toString();
    //
    // let userList = new ArrayList<User>();
    // userList.add(new User('2345', '测试用户1'));
    // userList.add(new User('7844', '测试用户2'));
    // userList.add(new User('1314', '测试用户3'));
    // userList.add(new User('5210', '测试用户4'));
    //
    // let jarr = JSONArrayList.from(userList);
    // this.msg = jarr.length + "";
    //
    // let s = JSONArrayList.toJSONString(userList);
    // this.msg = s;
    //
    // let jsArr = JSONArrayList.parse(s);
    // this.msg = jsArr.length + "";

    let str1 = '[{"threeMonthRate":null,"moduleName":"loan","productName":"网E贷","marketPatter":"随借随还，最高20万，利率低至8折起","labelListJson":{"site1":{"labelType":0,"labelValue":"网E贷","labelName":"产品名称:123","labelLocation":true}}},{"threeMonthRate":null,"moduleName":"loan","productName":"烟草贷","marketPatter":"无需抵押，无需担保，当天放款，随借随还","labelListJson":{"site1":{"labelType":12,"labelValue":"烟草贷","labelName":"产品名称","labelLocation":false}}}]';

    let array = JSONArrayList.parseArrayList<TestDDD>(str1);

    array.forEach(item => {
      this.msg += item.labelListJson?.site1?.labelName + " ";
    })

  }

  testJSONArray() {
    // let arr = new JSONArray();
    // arr.push(1);
    // arr.push("cccc");
    // arr.push("123");
    // arr.push("aaaaa\\\"34343434");
    // arr.push("2223\"dasdass");
    // arr.push(new Date());
    // arr.push(true);
    // arr.push(null);
    // arr.push(new User("10010", "实体数据"));
    // let str = arr.toString();

    // let userList = new Array<User>();
    // userList.push(new User('2345', '测试用户1'));
    // userList.push(new User('7844', '测试用户2'));
    // userList.push(new User('1314', '测试用户3'));
    // userList.push(new User('5210', '测试用户4'));

    // let jarr = JSONArray.from(userList);
    // this.msg = jarr.length + "----" + jarr[1]?.toString();

    // let s = JSONArray.toJSONString(userList);

    // let jsArr = JSONArray.parse(s);
    // this.msg = jsArr.length + "----" + jsArr[2]?.toString();
    // this.msg = s;

    // let array = new JSONArray();
    // let o1 = new JSONObject();
    // o1.set('k1', 'value1');
    // let o2 = new JSONObject();
    // o2.set('k2', 'value2');
    // array.push(o1);
    // array.push(o2);
    // array.push('hhh');
    // let a = array.toString();
    // this.msg = a;

    let arr = new Array<Person>();
    arr.push(new Person('csx', 18, true, new Date(), new User('1111', '哈哈哈哈哈')));
    arr.push(new Person('lcp', 19, false, new Date(), new User('2222', '嘻嘻嘻嘻嘻')));
    arr.push(new Person('zzp', 20, true, new Date(), new User('3333', '呜呜呜呜呜')));
    arr.push(new Person('wsp', 21, false, new Date(), new User('4444', '呵呵呵呵呵')));

    let str = JSONArray.toJSONString(arr);

    let list = JSONArray.parseArray<Person>(str);

    let str1 = '[{"threeMonthRate":null,"moduleName":"loan","productName":"网E贷","marketPatter":"随借随还，最高20万，利率低至8折起","labelListJson":{"site1":{"labelType":0,"labelValue":"网E贷","labelName":"产品名称:123","labelLocation":true}}},{"threeMonthRate":null,"moduleName":"loan","productName":"烟草贷","marketPatter":"无需抵押，无需担保，当天放款，随借随还","labelListJson":{"site1":{"labelType":12,"labelValue":"烟草贷","labelName":"产品名称","labelLocation":false}}}]';

    let array = JSONArray.parseArray<TestDDD>(str1);

    array.forEach(item => {
      this.msg += item.labelListJson?.site1?.labelName + " ";
    })

  }

  testJSONObject() {
    // let jsonObj = new JSONObject();
    // jsonObj.set("id", "100010");
    // jsonObj.set("age", 27);
    // jsonObj.set("sex", true);
    // jsonObj.set("birth", new Date());
    // let user = new JSONObject();
    // user.set("uid", "121212");
    // user.set("uName", "测试\\\"套对象");
    // jsonObj.set("user", user);
    // jsonObj.set("test", null);
    // jsonObj.set("person", new User('实体id', '实体name'));
    // jsonObj.set("name", "test字符串");
    // let arr = new JSONArray();
    // arr.push(1234);
    // arr.push(true);
    // arr.push(null);
    // arr.push(new Date());
    // arr.push(user);
    // jsonObj.set("csx", arr);
    // let st = jsonObj.toString();
    // this.msg = st;
    let userList = new Array<User>();
    userList.push(new User('2345', '测试用户1'));
    userList.push(new User('7844', '测试用户2'));
    let person = new Person('测试', 12, true, new Date(), new User("uuid", "打撒吃的是草动次打次"), userList);

    let j = JSONObject.toJSONString(person);

    // let f = JSONObject.parse(j);

    let o = JSONObject.parseObject<Person>(j);


    this.msg = o.birth + "-----" + o.sex + '------' + o.user.name + '======' + o.list?.length;
  }

  @State showDownBtn: Visibility = Visibility.None;
  @State process: number = 0;
  @State btnCtx: string = '';

  async testIdCard() {

    // let hmac2 = await SHA.hmac('这个是SHA的HMAC');
    // this.msg = hmac2.getDataRow();

    let re1 = await PreviewUtil.canPreview('http://124.71.72.144:8801/mbank/dist/121.gif');

    this.msg = re1.getMsg();

    // let isOk = await filePreview.canPreview(this.getUIContext(),'http://124.71.72.144:8801/mbank/dist/121.gif');
    // if (isOk) {
    //   ToastUtil.showToast('可以预览~');
    // }
    let res = IdCardUtil.isValidCard18('12022519540815028x');
    this.msg = res.getMsg();
  }

  async selectAudio() {
    let result = await PickerUtil.selectAudio();
    //判断是否成功
    if (result.getSuccess()) {
      let list = result.getDataTable();
      //获取选中照片uri
      let item = list[0];
      //创建文件信息
      let fileUriObject = new fileUri.FileUri(item);
      //获取文件名
      let name = fileUriObject.name;
      //打开文件
      let file = fs.openSync(item, fs.OpenMode.READ_ONLY);
      //读取文件大小
      let info = fs.statSync(file.fd);
      //缓存照片数据
      let bufferImg: ArrayBuffer = new ArrayBuffer(info.size);
      //写入缓存
      fs.readSync(file.fd, bufferImg);
      //关闭文件流
      fs.closeSync(file);
      //上传选择的的照片
      let upName = await this.testUpload(bufferImg, name);
      //下载
      this.testDownload(upName, name);
    }
  }

  async selectContact() {
    let result = await PickerUtil.selectContact();
    if (result.getSuccess()) {
      let list = result.getDataTable();
      let str = JSONArray.toJSONString(list);
      this.msg = str;
    }
  }

  async selectImage() {
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
      //打开文件
      let file = fs.openSync(item, fs.OpenMode.READ_ONLY);
      //读取文件大小
      let info = fs.statSync(file.fd);
      //缓存照片数据
      let bufferImg: ArrayBuffer = new ArrayBuffer(info.size);
      //写入缓存
      fs.readSync(file.fd, bufferImg);
      //关闭文件流
      fs.closeSync(file);
      //上传选择的的照片
      let upName = await this.testUpload(bufferImg, name);
      //下载
      this.testDownload(upName, name);
    }
  }

  async camera() {
    let res = await CameraUtil.picker();
    if (res.getSuccess()) {
      let str = res.getDataRow().resultUri;
      let fileUriObject = new fileUri.FileUri(str);
      let name = fileUriObject.name;
      let file = fs.openSync(str, fs.OpenMode.READ_ONLY);
      //读取文件大小
      let info = fs.statSync(file.fd);
      //缓存照片数据
      let bufferImg: ArrayBuffer = new ArrayBuffer(info.size);
      fs.closeSync(file);
      //上传
      let upName = await this.testUpload(bufferImg, name);
      //下载
      await this.testDownload(upName, name);
    }
  }

  async testUriUpload() {
    this.showDownBtn = Visibility.Visible;
    efAxiosParams.baseURL = 'http://192.168.0.103:18088';
    let ctx = getContext() as common.UIAbilityContext;
  }

  async commonUpload() {
    let ctx = getContext() as common.UIAbilityContext;
    let imageArray = await ctx.resourceManager.getMediaContent($r('app.media.notice').id);
    let imageResource = imageArray.buffer as ArrayBuffer;
    await this.testUpload(imageResource, 'notice.png');
  }

  async testUpload(data: ArrayBuffer, fileName: string): Promise<string> {
    this.showDownBtn = Visibility.Visible;
    let res = await efClientApi.upload('/api/eftool/upload', false, (progress: number) => {
      if (progress >= 100) {
        this.showDownBtn = Visibility.None;
      }
      this.process = progress;
    }, fileName, data);
    this.msg = res ? res["dataRow"] : '';
    return this.msg;
  }

  async testDownload(upName: string, downName: string) {
    this.showDownBtn = Visibility.Visible;
    let res = await efClientApi.download('/api/eftool/download/' + upName, downName, (progress: number) => {
      if (progress >= 100) {
        this.showDownBtn = Visibility.None;
      }
      this.process = progress;
    });
    ToastUtil.showToast(res ? res["msg"] : '下载文件出错了~');
    let context = getContext(this) as common.UIAbilityContext;
    //获取沙箱文件
    let filesDir = context.filesDir + "/" + downName;
    //转换成uri
    let uri = fileUri.getUriFromPath(filesDir);
    let suffix = uri.substring(uri.lastIndexOf(".") + 1);
    let r = await PreviewUtil.canPreview(uri);
    if (!r.getSuccess()) {
      ToastUtil.showToast(r.getMsg());
    }
    if (suffix === 'txt') {
      await PreviewUtil.previewTxt(uri);
    } else if (['png', 'gif', 'webp', 'bmp'].includes(suffix) || suffix === 'jpg' || suffix === 'jpeg' || suffix === 'svg') {
      await PreviewUtil.previewImage(uri);
    } else if (suffix === 'mp4' || suffix === 'mkv' || suffix === 'ts') {
      await PreviewUtil.previewVideo(uri);
    } else if (['aac', 'ogg'].includes(suffix) || suffix === 'm4a' || suffix === 'mp3' || suffix === 'wav') {
      await PreviewUtil.previewAudio(uri);
    } else if (['html', 'htm'].includes(suffix)) {
      await PreviewUtil.previewHtml(uri);
    } else {
      ToastUtil.showToast('该uri格式暂时无法预览~');
    }
  }

  testArray2Object() {
    let arr = new JSONArray();
    arr.push(new User('10010', '测试用户111'));
    arr.push(new User('10011', '测试用户222'));
    arr.push(new User('10012', '测试用户333'));
    arr.push(new User('10013', '测试用户444'));

    let obj = JSONObject.toJSONString(arr);

    this.msg = obj;

  }

  async selectFile() {
    //拉起选择文件
    let result = await PickerUtil.selectFile();
    let name: string = '';
    //判断是否成功
    if (result.getSuccess()) {
      let list = result.getDataTable();
      //获取选中照片uri
      let item = list[0];
      //创建文件信息
      let fileUriObject = new fileUri.FileUri(item);
      //获取文件名
      let name = fileUriObject.name;
      //打开文件
      let file = fs.openSync(item, fs.OpenMode.READ_ONLY);
      //读取文件大小
      let info = fs.statSync(file.fd);
      //缓存照片数据
      let bufferImg: ArrayBuffer = new ArrayBuffer(info.size);
      //写入缓存
      fs.readSync(file.fd, bufferImg);
      //关闭文件流
      fs.closeSync(file);
      //上传选择的的照片
      let upName = await this.testUpload(bufferImg, name);
      //下载
      await this.testDownload(upName, name);
    }
  }

  async SM2d2i() {
    let result = await SM2.generateSM2Key();
    let pubKey = result.getDataRow().publicKey;

    let ecc = cryptoFramework.ECCKeyUtil.genECCCommonParamsSpec('NID_sm2');


    let srr = buffer.from(pubKey, 'hex');


    let convert = new SM2Convert();
    let sm2PubKey = convert.d2i(pubKey);
    this.msg = sm2PubKey;
  }

  async previewDocument() {
    //拉起选择文件
    let result = await PickerUtil.selectFile();
    //判断是否成功
    if (result.getSuccess()) {
      let list = result.getDataTable();
      let item = list[0];
      await PreviewUtil.previewTxt(item);
    }
  }

  async previewImage() {
    //拉起选择文件
    let result = await PickerUtil.selectPhotoVideo();
    //判断是否成功
    if (result.getSuccess()) {
      let list = result.getDataTable();
      let item = list[0];
      let res = await PreviewUtil.canPreview(item);
      if (res.getSuccess()) {
        await PreviewUtil.previewImage(item);
      } else {
        ToastUtil.showToast(res.getMsg());
      }

    }
  }

  async previewVideo() {
    //拉起选择文件
    let result = await PickerUtil.selectPhotoVideo();
    //判断是否成功
    if (result.getSuccess()) {
      let list = result.getDataTable();
      let item = list[0];
      await PreviewUtil.previewVideo(item);
    }
  }

  async previewAudio() {
    //拉起选择文件
    let result = await PickerUtil.selectAudio();
    //判断是否成功
    if (result.getSuccess()) {
      let list = result.getDataTable();
      let item = list[0];
      await PreviewUtil.previewAudio(item);
    }
  }

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

  async openAlert() {
    let _that = this;
    await WinDialogUtil.showAlert({
      title: 'ef温馨提示',
      content: '只设置了内容，其他都默认~~~~~',
      isAutoClose: false,
      okCallBack: (winName?: string) => {
        _that.openAlertTwo(winName)
      },
      cancelCallBack: (winName?: string) => {
        _that.testJSONObject();
        if (winName) {
          WinDialogUtil.closeAlert(winName);
        }
      }
    });
  }

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

  async stopRecording() {
    let res = await AudioCapturerUtil.stopRecording();
    if (res.getSuccess()) {
      this.msg = res.getMsg();
    }
  }

  async recording() {
    let path = getContext().cacheDir;
    let filePath = path + '/csx.wav';
    let file: fs.File = fs.openSync(filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
    let bufferSize: number = 0;
    let initResult = await AudioCapturerUtil.init((buffer: ArrayBuffer) => {
      fs.writeSync(file.fd, buffer, {
        offset: bufferSize,
        length: buffer.byteLength
      });
      bufferSize += buffer.byteLength;
    });
    if (!initResult.getSuccess()) {
      ToastUtil.showToast(initResult.getMsg());
      return;
    }
    let record = await AudioCapturerUtil.startRecording();
    if (record.getSuccess()) {
      this.msg = record.getMsg();
    }
  }

  build() {
    Scroll() {
      Column() {
        Text(this.msg).fontColor('#ff4400')
        Button('录音').margin({ top: 20 }).onClick(() => {
          this.recording();
        })
        Button('停止录音').margin({ top: 20 }).onClick(() => {
          this.stopRecording();
        })
        Button('SM2d2i').margin({ top: 20 }).onClick(() => {
          this.SM2d2i();
        })
        Button('预览文档').margin({ top: 20 }).onClick(() => {
          this.previewDocument();
        })
        Button('预览图片').margin({ top: 20 }).onClick(() => {
          this.previewImage();
        })
        Button('预览视频').margin({ top: 20 }).onClick(() => {
          this.previewVideo();
        })
        Button('预览音频').margin({ top: 20 }).onClick(() => {
          this.previewAudio();
        })
        Button('打开弹窗').margin({ top: 20 }).onClick(() => {
          this.openAlert();
        })
        Button('AES-ECB-16key').margin({ top: 20 }).onClick(() => {
          this.aes();
        })
        Button('相机拍照').margin({ top: 20 }).onClick(() => {
          this.camera();
        })
        Button('选择文件').margin({ top: 20 }).onClick(() => {
          this.selectFile();
        })
        Button('选择图片').margin({ top: 20 }).onClick(() => {
          this.selectImage();
        })
        Button('选择音频').margin({ top: 20 }).onClick(() => {
          this.selectAudio();
        })
        Button('选择联系人').margin({ top: 20 }).onClick(() => {
          this.selectContact();
        })
        Button('uri上传文件').margin({ top: 20 }).onClick(() => {
          this.btnCtx = '上传URI文件中...';
          this.testUriUpload();
        })
        Button('上传文件').margin({ top: 20 }).onClick(() => {
          this.btnCtx = '上传文件中...';
          this.commonUpload();
        })
        Button('下载文件').margin({ top: 20 }).onClick(() => {
          this.btnCtx = '下载文件中...';
          this.testDownload('1abf78c7-7c6c-490d-bd36-88b5063daab1-default1715851330681', 'girl.jpg');
        })
        DownloadUtil({
          progressState: this.showDownBtn,
          halfProgress: this.process,
          ctx: this.btnCtx
        })
        Button('Array转Object').margin({ top: 20 }).onClick(() => {
          this.testArray2Object();
        })
        Button('验证身份证号').margin({ top: 20 }).onClick(() => {
          this.testIdCard();
        })
        Button('测试JSONArray').margin({ top: 20 }).onClick(() => {
          this.testJSONArray();
        })
        Button('测试JSONArrayList').margin({ top: 20 }).onClick(() => {
          this.testJSONArrayList();
        })
        Button('测试JSONObject').margin({ top: 20 }).onClick(() => {
          this.testJSONObject();
        })
      }
      .backgroundColor("#fff")
      .align(Alignment.Center)
      .width('100%')
      .borderRadius(10)
      .padding({ top: 50, bottom: 40 })
    }.scrollable(ScrollDirection.Vertical)

  }
}