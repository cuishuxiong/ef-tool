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

import { EfAVPlayer } from "../src/main/ets/audio/EfAVPlayer"

// 顺序播放-order、单曲循环-single、列表循环-repeat、随机播放-random
enum PlayMode {
  order,
  single,
  repeat,
  random
}

interface PlayModeIcon {
  url: ResourceStr
  mode: PlayMode
  name: string
}

interface SongItem {
  img: string
  name: string
  url: string
  id: string
}

/**
 * @Author wsy
 * @DateTime 2024/10/13 0:13
 * @TODO EfAVPlayerDemo  播放器基本功能示例
 */
@Component
export struct EfAVPlayerDemo {
  @State
  playModeIndex: number = 1
  @State
  playModeIcons: PlayModeIcon[] = [
    {
      mode: PlayMode.order,
      url: "https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/order",
      name: "顺序播放"
    },
    {
      mode: PlayMode.single,
      url: "https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/single",
      name: "单曲循环"
    },
    {
      mode: PlayMode.repeat,
      url: "https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/repeat",
      name: "列表循环"

    },
    {
      mode: PlayMode.random,
      url: "https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/random",
      name: "随机播放"

    },
  ]
  @State
  showPlayModePopup: boolean = false
  @State
  playList: SongItem[] = [
    {
      img: 'https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/0.jpg',
      name: '直到世界的尽头',
      url: 'https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/0.m4a',
      id: '0000'
    },
    {
      img: 'https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/1.jpg',
      name: '画',
      url: 'https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/1.mp3',
      id: '0001'
    },
    {
      img: 'https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/2.jpg',
      name: 'Sweet Dreams',
      url: 'https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/2.mp3',
      id: '0002'
    },
    {
      img: 'https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/3.jpg',
      name: '奢香夫人',
      url: 'https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/3.m4a',
      id: '0003'
    }
  ]
  @State
  songItem: SongItem = {} as SongItem
  @State
  // @Watch("getPlayItem")
  activeIndex: number = 0
  @State
  avPlayer: EfAVPlayer = new EfAVPlayer()
  @State
  showVolumn: boolean = false

  aboutToAppear() {
    this.songItem = this.getPlayItem()
    this.avPlayer.quickPlay(this.songItem.url)
    this.avPlayer.onStateChange(async (state) => {
      if (state === "completed") {
        await this.avPlayer.reset()
        switch (this.playModeIcons[this.playModeIndex].mode) {
          case PlayMode.order:
            if (this.activeIndex + 1 < this.playList.length - 1) {
              this.activeIndex++
              this.setPlay()
            }
            break
          case PlayMode.single:
            this.setPlay()
            break
          case PlayMode.repeat:
            if (this.activeIndex + 1 >= this.playList.length) {
              this.activeIndex = 0
            } else {
              this.activeIndex++
            }
            this.setPlay()
            break
          case PlayMode.random:
            this.activeIndex = Math.floor(Math.random() * (this.playList.length))
            this.setPlay()
            break
        }

      }
    })


  }

  setPlay() {
    this.songItem = this.getPlayItem()
    this.avPlayer.quickPlay(this.songItem.url)
  }

  getPlayItem() {
    return this.playList[this.activeIndex]
  }

  timeFormat(time: number) {
    const minute = Math.floor(time / 1000 / 60).toString().padStart(2, '0')
    const second = Math.floor(time / 1000 % 60).toString().padStart(2, '0')
    return `${minute}:${second}`
  }

