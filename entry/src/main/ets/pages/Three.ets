/**
 * @Author csx
 * @DateTime 2024/7/16 17:20:07
 * @TODO Three
 */
import { WinDialogUtil } from '@yunkss/eftool';
import { promptAction, router } from '@kit.ArkUI';

@Entry
@Component
export struct Three {
  @State draw: DrawModifier = new DrawModifier();

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
      bottom:-100
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
          Text('22222222222222222222222222222222222222')
            .maxLines(1)
            .textOverflow({
              overflow:TextOverflow.Ellipsis
            })
            .width('30%')
        }.tabBar('你的')

        TabContent() {
          Text('33333333333333')
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