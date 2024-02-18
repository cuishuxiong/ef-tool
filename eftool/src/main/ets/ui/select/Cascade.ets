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
  .height('3vp').backgroundColor(selected ? "#ee0a24" : "fff").width('48vp').margin({ top: 8 })
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
  .backgroundColor(0xFFFFFF)
}


@Component
export struct Cascade {
  @Link show: boolean
  @State private showCity: boolean = false
  @State private showArea: boolean = false
  private provinceList: Array<City> = new Array();
  //点击选择的数据
  @State private selectData: cascadeCity = new cascadeCity('', 0);
  //当前list显示的数据
  @State private currentList: Array<City> = new Array();

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
            this.selectData = new cascadeCity('', 0);
            this.selectData.children = new cascadeCity('', 0);
            this.selectData.children.children = new cascadeCity('', 0);
            this.currentList  = new Array();
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
          if (this.selectData.name == "") {
            Text("请选择").txtColor(true)
            Text("1").cascadeUnderLine(true)
          } else {
            Text(this.selectData.name).txtColor(false)
            Text("1").cascadeUnderLine(false)
          }
        }.margin({ right: 20 })
        //市
        if (this.showCity) {
          Column() {
            if (this.selectData.children.name == "") {
              Text("请选择").txtColor(true)
              Text("1").cascadeUnderLine(true)
            } else {
              Text(this.selectData.children.name).txtColor(false)
              Text("1").cascadeUnderLine(false)
            }
          }.margin({ right: 20 })
        }
        if (this.showArea) {
          //区域
          Column() {
            if (this.selectData.children.children.name == "") {
              Text("请选择").txtColor(true)
              Text("1").cascadeUnderLine(true)
            } else {
              Text(this.selectData.children.children.name).txtColor(false)
              Text("1").cascadeUnderLine(false)
            }
          }
        }
      }.width("100%").margin({ top: 10, left: 20 }).justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center)

      Row() {
        List({ space: 5, initialIndex: 0 }) {
          ForEach(this.currentList, (item) => {
            ListItem() {
              Row() {
                Text(item.name).cityTxtColor().fontColor(item.code == this.selectData.code ? "#1989fa" : "#323233")
                if (item.code == this.selectData.code) {
                  Image($r("app.media.ok")).width("15vp").height('15vp')
                }
              }
              .width("100%")
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }
            .onClick(event => {
              //点击赋值选中的数据
              if (!this.selectData.name) {
                this.selectData = new cascadeCity(item.name, item.code);
                this.selectData.children = new cascadeCity('', 0);
                this.currentList = this.provinceList.find(pro => pro.code == item.code).children;
                this.showCity = true;
              } else if (!this.selectData.children.name) {
                this.selectData.children = new cascadeCity(item.name, item.code);
                this.selectData.children.children = new cascadeCity('', 0);
                this.currentList = this.provinceList.find(pro => pro.code == this.selectData.code)
                  .children
                  .find(city => city.code == item.code)
                  .children;
                console.log(JSONUtil.toJSONString(this.currentList))
                this.showArea = true;
              } else {
                this.selectData.children.children = new cascadeCity(item.name, item.code);
              }
            })
          }, item => item.code)
        }
        .listDirection(Axis.Vertical) // 排列方向
        .divider({ strokeWidth: 1, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .edgeEffect(EdgeEffect.Fade) // 滑动到边缘无效果
        .width('90%')
      }.width("100%").margin({ top: 20, left: 20 })
    }
    .type(PanelType.Temporary)
    .mode(PanelMode.Half)
    .dragBar(false) // 默认开启
    .halfHeight(500) // 默认一半
    .backgroundColor("#fffffd")
    .position({ x: 0, y: 0 })
    .onChange((width: number, height: number, mode: PanelMode) => {
      console.info(`width:${width},height:${height},mode:${mode}`)
    })
  }
}

/**
 * 回调的选中数据
 */
class cascadeCity {
  name: string;
  code: string;
  children: cascadeCity;

  constructor(name, code) {
    this.name = name;
    this.code = code;
  }
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