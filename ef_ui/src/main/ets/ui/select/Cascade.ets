/**
 * @Author csx
 * @DateTime 2024/3/26 10:02:02
 * @TODO Cascade  级联选择器
 */
import { UiConst } from '@yunkss/ef_core'
import { util } from '@kit.ArkTS'
import { BusinessError } from '@kit.BasicServicesKit';
import { ToastUtil } from '../prompt/ToastUtil';

/**
 * 下划线样式
 */
@Extend(Text)
function cascadeUnderLine(selected: boolean) {
  .height(UiConst.VP_3)
  .backgroundColor(selected ? "#1989fa" : "fff")
  .width(UiConst.VP_45)
  .margin({ top: UiConst.NUMBER_5 })
}

/**
 * 顶部省市区文字样式
 * @param selected
 */
@Extend(Text)
function txtColor(selected: boolean, fontSize: number | string) {
  .fontSize(fontSize)
  .fontColor(selected ? "#969799" : "#000")
  .fontWeight(selected ? FontWeight.Normal : FontWeight.Bold)
}

/**
 * 省市区list样式
 */
@Extend(Text)
function cityTxtColor() {
  .fontSize(UiConst.FONT_16)
  .textAlign(TextAlign.Start)
  .padding({ top: UiConst.NUMBER_3, bottom: UiConst.NUMBER_3 })
  // .backgroundColor("#f7f8fa")
}


@Component
export struct Cascade {
  //反会给上一级的数据
  @Link callCity: string
  //是否显示
  @Link show: boolean
  //显示城市
  @State private showCity: boolean = false
  //显示区域
  @State private showArea: boolean = false
  private provinceList: Array<City> = new Array();
  //点击选择的数据
  @State private selectData: cascadeCity = new cascadeCity();
  //当前list显示的数据
  @State private currentList: Array<City> = new Array();
  //当前省市区选择的下标
  @State private selectIndex: number = 0;
  //顶部已选择省市区字体大小
  @State titleFontSize: number | string = UiConst.FONT_16;

  aboutToAppear() {
    if (this.provinceList.length == 0) {
      this.init();
    }
  }

  /**
   * 初始化城市数据
   */
  private init() {
    try {
      //获取区域数据
      let jsonStr = getContext().resourceManager.getRawFileContentSync("area.json");
      //转码
      let textCoder = util.TextDecoder.create('utf-8', { ignoreBOM: true });
      let vStr = textCoder.decodeWithStream(jsonStr, { stream: false });
      //获取数据
      this.provinceList = JSON.parse(vStr) as Array<City>;
      this.provinceList.forEach(province => {
        //默认将省数据赋值给当前listview对应的数据
        this.currentList.push(new City(province.name, province.code));
      })
    } catch (error) {
      let code = (error as BusinessError).code;
      let message = (error as BusinessError).message;
      ToastUtil.showToast(`获取区域数据出错, 错误编码: ${code}, 原因: ${message}.`);
    }
  }

  /**
   * 获取城市数据
   * @param prevCode 省code
   * @returns
   */
  private getCityData(prevCode: string): Array<City> {
    return (this.provinceList.filter((pro: City) => pro.code == prevCode).pop() as City).children;
  }

  /**
   * 获取区县数据
   * @param prevCode 省code
   * @param cityCode 市code
   * @returns
   */
  private getAreaData(prevCode: string, cityCode: string): Array<City> {
    return ((this.provinceList.filter((pro: City) => pro.code == prevCode)
      .pop() as City).children.filter((city: City) => city.code == cityCode).pop() as City).children;
  }

  /**
   * 重置数据
   */
  private reset() {
    this.show = !this.show;
    this.showCity = false;
    this.showArea = false;
    this.selectData = new cascadeCity();
    this.currentList = new Array();
    this.selectIndex = 0;
    this.currentList = this.getProvinceData();
  }

  /**
   * 获取省数据
   * @returns
   */
  private getProvinceData(): Array<City> {
    let provList: Array<City> = new Array();
    this.provinceList.forEach(province => {
      //默认将省数据赋值给当前listview对应的数据
      provList.push(new City(province.name, province.code));
    })
    return provList;
  }