  playToggle = () => {
    if (this.avPlayer.state === "playing") {
      this.avPlayer.pause()
    } else {
      if (this.avPlayer.state === "idle") {
        this.setPlay()
      } else {

        this.avPlayer.play()
      }
    }
  }
  previous = async () => {
    await this.avPlayer.reset()
    if (this.activeIndex - 1 < 0) {
      this.activeIndex = this.playList.length - 1
    } else {
      this.activeIndex--
    }
    this.setPlay()
  }
  next = async () => {
    await this.avPlayer.reset()
    const currentMode = this.playModeIcons[this.playModeIndex].mode
    if (currentMode === PlayMode.random) {
      this.activeIndex = Math.floor(Math.random() * (this.playList.length))
    } else {
      if (this.activeIndex + 1 >= this.playList.length) {
        this.activeIndex = 0
      } else {
        this.activeIndex++
      }
    }
    this.setPlay()
  }
  playModeToggle = () => {
    if (this.playModeIndex + 1 >= this.playModeIcons.length) {
      this.playModeIndex = 0
    } else {
      this.playModeIndex++
    }


    this.showPlayModePopup = true
    setTimeout(() => {
      this.showPlayModePopup = false
    }, 1000)
    if (this.playModeIcons[this.playModeIndex].mode !== PlayMode.single) {
      this.avPlayer.setPlayOptions({ loop: false })
    } else {
      this.avPlayer.setPlayOptions({ loop: true })

    }
  }
  setSeek = (time: number) => {
    this.avPlayer.seek(time)

  }

  build() {
    Column({ space: 20 }) {

      Column() {
        ForEach(this.playList, (item: SongItem, index: number) => {
          Text(item.name)
            .fontColor(this.activeIndex === index ? Color.Blue : Color.Black)
        })
      }

      Image(this.playList[this.activeIndex].img)
        .width(200)

      Row() {
        //   播放模式
        Image(this.playModeIcons[this.playModeIndex].url)
          .toolIcon()
          .onClick(this.playModeToggle)
          .bindPopup($$this.showPlayModePopup, { message: this.playModeIcons[this.playModeIndex].name })

        //   上一首
        Image("https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/previous")
          .toolIcon()
          .onClick(() => {
            this.previous()
          })
        //   播放&暂停
        Image(this.avPlayer.state === "playing" ?
          "https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/pause" :
          "https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/play")
          .fillColor(this.avPlayer.state === "playing" ? Color.Red : Color.Black)
          .toolIcon()

          .onClick(this.playToggle)
        //   下一首
        Image("https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/next")
          .toolIcon()
          .onClick(() => {
            this.next()
          })
        //   音量
        Image("https://mp-9c1e1be5-c4d2-4eb3-96a7-57f45b401012.cdn.bspapp.com/ef_audio_resource/voice")
          .toolIcon()
          .onClick(() => {
            this.showVolumn = true
          })
          .bindPopup($$this.showVolumn, {
            builder: this.volumnBuilder(),
            width: 40,
            placement: Placement.Top
          })

      }
      .width("80%")
      .justifyContent(FlexAlign.SpaceAround)

      Row({ space: 10 }) {
        Text(this.timeFormat(this.avPlayer.currentTime))
          .fontColor(Color.Gray)

        Slider({ min: 0, max: this.avPlayer.duration, value: this.avPlayer.currentTime })
          .layoutWeight(1)
          .onChange(this.setSeek)
        Text(this.timeFormat(this.avPlayer.duration))
          .fontColor(Color.Gray)


      }

    }
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
    .padding(5)
  }

  @Builder
  volumnBuilder() {
    Column({ space: 2 }) {
      Slider({
        value: this.avPlayer.volume,
        min: 0,
        max: 1,
        step: 0.01,
        direction: Axis.Vertical,
        reverse: true
      })
        .height(100)
        .onChange(v => {
          this.avPlayer.setPlayOptions({ volume: v })
        })
        .onTouch(v => {
          if (v.type === TouchType.Up) {
            this.showVolumn = false
          }
        })

      Text(`${Math.floor(this.avPlayer.volume * 100)}%`)
        .fontSize(12)
        .fontColor("#666")
    }
    .padding({ bottom: 5 })
  }
}


@Extend(Image)
function toolIcon() {
  .width(40)
  .stateStyles({
    normal: {
      .scale({ x: 1, y: 1 })
      .opacity(1)
    },
    pressed: {
      .scale({ x: 1.2, y: 1.2 })
      .opacity(0.4)
    }
  })
  .animation({ duration: 300, curve: Curve.Linear })

}