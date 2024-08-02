import { AbilityConstant, UIAbility, Want, wantAgent } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { efRcpParams, Logger, NotificationUtil, ImmersionUtil, efAxiosParams, efRcpSecurityParam } from '@yunkss/eftool'

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    efRcpParams.baseURL = "http://192.168.0.100:18088";
    efRcpParams.loadingTxt = '小的快马加鞭...';
    efRcpSecurityParam.certContent = '111111111';
    // efRcpParams.isLogger = false;
    // efRcpParams.isLoading = false;

    efAxiosParams.loadingTxt = '小的快马加鞭...';
    efAxiosParams.baseURL = 'http://192.168.0.100:18088';
    efAxiosParams.isAllEncrypt = false;
    efAxiosParams.sm2PubKey =
      '04ba3bc3c5834d9ad1a7d81c4b49cf1209d2f28e4a97c73b75d6561792a2bfafe811e0284692006b0ce1b51f8aadfd65241d80eb979365048253408f5d705ec17b';
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    Logger.init('API11TeTest', this.context);
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    //初始化
    let imm = new ImmersionUtil();
    windowStage.loadContent('pages/RcpPage', (err, data) => {
      //调用沉浸式设置方法
      imm.immersiveWindow(windowStage);
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  /**
   * 监听通知传入的want
   * @param want
   * @param launchParam
   */
  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    NotificationUtil.readOrRemoveNotice(want);
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
