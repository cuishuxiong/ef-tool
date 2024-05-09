import { ProgressButton } from '@kit.ArkUI'

/**
 * @Author csx
 * @DateTime 2024/3/28 20:52
 * @TODO DownloadUtil  下载按钮工具类
 */
@Component
export struct DownloadUtil {
  /**
   * 当前下载进度
   */
  @Prop halfProgress: number = 0
  /**
   * 下载提示内容
   */
  @Prop ctx: string = '下载中...'
  /**
   * 是否显示
   */
  @Prop progressState: Visibility = Visibility.None

  build() {
    Column() {
      ProgressButton({
        progress: this.halfProgress,
        progressButtonWidth: "120",
        content: this.ctx,
        enable: true,
        clickCallback: () => {
        }
      })
        .visibility(this.progressState)
        .padding({ top: 12, bottom: 12 })
    }
  }
}