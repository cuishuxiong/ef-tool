import { efRcpClientApi, efRcpInstance, JSONObject, ToastUtil, efRcpParams, OutDTO } from '@yunkss/eftool';


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

  async testRcp() {
    let dto = await efRcpClientApi.post <OutDTO<UserDTO>>('/api/eftool/login', {
      'account': 'efadmin',
      'pwd': '123456'
    });
    if (dto.getSuccess()) {
      ToastUtil.showToast(JSONObject.toJSONString(dto));
    }

  }

  build() {
    Column() {
      Text(this.message)
        .id('RcpPageHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
      Button('发送Rcp的post请求').margin({
        top: 40
      })
        .onClick(async () => {
          await this.testRcp();
        })
        .margin({
          top: '20'
        })
    }
    .margin({
      top: 40
    })
    .height('100%')
    .width('100%')
  }
}