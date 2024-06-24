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
import { picker } from '@kit.CoreFileKit';

export class ImageUtil {
  //新增保存到图库或用户选择的目录下
  //参考 https://developer.huawei.com/consumer/cn/forum/topic/0201150579990654020

  //新增图片压缩
  //参考 https://developer.huawei.com/consumer/cn/forum/topic/0203144584728486846?fid=0109140870620153026

  /**
   * 图片base64字符串转PixelMap
   * @param base64 图片base64字符串
   * @returns
   */
  static base64ToPixelMap(base64: string): Promise<image.PixelMap> {
    //将原始图片base64字符串转变为通过base64字符串
    const base64Str = StrUtil.replace(base64, new RegExp('data:image/\\w+;base64,'), '');
    //将通用base64字符串转变为arrayBuffer
    let arrayBuffer = Base64Util.decodeSync(base64Str).buffer;
    //将arrayBuffer转变为pixelMap
    let imageSource = image.createImageSource(arrayBuffer);
    let opts: image.DecodingOptions = { editable: false }
    return imageSource.createPixelMap(opts);
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
    return OutDTO.OKByDataRow<image.PixelMap>('成功转换~', res);
  }

  /**
   * 将buffer图片保存到图库
   * @param buffer
   */
  static async pickerSave(buffer: ArrayBuffer): Promise<OutDTO<string>> {
    const photoSaveOptions = new picker.PhotoSaveOptions(); // 创建文件管理器保存选项实例

    photoSaveOptions.newFileNames = ['efPickerSave ' + new Date().getTime() + 'jpg'] // 保存文件名（可选）

    const photoViewPicker = new picker.PhotoViewPicker;

    let photoSaveResult = await photoViewPicker.save(photoSaveOptions);

    let uri = photoSaveResult[0];

    let file = await fs.open(uri, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);

    await fs.write(file.fd, buffer);

    await fs.close(file.fd);

    return OutDTO.OK('保存图片成功~');
  }

  /**
   * PixelMap转图片base64字符串
   * @param pixelMap
   * @param format 目标格式,默认png,当前只支持jpg、webp和png。当传入的格式与文件格式不匹配，可能会导致生成错误的Base64字符串。
   * @returns
   */
  static async pixelMap2Base64Str(pixelMap: image.PixelMap, format: string = 'image/png'): Promise<string> {
    try {
      let packOpts: image.PackingOption = { format: format, quality: 100 }
      const arrayBuffer = await ImageUtil.packingFromPixelMap(pixelMap, packOpts);
      let base64Str: string = Base64Util.encodeToStrSync(new Uint8Array(arrayBuffer));
      let headStr = `data:${format};base64,`;
      if (!base64Str.startsWith(headStr)) {
        base64Str = headStr + base64Str
      }
      return base64Str;
    } catch (err) {
      return '';
    }
  }


  /**
   * 保存pixelMap到本地
   * @param pixelMap PixelMap
   * @param path 文件夹路径
   * @param name 文件名
   * @param format 目标格式。默认png。当前只支持jpg（image/jpeg）、webp和png（image/png）。
   * @returns
   */
  static async savePixelMap(pixelMap: image.PixelMap, path: string, name: string, format: string = 'image/png'): Promise<string> {
    try {
      if (!fs.accessSync(path)) {
        FileUtil.mkdirSync(path) //如果文件夹不存在就创建
      }
      let filePath = path + FileUtil.separator + name;
      let file = fs.openSync(filePath)
      let packOpts: image.PackingOption = { format: format, quality: 100 }
      await ImageUtil.packToFileFromPixelMap(pixelMap, file.fd, packOpts)
      fs.closeSync(file.fd) //关闭文件
      return filePath;
    } catch (err) {
      return '';
    }
  }


  /**
   * 保存ImageSource到本地
   * @param pixelMap PixelMap
   * @param path 文件夹路径
   * @param name 文件名
   * @param format 目标格式。默认png。当前只支持jpg（image/jpeg）、webp和png（image/png）。
   * @returns
   */
  static async saveImageSource(source: image.ImageSource, path: string, name: string, format: string = 'image/png'): Promise<string> {
    try {
      if (!fs.accessSync(path)) {
        fs.mkdirSync(path) //如果文件夹不存在就创建
      }
      let filePath = path + FileUtil.separator + name;
      let file = fs.openSync(filePath)
      let packOpts: image.PackingOption = { format: format, quality: 100 }
      await ImageUtil.packToFileFromImageSource(source, file.fd, packOpts)
      fs.closeSync(file.fd) //关闭文件
      return filePath;
    } catch (err) {
      return '';
    }
  }


