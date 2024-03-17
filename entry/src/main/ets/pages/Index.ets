import { CacheUtil, OutDTO, Logger, IdCardUtil, ToastUtil, ActionUtil, DialogUtil } from '@yunkss/eftool'


class User {
  id: string;
  name: string;

  constructor(id: string, name: string) {
    this.name = name;
    this.id = id;
  }
}

class Person {
  name: string;
  age: number;
  birth: Date;
  user: User;

  constructor(name: string, age: number, birth: Date, user: User) {
    this.birth = birth;
    this.name = name;
    this.age = age;
    this.user = user;
  }
}


@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  aboutToAppear(): void {
    this.test();
  }

  cancel() {
    ToastUtil.showToast('点击了取消')
  }

  ok() {
    ToastUtil.showToast('点击了确定')
  }

  test(): void {
    //存入字符串
    CacheUtil.save<string>("str", "测试存入字符串");
    //存入对象T
    let person = new Person('测试', 12, new Date(), new User("uuid", "打撒吃的是草动次打次"));
    CacheUtil.save<Person>("tetObj", person);
    //存入对象集合
    let arrP = Array<Person>();
    arrP[0] = new Person('test1', 1, new Date(), new User("uuid1", "user测试内容1"));
    arrP[1] = new Person('test2', 2, new Date(), new User("uuid2", "user测试内容2"));
    arrP[2] = new Person('test3', 3, new Date(), new User("uuid3", "user测试内容3"));
    CacheUtil.save<Array<Person>>("arrPerson", arrP);
    //获取字符串
    this.message = CacheUtil.get<string>("str");
    //获取对象T
    let p = CacheUtil.get<Person>("tetObj");
    this.message = p.name + p.age + p.user.id;
    //获取对象集合
    let newStr: string = '';
    let res = CacheUtil.get<Array<Person>>("arrPerson");
    res.forEach(item => {
      newStr += item.age + item.name + item.user.id + item.user.name;
    })
    this.message = newStr;

    //只需成功要提示
    Logger.error(OutDTO.OK('获取提示成功~').getMsg());
    //需要成功提示和单行数据-如更新
    let dto = OutDTO.OKByDataRow<Person>('获取当数据成功~', p);
    Logger.error(dto.getMsg(), dto.getDataRow().name)
    //需要成功提示和对象集合-如查询列表
    let outDTO = OutDTO.OKByDataTable<Person>('获取对象集合成功~', arrP);
    Logger.error(outDTO.getMsg(), JSON.stringify(outDTO.getDataTable()));
    //只需要失败提示
    let err = OutDTO.Error('获取数据失败~');
    Logger.error("结果:" + err.getSuccess(), err.getMsg())
    //需要失败提示和详细单行数据
    let errDTO = OutDTO.ErrorByDataRow<Person>('获取数据失败~', p);
    Logger.error("结果:" + errDTO.getSuccess() + "---" + errDTO.getMsg(), JSON.stringify(errDTO.getDataRow()));

    let o = IdCardUtil.isValidCard18('142303199507290633');
    Logger.error(o.getMsg(), o.getSuccess() + "");
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button("默认toast").margin({ bottom: '10vp' }).onClick(() => {
          ToastUtil.showToast('duration:2000,bottom:10vp');
          this.test()
        })
        Button("toast修改参数").margin({ bottom: '10vp' }).onClick(() => {
          ToastUtil.showToast('duration:4000,bottom:50vp', { duration: 4000, bottom: '50vp', showMode: 1 });
        })
        Button("dialog").margin({ bottom: '10vp' }).onClick(() => {
          DialogUtil.showDialog({
            msg: '这是一个弹框提示~~~~',
            okCallBack: this.ok,
            okText: '揍你',
            cancelText: '去吧',
            cancelCallBack: this.cancel
          });
        })
        Button("action").margin({ bottom: '10vp' }).onClick(() => {
          ActionUtil.showActionMenu({
            title: '修改后的标题', btn: [
              { text: '测试1', color: '#cdcdcd', btnCallBack: this.ok },
              { text: '测试2', color: '#108ee9', btnCallBack: this.cancel }
            ]
          });
        })
        Button("action默认标题").margin({ bottom: '10vp' }).onClick(() => {
          ActionUtil.showActionMenu({
            btn: [
              { text: '测试1', color: '#cdcdcd', btnCallBack: this.ok },
              { text: '测试2', color: '#108ee9', btnCallBack: this.cancel }
            ]
          });
        })
        Button("actionMenu默认标题").margin({ bottom: '10vp' }).onClick(() => {
          ActionUtil.showMenu({
            btn: ["菜单1", "菜单2"], clickCallBack: (data) => {
              ToastUtil.showToast(data);
            }
          })
        })
        Button("actionMenu修改标题").margin({ bottom: '10vp' }).onClick(() => {
          ActionUtil.showMenu({
            title: '修改了菜单标题', btn: ["菜单1", "菜单2"], clickCallBack: (data) => {
              ToastUtil.showToast(data);
            }
          })
        })
        Button("alertDialog默认值").margin({ bottom: '10vp' }).onClick(() => {
          DialogUtil.showAlertDialog({
            msg: "这个是一个，默认警告弹框",
            buttons: [
              { callBack: this.ok }
            ]
          });
        })
        Button("alertDialog修改值").margin({ bottom: '10vp' }).onClick(() => {
          DialogUtil.showAlertDialog({
            msg: "这个是一个警告弹框",
            title: '标题',
            alignment: DialogAlignment.Top,
            buttons: [
              { callBack: this.ok, style: DialogButtonStyle.HIGHLIGHT },
              { callBack: this.cancel }
            ]
          });
        })
        Button("列表选择弹窗默认参数").margin({ bottom: '10vp' }).onClick(() => {
          ActionUtil.showActionSheet({
            sheets: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
            clickCallBack: (data: string) => {
              ToastUtil.showToast(data);
            }
          });
        })
      }
      .width('100%')
      .height('100%')
    }
    .height('100%')
  }
}