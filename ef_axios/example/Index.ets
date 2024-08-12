import { efAxiosParams, efClientApi, EfAxiosError, efAxios } from '@yunkss/ef_axios';
import { OutDTO } from '@yunkss/ef_core';
import { AxiosResponse, FormData } from '@ohos/axios';
import { buffer, JSON } from '@kit.ArkTS';

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


@Entry
@Component
struct Index {
  /**
   * 账号
   */
  @State account: string = "efadmin";
  /**
   * 密码
   */
  @State pwd: string = "123456";
  @State message: string = '显示请求信息';

  aboutToAppear(): void {
    efAxiosParams.baseURL = "http://aliyunmr.com:18088";
  }

  async login() {
    //登录
    let dto = await efClientApi.post<User, OutDTO<UserDTO>>({
      url: '/api/eftool/login',
      query: new User(this.account, this.pwd),
      headers: {
        "efAxiosHeader": '旺旺崔冰冰'
      },
      loadingTxt: 'eftool登录中...'
    })
    //此处如果异常报错则类型为EfAxiosError
    if (!(dto instanceof EfAxiosError) && dto) {
      //请求成功后将token存储在efRcpParams.tokenValue
      efAxiosParams.tokenValue = dto["dataRow"].token;
      efAxiosParams.tokenName = "Authorization";
    }
    this.message = JSON.stringify(dto);
  }

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
      loadingTxt: '模拟form请求...'
    });
    this.message = JSON.stringify(dto);
  }

  async get() {
    //模拟测试get请求
    const dto = await efClientApi.get<OutDTO<Record<string, Object>>>({
      url: '/api/eftool/get/11111111'
    });
    this.message = JSON.stringify(dto);
  }

  async getParams() {
    //模拟测试get请求
    let dto = await efClientApi.getByParams<OutDTO<Record<string, Object>>>({
      url: '/api/eftool/getNew',
      params: {
        "key_csx": '测试get',
        "key_cc": '第二个参数'
      }
    })
    this.message = JSON.stringify(dto);
  }

  async delete() {
    //模拟测试delete请求
    const dto = await efClientApi.delete<OutDTO<Record<string, Object>>>({
      url: '/api/eftool/delete/1212133'
    });
    this.message = JSON.stringify(dto);
  }

  async put() {
    //模拟put
    let dto = await efClientApi.put<User, OutDTO<UserDTO>>({
      url: '/api/eftool/put',
      query: new User('put请求', 'xxxxxxxxx'),
      headers: {
        "efAxiosHeader": '旺旺崔冰冰'
      }
    })
    this.message = JSON.stringify(dto);
  }

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

  async upload() {

    let imgArr = getContext().resourceManager.getMediaContentSync($r("app.media.startIcon").id);

    let buf = buffer.from(imgArr).buffer;

    let res = await efClientApi.upload({
      url: '/api/eftool/upload',
      isUri: false,
      data: buf
    }, (progress: number) => {
      this.message = "上传进度:" + progress;
    });

    this.message = JSON.stringify(res)

  }

  async download() {
    //133cbf14-af0b-4764-8201-24b4b53f7e10-IMG_003.jpg

    //登录
    let res = await efClientApi.download({
      url: '/api/eftool/download/133cbf14-af0b-4764-8201-24b4b53f7e10-IMG_003.jpg',
      filePath: 'csx.jpg',
      headers: {
        "efAxiosHeader": '旺旺崔冰冰'
      }
    }, (progress: number) => {
      this.message = "下载进度:" + progress;
    });
    this.message = JSON.stringify(res);
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
            await this.get();
          })
      }
      .width('100%')

      Row() {
        Button('getParams', {
          type: ButtonType.Normal
        })
          .borderRadius(15)
          .backgroundColor('#104ae1')
          .width('100%')
          .height(50)
          .fontSize(22)
          .margin({
            bottom: 20
          })
          .onClick(async () => {
            await this.getParams();
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
            await this.delete();
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
            await this.put();
          })
      }
      .width('100%')

      Row() {
        Button('all', {
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
            await this.all();
          })
      }
      .width('100%')

      Row() {
        Button('upload', {
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
            await this.upload();
          })
      }
      .width('100%')

      Row() {
        Button('download', {
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
            await this.download();
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