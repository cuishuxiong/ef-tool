/**
 * @Author csx
 * @DateTime 2024/3/28 10:13:03
 * @TODO ExceptionUtil  异常提醒工具类
 */
import { ExceptionPrompt, MarginType } from '@ohos.arkui.advanced.ExceptionPrompt';

@Component
export struct ExceptionUtil {
  @Prop options: PromOptions = new PromOptions();

  build() {
    Column() {
      ExceptionPrompt({
        options: {
          tip: this.options.content != undefined ? this.options.content : '连接服务器异常,请重试!',
          icon: $r("app.media.error"),
          marginType: MarginType.FIT_MARGIN,
          actionText: this.options.actionText != undefined ? this.options.actionText : '重试',
          marginTop: '40vp',
          isShown: this.options.show
        },
        onTipClick: () => {
          this.options.clickCallBack(0);
        },
        onActionTextClick: () => {
          this.options.clickCallBack(1);
        },
      })
    }
  }
}

/**
 * Tips框参数
 */
class PromOptions {
  /**
   * 提示框内容
   */
  public content?: ResourceStr;
  /**
   * 指定当前异常提示的右侧图标按钮的文字
   */
  public actionText?: ResourceStr;
  /**
   * 是否显示
   */
  public show: boolean = false;
  /**
   * 点击弹框按钮回调函数
   */
  public clickCallBack: (index: number) => void = () => {
  };
}