  /**
   * 创建图片源实例
   * @param src（联合类型: string、number、ArrayBuffer、resourceManager.RawFileDescriptor）
   *   path string 图片路径，当前仅支持应用沙箱路径。当前支持格式有：.jpg .png .gif .bmp .webp RAW SVG10+ .ico11+。
   *   fd  number 文件描述符fd。
   *   buf  ArrayBuffer  图像缓冲区数组。
   *   rawfile resourceManager.RawFileDescriptor 图像资源文件的RawFileDescriptor。
   * options SourceOptions  图片属性，包括图片像素密度、像素格式和图片尺寸。
   *   sourceDensity  number ImageSource的密度。
   *   sourcePixelFormat  PixelMapFormat 图片像素格式。
   *   sourceSize  Size 图像像素大小。
   * @returns
   */
  static createImageSource(src: string | number | ArrayBuffer | resourceManager.RawFileDescriptor, options?: image.SourceOptions): image.ImageSource {
    if (typeof src === 'string') {
      if (options) {
        return image.createImageSource(src, options);
      } else {
        return image.createImageSource(src);
      }
    } else if (typeof src === 'number') {
      if (options) {
        return image.createImageSource(src, options);
      } else {
        return image.createImageSource(src);
      }
    } else if (src instanceof ArrayBuffer) {
      if (options) {
        return image.createImageSource(src, options);
      } else {
        return image.createImageSource(src);
      }
    } else {
      if (options) {
        return image.createImageSource(src, options);
      } else {
        return image.createImageSource(src);
      }
    }
  }


  /**
   * 以增量的方式创建图片源实例
   * @param buf ArrayBuffer  增量数据
   * @param options SourceOptions  图片属性，包括图片像素密度、像素格式和图片尺寸。
   *   sourceDensity  number ImageSource的密度。
   *   sourcePixelFormat  PixelMapFormat 图片像素格式。
   *   sourceSize  Size 图像像素大小。
   * @returns
   */
  static createIncrementalSource(buf: ArrayBuffer, options?: image.SourceOptions): image.ImageSource {
    if (options) {
      return image.CreateIncrementalSource(buf, options);
    } else {
      return image.CreateIncrementalSource(buf);
    }
  }


  /**
   * 图片压缩或重新打包，使用Promise形式返回结果。
   * @param source PixelMap-打包的PixelMap资源。
   * @param options 设置打包参数:
   *   format 目标格式。当前只支持jpg（image/jpeg）、webp 和 png（image/png）。
   *   quality JPEG编码中设定输出图片质量的参数，取值范围为0-100。
   *   bufferSize 接收编码数据的缓冲区大小，单位为Byte。默认为10MB。bufferSize需大于编码后图片大小。
   * @returns
   */
  static packingFromPixelMap(source: image.PixelMap, options: image.PackingOption): Promise<ArrayBuffer> {
    const imagePacker: image.ImagePacker = image.createImagePacker();
    return imagePacker.packing(source, options).finally(() => {
      imagePacker.release(); //释放
    });
  }


  /**
   * 图片压缩或重新打包，使用Promise形式返回结果。
   * @param source ImageSource-打包的图片源。
   * @param options 设置打包参数:
   *   format 目标格式。当前只支持jpg（image/jpeg）、webp 和 png（image/png）。
   *   quality JPEG编码中设定输出图片质量的参数，取值范围为0-100。
   *   bufferSize 接收编码数据的缓冲区大小，单位为Byte。默认为10MB。bufferSize需大于编码后图片大小。
   * @returns
   */
  static packingFromImageSource(source: image.ImageSource, options: image.PackingOption): Promise<ArrayBuffer> {
    const imagePacker: image.ImagePacker = image.createImagePacker();
    return imagePacker.packing(source as image.ImageSource, options).finally(() => {
      imagePacker.release(); //释放
    });
  }


  /**
   * 将PixelMap图片源编码后直接打包进文件。
   * @param source PixelMap-打包的PixelMap资源。
   * @param fd 文件描述符。
   * @param option 设置打包参数:
   *   format 目标格式。当前只支持jpg（image/jpeg）、webp 和 png（image/png）。
   *   quality JPEG编码中设定输出图片质量的参数，取值范围为0-100。
   *   bufferSize 接收编码数据的缓冲区大小，单位为Byte。默认为10MB。bufferSize需大于编码后图片大小。
   * @returns
   */
  static packToFileFromPixelMap(source: image.PixelMap, fd: number, options: image.PackingOption): Promise<void> {
    const imagePacker: image.ImagePacker = image.createImagePacker();
    return imagePacker.packToFile(source, fd, options).finally(() => {
      imagePacker.release(); //释放
    });
  }


  /**
   * 将ImageSource图片源编码后直接打包进文件。
   * @param source ImageSource-打包的图片源。
   * @param fd 文件描述符。
   * @param option 设置打包参数:
   *   format 目标格式。当前只支持jpg（image/jpeg）、webp 和 png（image/png）。
   *   quality JPEG编码中设定输出图片质量的参数，取值范围为0-100。
   *   bufferSize 接收编码数据的缓冲区大小，单位为Byte。默认为10MB。bufferSize需大于编码后图片大小。
   * @returns
   */
  static packToFileFromImageSource(source: image.ImageSource, fd: number, options: image.PackingOption): Promise<void> {
    const imagePacker: image.ImagePacker = image.createImagePacker();
    return imagePacker.packToFile(source, fd, options).finally(() => {
      imagePacker.release(); //释放
    });
  }


  /**
   * 用户获取resource目录下的media中的图片PixelMap
   * @param resource 例如：$r("app.media.icon"
   * @returns
   */
  static async getPixelMapFromMedia(resource: Resource): Promise<image.PixelMap> {
    let resourceManager = getContext().resourceManager;
    let uint8Array = resourceManager.getMediaContentSync(resource);
    return await ImageUtil.createImageSource(uint8Array.buffer).createPixelMap();
  }
}