import { SAPlayMode, SAPlayModeIcon, SongItemUrl } from './type'
import { getRandomFromRange, sa_throttle, sa_timeFormat } from './utils'
import { promptAction } from '@kit.ArkUI'
import { EfAVPlayer, EfAVPlayerState } from '../../../../../Index'

@Component
export struct EfAudioPlayer {
  /**
   * 播放模式
   */
  @State
  saPlayMode: SAPlayMode = SAPlayMode.order
  /**
   * 播放模式的图标
   */
  @State
  saPlayModeIcon: ResourceStr = $r("app.media.order")
  /**
   * 播放模式图标列表
   */
  @State
  playModeIcons: SAPlayModeIcon[] = [
    {
      mode: SAPlayMode.order,
      url: $r("app.media.order"),
      name: "顺序播放"
    },
    {
      mode: SAPlayMode.single,
      url: $r("app.media.single"),
      name: "单曲循环"
    },
    {
      mode: SAPlayMode.repeat,
      url: $r("app.media.repeat"),
      name: "列表循环"

    },
    {
      mode: SAPlayMode.random,
      url: $r("app.media.random"),
      name: "随机播放"

    },
  ]
  /**
   * 播放模式的下标
   */
  @State
  @Watch("_onPlayModeIndex")
  playModeIndex: number = 0
  /**
   * 歌曲时长 单位毫秒
   */
  @State
  duration: number = 0
  /**
   * 歌曲播放进度 单位毫秒
   */
  @State
  currentTime: number = 0
  /**
   * 是否正在播放
   */
  @State
  isPlay: boolean = true
  /**
   * 显示播放模式的弹窗
   */
  @State
  showPlayModePopup: boolean = false
  showPlayModePopupTid: number = -1
  /**
   * 要播放的歌曲列表
   */
  @Prop
  songList: SongItemUrl[] = []
  /**
   * 正在播放的歌曲列表的下标
   */
  @Link
  @Watch("_onPlayIndexChange")
  songPlayIndex: number
  /**
   * 正在播放的歌曲的地址
   */
  @State
  songPlayUrl: SongItemUrl = this.songList[this.songPlayIndex]
  /**
   * 封装了播放功能的AVPlay库
   */
  @Prop
  efAVPlay: EfAVPlayer = new EfAVPlayer()
  /**
   * 初始化播放的方法
   */
  initPlay = sa_throttle(() => {
    this.efAVPlay.onError(stateError => {
      this.onError(stateError)
      console.log("stateError", JSON.stringify(stateError))
    })

    this.efAVPlay.onStateChange(state => {
      this._onStateChange(state)
      switch (state) {
        case "playing":
          this.isPlay = true
          break
        case "completed":
          // 播放完毕
          this._onNext()
          // 切换下一首
          break;

        default:
          break;
      }
    })

    this.efAVPlay.onTimeUpdate(time => {

      this.duration = this.efAVPlay.duration
      this.currentTime = time
      this.onTimeUpdate(time)
    })

    this.efAVPlay.setUrl(this.songPlayUrl as string)
  }, 300)
  /**
   * 是否显示音量大小控件
   */
  @State
  showVolumn: boolean = false
  /**
   * 音量属性 0-1  包含小数
   */
  @Prop
  @Watch("_onVolumnChange")
  volume: number = 1
  /**
   * 是否静音
   */
  @Prop
  isMuted: boolean = false
  /**
   * 下一首
   */
  _onNext = async () => {
    if (!(this.saPlayMode === SAPlayMode.order && this.songPlayIndex + 1 >= this.songList.length)) {
      await this.efAVPlay.reset()
    }
    switch (this.saPlayMode) {
      case SAPlayMode.order:
        if (this.songPlayIndex + 1 >= this.songList.length) {
          // this.songPlayIndex = 0
          promptAction.showToast({ message: `已经是最后一首` })
          return
        } else {
          this.songPlayIndex++
        }
        break;
      case SAPlayMode.single:
        await this.efAVPlay.reset()
        break
      case SAPlayMode.repeat:
        if (this.songPlayIndex + 1 >= this.songList.length) {
          this.songPlayIndex = 0
        } else {
          this.songPlayIndex++
        }
        break
      case SAPlayMode.random:
        this.songPlayIndex = getRandomFromRange(0, this.songList.length - 1)
        break
      default:
        break;
    }
    this._onPlayIndexChange()
    this.efAVPlay.setUrl(this.songPlayUrl as string)
      .then(() => {
        this.onNext(this.songPlayIndex)
      })


  }
  /**
   * 上一首
   */
  _onPrevious = async () => {
    await this.efAVPlay.reset()
    if (this.songPlayIndex - 1 < 0) {
      this.songPlayIndex = this.songList.length - 1
    } else {

      this.songPlayIndex--
    }
    this._onPlayIndexChange()
    this.efAVPlay.setUrl(this.songPlayUrl as string)
      .then(() => {
        this.onPrevious(this.songPlayIndex)
      })

  }
  /**
   * 下一首
   */
  onNext: (index: number) => void = () => {
  }
  /**
   * 上一首
   */
  onPrevious: (index: number) => void = () => {
  }
  /**
   * 静音
   */

