/**
 Copyright 2024 csx - @yunkss/eftool

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */
import { EfAVPlayer } from '../src/main/ets/audio/EfAVPlayer'

/**
 * @Author wsy
 * @DateTime 2024/10/13 0:13
 * @TODO EfAVPlayerDemo  播放器基本功能示例
 */
@Component
export struct EfAVPlayerIndex {
  efAVPlay: EfAVPlayer = new EfAVPlayer()
  @State
  total: number = 0
  @State
  value: number = 0

  build() {
    Column() {
      Text(`total:${this.total}  value:${this.value}`)
      Slider({ value: this.value, min: 0, max: this.total })
        .onChange(v => {
          this.efAVPlay.seek(v)
        })


      Button("获取实例")
        .onClick(() => {
          this.efAVPlay.init()
        })
      Button("设置url")
        .onClick(() => {
          this.efAVPlay.setUrl("https://env-00jxhf99mujs.normal.cloudstatic.cn/play/0.m4a")
        })
      Button("播放")
        .onClick(() => {
          this.efAVPlay.play()
        })
      Button("暂停")
        .onClick(() => {
          this.efAVPlay.pause()
        })
      Button("一键播放")
        .onClick(async () => {
          await this.efAVPlay.init({ immediately: true, loop: true })
          await this.efAVPlay.setUrl("http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.m4a")
        })
      Button("一键播放-演示错误1")
        .onClick(async () => {
          await this.efAVPlay.init({ immediately: false })
          await this.efAVPlay.setUrl("http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.m4a")
          // await this.efAVPlay.setUrl('')
          await this.efAVPlay.play()
        })
      Button('获取播放时长')
        .onClick(() => {
          this.total = this.efAVPlay.duration
        })
      Button('获取当前播放进度')
        .onClick(() => {
          this.efAVPlay.onTimeUpdate(time => {
            this.value = time
          })
        })
      Button('停止')
        .onClick(() => {
          this.efAVPlay.stop()
        })
      Button('释放资源')
        .onClick(() => {
          this.efAVPlay.release()
        })

      Button("封装 一键播放")
        .onClick(async () => {
          await this.efAVPlay.quickPlay(
            "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.m4a",
            () => {
              this.total = this.efAVPlay.duration
              this.efAVPlay.onTimeUpdate(time => {
                this.value = time
              })
            }
          )


        })

    }
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.Pink)
  }
}