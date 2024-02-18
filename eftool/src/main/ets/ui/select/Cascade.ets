/**
 * @Author csx
 * @DateTime 2024/2/6 10:02:02
 * @TODO Cascade  级联选择器
 */
import { cityJSON } from '../../core/const/CityConst'
import { UiConst } from '../../core/const/UiConst'
import { JSONUtil } from '../../core/util/JSONUtil'
/**
 * 下划线样式
 */
@Extend(Text) function cascadeUnderLine(selected: boolean) {
  .height('3vp').backgroundColor(selected ? "#1989fa" : "fff").width('45vp').margin({ top: 5 })
}

@Extend(Text) function txtColor(selected: boolean) {
  .fontSize("14fp").fontColor(selected ? "#969799" : "#000").fontWeight(selected ? FontWeight.Normal : FontWeight.Bold)
}

@Extend(Text) function cityTxtColor() {
  .height(25)
  .fontSize('16fp')
  .lineHeight(25)
  .textAlign(TextAlign.Start)
  .padding({ top: 3, bottom: 3 })
  .backgroundColor("#eaeaea")
}


@Component
export struct Cascade {
  @Link show: boolean
  @State private showCity: boolean = false
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
    for (const province in cityJSON) {
      //设置省
      let pro: City = new City(province.split('&')[0], province.split('&')[1]);
      //默认将省数据赋值给当前listview对应的数据
      this.currentList.push(pro);
      //设置市
      let cityList = cityJSON[province];
      pro.children = new Array();
      for (const city in cityList) {
        let c: City = new City(city.split('&')[0], city.split('&')[1]);
        c.children = new Array();
        //设置区
        let districtList = cityList[city];
        for (const district in districtList) {
          let d: City = new City(district.split('&')[0], district.split('&')[1]);
          c.children.push(d);
        }
        pro.children.push(c);
      }
      this.provinceList.push(pro);
    }
  }

  private getCityData(prevCode: string): Array<City> {
    return this.provinceList.find(pro => pro.code == prevCode).children;
  }

  private getAreaData(prevCode: string, cityCode: string): Array<City> {
    return this.provinceList.find(pro => pro.code == prevCode)
      .children
      .find(city => city.code == cityCode)
      .children;
  }

  private getProvinceData(): Array<City> {
    let provList: Array<City> = new Array();
    for (const province in cityJSON) {
      //设置省
      let pro: City = new City(province.split('&')[0], province.split('&')[1]);
      //默认将省数据赋值给当前listview对应的数据
      provList.push(pro);
    }
    return provList;
  }

  build() {
    Panel(this.show) {
      //顶部
      Column() {
        Row() {
          Text('请选择地区').fontWeight('bold').fontSize('16fp')
          Image($r("app.media.close")).width('15vp').height('15vp').onClick(() => {
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
        .padding({ top: 15, left: 15, right: 15, bottom: 10 })
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
              this.selectData.cityCode = "";
              this.selectData.cityName = "";
              this.selectData.areaCode = "";
              this.selectData.areaName = "";
              this.showArea = false;
            })
            Text("1").cascadeUnderLine(this.selectIndex == 0)
          }
        }.margin({ right: 20 })
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
          }.margin({ right: 20 })
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
      }.width("100%").margin({ top: 10, left: 20 }).justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center)

      Row() {
        List({ space: 5, initialIndex: 0 }) {
          ForEach(this.currentList, (item) => {
            ListItem() {
              Row() {
                if (this.selectIndex === 0) {
                  Text(item.name)
                    .cityTxtColor()
                    .fontColor(item.code == this.selectData.provinceCode ? "#1989fa" : "#323233")
                  if (item.code == this.selectData.provinceCode) {
                    Image($r("app.media.ok")).width("15vp").height('15vp')
                  }
                }
                if (this.selectIndex === 1) {
                  Text(item.name)
                    .cityTxtColor()
                    .fontColor(item.code == this.selectData.cityCode ? "#1989fa" : "#323233")
                  if (item.code == this.selectData.cityCode) {
                    Image($r("app.media.ok")).width("15vp").height('15vp')
                  }
                }
                if (this.selectIndex === 2) {
                  Text(item.name)
                    .cityTxtColor()
                    .fontColor(item.code == this.selectData.areaCode ? "#1989fa" : "#323233")
                  if (item.code == this.selectData.areaCode) {
                    Image($r("app.media.ok")).width("15vp").height('15vp')
                  }
                }
              }
              .width("100%")
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .padding({ right: 20 })
            }
            .onClick(event => {
              //点击赋值选中的数据
              if (this.selectIndex === 0) {
                this.selectData.provinceName = item.name;
                this.selectData.provinceCode = item.code;
                this.showCity = true;
                setTimeout(() => {
                  this.currentList = this.provinceList.find(pro => pro.code == item.code).children;
                  this.selectIndex = 1;
                }, 200)
              }
              if (this.selectIndex === 1) {
                this.selectData.cityName = item.name;
                this.selectData.cityCode = item.code;
                this.showArea = true;
                setTimeout(() => {
                  this.currentList = this.provinceList.find(pro => pro.code == this.selectData.provinceCode)
                    .children
                    .find(city => city.code == item.code)
                    .children;
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
        .edgeEffect(EdgeEffect.Spring) // 滑动到边缘无效果
        .width('100%')
      }.width("100%").margin({ top: 5, left: 20 })
    }
    .type(PanelType.Temporary)
    .mode(PanelMode.Half)
    .dragBar(false) // 默认开启
    .halfHeight(500) // 默认一半
    .backgroundColor("#eaeaea")
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