/**
 * @Author csx
 * @DateTime 2024/3/28 20:52
 * @TODO DownloadUtil  下载按钮工具类
 */
import { ProgressButton } from '@kit.ArkUI'
import { UiConst } from '../../core/const/UiConst'

@Component
export struct DownloadUtil {
  @State halfProgress: number = 0
  @State smallProgress: number = 0
  @State bigProgress: number = 0
  @State textState1: string = ''
  @State isRunning1: boolean = false
  @State enableState1: boolean = true
  @State progressState: Visibility = Visibility.None
  @State ButtonState: Visibility = Visibility.Visible
  @State buttonText: string = '开始下载'
  @State buttonEnable: boolean = true
  @State isEnd: boolean = false

  build() {
    Column({ space: 20 }) {
      Button(this.buttonText)
        .fontSize(UiConst.FONT_16)
        .fontWeight(FontWeight.Medium)
        .fontColor(UiConst.PRIMARY_COLOR)
        .padding({ left: 10, right: 10 })
        .opacity(this.buttonEnable ? 1 : 0.4)
        .enabled(this.buttonEnable)
        .height(30)
        .borderRadius(14)
        .width(180)
        .backgroundColor($r("sys.color.ohos_id_color_button_normal"))
        .onClick(() => {
          if (!this.isEnd) {
            this.buttonText = '等待中...'
            let timer1 = setInterval(() => {
              this.progressState = Visibility.Visible
              this.ButtonState = Visibility.None
              clearInterval(timer1)
              this.isRunning1 = true
              let timer = setInterval(() => {
                if (this.isRunning1) {
                  if (this.halfProgress === 100) {
                    this.isEnd = true
                  } else {
                    this.halfProgress++
                    if (this.halfProgress === 100) {
                      this.textState1 = '安装中...'
                      this.enableState1 = false
                      this.ButtonState = Visibility.Visible
                      this.progressState = Visibility.None
                      this.buttonEnable = false
                      this.buttonText = '安装中'
                      let timer2 = setInterval(() => {
                        this.buttonText = '打开'
                        this.buttonEnable = true
                        this.isEnd = true
                        clearInterval(timer2)
                      }, 2000)
                    }
                  }
                } else {
                  clearInterval(timer)
                }
              }, 100)
            }, 2000)
          }
        })
        .visibility(this.ButtonState)
      ProgressButton({
        progress: this.halfProgress,
        progressButtonWidth: "60",
        content: this.textState1,
        enable: this.enableState1,

        clickCallback: () => {
          if (this.isRunning1 && this.halfProgress < 100) {
            this.textState1 = '继续'
          }
          this.isRunning1 = !this.isRunning1
          let timer = setInterval(() => {

            if (this.isRunning1) {
              if (this.halfProgress === 100) {
              } else {
                this.halfProgress++
                if (this.halfProgress === 100) {
                  this.textState1 = '安装中...'
                  this.enableState1 = false
                  this.ButtonState = Visibility.Visible
                  this.progressState = Visibility.None
                  this.buttonEnable = false
                  this.buttonText = '安装中...'
                  let timer2 = setInterval(() => {
                    this.buttonText = '打开'
                    this.buttonEnable = true
                    this.isEnd = true
                    clearInterval(timer2)
                  }, 2000)
                }
              }
            } else {
              clearInterval(timer)
            }
          }, 100)
        }
      }).visibility(this.progressState).padding({ top: 10, bottom: 10 })
    }.alignItems(HorizontalAlign.Center).width('100%')
  }
}