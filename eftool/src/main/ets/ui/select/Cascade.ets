/**
 * @Author csx
 * @DateTime 2024/2/6 10:02:02
 * @TODO Cascade  级联选择器
 */
import { pcaJSON } from '../../core/const/CityConst'
import { UiConst } from '../../core/const/UiConst'
import { JSONUtil } from '../../core/util/JSONUtil'
/**
 * 下划线样式
 */
@Extend(Text) function cascadeUnderLine(selected: boolean) {
  .height(UiConst.VP_3).backgroundColor(selected ? "#1989fa" : "fff").width(UiConst.VP_45).margin({ top: UiConst.NUMBER_5 })
}

/**
 * 顶部省市区文字样式
 * @param selected
 */
@Extend(Text) function txtColor(selected: boolean) {
  .fontSize(UiConst.FONT_14).fontColor(selected ? "#969799" : "#000").fontWeight(selected ? FontWeight.Normal : FontWeight.Bold)
}

/**
 * 省市区list样式
 */
@Extend(Text) function cityTxtColor() {
  .height(UiConst.NUMBER_25)
  .fontSize(UiConst.FONT_16)
  .lineHeight(UiConst.NUMBER_25)
  .textAlign(TextAlign.Start)
  .padding({ top: UiConst.NUMBER_3, bottom: UiConst.NUMBER_3 })
  .backgroundColor("#f7f8fa")
}


@Component
export struct Cascade {
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

  aboutToAppear() {
    if (this.provinceList.length == 0) {
      this.init();
    }
  }

  /**
   * 初始化城市数据
   */
  private init() {
    //解析省市区json
    this.provinceList = JSONUtil.parseArray<City>(JSONUtil.toJSONString(pcaJSON));
    this.provinceList.forEach(province => {
      //默认将省数据赋值给当前listview对应的数据
      this.currentList.push(new City(province.name, province.code));
      // @ts-ignore
      province.children = JSONUtil.parseArray<City>(province.children);
      province.children.forEach(city => {
        // @ts-ignore
        city.children = JSONUtil.parseArray<City>(city.children);
      })
    })
  }

  /**
   * 获取城市数据
   * @param prevCode 省code
   * @returns
   */
  private getCityData(prevCode: string): Array<City> {
    return this.provinceList.find(pro => pro.code == prevCode).children;
  }

  /**
   * 获取区县数据
   * @param prevCode 省code
   * @param cityCode 市code
   * @returns
   */
  private getAreaData(prevCode: string, cityCode: string): Array<City> {
    return this.provinceList.find(pro => pro.code == prevCode)
      .children
      .find(city => city.code == cityCode)
      .children;
  }

  /**
   * 获取省数据
   * @returns
   */
  private getProvinceData(): Array<City> {
    let provList: Array<City> = new Array();
    pcaJSON.forEach(province => {
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
          Image($r("app.media.close")).width(UiConst.VP_15).height(UiConst.VP_15).onClick(() => {
            this.show = !this.show;
            this.showCity = false;
            this.showArea = false;
            this.selectData = new cascadeCity();
            this.currentList = new Array();
            this.selectIndex = 0;
            this.currentList = this.getProvinceData();
          })
        }
        .width('100%')
        .padding({ top: UiConst.NUMBER_15, left: UiConst.NUMBER_15, right: UiConst.NUMBER_15, bottom: UiConst.NUMBER_10 })
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
      }
      //中部选择区域
      Row() {
        //省市区
        Column() {
          if (this.selectIndex == 0 && !this.selectData.provinceName) {
            Text("请选择").txtColor(true)
            Text("1").cascadeUnderLine(true)
          } else {
            Text(this.selectData.provinceName).txtColor(false).onClick(() => {
              this.selectIndex = 0;
              this.currentList = this.getProvinceData();
            })
            Text("1").cascadeUnderLine(this.selectIndex == 0)
          }
        }.margin({ right: UiConst.NUMBER_20 })
        //市
        if (this.showCity) {
          Column() {
            if (this.selectIndex === 1 && !this.selectData.cityName) {
              Text("请选择").txtColor(true)
              Text("1").cascadeUnderLine(true)
            } else {
              Text(this.selectData.cityName).txtColor(false).onClick(() => {
                this.selectIndex = 1;
                this.currentList = this.getCityData(this.selectData.provinceCode);
              })
              Text("1").cascadeUnderLine(this.selectIndex == 1)
            }
          }.margin({ right: UiConst.NUMBER_20 })
        }
        if (this.showArea) {
          //区域
          Column() {
            if (this.selectIndex === 2 && !this.selectData.areaName) {
              Text("请选择").txtColor(true)
              Text("1").cascadeUnderLine(true)
            } else {
              Text(this.selectData.areaName).txtColor(false).onClick(() => {
                this.selectIndex = 2;
                this.currentList = this.getAreaData(this.selectData.provinceCode, this.selectData.cityCode);
              })
              Text("1").cascadeUnderLine(this.selectIndex == 2)
            }
          }
        }
      }.width("100%").margin({ top: UiConst.NUMBER_10, left: UiConst.NUMBER_20 }).justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center)

      Row() {
        List({ space: UiConst.NUMBER_5, initialIndex: 0 }) {
          ForEach(this.currentList, (item) => {
            ListItem() {
              Row() {
                if (this.selectIndex === 0) {
                  Text(item.name)
                    .cityTxtColor()
                    .fontColor(item.code == this.selectData.provinceCode ? "#1989fa" : "#323233")
                  if (item.code == this.selectData.provinceCode) {
                    Image($r("app.media.ok")).width(UiConst.VP_15).height(UiConst.VP_15)
                  }
                }
                if (this.selectIndex === 1) {
                  Text(item.name)
                    .cityTxtColor()
                    .fontColor(item.code == this.selectData.cityCode ? "#1989fa" : "#323233")
                  if (item.code == this.selectData.cityCode) {
                    Image($r("app.media.ok")).width(UiConst.VP_15).height(UiConst.VP_15)
                  }
                }
                if (this.selectIndex === 2) {
                  Text(item.name)
                    .cityTxtColor()
                    .fontColor(item.code == this.selectData.areaCode ? "#1989fa" : "#323233")
                  if (item.code == this.selectData.areaCode) {
                    Image($r("app.media.ok")).width(UiConst.VP_15).height(UiConst.VP_15)
                  }
                }
              }
              .width("100%")
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .padding({ right: UiConst.NUMBER_20 })
            }
            .onClick(event => {
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
              }
            })
          }, item => item.code)
        }
        .listDirection(Axis.Vertical) // 排列方向
        .edgeEffect(EdgeEffect.None)
        .width('100%')
        .height(500)
        .scrollBar(BarState.Auto)
      }
      .height('100%')
      .width("100%")
      .alignItems(VerticalAlign.Top)
      .margin({ top: UiConst.NUMBER_5, left: UiConst.NUMBER_20, bottom: UiConst.NUMBER_5 })
    }
    .type(PanelType.Temporary)
    .mode(PanelMode.Full)
    .dragBar(false)
    .fullHeight(700)
    .backgroundColor("#f7f8fa")
    .position({ x: 0, y: 0 })
  }
}

/**
 * 回调的选中数据
 */
class cascadeCity {
  provinceName: string;
  provinceCode: string;
  cityName: string;
  cityCode: string;
  areaName: string;
  areaCode: string;
}

/**
 * 选择器所需的数据
 */
class City {
  name: string;
  code: string;
  children: Array<City>;

  constructor(name, code) {
    this.name = name;
    this.code = code;
  }
}