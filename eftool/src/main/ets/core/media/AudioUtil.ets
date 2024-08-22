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

import audio from '@ohos.multimedia.audio';
import { AuthUtil } from '@yunkss/ef_ui';

/**
 * @Author csx
 * @DateTime 2024/6/3 19:12
 * @TODO AudioUtil  音频工具类(暂未开发完,需要迁移到media后完善)
 */
export class AudioUtil {
  //视频 https://gitee.com/harmonyos_samples/video-show

  /**
   * 音频捕捉器
   */
  private static audioCapturer: audio.AudioCapturer | undefined = undefined;

  /**
   * 初始化音频捕捉器
   */
  static async init(readDataCallback: (buffer: ArrayBuffer) => void): Promise<string> {
    let isAuth = await AuthUtil.checkPermissions('ohos.permission.MICROPHONE');
    if (!isAuth) {
      let res = await AuthUtil.reqPermissions('ohos.permission.MICROPHONE');
      if (res < 0) {
        return '用户取消授权录音权限~';
      }
    }
    let audioStreamInfo: audio.AudioStreamInfo = {
      samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_48000, // 采样率
      channels: audio.AudioChannel.CHANNEL_2, // 通道
      sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE, // 采样格式
      encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW // 编码格式
    };
    let audioCapturerInfo: audio.AudioCapturerInfo = {
      source: audio.SourceType.SOURCE_TYPE_MIC, // 音源类型
      capturerFlags: 0 // 音频采集器标志
    };
    let audioCapturerOptions: audio.AudioCapturerOptions = {
      streamInfo: audioStreamInfo,
      capturerInfo: audioCapturerInfo
    };
    //赋值
    AudioUtil.audioCapturer = await audio.createAudioCapturer(audioCapturerOptions);
    if (AudioUtil.audioCapturer !== undefined) {
      (AudioUtil.audioCapturer as audio.AudioCapturer).on('readData', readDataCallback);
      return '初始化音频采集器成功~';
    } else {
      return '初始化音频采集器失败~';
    }
  }


  /**
   * 启动音频采集
   * @returns
   */
  static async startRecording(): Promise<string> {
    if (AudioUtil.audioCapturer !== undefined) {
      let stateGroup = [audio.AudioState.STATE_PREPARED, audio.AudioState.STATE_PAUSED, audio.AudioState.STATE_STOPPED];
      if (stateGroup.indexOf((AudioUtil.audioCapturer as audio.AudioCapturer).state.valueOf()) === -1) {
        // 当且仅当状态为STATE_PREPARED、STATE_PAUSED和STATE_STOPPED之一时才能启动采集
        return '当且仅当状态为STATE_PREPARED、STATE_PAUSED和STATE_STOPPED之一时才能启动采集';
      }
      // 启动采集
      await (AudioUtil.audioCapturer as audio.AudioCapturer).start();
      return '音频采集器已启动~';
    } else {
      return '未创建音频捕捉器,请先调用init方法初始化~';
    }
  }

  /**
   * 停止音频采集
   * @returns
   */
  static async stopRecording(): Promise<string> {
    if (AudioUtil.audioCapturer !== undefined) {
      // 只有采集器状态为STATE_RUNNING或STATE_PAUSED的时候才可以停止
      if ((AudioUtil.audioCapturer as audio.AudioCapturer).state.valueOf() !== audio.AudioState.STATE_RUNNING &&
        (AudioUtil.audioCapturer as audio.AudioCapturer).state.valueOf() !== audio.AudioState.STATE_PAUSED) {
        return '音频采集器未启动或者已暂停';
      }
      //停止采集
      await (AudioUtil.audioCapturer as audio.AudioCapturer).stop();
      //销毁
      await AudioUtil.release();
      return '音频采集器已停止~';
    } else {
      return '未创建音频捕捉器,请先调用init方法初始化~';
    }
  }

  /**
   * 销毁释放音频采集器
   */
  static async release() {
    // 采集器状态不是STATE_RELEASED或STATE_NEW状态，才能release
    if ((AudioUtil.audioCapturer as audio.AudioCapturer).state.valueOf() === audio.AudioState.STATE_RELEASED ||
      (AudioUtil.audioCapturer as audio.AudioCapturer).state.valueOf() === audio.AudioState.STATE_NEW) {
      return;
    }
    //释放资源
    await (AudioUtil.audioCapturer as audio.AudioCapturer).release();
  }
}