  build() {
    Panel(this.show) {
      //顶部
      Column() {
        Row() {
          Text('请选择地区').fontWeight('bold').fontSize(UiConst.FONT_16)
          Image(getContext().resourceManager.getMediaBase64ByNameSync("close"))
            .width(UiConst.VP_15)
            .height(UiConst.VP_15)
            .onClick(() => {
              this.reset()
            })
        }
        .width('100%')
        .padding({
          top: UiConst.NUMBER_15,
          left: UiConst.NUMBER_20,
          right: UiConst.NUMBER_25,
          bottom: UiConst.NUMBER_10
        })
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
      }

      //中部选择区域
      Row() {
        //省市区
        Column() {
          if (this.selectIndex == 0 && !this.selectData.provinceName) {
            Text("请选择").txtColor(true, this.titleFontSize)
            Text(" ").cascadeUnderLine(true)
          } else {
            Text(this.selectData.provinceName).txtColor(false, this.titleFontSize).onClick(() => {
              this.selectIndex = 0;
              this.currentList = this.getProvinceData();
            })
            Text(" ").cascadeUnderLine(this.selectIndex == 0)
          }
        }.margin({ right: UiConst.NUMBER_20 })

        //市
        if (this.showCity) {
          Column() {
            if (this.selectIndex === 1 && !this.selectData.cityName) {
              Text("请选择").txtColor(true, this.titleFontSize)
              Text(" ").cascadeUnderLine(true)
            } else {
              Text(this.selectData.cityName).txtColor(false, this.titleFontSize).onClick(() => {
                this.selectIndex = 1;
                this.currentList = this.getCityData(this.selectData.provinceCode);
              })
              Text(" ").cascadeUnderLine(this.selectIndex == 1)
            }
          }.margin({ right: UiConst.NUMBER_20 })
        }
        //区
        if (this.showArea) {
          //区域
          Column() {
            if (this.selectIndex === 2 && !this.selectData.areaName) {
              Text("请选择").txtColor(true, this.titleFontSize)
              Text(" ").cascadeUnderLine(true)
            } else {
              Text(this.selectData.areaName).txtColor(false, this.titleFontSize).onClick(() => {
                this.selectIndex = 2;
                this.currentList = this.getAreaData(this.selectData.provinceCode, this.selectData.cityCode);
              })
              Text(" ").cascadeUnderLine(this.selectIndex == 2)
            }
          }
        }
      }
      .width("100%")
      .margin({ top: UiConst.NUMBER_10, left: UiConst.VP_35 })
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)

      Row() {
        List({ space: UiConst.NUMBER_5, initialIndex: 0 }) {
          ForEach(this.currentList, (item: City) => {
            ListItem() {
              Row() {
                if (this.selectIndex === 0) {
                  Text(item.name)
                    .cityTxtColor()
                    .fontColor(item.code == this.selectData.provinceCode ? "#1989fa" : "#323233")
                  if (item.code == this.selectData.provinceCode) {
                    Image(getContext().resourceManager.getMediaBase64ByNameSync("ok")).width(UiConst.VP_15).height(UiConst.VP_15)
                  }
                }
                if (this.selectIndex === 1) {
                  Text(item.name)
                    .cityTxtColor()
                    .fontColor(item.code == this.selectData.cityCode ? "#1989fa" : "#323233")
                  if (item.code == this.selectData.cityCode) {
                    Image(getContext().resourceManager.getMediaBase64ByNameSync("ok")).width(UiConst.VP_15).height(UiConst.VP_15)
                  }
                }
                if (this.selectIndex === 2) {
                  Text(item.name)
                    .cityTxtColor()
                    .fontColor(item.code == this.selectData.areaCode ? "#1989fa" : "#323233")
                  if (item.code == this.selectData.areaCode) {
                    Image(getContext().resourceManager.getMediaBase64ByNameSync("ok")).width(UiConst.VP_15).height(UiConst.VP_15)
                  }
                }
              }
              .width("100%")
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .padding({ right: UiConst.NUMBER_20 })
            }
            .margin({ top: UiConst.NUMBER_5, bottom: UiConst.NUMBER_5 })
            .onClick(() => {
              //点击赋值选中的数据
              if (this.selectIndex === 0) {
                this.selectData.provinceName = item.name;
                this.selectData.provinceCode = item.code;
                this.selectData.cityCode = "";
                this.selectData.cityName = "";
                this.selectData.areaCode = "";
                this.selectData.areaName = "";
                this.showCity = true;
                setTimeout(() => {
                  this.currentList = this.getCityData(item.code);
                  this.selectIndex = 1;
                }, 200)
              }
              if (this.selectIndex === 1) {
                this.selectData.cityName = item.name;
                this.selectData.cityCode = item.code;
                this.selectData.areaCode = "";
                this.selectData.areaName = "";
                this.showArea = true;
                setTimeout(() => {
                  this.currentList = this.getAreaData(this.selectData.provinceCode, item.code);
                  this.selectIndex = 2;
                }, 200)
              }
              if (this.selectIndex === 2) {
                this.selectData.areaName = item.name;
                this.selectData.areaCode = item.code;
                //赋值
                this.callCity =
                  this.selectData.provinceName + "/" + this.selectData.cityName + "/" + this.selectData.areaName;
                //赋值后初始化数据
                this.reset()
              }
            })
          }, (item: City) => item.code)
        }
        .listDirection(Axis.Vertical) // 排列方向
        .edgeEffect(EdgeEffect.None)
        .width('100%')
        .scrollBar(BarState.Auto)
        .scrollBarWidth(UiConst.NUMBER_3)
        .scrollBarColor(UiConst.PRIMARY_COLOR)
        .padding({ bottom: UiConst.NUMBER_10 })
      }
      .height('100%')
      .width("100%")
      .alignItems(VerticalAlign.Top)
      .padding({ left: UiConst.NUMBER_20 })
    }
    .type(PanelType.CUSTOM)
    .dragBar(false)
    .height(PanelHeight.WRAP_CONTENT)
    .customHeight(600)
    // .backgroundColor("#22000000")
    // .backgroundMask(UiConst.DIALOG_CANCEL_COLOR)
    .position({ x: 0, y: 0 })
  }
}

/**
 * 回调的选中数据
 */
class cascadeCity {
  provinceName: string = '';
  provinceCode: string = '';
  cityName: string = '';
  cityCode: string = '';
  areaName: string = '';
  areaCode: string = '';
}

/**
 * 选择器所需的数据
 */
class City {
  name: string;
  code: string;
  children: Array<City> = new Array<City>();

  constructor(name: string, code: string) {
    this.name = name;
    this.code = code;
  }
}