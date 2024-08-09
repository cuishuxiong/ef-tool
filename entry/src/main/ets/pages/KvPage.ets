/**
 * @Author csx
 * @DateTime 2024/8/6 23:37
 * @TODO KvPage
 */
import { GlobalContext, KvUtil } from '@yunkss/eftool'

@Component
export struct KvPage {
  @Consume('NavPathStack') pageStack: NavPathStack;
  @State msg: string = "";

  build() {
    NavDestination() {
      Column() {

        Text(this.msg);

        Button("kv存储")
          .margin({ top: 20 })
          .onClick(async () => {
            let kvUtil = GlobalContext.getContext().getT<KvUtil>("kvUtil");
            this.msg = await kvUtil.put("csx", true);
          })

        Button("token获取")
          .margin({ top: 20 })
          .onClick(async () => {
            let kvUtil = GlobalContext.getContext().getT<KvUtil>("kvUtil");
            this.msg = await kvUtil.get<string>("Authorization","") + "";
          })

        Button("token删除")
          .margin({ top: 20 })
          .onClick(async () => {
            let kvUtil = GlobalContext.getContext().getT<KvUtil>("kvUtil");
            this.msg = await kvUtil.delete("Authorization");
          })
      }
      .width('100%')
      .height('100%')
      .margin({ top: 40 })
    }
    .title('KvPage')
    .hideTitleBar(true)
  }
}