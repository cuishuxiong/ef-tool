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
  //当前显示页面
  @State pageName: string = 'RcpPage';
  /**
   * 底部导航
   */
  private toolBar: ToolbarItem[] = [
    {
      value: 'efRcp',
      icon: $r("app.media.startIcon"),
      action: () => {
        this.pageName = 'RcpPage';
        this.pageStack.pushPath({ name: this.pageName })
      }
    },
    {
      value: 'efUI',
      icon: $r("app.media.startIcon"),
      action: () => {
        this.pageName = 'IndexPage';
        this.pageStack.pushPath({ name: this.pageName })
      }
    },
    {
      value: 'efAxios',
      icon: $r("app.media.startIcon"),
      action: () => {
        this.pageName = 'WelcomePage';
        this.pageStack.pushPath({ name: this.pageName })
      }
    },
    {
      value: 'efCrypto',
      icon: $r("app.media.startIcon"),
      action: () => {
        this.pageName = 'CryptoPage';
        this.pageStack.pushPath({ name: this.pageName })
      }
    },
    {
      value: 'other',
      icon: $r("app.media.startIcon"),
      action: () => {
        this.pageName = 'KvPage';
        this.pageStack.pushPath({ name: this.pageName })
      }
    }
  ];

  /**
   * 构建页面
   */
  @Builder
  PageMap() {
    if (this.pageName === "RcpPage") {
      RcpPage()
    }
    if (this.pageName === "KvPage") {
      KvPage()
    }
    if (this.pageName === "CryptoPage") {
      Crypto()
    }
    if (this.pageName === "WelcomePage") {
      Welcome()
    }
    if (this.pageName === "IndexPage") {
      Index()
    }
  }

  build() {
    Navigation(this.pageStack) {
      Index()
    }
    .mode(NavigationMode.Stack)
    .navDestination(this.PageMap)
    .toolbarConfiguration(this.toolBar);
  }
}