import { promptAction } from '@kit.ArkUI'
import { photoAccessHelper } from '@kit.MediaLibraryKit'
import { BusinessError, request } from '@kit.BasicServicesKit'
import { util } from '@kit.ArkTS'


@Preview
@CustomDialog
@Component
export struct ImgPreviewUtil {
  defController: CustomDialogController
  @State imgWidth: number = 300 //图片宽度
  @State beis: number = 1 //缩放倍数
  @State url: ResourceStr = '' //图片url
  @State showPopup: boolean = false //控制保存按钮显示
  @State filePath: string = '' //下载路径  沙箱路径
  // 设置安全控件按钮属性
  @State saveButtonOptions: SaveButtonOptions = {
    icon: SaveIconStyle.FULL_FILLED,
    text: SaveDescription.SAVE_IMAGE,
    buttonType: ButtonType.Capsule
  } // 设置安全控件按钮属性
  @State transtion0bj: obj = new obj()
  @State defaultobj: obj = new obj()
  @State isScale: boolean = false //是否缩放

  aboutToAppear(): void {
    //页面一加载就缓存图片
    this.downLoadImg(this.url)
  }

  //缓存图片
  downLoadImg(url: ResourceStr) {
    let context = getContext(this)
    let filesDir = context.filesDir
    let uuid = util.generateRandomUUID(true);
    this.filePath = filesDir + '/' + uuid + '.jpg'
    console.info('ImgToUp_filename: ' + this.filePath);
    try {
      request.downloadFile(context, {
        url: url.toString(),
        filePath: this.filePath
      }).then((downloadTask: request.DownloadTask) => {
        downloadTask.on('complete', () => {
          console.info('ImgToUp_downLoadImg file success');
        })
      }).catch((err: BusinessError) => {
        console.error(`ImgToUp_downLoadImg downloadTask failed, code is ${err.code}, message is ${err.message}`);
      });
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      console.error(`ImgToUp_downLoadImg downloadFile failed, code is ${err.code}, message is ${err.message}`);
    }


  }

  //保存图片至相册
  async saveImg(res: SaveButtonOnClickResult) {
    if (res == SaveButtonOnClickResult.SUCCESS) {
      try {
        //拷贝文件
        let context = getContext()
        let phAccessHelper = photoAccessHelper.getPhotoAccessHelper(context)
        let assetChangeRequest: photoAccessHelper.MediaAssetChangeRequest =
          photoAccessHelper.MediaAssetChangeRequest.createImageAssetRequest(context, this.filePath)
        await phAccessHelper.applyChanges(assetChangeRequest);
        console.info('ImgToUp_saveImg success, uri: ' + assetChangeRequest.getAsset().uri)
        promptAction.showToast({ message: '保存成功' })
      } catch (err) {
        console.error(`ImgToUp_saveImg failed, error: ${err.code}, ${err.message}`)
        promptAction.showToast({ message: '保存失败' })
      }
    } else {
      promptAction.showToast({ message: '保存失败' })
      console.error('ImgToUp_SaveButtonOnClickResult create asset failed');
    }
  }

  build() {
    Column({ space: 10 }) {
      SaveButton(this.saveButtonOptions)// 创建安全控件按钮
        .onClick((event, result: SaveButtonOnClickResult) => {
          this.saveImg(result)
        })
      Image(this.url)
        .width(this.imgWidth)
        .scale({ x: this.beis, y: this.beis })
        .aspectRatio(1)
        .onClick(() => {
          this.isScale = false
          this.defController.close()
        })
        .translate({
          x: this.isScale ? this.transtion0bj.x : 0,
          y: this.isScale ? this.transtion0bj.y : 0
        })
        .gesture(
          //捏合事件
          PinchGesture({ fingers: 2 })//捏合事件开始
            .onActionStart((event: GestureEvent) => {
              this.isScale = true
              this.beis = event.scale
              console.info('ImgToUp_PinchGesture-onActionStart： scale：' + event.scale)
            })//捏合事件更新
            .onActionUpdate((event: GestureEvent) => {
              this.beis = event.scale
              console.info('ImgToUp_PinchGesture-onActionUpdate： scale：' + event.scale)
            })//捏合事件结束
            .onActionEnd((event: GestureEvent) => {
              this.beis = event.scale
              console.info('ImgToUp_PinchGesture-onActionEnd： scale：' + event.scale)
            }))

        .gesture(
          //平移事件
          PanGesture()
            .onActionStart((event: GestureEvent) => {
              this.defaultobj.x = this.transtion0bj.x
              this.defaultobj.y = this.transtion0bj.y
            })
            .onActionUpdate((event: GestureEvent) => {
              this.transtion0bj.x = event.offsetX + this.defaultobj.x
              this.transtion0bj.y = event.offsetY + this.defaultobj.y
            })
        )
        .width('100%')
        .height('100%')


    }
  }
}


export class obj {
  x: number = 0
  y: number = 0
}
