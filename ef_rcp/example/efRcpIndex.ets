import { Logger, OutDTO } from '@yunkss/ef_core';
import { efRcpClientApi, efRcp, efRcpConfig, EfRcpError } from '@yunkss/ef_rcp';
import { buffer, JSON, util } from '@kit.ArkTS';
import { rcp } from '@kit.RemoteCommunicationKit';
import lottie from '@ohos/lottie'
import { common } from '@kit.AbilityKit';


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

  constructor(id: string, name: string) {
    super(id, name);
  }
}


@Builder
function loadingImg() {
  Image($r("app.media.tLoading")).width(40)
}

@Entry
@Component
struct EfRcpIndex {
  @State message: string = 'Hello World';
  @State lottieStr: string = '';

  aboutToAppear(): void {

    let resStr = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    this.lottieStr =
      resStr.decodeWithStream(new Uint8Array(getContext(this)
        .resourceManager
        .getRawFileContentSync('csx.json')
        .buffer));

    efRcp
      .enableLogInterceptor()
      .setLoadingContent('充值有大礼包...')
      .addCommonHeaders({
        "platform": "HarmonyOS",
        "version": "V1.0.0"
      })// .setLoadingImg(wrapBuilder(loadingImg))
      .enableLottie()
      .addCodeEvent({
        listener: (code: number) => {
          Logger.debug("----code监听事件-----", code + "")
        }
      })
      .addCryptoEvent({
        requestEncoder: (request: rcp.RequestContext): rcp.RequestContext => {
          if (request.request.content) {
            Logger.debug('-----------------加密操作--------------', request.request.content as string)
          }
          return request;
        },
        responseDecoder: (response: rcp.Response): rcp.Response => {
          if (response) {
            Logger.debug('-----------------解密操作--------------', JSON.stringify(response.toJSON()))
          }
          return response;
        }
      })
      .setUploadEvent({
        onUploadProgress: (progress) => {
          Logger.debug("---------测试上传进度----------", progress + "%")
        }
      })
      .create()
      .builder();
  }

  async login() {
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
            animationData: JSON.parse(this.lottieStr)
            // imagePath: '', // 加载读取指定路径下的图片资源
            // path: 'pages/csx.json', // json路径
            // initialSegment: [10, 50]                      // 播放的动画片段
          })
        });
      // lottie.play();
    }, 100)
    //登录
    let dto = await efRcpClientApi.post<OutDTO<UserDTO>>({
      url: '/api/eftool/login',
      query: {
        'account': 'efadmin',
        'pwd': '123456'
      },
      loadingTxt: '正在登录中...'
    });
    if (!(dto instanceof EfRcpError) && dto["success"]) {
      // ToastUtil.showToast('登录成功~');
      //请求成功后将token存储在efRcpParams.tokenValue
      efRcpConfig.token.tokenValue = dto["dataRow"].token;
      efRcpConfig.token.tokenName = "Authorization";
      this.message = JSON.stringify(dto);
    } else {
      this.message = (dto as EfRcpError).toString();
    }
  }

  async postForm() {
    //登录
    let dto = await efRcpClientApi.postForm <OutDTO<UserDTO>>({
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
        url: '/api/eftool/download/e6644147-12a6-4629-9532-94eeb6c8059a-screenshot_20240630_084617.jpg',
        fileName: 'csx1.jpg'
      })
    this.message = JSON.stringify(dto);
  }

  async testUploadFile() {
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
  }

  build() {
    Column() {
      Text(this.message)
        .fontColor("#ff4400")
        .margin({
          bottom: 20
        })
      Row() {
        Button('登录', {
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
            await this.login();
          })
      }
      .width('100%')

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
}