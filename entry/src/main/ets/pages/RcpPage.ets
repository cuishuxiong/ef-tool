import { efRcp, efRcpClientApi, Logger, OutDTO, PickerUtil } from '@yunkss/eftool';
import { buffer, JSON, util } from '@kit.ArkTS';
import { rcp } from '@kit.RemoteCommunicationKit';
import lottie from '@ohos/lottie'
import { fileUri } from '@kit.CoreFileKit';
import fs from '@ohos.file.fs'

class User {
  account?: string;
  pwd?: string;

  constructor(account: string, pwd: string) {
    this.account = account;
    this.pwd = pwd;
  }
}


class UserDTO extends User {
  token: string = '';
  birth: string = '';

  constructor(id: string, name: string) {
    super(id, name);
  }
}

@Component
struct RcpPage {
  @Consume('NavPathStack') pageStack: NavPathStack;
  @State message: string = 'Hello World';
  @State lottieStr: string = '';

  aboutToAppear(): void {

  }

  async postForm() {
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

  async postJSON() {
    let dto = await efRcpClientApi.post<OutDTO<UserDTO>>({
      url: '/api/eftool/post',
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

  async testCancel() {
    let dto = await efRcpClientApi.post<OutDTO<UserDTO>>({
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

  async testDelete() {
    let dto = await efRcpClientApi.delete<OutDTO<string>>({
      url: '/api/eftool/delete/5345345'
    });
    this.message = JSON.stringify(dto);
  }

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

  async testDownloadStream() {
    let dto =
      await efRcpClientApi.downloadStream<OutDTO<string>>({
        url: '/api/eftool/download/13c79c32-c291-429b-a1a9-e6ae2cb0b635-IMG_010.png',
        fileName: 'abc.jpg'
      });
    this.message = JSON.stringify(dto);
  }

  async testDownloadFile() {
    let dto =
      await efRcpClientApi.downloadFile<OutDTO<string>>({
        url: '/api/eftool/download/ddbab76c-6d73-4ba8-8efc-9e5264ade01a-newRcp.png',
        fileName: 'csx1.png'
      })
    this.message = JSON.stringify(dto);
  }

  async selectImage(): Promise<ArrayBuffer> {
    //拉起选中照片
    let result = await PickerUtil.selectPhotoVideo();
    //判断是否成功
    if (result && result.length > 0) {
      //获取选中照片uri
      let item = result[0];
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
      return bufferImg;
    }
    return new ArrayBuffer(12);
  }

  async testUploadFile() {
    let arr = await this.selectImage();
    //上传
    let dto =
      await efRcpClientApi.uploadFile<OutDTO<string>>({
        url: '/api/eftool/upload',
        fileInfo: {
          "file": {
            contentType: 'multipart/form-data',
            remoteFileName: 'newRcp0819.png',
            contentOrPath: {
              content: arr
            }
          }
        }
      });
    this.message = JSON.stringify(dto);
  }

  build() {

    NavDestination() {
      Column() {
        Text(this.message)
          .fontColor("#ff4400")
          .margin({
            bottom: 20
          })

        Row() {
          Button('postJSON', {
            type: ButtonType.Normal
          })
            .borderRadius(15)
            .backgroundColor('#108ee9')
            .width('100%')
            .height(50)
            .fontSize(22)
            .margin({
              bottom: 20
            })
            .onClick(async () => {
              await this.postJSON();
            })
        }
        .width('100%')

        Row() {
          Button('postForm', {
            type: ButtonType.Normal
          })
            .borderRadius(15)
            .backgroundColor('#108ee9')
            .width('100%')
            .height(50)
            .fontSize(22)
            .margin({
              bottom: 20
            })
            .onClick(async () => {
              await this.postForm();
            })
        }
        .width('100%')

        Row() {
          Button('get', {
            type: ButtonType.Normal
          })
            .borderRadius(15)
            .backgroundColor('#105e21')
            .width('100%')
            .height(50)
            .fontSize(22)
            .margin({
              bottom: 20
            })
            .onClick(async () => {
              await this.testGet();
            })
        }
        .width('100%')

        Row() {
          Button('delete', {
            type: ButtonType.Normal
          })
            .borderRadius(15)
            .backgroundColor('#1B1839')
            .width('100%')
            .height(50)
            .fontSize(22)
            .margin({
              bottom: 20
            })
            .onClick(async () => {
              await this.testDelete();
            })
        }
        .width('100%')

        Row() {
          Button('put', {
            type: ButtonType.Normal
          })
            .borderRadius(15)
            .backgroundColor('#1B1839')
            .width('100%')
            .height(50)
            .fontSize(22)
            .margin({
              bottom: 20
            })
            .onClick(async () => {
              await this.testPUT();
            })
        }
        .width('100%')

        Row() {
          Button('patch', {
            type: ButtonType.Normal
          })
            .borderRadius(15)
            .backgroundColor('#1Bee39')
            .width('100%')
            .height(50)
            .fontSize(22)
            .margin({
              bottom: 20
            })
            .onClick(async () => {
              await this.testPATCH();
            })
        }
        .width('100%')


        Row() {
          Button('upload', {
            type: ButtonType.Normal
          })
            .borderRadius(15)
            .backgroundColor('#1B1839')
            .width('100%')
            .height(50)
            .fontSize(22)
            .margin({
              bottom: 20
            })
            .onClick(async () => {
              await this.testUploadFile();
            })
        }
        .width('100%')

        Row() {
          Button('downFile', {
            type: ButtonType.Normal
          })
            .borderRadius(15)
            .backgroundColor('#ff4488')
            .width('100%')
            .height(50)
            .fontSize(22)
            .margin({
              bottom: 20
            })
            .onClick(async () => {
              await this.testDownloadFile();
            })
        }
        .width('100%')

        Row() {
          Button('downloadStream', {
            type: ButtonType.Normal
          })
            .borderRadius(15)
            .backgroundColor('#ff8811')
            .width('100%')
            .height(50)
            .fontSize(22)
            .margin({
              bottom: 20
            })
            .onClick(async () => {
              await this.testDownloadStream();
            })
        }
        .width('100%')
      }
      .padding({
        top: 40,
        left: 20,
        right: 20
      })
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
    }
    .title('RcpPage')
    .hideTitleBar(true)


  }
}

export { RcpPage };
