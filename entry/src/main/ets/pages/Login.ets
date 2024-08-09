/**
 * @Author csx
 * @DateTime 2024/8/7 16:24:19
 * @TODO Login 登录页面
 */
import { efRcpClientApi, efRcpParams, GlobalContext, KvUtil, OutDTO, ToastUtil } from '@yunkss/eftool'
import { router } from '@kit.ArkUI';


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

@Extend(TextInput)
function iptStyle() {
  .height(50)
  .fontSize(20)
  .margin({
    bottom: 40
  })
  .backgroundColor("#00000000")
  .border({
    width: {
      top:0,
      left:0,
      right:0,
      bottom:1
    },
    color: "#979BB5",
  })
  .borderRadius(0)
}

@Component
@Entry
export struct Login {
  /**
   * 账号
   */
  @State account: string = "efadmin";
  /**
   * 密码
   */
  @State pwd: string = "123456";

  aboutToAppear(): void {
    //获取token值如果取到了说明登录过直接跳转
    let kvUtil = GlobalContext.getContext().getT<KvUtil>("kvUtil");
    kvUtil.get("Authorization", '').then(token => {
      if (token) {
        //跳转
        router.pushUrl({
          url: 'pages/Home'
        })
      }
    })

  }

  build() {
    Column() {
      Row() {
        Image($r("app.media.icon"))
          .width(40)
          .borderRadius(8)
          .margin({ right: 20 })
        Image($r("app.media.login"))
          .width(80)
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .margin({
        bottom: 60
      })

      Text("鸿蒙开发宝典")
        .fontSize(32)
        .fontColor("#108ee9")
        .margin({
          bottom: 120
        })

      TextInput({
        text: this.account,
        placeholder: '请输入账号'
      })
        .iptStyle()
        .onChange((value: string) => {
          this.account = value;
        })
      TextInput({
        text: this.pwd,
        placeholder: '请输入密码'
      })
        .iptStyle()
        .type(InputType.Password)
        .onChange((value: string) => {
          this.pwd = value;
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
            top: 40
          })
          .onClick(async () => {
            if (this.account == '' || this.pwd == '') {
              ToastUtil.showToast('账号密码不能为空~', {
                alignment: Alignment.Top
              });
            }
            //登录
            let dto = await efRcpClientApi.post <OutDTO<UserDTO>>('/api/eftool/login', {
              'account': this.account,
              'pwd': this.pwd
            }, {}, {}, '正在登录中,稍等...');
            if (!(dto instanceof Error) && dto.getSuccess()) {
              // ToastUtil.showToast('登录成功~');
              //请求成功后将token存储在efRcpParams.tokenValue
              efRcpParams.tokenValue = dto.getDataRow().token;
              efRcpParams.tokenName = "Authorization";
              //存入数据库
              let kvUtil = GlobalContext.getContext().getT<KvUtil>("kvUtil");
              await kvUtil.put("Authorization", efRcpParams.tokenValue);
              //跳转
              router.pushUrl({
                url: 'pages/Home'
              })
            } else {
              ToastUtil.showToast(dto.getMsg(), {
                alignment: Alignment.Center
              });
            }
          })
      }
      .width('100%')
    }
    .margin({
      top: 180
    })
    .padding({
      left: 20,
      right: 20
    })
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .height('100%')
  }
}