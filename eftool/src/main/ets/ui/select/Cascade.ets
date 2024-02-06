/**
 * @Author csx
 * @DateTime 2024/2/6 10:02:02
 * @TODO Cascade  级联选择器
 */
import { UiConst } from '../../core/const/UiConst'

// @Preview
@Component
export struct Cascade {
  @Link show: boolean;

  build() {
    Panel(this.show) {
      Column() {
        Row() {
          Text('请选择地区').fontWeight('bold').fontSize('16fp')
          Image($r("app.media.close")).width('18vp').height('18vp').onClick(()=>{
            this.show = false;
          })
        }
        .width('100%')
        .padding({ left: 20, right: 20, bottom: 10 })
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
      }
      Divider()
      Row() {
        //省市区
        Column() {
          Text(){
            Span("请选择").margin({bottom:10})
          }.fontSize("16fp")
          .decoration({ type: TextDecorationType.Underline, color: UiConst.ALERT_OK_BG_COLOR })
        }.margin({right:20})
        //市
        Column() {
          Text("请选择")
        }.margin({right:20})
        //区域
        Column() {
          Text("请选择")
        }
      }.width("100%").margin({ top: 10,left:20 }).justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center)
    }
    .type(PanelType.Foldable)
    .mode(PanelMode.Half)
    .dragBar(true) // 默认开启
    .halfHeight(500) // 默认一半
    .backgroundColor(UiConst.ALERT_OK_COLOR)
    .position({x:0,y:0})
    .onChange((width: number, height: number, mode: PanelMode) => {
      console.info(`width:${width},height:${height},mode:${mode}`)
    })
  }
}