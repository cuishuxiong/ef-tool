/**
 * @Author csx
 * @DateTime 2024/3/25 15:54:03
 * @TODO LoadingUtil 全局加载工具类
 */
import { LoadingDialog } from '@kit.ArkUI'

@Preview
export struct LoadingUtil {

  dialogControllerProgress: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog({
      content: '正在加载中,请稍等...',
    }),
    autoCancel: true,
    customStyle: true,
    alignment: DialogAlignment.Center
  })

  build() {
    Row() {
      Stack() {
        Column() {
          Button("进度条弹出框")
            .width(96)
            .height(40)
            .onClick(() => {
              this.dialogControllerProgress.open()
            })
        }.margin({ bottom: 300 })
      }.align(Alignment.Bottom)
      .width('100%').height('100%')
    }
    .backgroundImageSize({ width: '100%', height: '100%' })
    .height('100%')
  }
}