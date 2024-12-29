# <center>ef_audio</center>

# <center>V1.1.0(API12)</center>

--------------------------------------------------------------------------------

## 📚简介

`ef_audio`是`eftool`的音频相关组件包。

> 你可以引入使用，也可以**拷贝**和修改使用，如需分享扩展
> ### **希望可以注明原出处即可**
> 也希望能把bug及时反馈回来。

> 我努力健全**中文**注释，为源码学习者提供良好地学习环境，争取做到人人都能看得懂。

## 🛠️包含组件

| 模块          | 介绍                                   |
| ------------- | -------------------------------------- |
| EfAVPlayer    | 提供eftool封装AVPlayer的常规使用功能   |
| EfAudioPlayer | 基于AVPlayer封装的极简的音乐播放器组件 |

## 📦安装

### 🍊ohpm

* 执行安装命令

```
ohpm install @yunkss/ef_audio
```

## 📦使用EfAVPlayer

### 1.在项目中引入插件

```
import { EfAVPlayer} from '@yunkss/ef_audio'
```

### 2.实例化

```
efAVPlay: EfAVPlayer = new EfAVPlayer()
```

### 3.初始化

```
this.efAVPlay.init()
```

### 4.设置播放的url

```
this.efAVPlay.setUrl("https://env-00jxhf99mujs.normal.cloudstatic.cn/play/0.m4a")
```

### 前言

EfAVPlayer 针对 AVPlayer的不同状态封装了常见的 API。初始化、播放、暂停、停止、释放资源等。支持 url、fdSrc、dataSrc三种资源路径。

