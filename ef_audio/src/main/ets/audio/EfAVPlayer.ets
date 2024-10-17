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
import media from '@ohos.multimedia.media';
import { EfAVPlayerState, EFPlayOptions } from '../type';
import { BusinessError } from '@kit.BasicServicesKit';


/**
 * @Author wsy
 * @DateTime 2024/10/13 0:11
 * @TODO EfAVPlayer 类用于管理多媒体播放器
 */
export class EfAVPlayer {
  /**
   * 私有属性，存储多媒体播放器实例，初始值为 null。
   */
  private avPlayer: media.AVPlayer | null = null;
  /**
   * 私有属性，用于存储状态变化的回调函数，初始值为 undefined。
   */
  private stateChangeCallback?: Function;
  /**
   * 私有属性，用于存储错误的回调函数，初始值为 undefined。
   */
  private errorCallback?: Function;
  /**
   * 私有属性，用于存储时间更新的回调函数，初始值为 undefined。
   */
  private timeUpdateCallback?: Function;
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
   * 私有属性，存储播放选项，包括立即播放和循环播放等设置。
   */
  private efPlayOptions: EFPlayOptions = {
    immediately: true,
    loop: this.loop,
    volume: this.volume
  };

  /**
   * 获取AVPlayer实例
   * @returns media.AVPlayer
   */
  getAVPlayer() {
    return this.avPlayer
  }

  /**
   * 用于设置播放选项。
   * @param options - 播放选项对象。
   */
  setPlayOptions(options: EFPlayOptions = {}) {
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
  async init(options: EFPlayOptions = this.efPlayOptions) {
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
  private async _onStateChange() {
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
  async onStateChange(callback: (state: EfAVPlayerState) => void) {

    this.stateChangeCallback = callback;
  }

  /**
   * 用于设置错误的回调函数。
   * @param callback - 错误的回调函数，接收错误对象并返回 void。
   */
  async onError(callback: (stateErr: Error) => void) {
    this.errorCallback = callback;
  }

  /**
   * 私有用于处理错误事件。
   */
  private async _onError() {
    const avPlayer = await this.init();
    avPlayer.on("error", (err: BusinessError) => {

      this.errorCallback && this.errorCallback(err);
    });
  }

  /**
   * 私有用于处理时间更新事件。
   */
  private async _onTimeUpdate() {
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
  async seek(time: number) {
    const avPlayer = await this.init();
    avPlayer.seek(time);
  }

  /**
   * 用于设置时间更新的回调函数。
   * @param callback - 时间更新的回调函数，接收时间参数并返回 void。
   */
  async onTimeUpdate(callback: (time: number) => void) {
    this.timeUpdateCallback = callback;
  }

  /**
   * 用于停止播放。
   */
  async stop() {
    const avPlayer = await this.init();
    await avPlayer.stop();
  }

  /**
   * 用于设置播放的 URL。
   * @param url - 要播放的资源 URL。
   */
  async setUrl(url: string) {
    const avPlayer = await this.init();

    avPlayer.url = url;
  }

  /**
   * 用于设置播放的文件描述符源。
   * @param url - 文件描述符源。
   */
  async setFdSrc(url: media.AVFileDescriptor) {
    const avPlayer = await this.init();
    avPlayer.fdSrc = url;
  }

  /**
   * 用于设置播放的数据源描述符。
   * @param url - 数据源描述符。
   */
  async setDataSrc(url: media.AVDataSrcDescriptor) {
    const avPlayer = await this.init();
    avPlayer.dataSrc = url;
  }

  /**
   * 用于播放多媒体。
   */
  async play() {
    const avPlayer = await this.init();
    avPlayer.play();
  }

  /**
   * 用于暂停播放。
   */
  async pause() {
    const avPlayer = await this.init();
    avPlayer.pause();
  }

  /**
   * 用于重置播放器
   */
  async reset() {
    await this.avPlayer?.reset()
  }

  /**
   * 用于释放多媒体播放器资源。
   */
  async release() {
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

  async quickPlay(url: string, callback?: Function)

  async quickPlay(url: media.AVFileDescriptor, callback?: Function)

  async quickPlay(url: media.AVDataSrcDescriptor, callback?: Function)

  /**
   * 快速播放
   * @param url 要播放的音频的url
   */
  async quickPlay(url: string | media.AVFileDescriptor | media.AVDataSrcDescriptor) {

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
}