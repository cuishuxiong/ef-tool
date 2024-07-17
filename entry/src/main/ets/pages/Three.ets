/**
 * @Author csx
 * @DateTime 2024/7/16 17:20:07
 * @TODO Three
 */
import { WinDialogUtil } from '@yunkss/eftool';
import { router } from '@kit.ArkUI';

@Entry
@Component
export struct Three {

  @State draw:DrawModifier = new DrawModifier();

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

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Start }) {
        TabContent() {
          Button('打开弹窗').margin({ top: 20 }).onClick(() => {
            this.openAlert();
          })
        }.tabBar('我的')

        TabContent() {
          Text('222222222222222')
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
    .padding({ top: 60 })
    .backgroundColor('#ffffff')
  }
}