import {
  efRcpClientApi,
  JSONObject,
  ToastUtil,
  efRcpParams,
  OutDTO,
  PickerUtil,
  RandomUtil,
  FileUtil,
  DownloadUtil,
  PreviewUtil,
  ImageUtil
} from '@yunkss/eftool';
import { fileUri } from '@kit.CoreFileKit';
import image from '@ohos.multimedia.image';
import { buffer } from '@kit.ArkTS';


class User {
  id?: string;
  name?: string;

  constructor(id: string, name: string) {
    this.name = name;
    this.id = id;
  }
}


class UserDTO extends User {
  token: string = '';

  constructor(id: string, name: string) {
    super(id, name);
  }
}


@Entry
@Component
export struct RcpPage {
  @State message: string = 'Hello World';
  @State showDownBtn: Visibility = Visibility.None;
  @State process: number = 0;
  @State btnCtx: string = '';
  @State pixImg: image.PixelMap | null = null;

  async testLogin() {
    let dto = await efRcpClientApi.post <OutDTO<UserDTO>>('/api/eftool/login', {
      'account': 'efadmin',
      'pwd': '123456'
    });
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

  async testDownloadStream() {
    this.btnCtx = "正在下载中...";
    this.showDownBtn = Visibility.Visible;
    let dto =
      await efRcpClientApi.downloadStream<OutDTO<string>>('/api/eftool/download/d72c8836-8fd5-4720-b975-f5e64a2f0c75-IMG_20240214_212933.jpg',
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

  async testDownloadFile() {
    this.btnCtx = "正在下载中...";
    this.showDownBtn = Visibility.Visible;
    let dto =
      await efRcpClientApi.downloadFile<OutDTO<string>>('/api/eftool/download/d72c8836-8fd5-4720-b975-f5e64a2f0c75-IMG_20240214_212933.jpg',
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

  build() {
    Column() {
      Image(this.pixImg)
        .width(200)
        .objectFit(ImageFit.Contain)
      Text(this.message)
        .id('RcpPageHelloWorld')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
      Button('发送Rcp的login请求').margin({
        top: 40
      })
        .margin({
          top: '20'
        })
        .onClick(async () => {
          await this.testLogin();
        })
      Button('发送Rcp的post请求json').margin({
        top: 40
      })
        .margin({
          top: '20'
        })
        .onClick(async () => {
          await this.testPostJSON();
        })
      Button('发送Rcp的post请求from').margin({
        top: 40
      })
        .margin({
          top: '20'
        })
        .onClick(async () => {
          await this.testPostForm();
        })
      Button('发送Rcp的get请求').margin({
        top: 40
      })
        .margin({
          top: '20'
        })
        .onClick(async () => {
          await this.testGet();
        })
      Button('发送Rcp的put请求').margin({
        top: 40
      })
        .margin({
          top: '20'
        })
        .onClick(async () => {
          await this.testPUT();
        })
      Button('发送Rcp的delete').margin({
        top: 40
      })
        .margin({
          top: '20'
        })
        .onClick(async () => {
          await this.testDelete();
        })
      Button('取消请求').margin({
        top: 40
      })
        .margin({
          top: '20'
        })
        .onClick(async () => {
          await this.testCancel();
        })
      Button('发送Rcp的upload').margin({
        top: 40
      })
        .margin({
          top: '20'
        })
        .onClick(async () => {
          await this.testUploadFile();
        })
      Button('发送Rcp的downloadFile').margin({
        top: 40
      })
        .margin({
          top: '20'
        })
        .onClick(async () => {
          await this.testDownloadFile();
        })
      Button('发送Rcp的downloadStream').margin({
        top: 40
      })
        .margin({
          top: '20'
        })
        .onClick(async () => {
          await this.testDownloadStream();
        })
      DownloadUtil({
        progressState: this.showDownBtn,
        halfProgress: this.process,
        ctx: this.btnCtx
      })
    }
    .margin({
      top: 60
    })
    .height('100%')
    .width('100%')
  }
}