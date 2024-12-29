import { media } from '@kit.MediaKit'

export enum SAPlayMode {
  /**
   * 列表播放
   */
  order,
  /**
   * 单曲播放
   */
  single,
  /**
   * 重复播放
   */
  repeat,
  /**
   * 随机播放
   */
  random
}

/**
 * 播放模式相关的图标和文字
 */
export interface SAPlayModeIcon {
  url: ResourceStr
  mode: SAPlayMode
  name: string
}

// 支持的播放的资源url
export type SongItemUrl = string | media.AVFileDescriptor | media.AVDataSrcDescriptor