  onMuted: () => void = () => {
  }
  /**
   * 错误监听
   */
  onError: (error: Error) => void = () => {
  }
  /**
   * 实时播放
   */
  onTimeUpdate: (time: number) => void = () => {
  }
  /**
   * 音量调整
   */
  onVolumnChange: (v: number) => void = () => {
  }

  /**
   * 音量调整
   */
  _onVolumnChange(v: number) {
    // this.efAVPlay
    this.efAVPlay.setPlayOptions({ volume: this.volume })
    this.onVolumnChange(this.volume)
  }

  @Builder
  volumnBuilder() {
    Column({ space: 2 }) {
      Slider({
        value: this.efAVPlay.volume,
        min: 0,
        max: 1,
        step: 0.01,
        direction: Axis.Vertical,
        reverse: true
      })
        .height(100)
        .onChange((v, e) => {
          if (e === SliderChangeMode.Moving) {
            this.volume = v
            this.efAVPlay.setPlayOptions({ volume: v })
            if (this.volume === 0) {
              this.isMuted = true
              this.onMuted()
            } else {
              this.isMuted = false
            }
          }
        })
        .onTouch(v => {
          if (v.type === TouchType.Up) {
            this.showVolumn = false
          }
        })

      Text(`${Math.floor(this.volume * 100)}%`)
        .fontSize(12)
        .fontColor("#666")
    }
    .padding({ bottom: 5 })
  }

  /**
   * 歌曲切换
   */
  onPlayIndexChange: (index: number) => void = () => {
  }

  /**
   * 歌曲切换
   */
  _onPlayIndexChange() {
    this.songPlayUrl = this.songList[this.songPlayIndex]
    this.onPlayIndexChange(this.songPlayIndex)
  }

  aboutToAppear() {
    this.efAVPlay.init()
      .then(async () => {
        this._onPlayIndexChange()
        if (this.isPlay) {
          this.initPlay()
        }
      })

  }

  aboutToDisappear() {
    this.efAVPlay.release()
  }

  /**
   * 播放进度改变
   */
  onSeek: (time: number) => void = () => {
  }
  /**
   * 设置播放进度
   */
  setSeek = (time: number) => {
    this.efAVPlay.seek(time)
    this.onSeek(time)

  }
  /**
   * 暂停
   */
  onPaused: () => void = () => {
  }
  /**
   * 暂停
   */
  _onPaused = () => {
    this.efAVPlay.pause()
    this.onPaused()
  }
  /**
   * 播放
   */
  onPlay: () => void = () => {
  }
  /**
   * 播放
   */
  _onPlay = () => {
    this.efAVPlay.play()
    this.onPlay()
  }
  /**
   * 切换播放状态
   */
  togglePlay = () => {
    this.isPlay = !this.isPlay
    if (this.isPlay) {
      this._onPlay()
    } else {
      this._onPaused()
    }
  }
  /**
   * 播放模式改变
   */
  onPlayModeIndex: (mode: SAPlayMode) => void = () => {
  }

