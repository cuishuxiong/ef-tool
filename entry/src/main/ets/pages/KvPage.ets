/**
 * @Author csx
 * @DateTime 2024/8/6 23:37
 * @TODO KvPage
 */
import { GlobalContext, KvUtil } from '@yunkss/eftool'

@Component
export struct KvPage {
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

        Button("kv获取")
          .margin({ top: 20 })
          .onClick(async () => {
            let kvUtil = GlobalContext.getContext().getT<KvUtil>("kvUtil");
            this.msg = await kvUtil.get<boolean>("csx", false) + "";
          })

        Button("kv删除")
          .margin({ top: 20 })
          .onClick(async () => {
            let kvUtil = GlobalContext.getContext().getT<KvUtil>("kvUtil");
            this.msg = await kvUtil.delete("csx");
          })
      }
      .width('100%')
      .height('100%')
      .margin({ top: 40 })
    }
    .title('KvPage')
  }
}