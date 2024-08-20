/**
 * @Author csx
 * @DateTime 2024/8/7 16:24:19
 * @TODO Login 登录页面
 */
import {
  efRcp,
  efRcpClientApi,
  efRcpConfig,
  EfRcpError,
  GlobalContext,
  JSONObject,
  KvUtil,
  Logger,
  OutDTO,
  ToastUtil
} from '@yunkss/eftool'
import { router } from '@kit.ArkUI';
import { JSON, util } from '@kit.ArkTS';
import lottie from '@ohos/lottie';
import { rcp } from '@kit.RemoteCommunicationKit';


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

@Extend(TextInput)
function iptStyle() {
  .height(50)
  .fontSize(20)
  .margin({
    bottom: 40
  })
  .backgroundColor("#00000000")
  .border({
    width: 1,
    color: "#979BB5"
  })
  .borderRadius(15)
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
  @State lottieStr: string = '';

  buildRcpCfg() {
    let resStr = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    this.lottieStr = resStr.decodeWithStream(new Uint8Array(getContext(this)
      .resourceManager
      .getRawFileContentSync('csx.json')
      .buffer));

    efRcp
      .setBaseURL("http://aliyunmr.com:18088")
      .enableLogInterceptor()
      .setLoadingContent('充值有大礼包...')
      .setTimeOut({
        transferMs: 200000
      })
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
      .setDownLoadEvent({
        onDownloadProgress: (progress) => {
          Logger.debug("---------测试下载进度----------", progress + "%")
        }
      })
      .create()
      .builder();
  }

  aboutToAppear(): void {

    this.buildRcpCfg();

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
        text: $$this.account,
        placeholder: '请输入账号'
      })
        .iptStyle()
      // .onChange((value: string) => {
      //   this.account = value;
      // })
      TextInput({
        text: $$this.pwd,
        placeholder: '请输入密码'
      })
        .iptStyle()
        .type(InputType.Password)
      // .onChange((value: string) => {
      //   this.pwd = value;
      // })
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
                  })
                });
            }, 100)
            //登录
            let dto = await efRcpClientApi.post<string>({
              url: '/api/eftool/login',
              query: {
                'account': this.account,
                'pwd': this.pwd
              },
              loadingTxt: '正在登录中,稍等...'
            });
            if (!(dto instanceof EfRcpError) && dto) {
              // ToastUtil.showToast('登录成功~');
              //请求成功后将token存储在efRcpParams.tokenValue
              let map = JSONObject.parse(JSON.stringify(dto));
              if (map.hasKey('dataRow')) {
                let dataRow = map.get("dataRow");
                if (dataRow) {
                }
              }
              efRcpConfig.token.tokenValue = map.hasKey('dataRow')?map.get("dataRow") as string:'';
              efRcpConfig.token.tokenName = "Authorization";
              //存入数据库
              let kvUtil = GlobalContext.getContext().getT<KvUtil>("kvUtil");
              await kvUtil.put(efRcpConfig.token.tokenName, efRcpConfig.token.tokenValue);
              //跳转
              router.pushUrl({
                url: 'pages/Home'
              })
            } else {
              ToastUtil.showToast(dto.toString(), {
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