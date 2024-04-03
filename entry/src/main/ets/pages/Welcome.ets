/**
 * @Author csx
 * @DateTime 2024/4/3 10:24:04
 * @TODO Welcome
 */
export const entryName: string = 'Welcome';

@Entry({ routeName: entryName })
@Component
export struct Welcome {
  build() {
    Row() {
      Text('弹窗内容')
    }
    .width('100%')
    .height('100%')
  }
}