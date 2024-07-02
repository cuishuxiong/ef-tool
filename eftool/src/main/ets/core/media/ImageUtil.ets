import fs from '@ohos.file.fs';

/**
 * @Author csx
 * @DateTime 2024/6/6 00:17
 * @TODO ImageUtil  图片处理类
 */
import { image } from '@kit.ImageKit';
import { Base64Util } from '../util/Base64Util';
import { StrUtil } from '../util/StrUtil';
import { FileUtil } from './FileUtil';
import { resourceManager } from '@kit.LocalizationKit';
import { OutDTO } from '../base/OutDTO';
import { fileIo, picker } from '@kit.CoreFileKit';
import { buffer } from '@kit.ArkTS';
import { photoAccessHelper } from '@kit.MediaLibraryKit';

export class ImageUtil {
  //新增保存到图库或用户选择的目录下
  //参考 https://developer.huawei.com/consumer/cn/forum/topic/0201150579990654020

  //新增图片压缩
  //参考 https://developer.huawei.com/consumer/cn/forum/topic/0203144584728486846?fid=0109140870620153026


  //背景颜色根据图片颜色更改  https://gitee.com/harmonyos_samples/effect-kit

  //水印  https://gitee.com/harmonyos_samples/watermark

  /**
   * 将buffer图片保存到选择路径
   * @param buffer  图片buffer
   * @returns 保存结果
   */
  static async pickerSave(buffer: ArrayBuffer): Promise<OutDTO<string>> {
    // 创建文件管理器保存选项实例
    const photoSaveOptions = new picker.PhotoSaveOptions();
    //设置默认文件名
    photoSaveOptions.newFileNames = ['efPickerSave' + new Date().getTime() + '.jpg'] // 保存文件名（可选）
    //创建照片选择器
    const photoViewPicker = new picker.PhotoViewPicker;
    //来气保存操作
    let photoSaveResult = await photoViewPicker.save(photoSaveOptions);
    //获取选择保存路径
    let uri = photoSaveResult[0];
    //打开文件
    let file = await fs.open(uri, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
    //写入
    await fs.write(file.fd, buffer);
    //释放
    await fs.close(file.fd);
    //返回结果
    return OutDTO.OK('保存图片成功~');
  }

  /**
   * 保存图片到图库
   * @param buffer 图片buffer
   * @returns 保存结果
   */
  static async pickerSaveGallery(buffer: ArrayBuffer): Promise<OutDTO<string>> {
    const context = getContext();
    let helper = photoAccessHelper.getPhotoAccessHelper(context);
    // onClick触发后10秒内通过createAsset接口创建图片文件，10秒后createAsset权限收回。
    let uri = await helper.createAsset(photoAccessHelper.PhotoType.IMAGE, 'png');
    // 使用uri打开文件，可以持续写入内容，写入过程不受时间限制
    let file = await fileIo.open(uri, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE);
    // 写入文件
    await fileIo.write(file.fd, buffer);
    // 关闭文件
    await fileIo.close(file.fd);
    //返回结果
    return OutDTO.OK('保存图片到图库成功~');
  }

  /**
   * 图片base64字符串转PixelMap
   * @param base64 图片base64字符串
   * @returns 转换后的结果
   */
  static async base64ToPixelMap(base64: string): Promise<OutDTO<image.PixelMap>> {
    //将原始图片base64字符串转变为通过base64字符串
    const base64Str = StrUtil.replace(base64, new RegExp('data:image/\\w+;base64,'), '');
    //将通用base64字符串转变为arrayBuffer
    let arrayBuffer = Base64Util.decodeSync(base64Str).buffer;
    //将arrayBuffer转变为pixelMap
    let imageSource = image.createImageSource(arrayBuffer);
    let opts: image.DecodingOptions = { editable: false }
    //创建PixelMap
    let res = await imageSource.createPixelMap(opts);
    //返回结果
    return OutDTO.OKByDataRow<image.PixelMap>('图片base64字符串转PixelMap成功~', res);
  }

  /**
   * buffer转PixelMap
   * @param buffer
   * @returns
   */
  static async arrayBuffer2PixelMap(buffer: ArrayBuffer): Promise<OutDTO<image.PixelMap>> {
    let imageSource: image.ImageSource = image.createImageSource(buffer);
    let res = await imageSource.createPixelMap({
      editable: false
    });
    return OutDTO.OKByDataRow<image.PixelMap>('buffer转PixelMap成功~', res);
  }

  /**
   * PixelMap转图片base64字符串
   * @param pixelMap
   * @param format 目标格式,默认png,只支持jpg、webp和png。
   * @returns 转换后的结果
   */
  static async pixelMap2Base64Str(pixelMap: image.PixelMap, format: string = 'image/png'): Promise<OutDTO<string>> {
    try {
      //创建操作对象
      let packOpts: image.PackingOption = { format: format, quality: 100 }
      //pixelMap转arrayBuffer
      const arrayBuffer = await ImageUtil.packingFromPixelMap(pixelMap, format);
      if (arrayBuffer.getSuccess()) {
        //转base64
        let base64Str: string = Base64Util.encodeToStrSync(new Uint8Array(arrayBuffer.getDataRow()));
        //头
        let headStr = `data:${format};base64,`;
        //如果没有头则拼接
        if (!base64Str.startsWith(headStr)) {
          base64Str = headStr + base64Str
        }
        return OutDTO.OKByDataRow('PixelMap转图片base64字符串成功', base64Str);
      }
      return OutDTO.Error('PixelMap转图片base64字符串失败~');
    } catch (err) {
      return OutDTO.Error(err);
    }
  }

  /**
   * 保存pixelMap到本地
   * @param pixelMap PixelMap
   * @param path 文件夹路径
   * @param name 文件名
   * @param format 目标格式。默认png。只支持jpg、webp、png
   * @returns
   */
  static async savePixelMap(pixelMap: image.PixelMap, path: string, name: string, format: string = 'image/png'): Promise<OutDTO<string>> {
    try {
      //如果文件夹不存在就创建
      if (!fs.accessSync(path)) {
        fs.mkdirSync(path)
      }
      //拼接图片全路径
      let filePath = path + FileUtil.separator + name;
      //打开图片
      let file = fs.openSync(filePath)
      //保存图片
      let result = await ImageUtil.pack2FileFromPixelMap(pixelMap, file.fd, format)
      //关闭文件
      fs.closeSync(file.fd)
      //判断是否成功
      if (result.getSuccess()) {
        return OutDTO.OKByDataRow('保存图片成功~', filePath);
      } else {
        return OutDTO.Error('保存图片失败~');
      }
    } catch (err) {
      return OutDTO.Error('保存图片失败~' + err);
    }
  }

  /**
   * 保存ImageSource到本地
   * @param pixelMap 图片
   * @param path 文件夹路径
   * @param name 文件名
   * @param format 目标格式。默认png。只支持jpg、webp、png
   * @returns
   */
  static async saveImageSource(source: image.ImageSource, path: string, name: string, format: string = 'image/png'): Promise<OutDTO<string>> {
    try {
      //如果文件夹不存在就创建
      if (!fs.accessSync(path)) {
        fs.mkdirSync(path)
      }
      //拼接图片全路径
      let filePath = path + FileUtil.separator + name;
      //打开图片
      let file = fs.openSync(filePath)
      //保存图片
      let result = await ImageUtil.pack2FileFromImageSource(source, file.fd, format)
      //关闭文件
      fs.closeSync(file.fd)
      //判断是否成功
      if (result.getSuccess()) {
        return OutDTO.OKByDataRow('保存图片成功~', filePath);
      } else {
        return OutDTO.Error('保存图片失败~');
      }
    } catch (err) {
      return OutDTO.Error('保存图片失败~' + err);
    }
  }

  /**
   * 创建图片源实例
   * @param src
   * options SourceOptions  图片属性，包括图片像素密度、像素格式和图片尺寸。
   * @returns
   */
  static createImageSource(target: string | number | ArrayBuffer | resourceManager.RawFileDescriptor, options?: image.SourceOptions): OutDTO<image.ImageSource> {
    if (typeof target === 'string') {
      if (options) {
        return OutDTO.OKByDataRow('创建图片资源成功~', image.createImageSource(target, options));
      } else {
        return OutDTO.OKByDataRow('创建图片资源成功~', image.createImageSource(target));
      }
    } else if (typeof target === 'number') {
      if (options) {
        return OutDTO.OKByDataRow('创建图片资源成功~', image.createImageSource(target, options));
      } else {
        return OutDTO.OKByDataRow('创建图片资源成功~', image.createImageSource(target));
      }
    } else if (target instanceof ArrayBuffer) {
      if (options) {
        return OutDTO.OKByDataRow('创建图片资源成功~', image.createImageSource(target, options));
      } else {
        return OutDTO.OKByDataRow('创建图片资源成功~', image.createImageSource(target));
      }
    } else {
      if (options) {
        return OutDTO.OKByDataRow('创建图片资源成功~', image.createImageSource(target, options));
      } else {
        return OutDTO.OKByDataRow('创建图片资源成功~', image.createImageSource(target));
      }
    }
  }

  /**
   * 将PixelMap图片写入文件
   * @param source PixelMap图片
   * @param fd 文件描述符
   * @param format  目标格式。只支持jpeg、webp、png
   * @returns
   */
  static async pack2FileFromPixelMap(source: image.PixelMap, fd: number, format: string = 'image/png'): Promise<OutDTO<string>> {
    //创建图像编码ImagePacker对象
    const imagePacker: image.ImagePacker = image.createImagePacker();
    //打包参数
    let packOpts: image.PackingOption = { format: format, quality: 98 };
    //打包
    await imagePacker.packToFile(source, fd, packOpts);
    //释放资源
    imagePacker.release();
    //返回
    return OutDTO.OK('图片保存文件成功~');
  }

  /**
   * PixelMap转ArrayBuffer
   * @param target PixelMap
   * @param format 目标格式。只支持jpg、webp 、 png
   * @returns
   */
  static async packingFromPixelMap(target: image.PixelMap, format: string = 'image/png'): Promise<OutDTO<ArrayBuffer>> {
    const imagePacker: image.ImagePacker = image.createImagePacker();
    //转换
    let res = await imagePacker.packing(target, { format: format, quality: 98 });
    //释放资源
    imagePacker.release();
    //返回
    return OutDTO.OKByDataRow('PixelMap转ArrayBuffer成功~', res);
  }

  /**
   * 将ImageSource图片写入文件
   * @param source ImageSource图片
   * @param fd 文件描述符
   * @param format  目标格式。只支持jpeg、webp、png
   * @returns
   */
  static async pack2FileFromImageSource(source: image.ImageSource, fd: number, format: string = 'image/png'): Promise<OutDTO<string>> {
    //创建图像编码ImagePacker对象
    const imagePacker: image.ImagePacker = image.createImagePacker();
    //打包参数
    let packOpts: image.PackingOption = { format: format, quality: 98 };
    //打包
    await imagePacker.packToFile(source, fd, packOpts);
    //释放资源
    imagePacker.release();
    //返回
    return OutDTO.OK('图片保存文件成功~');
  }

  /**
   * 获取resource目录下media中的图片转换成PixelMap
   * @param resource 资源
   * @returns
   */
  static async getPixelMapFromMedia(resource: Resource): Promise<OutDTO<image.PixelMap>> {
    //获取资源管理器
    let resourceManager = getContext().resourceManager;
    //获取图片uint8数组
    let uint8Array = resourceManager.getMediaContentSync(resource);
    //转换
    let pm = await ImageUtil.arrayBuffer2PixelMap(buffer.from(uint8Array).buffer);
    if (pm.getSuccess()) {
      return OutDTO.OKByDataRow('获取资源文件中图片成功~', pm.getDataRow());
    }
    return OutDTO.ErrorByDataRow('获取资源文件中图片失败~', pm.getDataRow());
  }
}