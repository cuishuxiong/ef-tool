# <center>ef_audio</center>

# <center>V1.0.1(API12)</center>

--------------------------------------------------------------------------------

## 📚简介

`ef_audio`是`eftool`的音频相关组件包。

> 你可以引入使用，也可以**拷贝**和修改使用，如需分享扩展
> ### **希望可以注明原出处即可**
> 也希望能把bug及时反馈回来。

> 我努力健全**中文**注释，为源码学习者提供良好地学习环境，争取做到人人都能看得懂。

## 🛠️包含组件

| 模块         | 介绍                        |
|------------|---------------------------|
| EfAVPlayer | 提供eftool封装AVPlayer的常规使用功能 |

## 📦安装

### 🍊ohpm

* 执行安装命令

```
ohpm install @yunkss/ef_audio
```

## 📦使用

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

#### 4.设置播放的url

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

## [eftool](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Feftool)工具类ohpm地址

## 特别鸣谢

* [万少](https://juejin.cn/user/4441682708283191)

## star `ef_audio` 希望您可以动一动小手点点小⭐⭐

## 👴希望大家如有好的需求踊跃提交,如有问题请前往gitee提交issue，我闲暇时间会扩充与修复优化