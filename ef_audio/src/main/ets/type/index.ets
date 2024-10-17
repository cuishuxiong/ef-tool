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


/**
 * @Author wsy
 * @DateTime 2024/10/13 0:11
 * @TODO index 类用于管理多媒体播放器相关类型
 */


/**
 * 定义一个名为 EfAVPlayerState 的联合类型，用于表示多媒体播放器的不同状态
 */
export type EfAVPlayerState = 'idle' | 'initialized' | 'prepared' | 'playing' | 'paused' | 'completed' | 'stopped'
  | 'released' | 'error';

/**
 * 定义一个名为 EFPlayOptions 的接口，表示播放选项。
 */
export interface EFPlayOptions {
  /**
   * 可选属性，表示是否立即播放，默认为 undefined
   */
  immediately?: boolean
  /**
   * 可选属性，表示是否循环播放，默认为 undefined
   */
  loop?: boolean
  /**
   * 可选属性，指定的相对音量大小，取值范围为[0.00-1.00]，1表示最大音量
   */
  volume?: number
}