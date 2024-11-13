/**
 Copyright 2024 csx - @yunkss/ef_ai

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
import { visionImageAnalyzer } from "@kit.VisionKit";
import { BusinessError } from "@kit.BasicServicesKit";

/**
 * @Author csx
 * @DateTime 2024/11/12 22:59
 * @TODO visionImageUtil
 */
@ComponentV2
export struct visionImageUtil {
  private visionImageAnalyzerController: visionImageAnalyzer.VisionImageAnalyzerController =
    new visionImageAnalyzer.VisionImageAnalyzerController();

  aboutToAppear(): void {
    this.visionImageAnalyzerController.on('imageAnalyzerVisibilityChange',
      (visibility: visionImageAnalyzer.ImageAnalyzerVisibility) => {
        console.info("DEMO_TAG", `imageAnalyzerVisibilityChange result: ${JSON.stringify(visibility)}`)
      })
    this.visionImageAnalyzerController.on('textAnalysis', (text: string) => {
      console.info("DEMO_TAG", `textAnalysis result: ${JSON.stringify(text)}`)
    })
    this.visionImageAnalyzerController.on('selectedTextChange', (selectedText: string) => {
      console.info("DEMO_TAG", `selectedTextChange result: ${JSON.stringify(selectedText)}`)
    })
    this.visionImageAnalyzerController.on('subjectAnalysis', (subjects: visionImageAnalyzer.Subject[]) => {
      console.info("DEMO_TAG", `subjectAnalysis result: ${JSON.stringify(subjects)}`)
    })
    this.visionImageAnalyzerController.on('selectedSubjectsChange', (subjects: visionImageAnalyzer.Subject[]) => {
      console.info("DEMO_TAG", `selectedSubjectsChange result: ${JSON.stringify(subjects)}`)
    })
    this.visionImageAnalyzerController.on('analyzerFailed', (error: BusinessError) => {
      console.error("DEMO_TAG", `analyzerFailed result: ${JSON.stringify(error)}`)
    })
  }

  build() {
    Stack() {
      // 需要替换您自己的资源图片，存放在resources/base/media目录下
      Image($r('app.media.axiosLoading'), {
        types: [ImageAnalyzerType.TEXT, ImageAnalyzerType.SUBJECT, ImageAnalyzerType.OBJECT_LOOKUP],
        aiController: this.visionImageAnalyzerController
      })
        .width('100%')
        .height('100%')
        .enableAnalyzer(true)
        .objectFit(ImageFit.Contain)
    }.width('100%').height('100%')
  }

  aboutToDisappear(): void {
    this.visionImageAnalyzerController.off('imageAnalyzerVisibilityChange')
    this.visionImageAnalyzerController.off('textAnalysis')
    this.visionImageAnalyzerController.off('selectedTextChange')
    this.visionImageAnalyzerController.off('subjectAnalysis')
    this.visionImageAnalyzerController.off('selectedSubjectsChange')
    this.visionImageAnalyzerController.off('analyzerFailed')
  }
}