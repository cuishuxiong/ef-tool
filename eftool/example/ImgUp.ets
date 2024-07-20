import { ImgPreviewUtil } from '@yunkss/eftool';

@Entry
@Component
struct ImgUp {
  private urlList: ResourceStr[] = ['http://p8.qhimg.com/bdm/0_0_100/t01278eb24731562db5.jpg',
    'https://www.freeimg.cn/i/2023/12/26/658a379b526e6.png',
    'http://p5.qhimg.com/bdm/0_0_100/t015a6eec56526e2d36.jpg',
    'https://www.freeimg.cn/i/2023/11/22/655d4adc81261.jpg',
    'http://p5.qhimg.com/bdm/0_0_100/t01344a9e6aeccb2a41.jpg',
    'https://p9.qhimg.com/bdm/0_0_100/t0169ac90c2d4338dd0.jpg',
    'http://p1.qhimg.com/bdm/0_0_100/t018f78840a39a142aa.jpg',
  ]
  @State url: ResourceStr = ''
  defDialog: CustomDialogController = new CustomDialogController({
    builder: ImgPreviewUtil({
      url: this.url
    }),
    autoCancel: true,
    alignment: DialogAlignment.Center,
    customStyle: true
  })

  build() {
    Column({ space: 10 }) {
      List() {
        ForEach(this.urlList, (item: ResourceStr) => {
          ListItem() {
            Row() {
              Image(item)
                .width(200)
                .aspectRatio(1)
                .onClick(() => {
                  this.url = item
                  this.defDialog.open()
                })
            }.width('100%')
            .alignItems(VerticalAlign.Center)
            .justifyContent(FlexAlign.Center)
          }
        })
      }.width('100%')
    }
    .height('100%')
    .width('100%')

  }
}