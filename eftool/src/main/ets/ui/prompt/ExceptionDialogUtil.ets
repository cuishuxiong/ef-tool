/**
 * @Author csx
 * @DateTime 2024/3/28 10:50:03
 * @TODO ExceptionDialogUtil 异常提醒弹框工具类
 */
import { UiConst } from '../../core/const/UiConst'
import { ExceptionUtil } from './ExceptionUtil'

@Component
export struct ExceptionDialogUtil {
  callBack: (data: string) => void = () => {
  };
  dialogController: CustomDialogController = new CustomDialogController({
    builder: ExceptionUI({
      callBack: (data: string) => {
        this.callBack(data);
        this.dialogController.close();
      }
    }),
    autoCancel: false,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 10,
    customStyle: false,
    isModal: true
  })

  build() {
    Column() {
      Button('点我有奇迹')
        .margin({ top: 20, bottom: 20 })
        .onClick(() => {
          if (this.dialogController != undefined) {
            this.dialogController.open()
          }
        })
    }
  }
}

@CustomDialog
struct ExceptionUI {
  callBack: (data: string) => void = () => {
  };
  controller: CustomDialogController

  build() {
    Column() {
      ExceptionUtil({
        options: {
          show: true,
          clickCallBack: (index) => {
            this.callBack(index == 0 ? '点击了提示文本' : '点击了提示图标');
          }
        }
      }).zIndex(999)
      Text('是否需要上报服务器,获得更高体验?').fontSize(16).margin({ top: 10, bottom: 10 }).textAlign(TextAlign.Start);
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .fontColor(UiConst.ALERT_CANCEL_COLOR)
          .backgroundColor(UiConst.ALERT_CANCEL_BG_COLOR)
          .onClick(() => {
            this.callBack('取消')
          })
        Button('确认')
          .fontColor(UiConst.ALERT_OK_COLOR)
          .backgroundColor(UiConst.ALERT_OK_BG_COLOR)
          .onClick(() => {
            this.callBack('确认')
          })
      }.margin({ top: 10, bottom: 10 })
    }.height('80vp')
  }
}