![img](https://alliance-communityfile-drcn.dbankcdn.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20241015135130.64410763661269625666794578238334:50001231000000:2800:A6E707914B74421E3C9C965655A5E1F78879279A6A557114DA6F47F62547CE6B.png?needInitFileName=true?needInitFileName=true)

并且考虑常见的使用场景，提供了两个示例demo。

#### 基本示例

> ```
> EfAVPlayerIndex
> ```

![image-20241016100542237](https://z4a.net/images/2024/11/12/image-20241016100542237.png)

#### 播放器示例

实现了播放、暂停、音量大小调整、循环播放、列表播放、随机播放、单曲播放等功能

![image-20241016100624387](https://z4a.net/images/2024/11/12/image-20241016100624387.png)

### EfAVPlayer 类参数详解

```typescript

/**
 * 存储多媒体播放器实例，初始值为 null。
 */
avPlayer: media.AVPlayer | null = null;
/**
 * 用于存储状态变化的回调函数，初始值为 undefined。
 */
stateChangeCallback ? : Function;
/**
 * 用于存储错误的回调函数，初始值为 undefined。
 */
errorCallback ? : Function;
/**
 * 用于存储时间更新的回调函数，初始值为 undefined。
 */
timeUpdateCallback ? : Function;
/**
 * 指定的相对音量大小，取值范围为[0.00-1.00]，1表示最大音量
 */
volume: number = 1
/**
 * 是否循环播放
 */
loop: boolean = false
/**
 * 存储多媒体的总时长。
 */
duration: number = 0;
/**
 * 存储当前播放时间。
 */
currentTime: number = 0;
/**
 * 播放器的状态
 */
state: EfAVPlayerState = "idle"
/**
 * 存储播放选项，包括立即播放和循环播放等设置。
 */
private
efPlayOptions: EFPlayOptions = {
  immediately: true,
  loop: this.loop,
  volume: this.volume
};

/**
 * 获取AVPlayer实例
 * @returns media.AVPlayer
 */
getAVPlayer()
{
  return this.avPlayer
}

/**
 * 用于设置播放选项。
 * @param options - 播放选项对象。
 */
setPlayOptions(options:
EFPlayOptions = {}
)
{
  // this.efPlayOptions = options;
  if (options.immediately !== undefined) {
    this.efPlayOptions.immediately = options.immediately
  }
  if (options.loop !== undefined) {
    this.efPlayOptions.loop = options.loop
    this.loop = options.loop
  }
  if (options.volume !== undefined) {
    this.efPlayOptions.volume = options.volume
    this.volume = options.volume
  }
  if (this.avPlayer && ['prepared', 'playing', 'paused', 'completed'].includes(this.avPlayer.state)) {
    if (this.avPlayer.loop !== this.loop) {
      this.avPlayer.loop = this.loop
    }
    this.avPlayer.setVolume(this.volume)
  }
}

/**
 * 用于初始化多媒体播放器。
 * @param options - 播放选项对象，默认为当前实例的 efPlayOptions。
 * @returns 多媒体播放器实例。
 */
async
init(options:
EFPlayOptions = this.efPlayOptions
)
{
  if (!this.avPlayer) {

    this.avPlayer = await media.createAVPlayer();
    this.setPlayOptions(options);
    this._onError();
    this._onStateChange();
    this._onTimeUpdate();
  }

  return this.avPlayer;
}

/**
 * 私有用于处理状态变化事件。
 */
private
async
_onStateChange()
{
  const avPlayer = await this.init();

  avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
    this.state = state as EfAVPlayerState
    switch (state) {
      case 'idle':
        break;
      case 'initialized':
        avPlayer.prepare();
        break;
      case 'prepared':
        this.duration = avPlayer.duration;
        if (this.efPlayOptions.immediately) {
          avPlayer.play();
        }
        break;
      case 'playing':
        // this.avPlayer!.setVolume(this.efPlayOptions.volume)
        // this.volume = this.efPlayOptions.volume!
        this.avPlayer!.loop = !!this.efPlayOptions.loop;
        this.loop = !!this.efPlayOptions.loop;
        break;
      case 'paused':
        break;
      case 'completed':
        break;
      case 'stopped':
        break;
      case 'released':
        break;
      default:
        break;
    }
    this.stateChangeCallback && this.stateChangeCallback(state);
  });
}

/**
 * 用于设置状态变化的回调函数。
 * @param callback - 状态变化的回调函数，接收状态参数并返回 void。
 */
async
onStateChange(callback:
(state: EfAVPlayerState) => void
)
{

  this.stateChangeCallback = callback;
}

/**
 * 用于设置错误的回调函数。
 * @param callback - 错误的回调函数，接收错误对象并返回 void。
 */
async
onError(callback:
(stateErr: Error) => void
)
{
  this.errorCallback = callback;
}

/**
 * 私有用于处理错误事件。
 */
private
async
_onError()
{
  const avPlayer = await this.init();
  avPlayer.on("error", (err: BusinessError) => {

    this.errorCallback && this.errorCallback(err);
  });
}

/**
 * 私有用于处理时间更新事件。
 */
private
async
_onTimeUpdate()
{
  const avPlayer = await this.init();
  avPlayer.on("timeUpdate", (time: number) => {
    this.currentTime = time;
    this.timeUpdateCallback && this.timeUpdateCallback(time);
  });
}

/**
 * 用于跳转到指定时间。
 * @param time - 要跳转的时间。
 */
async
seek(time:
number
)
{
  const avPlayer = await this.init();
  avPlayer.seek(time);
}

/**
 * 用于设置时间更新的回调函数。
 * @param callback - 时间更新的回调函数，接收时间参数并返回 void。
 */
async
onTimeUpdate(callback:
(time: number) => void
)
{
  this.timeUpdateCallback = callback;
}

/**
 * 用于停止播放。
 */
async
stop()
{
  const avPlayer = await this.init();
  await avPlayer.stop();
}

/**
 * 用于设置播放的 URL。
 * @param url - 要播放的资源 URL。
 */
async
setUrl(url:
string
)
{
  const avPlayer = await this.init();

  avPlayer.url = url;
}

/**
 * 用于设置播放的文件描述符源。
 * @param url - 文件描述符源。
 */
async
setFdSrc(url:
media.AVFileDescriptor
)
{
  const avPlayer = await this.init();
  avPlayer.fdSrc = url;
}

/**
 * 用于设置播放的数据源描述符。
 * @param url - 数据源描述符。
 */
async
setDataSrc(url:
media.AVDataSrcDescriptor
)
{
  const avPlayer = await this.init();
  avPlayer.dataSrc = url;
}

/**
 * 用于播放多媒体。
 */
async
play()
{
  const avPlayer = await this.init();
  avPlayer.play();
}

/**
 * 用于暂停播放。
 */
async
pause()
{
  const avPlayer = await this.init();
  avPlayer.pause();
}

/**
 * 用于重置播放器
 */
async
reset()
{
  await this.avPlayer?.reset()
}

/**
 * 用于释放多媒体播放器资源。
 */
async
release()
{
  await this.avPlayer?.release();
  this.avPlayer?.off("stateChange");
  this.avPlayer?.off("error");
  this.avPlayer?.off("timeUpdate");
  this.currentTime = 0;
  this.duration = 0;
  this.avPlayer = null;
  this.errorCallback = undefined;
  this.stateChangeCallback = undefined;
  this.timeUpdateCallback = undefined;
}

async
quickPlay(url:
string, callback ? : Function
)

async
quickPlay(url:
media.AVFileDescriptor, callback ? : Function
)

async
quickPlay(url:
media.AVDataSrcDescriptor, callback ? : Function
)

/**
 * 快速播放
 * @param url 要播放的音频的url
 */
async
quickPlay(url:
string | media.AVFileDescriptor | media.AVDataSrcDescriptor
)
{

  await this.init({ immediately: true, loop: true });
  if (typeof url === "string") {
    await this.setUrl(url)
  } else {
    if (typeof (url as media.AVFileDescriptor).fd === "number") {
      await this.setFdSrc(url as media.AVFileDescriptor)
    } else {
      await this.setDataSrc(url as media.AVDataSrcDescriptor)
    }
  }
  await this.play()
}
```



## 📦使用EfAudioPlayer

### 1. 功能介绍

1. 播放&暂停
2. 上一首&下一首
3. 单曲播放&列表播放&循环播放&随机播放
4. 音量大小调整
5. 播放进度调整

![image-20241220173228806](README.assets/image-20241220173228806.png)

### 2.在项目中引入组件

```
import { EfAudioPlayer} from '@yunkss/ef_audio'
```

### 3.使用组件

```jsx

import { promptAction } from '@kit.ArkUI'
import { EfAudioPlayer } from '../Index'
import { SongItemUrl } from '../src/main/ets/ui/Ef_audio_player/type'


interface SongItem {
  title: string
  url: SongItemUrl
}

@Component
export struct EfAudioPlayDemo {
  @State
  songList: SongItem[] = [
    {
      title: "直到世界的尽头",
      url: 'https://wsy997.obs.cn-east-3.myhuaweicloud.com/simple_audio%E7%B4%A0%E6%9D%90/0.m4a',
    },
    {
      title: '画',
      url: 'https://wsy997.obs.cn-east-3.myhuaweicloud.com/simple_audio%E7%B4%A0%E6%9D%90/1.mp3',
    },
    {
      title: 'Sweet Dreams',
      url: 'https://wsy997.obs.cn-east-3.myhuaweicloud.com/simple_audio%E7%B4%A0%E6%9D%90/2.mp3',
    },
    {
      title: '奢香夫人',
      url: 'https://wsy997.obs.cn-east-3.myhuaweicloud.com/simple_audio%E7%B4%A0%E6%9D%90/0.m4a',
    }
  ]
  @State
  songPlayIndex: number = 0
  @State
  volume: number = 1

  build() {
    Column() {
      EfAudioPlayer({
        songList: this.songList.map(v => v.url),
        songPlayIndex: this.songPlayIndex,
        onVolumnChange: (v) => {
          promptAction.showToast({ message: `音量改变` + v })
        },
        onTimeUpdate: (t => {
          // promptAction.showToast({ message: `${t}` })
        }),
        onPaused: () => {
          promptAction.showToast({ message: `暂停了` })
        },
        onPlay: () => {
          promptAction.showToast({ message: `播放了` })
        },
        onPlayModeIndex: (mode) => {
          promptAction.showToast({ message: `播放模式改变${mode}` })
        },
        onMuted: () => {
          promptAction.showToast({ message: `静音了` })
        },
        onError: (stateError) => {
          AlertDialog.show({ message: JSON.stringify(stateError, null, 2) })
        },
        onPlayIndexChange: (index) => {
          promptAction.showToast({ message: `歌曲序号${index}` })
        },
        onNext: (index) => {
          promptAction.showToast({ message: `下一首${index}` })
        },

        onPrevious: (index) => {
          promptAction.showToast({ message: `上一首${index}` })
        },
        onStateChange: (state) => {
          promptAction.showToast({ message: `播放状态${state}` })
        },
        onSeek: (time) => {
          promptAction.showToast({ message: `${time}` })
        }
      })

    }
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
  }
}
```

### 4. Props

| 属性     | 类型          | 说明                                                         |
| -------- | ------------- | ------------------------------------------------------------ |
| songList | SongItemUrl[] | 要播放的歌曲列表                                             |
| volume   | number        | 音量属性 0-1  包含小数                                       |
| isMuted  | boolean       | 是否静音                                                     |
| efAVPlay | EfAVPlayer    | [ef_auido 核心类](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_audio) |

### 5. event

| 事件              | 说明         |
| ----------------- | ------------ |
| onNext            | 下一首       |
| onPrevious        | 上一首       |
| onMuted           | 静音         |
| onError           | 错误监听     |
| onTimeUpdate      | 实时播放     |
| onVolumnChange    | 音量调整     |
| onPlayIndexChange | 歌曲切换     |
| onSeek            | 播放进度     |
| onPaused          | 暂停         |
| onPlay            | 播放         |
| onPlayModeIndex   | 播放模式改变 |
| onStateChange     | 播放状态改变 |

### 6. 核心代码

```jsx
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
```



## [eftool](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Feftool)工具类ohpm地址

## 特别鸣谢

* [万少](https://juejin.cn/user/4441682708283191)

## star `ef_audio` 希望您可以动一动小手点点小⭐⭐

## 👴希望大家如有好的需求踊跃提交,如有问题请前往gitee提交issue，我闲暇时间会扩充与修复优化