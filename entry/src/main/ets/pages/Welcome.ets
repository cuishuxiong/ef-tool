/**
 * @Author csx
 * @DateTime 2024/4/3 10:24:04
 * @TODO Welcome
 */
import { JSONArray, JSONArrayList, JSONObject } from '@yunkss/eftool'
import { ArrayList } from '@kit.ArkTS';


class User {
  id?: string;
  name?: string;

  constructor(id: string, name: string) {
    this.name = name;
    this.id = id;
  }
}

class Person {
  name: string;
  age: number;
  birth: Date;
  sex: boolean;
  user: User;
  list?: Array<User>;

  constructor(name: string, age: number, sex: boolean, birth: Date, user: User, list?: Array<User>) {
    this.birth = birth;
    this.name = name;
    this.age = age;
    this.sex = sex;
    this.user = user;
    this.list = list;
  }
}

@Entry
@Component
struct Welcome {
  @State msg: string = 'csx';

  testJSONArrayList() {
    // let arr = new JSONArrayList();
    // arr.add(1);
    // arr.add("cccc");
    // arr.add("123");
    // arr.add("aaaaa\\\"34343434");
    // arr.add("2223\"dasdass");
    // arr.add(new Date());
    // arr.add(true);
    // arr.add(null);
    // arr.add(new User("10010", "实体数据"));
    // let str = arr.toString();
    // this.msg = str;

    let userList = new ArrayList<User>();
    userList.add(new User('2345', '测试用户1'));
    userList.add(new User('7844', '测试用户2'));
    userList.add(new User('1314', '测试用户3'));
    userList.add(new User('5210', '测试用户4'));

    let jarr = JSONArrayList.from(userList);
    this.msg = jarr.length+"";

    let s = JSONArrayList.toJSONString(userList);
    this.msg = s;

    let jsArr = JSONArrayList.parse(s);
    this.msg = jsArr.length +"";


  }

  testJSONArray() {
    // let arr = new JSONArray();
    // arr.push(1);
    // arr.push("cccc");
    // arr.push("123");
    // arr.push("aaaaa\\\"34343434");
    // arr.push("2223\"dasdass");
    // arr.push(new Date());
    // arr.push(true);
    // arr.push(null);
    // arr.push(new User("10010", "实体数据"));
    // let str = arr.toString();;
    // this.msg = str;

    let userList = new Array<User>();
    userList.push(new User('2345', '测试用户1'));
    userList.push(new User('7844', '测试用户2'));
    userList.push(new User('1314', '测试用户3'));
    userList.push(new User('5210', '测试用户4'));

    // let jarr = JSONArray.from(userList);
    // this.msg = jarr.length + "----" + jarr[1]?.toString();

    let s = JSONArray.toJSONString(userList);

    let jsArr = JSONArray.parse(s);
    this.msg = jsArr.length + "----" + jsArr[2]?.toString();
    // this.msg = s;
  }

  testJSONObject() {
    let jsonObj = new JSONObject();
    jsonObj.set("id", "100010");
    jsonObj.set("age", 27);
    jsonObj.set("sex", true);
    jsonObj.set("birth", new Date());
    let user = new JSONObject();
    user.set("uid", "121212");
    user.set("uName", "测试\\\"套对象");
    jsonObj.set("user", user);
    jsonObj.set("test", null);
    jsonObj.set("person", new User('实体id', '实体name'));
    jsonObj.set("name", "test字符串");
    let st = jsonObj.toString();

    let userList = new Array<User>();
    userList.push(new User('2345', '测试用户1'));
    userList.push(new User('7844', '测试用户2'));
    let person = new Person('测试', 12, true, new Date(), new User("uuid", "打撒吃的是草动次打次"), userList);

    let j = JSONObject.toJSONString(person);

    let o = JSONObject.parseObject<Person>(j);


    this.msg = o.birth + "-----" + o.sex + '------' + o.user.name + '======' + o.list?.length;
  }

  build() {
    Column() {
      Text(this.msg).fontColor('#ff4400')
      Button('测试JSONArray').margin({ top: 20 }).onClick(() => {
        this.testJSONArray();
      })
      Button('测试JSONArrayList').margin({ top: 20 }).onClick(() => {
        this.testJSONArrayList();
      })
      Button('测试JSONObject').margin({ top: 20 }).onClick(() => {
        this.testJSONObject();
      })
    }
    .backgroundColor("#fff")
    .align(Alignment.Center)
    .width('100%')
    .borderRadius(10)
    .margin({ top: 80 })
    .padding({ top: 20, bottom: 20 })

  }
}