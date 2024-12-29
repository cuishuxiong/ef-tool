
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