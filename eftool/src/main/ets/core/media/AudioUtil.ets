import audio from '@ohos.multimedia.audio';
import { ToastUtil } from '../../ui/prompt/ToastUtil';
import { AuthUtil } from '../auth/AuthUtil';
import { OutDTO } from '../base/OutDTO';

/**
 * @Author csx
 * @DateTime 2024/6/3 19:12
 * @TODO AudioCapturerUtil  音频工具类
 */
export class AudioCapturerUtil {
  /**
   * 音频捕捉器
   */
  private static audioCapturer: audio.AudioCapturer | undefined = undefined;

  /**
   * 初始化音频捕捉器
   */
  static async init(readDataCallback: (buffer: ArrayBuffer) => void): Promise<OutDTO<string>> {
    let isAuth = await AuthUtil.checkPermissions('ohos.permission.MICROPHONE');
    if (!isAuth) {
      let res = await AuthUtil.reqPermissions('ohos.permission.MICROPHONE');
      if (res < 0) {
        return OutDTO.Error('用户取消授权录音权限~');
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
    AudioCapturerUtil.audioCapturer = await audio.createAudioCapturer(audioCapturerOptions);
    if (AudioCapturerUtil.audioCapturer !== undefined) {
      (AudioCapturerUtil.audioCapturer as audio.AudioCapturer).on('readData', readDataCallback);
      return OutDTO.OK('初始化音频采集器成功~');
    } else {
      return OutDTO.Error('初始化音频采集器失败~');
    }
  }


  /**
   * 启动音频采集
   * @returns
   */
  static async startRecording(): Promise<OutDTO<string>> {
    if (AudioCapturerUtil.audioCapturer !== undefined) {
      let stateGroup = [audio.AudioState.STATE_PREPARED, audio.AudioState.STATE_PAUSED, audio.AudioState.STATE_STOPPED];
      if (stateGroup.indexOf((AudioCapturerUtil.audioCapturer as audio.AudioCapturer).state.valueOf()) === -1) {
        // 当且仅当状态为STATE_PREPARED、STATE_PAUSED和STATE_STOPPED之一时才能启动采集
        return OutDTO.Error('当且仅当状态为STATE_PREPARED、STATE_PAUSED和STATE_STOPPED之一时才能启动采集');
      }
      // 启动采集
      await (AudioCapturerUtil.audioCapturer as audio.AudioCapturer).start();
      return OutDTO.OK('音频采集器已启动~');
    } else {
      return OutDTO.Error('未创建音频捕捉器,请先调用init方法初始化~');
    }
  }

  /**
   * 停止音频采集
   * @returns
   */
  static async stopRecording(): Promise<OutDTO<string>> {
    if (AudioCapturerUtil.audioCapturer !== undefined) {
      // 只有采集器状态为STATE_RUNNING或STATE_PAUSED的时候才可以停止
      if ((AudioCapturerUtil.audioCapturer as audio.AudioCapturer).state.valueOf() !== audio.AudioState.STATE_RUNNING && (AudioCapturerUtil.audioCapturer as audio.AudioCapturer).state.valueOf() !== audio.AudioState.STATE_PAUSED) {
        return OutDTO.Error('音频采集器未启动或者已暂停');
      }
      //停止采集
      await (AudioCapturerUtil.audioCapturer as audio.AudioCapturer).stop();
      //销毁
      await AudioCapturerUtil.release();
      return OutDTO.OK('音频采集器已停止~');
    } else {
      return OutDTO.Error('未创建音频捕捉器,请先调用init方法初始化~');
    }
  }

  /**
   * 销毁释放音频采集器
   */
  static async release() {
    // 采集器状态不是STATE_RELEASED或STATE_NEW状态，才能release
    if ((AudioCapturerUtil.audioCapturer as audio.AudioCapturer).state.valueOf() === audio.AudioState.STATE_RELEASED || (AudioCapturerUtil.audioCapturer as audio.AudioCapturer).state.valueOf() === audio.AudioState.STATE_NEW) {
      ToastUtil.showToast('音频采集器已销毁');
      return;
    }
    //释放资源
    await (AudioCapturerUtil.audioCapturer as audio.AudioCapturer).release();
  }
}