  /**
   * 播放模式改变
   */
  _onPlayModeIndex() {
    this.saPlayMode = this.playModeIcons[this.playModeIndex].mode
    this.saPlayModeIcon = this.playModeIcons[this.playModeIndex].url
    this.onPlayModeIndex(this.saPlayMode)
  }

  /**
   * 播放状态改变 和 AVPlayer内置的state一致
   */
  onStateChange: (state: EfAVPlayerState) => void = () => {
  }
  /**
   * 播放状态改变 和 AVPlayer内置的state一致
   */
  _onStateChange = (state: EfAVPlayerState) => {
    this.onStateChange(state)
  }
  /**
   * 切换播放模式
   */
  togglePlayMode = () => {
    if (this.playModeIndex + 1 >= this.playModeIcons.length) {
      this.playModeIndex = 0
    } else {
      this.playModeIndex++
      this.showPlayModePopup = true
    }
    if (this.showPlayModePopupTid !== -1) {

      clearTimeout(this.showPlayModePopupTid)
    }
    this.showPlayModePopupTid = setTimeout(() => {
      this.showPlayModePopup = false
      this.showPlayModePopupTid = -1
    }, 1000)
    // this.onPlayModeIndex()
  }

  build() {
    Column() {
      //   1 进度条
      Row() {
        Slider({ min: 0, max: this.duration, value: this.currentTime })
          .layoutWeight(1)
          .blockColor("#eee")
          .trackColor("#eef")
          .selectedColor("#bee")
          .onChange(this.setSeek)
      }

      // 2 播放时间
      Row() {
        Text(sa_timeFormat(this.currentTime))
          .fontColor("#aaa")
          .fontSize(12)
        Text(sa_timeFormat(this.duration))
          .fontColor("#aaa")
          .fontSize(12)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width("100%")
      .padding({ left: 15, right: 15 })

      //   3 按钮
      Row() {
        //   播放模式
        Row() {
          Image(this.saPlayModeIcon)
            .setImageIconStyle()
            .onClick(this.togglePlayMode)
            .bindPopup($$this.showPlayModePopup, { message: this.playModeIcons[this.playModeIndex].name })

        }
        .setImageRowIconStyle()

        //   上一首
        Row() {
          Image($r("app.media.previous"))
            .setImageIconStyle()
        }
        .setImageRowIconStyle()
        .onClick(this._onPrevious)

        //  播放&暂停
        Row() {
          Image(this.isPlay ? $r("app.media.paused") : $r("app.media.play"))
            .setImageIconStyle()
            .onClick(this.togglePlay)
        }
        .setImageRowIconStyle()
        .scale({ x: 1.2, y: 1.2 })

        //   下一首
        Row() {
          Image($r("app.media.next"))
            .setImageIconStyle()
        }
        .setImageRowIconStyle()
        .onClick(this._onNext)

        //   静音
        Row() {
          Image(this.isMuted ? $r("app.media.muted") : $r("app.media.voice"))
            .setImageIconStyle()

        }
        .setImageRowIconStyle()
        .onClick(() => {
          this.showVolumn = true
        })
        .bindPopup($$this.showVolumn, {
          builder: this.volumnBuilder(),
          width: 40,
          placement: Placement.Top
        })

      }.width("100%")
      .padding({ left: 15, right: 15 })
      .justifyContent(FlexAlign.SpaceAround)
      .margin({ top: 20 })
    }
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
    .padding(5)
  }
}


@Extend(Row)
function setImageRowIconStyle() {
  .width(50)
  .aspectRatio(1)
  .borderRadius(25)
  .justifyContent(FlexAlign.Center)
  .alignItems(VerticalAlign.Center)
  .border({
    width: 1, color: "#eee"
  })
}

@Extend(Image)
function setImageIconStyle() {
  .width(30)
  .fillColor("#666")
}