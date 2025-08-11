import { LayeredDrawableDescriptor } from "@kit.ArkUI";

/**
 Copyright 2024 csx -

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
 * 分层图片工具类
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_ui
 */
export class ImgLayerUtil {
  /**
   * 获取分层图片图片
   * @param ctx  上下文
   * @param fg   分层前景图
   * @param bg   分层背景图
   */
  public static async getLayerImg(ctx: UIContext, fg: Resource, bg: Resource) {
    // 创建分层图标
    const foreground = await ImgLayerUtil.getDrawableDescriptor(ctx, fg);
    const background = await ImgLayerUtil.getDrawableDescriptor(ctx, bg);
    return new LayeredDrawableDescriptor(foreground, background);
  }

  /**
   * 获取DrawableDescriptor
   * @param ctx
   * @param resource
   * @returns
   */
  private static async getDrawableDescriptor(ctx: UIContext,
    resource: Resource): Promise<DrawableDescriptor | undefined> {
    const resManager = ctx.getHostContext()?.resourceManager;
    if (!resManager) {
      return undefined;
    }
    return (resManager.getDrawableDescriptor(resource.id)) as DrawableDescriptor;
  }
}