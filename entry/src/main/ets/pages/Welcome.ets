/**
 * @Author csx
 * @DateTime 2024/4/3 10:24:04
 * @TODO Welcome
 */
import { LocationUtil, MapUtil, WindowUtil } from '@yunkss/eftool'

@Entry
@Component
struct Welcome {
  build() {
    Column() {
      Text('弹窗内容').fontColor('#ff4400')
      Button('关闭弹窗').margin({ top: 20 }).onClick(() => {
        WindowUtil.closeWindow();
      })
      Button('定位').margin({ top: 20 }).onClick(() => {
        LocationUtil.startLocation();
      })
    }
    .backgroundColor("#fff")
    .align(Alignment.Center)
    .width('100%')
    .borderRadius(10)
    .margin({ top: 80 })
    .padding({ top: 20, bottom: 20 })

  }
}