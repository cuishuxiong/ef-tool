/**
 * @Author csx
 * @DateTime 2024/7/16 17:20:07
 * @TODO Three
 */
import { PhoneUtil, WinDialogUtil, ImageUtil } from '@yunkss/eftool';
import { promptAction, router } from '@kit.ArkUI';
import { image } from '@kit.ImageKit';

@Entry
@Component
export struct Three {
  @State msg: string = "1111";
  @State draw: DrawModifier = new DrawModifier();
  @State pxImg: image.PixelMap | null = null;

  async openAlert() {
    await WinDialogUtil.showAlert({
      title: 'ef温馨提示',
      content: '只设置了内容，其他都默认~~~~~',
      isAutoClose: true,
      okCallBack: (winName?: string) => {
        this.getUIContext().getRouter().back({ url: 'pages/Welcome' })
      }
    });
  }

  @Builder
  dialog() {
    Row() {
      Text('xxxxxxxxxxxxxxxx')
    }
    .height('100%')
    .width('100%')
    .margin({
      bottom: -100
    })
    .padding({
      bottom: -100
    })
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Start }) {
        TabContent() {
          Column() {
            Button('打开弹窗').margin({ top: 20 }).onClick(() => {
              this.openAlert();
            })
            Button('打开自定义弹框').margin({ top: 20 }).onClick(() => {
              promptAction.openCustomDialog({
                builder: () => {
                  this.dialog()
                },
                maskRect: {
                  x: 0,
                  y: 0,
                  width: '100%',
                  height: '100%'
                },
                isModal: true,
                width: '100%',
                height: '100%',
                offset: { dx: 0, dy: -50 }
              })
            })
          }
        }.tabBar('我的')

        TabContent() {
          Column() {
            Image(this.pxImg).width(200)
            Text('22222222222222222222222222222222222222')
              .maxLines(1)
              .textOverflow({
                overflow: TextOverflow.Ellipsis
              })
              .width('30%')
              .onClick(async () => {
                let r = await ImageUtil.base64ToPixelMap('data:image/png;base64,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');
                this.pxImg = r.getDataRow();
              })
          }
        }.tabBar('你的')

        TabContent() {
          Text(this.msg)
            .onClick(() => {
              this.msg = PhoneUtil.isMobile('19876543210').getMsg()
            })
        }.tabBar('他的')
      }
      .width('100%')
      .scrollable(true)
      .barMode(BarMode.Scrollable, {
        nonScrollableLayoutStyle: LayoutStyle.SPACE_BETWEEN_OR_CENTER
      })
      .barWidth('100%')
      .layoutWeight(1)
      .barOverlap(true)
      .fadingEdge(true)
      .drawModifier(this.draw)
    }
    .width('100%')
    .padding({ top: 40 })
    .backgroundColor('#ffffff')
  }
}