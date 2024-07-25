import { efRcpClientApi, JSONObject, ToastUtil, efRcpParams, OutDTO, PickerUtil } from '@yunkss/eftool';


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

  async testUploadFile() {
    //拉起选中照片
    let result = await PickerUtil.selectPhotoVideo();
    //判断是否成功
    if (result.getSuccess()) {
      let list = result.getDataTable();
      //获取选中照片uri
      let item = list[0];
      //上传
      let dto =
        await efRcpClientApi.uploadFile<OutDTO<string>>('/api/eftool/upload', { fileOrPath: item }, (process) => {
          ToastUtil.showToast("当前上传进度为:" + process)
        });
      if (dto.getSuccess()) {
        let res = JSONObject.toJSONString(dto);
        ToastUtil.showToast(res);
        this.message = res;
      } else {
        ToastUtil.showToast(JSONObject.toJSONString(dto));
      }
    }
  }

  build() {
    Column() {
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
      Button('发送Rcp的upload(暂时有bug)').margin({
        top: 40
      })
        .margin({
          top: '20'
        })
        .onClick(async () => {
          await this.testUploadFile();
        })

    }
    .margin({
      top: 60
    })
    .height('100%')
    .width('100%')
  }
}