/**
 * @Author csx
 * @DateTime 2024/8/7 16:24:19
 * @TODO Login
 */
import { ToastUtil } from '@yunkss/eftool'

@Component
@Entry
export struct Login {
  /**
   * 账号
   */
  @State account: string = "admin";
  /**
   * 密码
   */
  @State pwd: string = "1233456";

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
        .fontSize(20)
        .margin({
          bottom: 40
        })
        .onChange((value: string) => {
          this.account = value;
        })
      TextInput({
        text: this.pwd,
        placeholder: '请输入密码'
      })
        .type(InputType.Password)
        .fontSize(20)
        .onChange((value: string) => {
          this.pwd = value;
        })
      Button('登录', {
        type: ButtonType.Capsule,
        stateEffect: true
      })
        .backgroundColor(0x317aff)
        .width(200)
        .height(50)
        .fontSize(22)
        .margin({
          top: 80
        })
        .onClick(async () => {
          if (this.account == '' || this.pwd == '') {
            ToastUtil.showToast('账号密码不能为空~');
          }
        })
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