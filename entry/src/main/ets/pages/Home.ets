import { Crypto } from './Crypto';
import { Index } from './Index';
import { KvPage } from './KvPage';
import { RcpPage } from './RcpPage';
import { Welcome } from './Welcome';

@Entry
@Component
struct Home {
  /**
   * 创建一个页面栈对象并传入Navigation
   */
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()
  /**
   * 底部导航
   */
  private toolBar: ToolbarItem[] = [
    {
      value: 'efRcp',
      icon: $r("app.media.ok")
    },
    {
      value: 'efUI',
      icon: $r("app.media.tips")
    },
    {
      value: 'efAxios',
      icon: $r("app.media.notice")
    },
    {
      value: 'efCrypto',
      icon: $r("app.media.startIcon")
    },
    {
      value: 'other',
      icon: $r("app.media.error")
    }
  ];
  /**
   * list数据
   */
  @State arr: Array<Record<string, string>> = [
    {
      "title": 'efRcp请求Demo',
      "page": 'RcpPage'
    },
    {
      "title": 'efAxios请求Demo',
      "page": 'Index'
    },
    {
      "title": '数据库Demo',
      "page": 'KvPage'
    },
    {
      "title": 'UIDemo',
      "page": 'Welcome'
    },
    {
      "title": '加解密Demo',
      "page": 'Crypto'
    }
  ];

  /**
   * 构建页面
   * @param name
   */
  @Builder
  PageMap(name: string) {
    if (name === "RcpPage") {
      RcpPage()
    }
    if (name === "KvPage") {
      KvPage()
    }
    if (name === "Crypto") {
      Crypto()
    }
    if (name === "Welcome") {
      Welcome()
    }
    if (name === "Index") {
      Index()
    }
  }

  build() {
    Navigation(this.pageStack) {
      List({ space: 12 }) {
        ForEach(this.arr, (item: Record<string, string>) => {
          ListItem() {
            Text(item["title"])
              .width("100%")
              .height(72)
              .backgroundColor('#FFFFFF')
              .borderRadius(24)
              .fontSize(16)
              .fontWeight(500)
              .borderColor("#108ee9")
              .textAlign(TextAlign.Center)
              .onClick(() => {
                this.pageStack.pushPath({ name: item["page"] })
              })
          }
        }, (item: Record<string, string>): string => item["page"])
      }
      .width("100%")
      .margin({ top: 12 })
    }
    .mode(NavigationMode.Stack)
    .navDestination(this.PageMap)
    .toolbarConfiguration(this.toolBar);
  }
}