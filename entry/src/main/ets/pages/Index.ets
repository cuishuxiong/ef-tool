import {
  CacheUtil,
  OutDTO,
  Logger,
  IdCardUtil,
  ToastUtil,
  ActionUtil,
  DialogUtil,
  ArrayUtil,
  ObjectUtil,
  PhoneUtil,
  StrUtil,
  DateUtil,
  CharUtil,
  RegUtil,
  RegexConst,
  RandomUtil,
  IdUtil,
  AES,
  SM4,
  RSA,
  SM2,
  DES,
  CryptoUtil
} from '@yunkss/eftool'


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
    // this.testCrypto();
  }

  cancel() {
    ToastUtil.showToast('点击了取消')
  }

  ok() {
    ToastUtil.showToast('点击了确定')
  }

  async testCrypto() {

    //获取iv
    let iv = await CryptoUtil.generateIV();

    //AES
    // let aes = await AES.generateAesKey();
    // this.message = aes.getDataRow();
    // let encodeGCM = await AES.encodeGCM('测试加密字符串Test!', aes.getDataRow());
    // this.message = encodeGCM.getDataRow();
    // let decodeGCM = await AES.decodeGCM(encodeGCM.getDataRow(), aes.getDataRow());
    // this.message = decodeGCM.getDataRow();
    // let encode = await AES.encodeCBC('测试CBC加密字符串Test!', aes.getDataRow(), iv.getDataRow());
    // this.message = encode.getDataRow();
    // let decode = await AES.decodeCBC(encode.getDataRow(), aes.getDataRow(), iv.getDataRow());
    // this.message = decode.getDataRow();

    //SM4
    // let sm4 = await SM4.generateSM4Key();
    // this.message = sm4.getDataRow();
    // let encodeECB = await SM4.encodeECB('测试SM4加密字符串Test!', sm4.getDataRow());
    // this.message = encodeECB.getDataRow();
    // let decodeECB = await SM4.decodeECB(encodeECB.getDataRow(), sm4.getDataRow());
    // this.message = decodeECB.getDataRow();
    // let encodeCBC = await SM4.encodeCBC('测试SM4的CBC加密字符串Test!', sm4.getDataRow(), iv.getDataRow());
    // this.message = encodeCBC.getDataRow();
    // let decodeCBC = await SM4.decodeCBC(encodeCBC.getDataRow(), sm4.getDataRow(), iv.getDataRow());
    // this.message = decodeCBC.getDataRow();

    //3DES
    // let des = await DES.generate3DESKey();
    // this.message = des.getDataRow();
    // let encodeECB = await DES.encodeECB('测试3DES-ECB加密字符串Test!', des.getDataRow());
    // this.message = encodeECB.getDataRow();
    // let decodeECB = await DES.decodeECB(encodeECB.getDataRow(), des.getDataRow());
    // this.message = decodeECB.getDataRow();
    // let encodeCBC = await DES.encodeCBC('测试3DES-CBC加密字符串Test!', des.getDataRow(), iv.getDataRow());
    // this.message = encodeCBC.getDataRow();
    // let decodeCBC = await DES.decodeCBC(encodeCBC.getDataRow(), des.getDataRow(), iv.getDataRow());
    // this.message = decodeCBC.getDataRow();

    //RSA
    // let rsa = await RSA.generateRSAKey();
    // this.message = rsa.getDataRow().publicKey;
    // let encode = await RSA.encodePKCS1('测试RSA-PKCS1加密字符串CSX~~',rsa.getDataRow().publicKey);
    // this.message = encode.getDataRow();
    // let decode = await RSA.decodePKCS1(encode.getDataRow(),rsa.getDataRow().privateKey);
    // this.message = decode.getDataRow();
    // let sign = await RSA.signPKCS1('这个是RSA的验签字符串~~',rsa.getDataRow().privateKey);
    // this.message = sign.getDataRow();
    // let verify = await RSA.verifyPKCS1(sign.getDataRow(),'这个是RSA的验签字符串~~',rsa.getDataRow().publicKey);
    // this.message = verify.getMsg();

    //SM2
    // let sm2 = await SM2.generateSM2Key();
    // this.message = sm2.getDataRow().publicKey;
    // let encode = await SM2.encode('测试SM2加密字符串CSX~~', sm2.getDataRow().publicKey);
    // this.message = encode.getDataRow();
    // let decode = await SM2.decode(encode.getDataRow(), sm2.getDataRow().privateKey);
    // this.message = decode.getDataRow();
    // let sign = await SM2.sign('这个是SM2的验签字符串~~', sm2.getDataRow().privateKey);
    // this.message = sign.getDataRow();
    // let verify = await SM2.verify(sign.getDataRow(), '这个是SM2的验签字符串~~', sm2.getDataRow().publicKey);
    // this.message = verify.getMsg();

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
    //身份证校验
    Logger.error(IdCardUtil.isValidCard18("120102199001015965").getMsg(), '------------------');
    this.message = IdCardUtil.convert15To18("420106640901234").getDataRow();
    Logger.error(IdCardUtil.isValidCard15("420106840901234").getMsg(), '0000000000000000')
    let n = ArrayUtil.append(["1", "2", "3"], ["4"]);
    n.forEach(item => {
      console.error(item);
    })

    console.error(ObjectUtil.notEqual("1", "1") + "")

    console.error(PhoneUtil.isPhone("17111114114").getMsg())

    console.error(StrUtil.hasBlank("", "232323") + "")

    console.error(StrUtil.isEmpty(' ') + "")

    console.error(StrUtil.isNotBlank('222') + "")

    console.error(StrUtil.trim([" 你好 ", " hi", "hello "]).join("----"))

    const obj: Record<string, string> = { 'key': 'this is value' } // key的值类型为 string | undefined
    const test = StrUtil.asString(obj)

    const a = StrUtil.isBlankIfStr(obj);

    this.message = DateUtil.parse("2023-01-01") + "";

    console.error(DateUtil.formatDate("2023/1/1", 'yyyy-MM-dd HH:mm:ss'))

    console.error(DateUtil.format(new Date, 'HH:mm:ss'))

    if (CharUtil.isBlankChar(0xFEFF)) {
      this.message = "111"
    } else {
      this.message = "222"
    }

    let res1 = RegUtil.isMatch(RegexConst.EMAIL, '111111');
    console.error(res1.getSuccess() + "---" + res1.getMsg());

    let res2 = RegUtil.isEmailMatch('13191191111@163.com');
    console.error(res2.getSuccess() + "---" + res2.getMsg());

    this.message = RegUtil.isIdCardMatch('111111111111111111').getMsg();

    this.message = RegUtil.isEmailMatch('13191191111').getMsg();
    let str: string[] = ["1", ""];
    if (ArrayUtil.strValIsNotEmpty(str)) {
      this.message = "不是空的";
    } else {
      this.message = "是空的"
    }
    if (ArrayUtil.isEmpty(str)) {
      this.message = "是空的";
    } else {
      this.message = "不是空的"
    }


    ArrayUtil.defaultIfEmpty(str, ["1", "32"]).forEach(item => {
      this.message += item + "、";
    })
    this.message = IdUtil.randomUUID();
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button("默认toast").margin({ bottom: '10vp' }).onClick(() => {
          ToastUtil.showToast('duration:2000,bottom:10vp');
          this.testCrypto();
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
        Button("dialog修改参数").margin({ bottom: '10vp' }).onClick(() => {
          DialogUtil.showDialog({
            msg: '这是一个弹框提示',
            okCallBack: this.test   //调用方法无需小括号()
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
        Button("列表选择弹窗修改参数").margin({ bottom: '10vp' }).onClick(() => {
          ActionUtil.showActionSheet({
            title: '弹框的标题',
            msg: '弹框的消息',
            subtitle: '副标题',
            alignment: DialogAlignment.Top,
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