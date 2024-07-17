import { TypeWritingUtil } from '@yunkss/eftool';

@Entry
@Component
struct InputIndex {
  @State text: string = ''
  inputController: TextInputController = new TextInputController()

  //自定义键盘关闭事件
  hideClick() {
    this.inputController.stopEditing()
  }

  //自定义键盘组件
  @Builder
  shurufa() {
    TypeWritingUtil({
      text: this.text, hideClick: () => {
        this.hideClick()
      }
    })
  }

  build() {
    Row() {
      TextArea({ text: this.text, controller: this.inputController })
        .customKeyboard(this.shurufa(), { supportAvoidance: true }) //supportAvoidance 是否避让
    }.width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
  }
}



