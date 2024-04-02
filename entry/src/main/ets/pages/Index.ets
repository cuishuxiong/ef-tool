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
  ECDSA,
  ECDH,
  CryptoUtil,
  X25519,
  SM3,
  MD5,
  SHA,
  LoadingUtil,
  TipsUtil,
  ConfirmUtil,
  AlertUtil,
  SelectUtil,
  JSONUtil,
  ExceptionUtil,
// DownloadUtil,
  Cascade,
  DateConst
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
  sex: boolean;
  user: User;
  list: Array<User>;

  constructor(name: string, age: number, sex: boolean, birth: Date, user: User, list: Array<User>) {
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
struct Index {
  @State message: string = 'Hello World';
  @State showLoading: boolean = false;
  @State showTips: boolean = false;
  @State showConfirm: boolean = false;
  @State showAlert: boolean = false;
  @State showSelect: boolean = false;
  @State showException: boolean = false;
  scroller: Scroller = new Scroller()
  @State show: boolean = false
  @State callCity: string = ''

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
    // let iv = await RandomUtil.generateIV();

    //ECDSA
    // let ecdsa = await ECDSA.generateECDSAKey();
    // this.message = ecdsa.getDataRow().publicKey;
    // let sign = await ECDSA.sign('这个是ECDSA的验签字符串~~', ecdsa.getDataRow().privateKey);
    // let sign = await ECDSA.sign('这个是ECDSA的验签字符串~~', ecdsa.getDataRow().privateKey);
    // this.message = sign.getDataRow();
    // let verify = await ECDSA.verify(sign.getDataRow(), '这个是ECDSA的验签字符串~~', ecdsa.getDataRow().publicKey);
    // this.message = verify.getMsg();

    //ecdh-传入256位字符串公私钥
    // let symKey = await ECDH.ecdh(ecdsa.getDataRow().publicKey, ecdsa.getDataRow().privateKey);
    //ecdh-传入字节流公私钥
    // 创建非对称密钥生成器
    // let rsaGenerator = crypto.createAsyKeyGenerator('ECC256');
    // 通过非对称密钥生成器，随机生成非对称密钥
    // let promiseKeyPair = await rsaGenerator.generateKeyPair();
    // 转换成可以读懂的公私钥字符串
    // let pubKey = promiseKeyPair.pubKey.getEncoded().data;
    // let priKey = promiseKeyPair.priKey.getEncoded().data;
    //获取到贡献密钥
    // let symKey = await ECDH.ecdh(pubKey, priKey);
    //可以进行对称加密
    // let encode = await CryptoUtil.encodeECB('测试共享密钥加密数据~~~', symKey.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    // this.message = encode.getDataRow();
    //对称解密
    // let decode = await CryptoUtil.decodeECB(encode.getDataRow(), symKey.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    // this.message = decode.getDataRow();

    // let rsaGenerator = crypto.createAsyKeyGenerator('X25519');
    // 通过非对称密钥生成器，随机生成非对称密钥
    // let promiseKeyPair = await rsaGenerator.generateKeyPair();
    // 转换成可以读懂的公私钥字符串
    // let pubKey = promiseKeyPair.pubKey.getEncoded().data;
    // let priKey = promiseKeyPair.priKey.getEncoded().data;
    //生成x25519公私钥
    // let x25519Key = await CryptoUtil.generateCryptoKey('X25519');
    // let x25519 = await X25519.x25519(x25519Key.getDataRow().publicKey, x25519Key.getDataRow().privateKey);
    // let x25519 = await X25519.x25519(pubKey, priKey);
    // this.message = x25519.getDataRow();
    //可以进行对称加密
    // let encode = await CryptoUtil.encodeECB('测试共享密钥加密数据~~~', x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    // this.message = encode.getDataRow();
    //对称解密
    // let decode = await CryptoUtil.decodeECB(encode.getDataRow(), x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    // this.message = decode.getDataRow();

    // let sm3 = await SM3.digest('使用SM3进行摘要数据~~~');
    // this.message = sm3.getDataRow();

    // let md5 = await MD5.digest('使用MD5进行摘要~~~');
    // this.message = md5.getDataRow();

    //AES
    // let aes = await AES.generateAESKey();
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
    let pubKey = RSA.pemToStrKey(`-----BEGIN PUBLIC KEY-----
                  MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDhoZDHUVp7y2zw7T7SQYDiUQCn
                  ImnsKogqWOF3hBfaBr8xK/7I/PfbLcPV/MrWKPi2uaiXkhmITX+24ZWVBInxELBa
                  4kccFJeZReMRmu7rKZgkVzU6JKyfaH8zMxipEBh0TyS6JVHHjPd4eezzzVDHc59O
                  fYyzs3kM3Z6oczwTDwIDAQAB
                  -----END PUBLIC KEY-----`);
    let encode = await RSA.encodePKCS1('测试RSA-PKCS1加密字符串CSX~~', pubKey);
    this.message = encode.getDataRow();
    let priKey = RSA.pemToStrKey(`-----BEGIN PRIVATE KEY-----
                MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAOGhkMdRWnvLbPDt
                PtJBgOJRAKciaewqiCpY4XeEF9oGvzEr/sj899stw9X8ytYo+La5qJeSGYhNf7bh
                lZUEifEQsFriRxwUl5lF4xGa7uspmCRXNTokrJ9ofzMzGKkQGHRPJLolUceM93h5
                7PPNUMdzn059jLOzeQzdnqhzPBMPAgMBAAECgYEAjJjm5Kz3G0kJ25+ak94pd91N
                8Nfq9TUToH++D4GKc1vc68EkhQ3NTRDZhZB+vLDPOt26BqkNq/fO66DqWu93HEra
                jBE4pZzCxmVmLanuimxiA45Td1DalL0mmd9ab2cusqwXo6LDs3mSU/t7gSBRUCnt
                kv4MBZMgIDA92QSadHECQQD1HZKBIbWQtZ4nDxgaP1MOQC7dKmXlIkCsDbuwaZhj
                RM8/+iqBBtgSkviwOCDWNiFcpzf+nUM1+ba9OE9iTOqTAkEA66Z/ifnKVCNbHiW8
                i6E2K/2NcJH4qsxRrIMs+eyxqC/yEjkxol26OVmemxu22Fjkx/xIOKg6zFJRstXy
                i6P3FQJBAKZ7xINCwxCb2uSKowNI2X/HZk0/u9+qqSRzW3TR8/gQx3eb0fy7Ck1r
                V9BQ/zSfpX9J8IVWiU0C4/SXZ4vL1FMCQQCPaQh9I7NqeQne0wBnyXh6VRhaxbsb
                1rRt1Hbusol73ZHoXT5Dnd7TQCMyKi+ggpjYzEP3lwoRhpeJyoKNUP/xAkB+//w9
                SyKHWOZOCLj47/1/7YZGzKv/Ttb4NVFtqDPl2QtbXqDcP8d5ZI4p37rJIq1XZ0sT
                l2UgKQV+KZkPdL1n
                -----END PRIVATE KEY-----
                `)
    let decode = await RSA.decodePKCS1(encode.getDataRow(), priKey);
    this.message = decode.getDataRow();
    // let sign = await RSA.signPKCS1('这个是RSA的验签字符串~~', rsa.getDataRow().privateKey);
    // this.message = sign.getDataRow();
    // let verify = await RSA.verifyPKCS1(sign.getDataRow(), '这个是RSA的验签字符串~~', rsa.getDataRow().publicKey);
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

    // let hmac1 = await SM3.hmac('这个是SM3的HMAC~~~');
    // this.message = hmac1.getDataRow();

    // let hmac2 = await SHA.hmac('这个是SHA的HMAC');
    // this.message = hmac2.getDataRow();

    // let digest = await SHA.digest('这个是SHA的摘要方法~~');
    // this.message = digest.getDataRow();

  }

  test(): void {
    //存入字符串
    // CacheUtil.save<string>("str", "测试存入字符串");
    //存入对象T
    let userList = new Array<User>();
    userList.push(new User('2345', '测试用户1'));
    userList.push(new User('7844', '测试用户2'));
    let person = new Person('测试', 12, true, new Date(), new User("uuid", "打撒吃的是草动次打次"), userList);

    let str1 = JSONUtil.toJSONString(person, DateConst.YMD_HLINE_HMS);

    Logger.error(str1, "11111111111")

    let p = JSONUtil.parseObject<Person>(str1, DateConst.YMD_HLINE_HMS);

    Logger.debug(p.name, p.user.name + p.list[0].name);

    let listStr = JSONUtil.toJSONString(userList);

    let uList = JSONUtil.parseArray<User>(listStr);
    uList.forEach(item => {
      Logger.error(item.id, item.name);
    })

    // CacheUtil.save<Person>("tetObj", person);
    //存入对象集合
    // let arrP = Array<Person>();
    // arrP[0] = new Person('test1', 1, new Date(), new User("uuid1", "user测试内容1"));
    // arrP[1] = new Person('test2', 2, new Date(), new User("uuid2", "user测试内容2"));
    // arrP[2] = new Person('test3', 3, new Date(), new User("uuid3", "user测试内容3"));
    // CacheUtil.save<Array<Person>>("arrPerson", arrP);
    //获取字符串
    // this.message = CacheUtil.get<string>("str");
    //获取对象T
    // let p = CacheUtil.get<Person>("tetObj");
    // this.message = p.name + p.age + p.user.id;
    //获取对象集合
    // let newStr: string = '';
    // let res = CacheUtil.get<Array<Person>>("arrPerson");
    // res.forEach(item => {
    //   newStr += item.age + item.name + item.user.id + item.user.name;
    // })
    // this.message = newStr;
    //只需成功要提示
    // Logger.error(OutDTO.OK('获取提示成功~').getMsg());
    //需要成功提示和单行数据-如更新
    // let dto = OutDTO.OKByDataRow<Person>('获取当数据成功~', p);
    // Logger.error(dto.getMsg(), dto.getDataRow().name)
    //需要成功提示和对象集合-如查询列表
    // let outDTO = OutDTO.OKByDataTable<Person>('获取对象集合成功~', arrP);
    // Logger.error(outDTO.getMsg(), JSON.stringify(outDTO.getDataTable()));
    //只需要失败提示
    // let err = OutDTO.Error('获取数据失败~');
    // Logger.error("结果:" + err.getSuccess(), err.getMsg())
    //需要失败提示和详细单行数据
    // let errDTO = OutDTO.ErrorByDataRow<Person>('获取数据失败~', p);
    // Logger.error("结果:" + errDTO.getSuccess() + "---" + errDTO.getMsg(), JSON.stringify(errDTO.getDataRow()));
    //身份证校验
    // Logger.error(IdCardUtil.isValidCard18("120102199001015965").getMsg(), '------------------');
    // this.message = IdCardUtil.convert15To18("420106640901234").getDataRow();
    // Logger.error(IdCardUtil.isValidCard15("420106840901234").getMsg(), '0000000000000000')
    // let n = ArrayUtil.append(["1", "2", "3"], ["4"]);
    // n.forEach(item => {
    //   console.error(item);
    // })

    // console.error(ObjectUtil.notEqual("1", "1") + "")

    // console.error(PhoneUtil.isPhone("17111114114").getMsg())

    // console.error(StrUtil.hasBlank("", "232323") + "")

    // console.error(StrUtil.isEmpty(' ') + "")

    // console.error(StrUtil.isNotBlank('222') + "")

    // console.error(StrUtil.trim([" 你好 ", " hi", "hello "]).join("----"))

    // const obj: Record<string, string> = { 'key': 'this is value' } // key的值类型为 string | undefined
    // const test = StrUtil.asString(obj)

    // const a = StrUtil.isBlankIfStr(obj);

    // this.message = DateUtil.parse("2023-01-01") + "";

    // console.error(DateUtil.formatDate("2023/1/1", 'yyyy-MM-dd HH:mm:ss'))

    // console.error(DateUtil.format(new Date, 'HH:mm:ss'))

    // if (CharUtil.isBlankChar(0xFEFF)) {
    //   this.message = "111"
    // } else {
    //   this.message = "222"
    // }

    // let res1 = RegUtil.isMatch(RegexConst.EMAIL, '111111');
    // console.error(res1.getSuccess() + "---" + res1.getMsg());

    // let res2 = RegUtil.isEmailMatch('13191191111@163.com');
    // console.error(res2.getSuccess() + "---" + res2.getMsg());

    // this.message = RegUtil.isIdCardMatch('111111111111111111').getMsg();

    // this.message = RegUtil.isEmailMatch('13191191111').getMsg();
    // let str: string[] = ["1", ""];
    // if (ArrayUtil.strValIsNotEmpty(str)) {
    //   this.message = "不是空的";
    // } else {
    //   this.message = "是空的"
    // }
    // if (ArrayUtil.isEmpty(str)) {
    //   this.message = "是空的";
    // } else {
    //   this.message = "不是空的"
    // }


    // ArrayUtil.defaultIfEmpty(str, ["1", "32"]).forEach(item => {
    //   this.message += item + "、";
    // })
    // this.message = IdUtil.randomUUID();
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Scroll(this.scroller) {
        Column() {
          Text(this.callCity)
          Text(this.message)
            .fontSize(50)
            .fontWeight(FontWeight.Bold)
          // DownloadUtil({})

          Button("默认toast").margin({ top: 30, bottom: '10vp' }).onClick(() => {
            ToastUtil.showToast('duration:2000,bottom:10vp');
            this.testCrypto();
          })
          Button("级联菜选择器").margin({ bottom: '10vp' }).onClick(() => {
            this.show = !this.show;
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
          Button("dialog一个按钮").margin({ bottom: '10vp' }).onClick(() => {
            DialogUtil.showDialog({
              msg: '不写cancelCallBack则显示一个按钮',
              okCallBack: this.test   //调用方法无需小括号()
            });
          })
          Button("dialog修改参数").margin({ bottom: '10vp' }).onClick(() => {
            DialogUtil.showDialog({
              msg: '这是一个弹框提示',
              okText: '同意',
              okCallBack: this.test, //调用方法无需小括号()
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

          LoadingUtil({
            options: { show: this.showLoading, alignment: DialogAlignment.Top, content: '更改了加载提示...' }
          });
          TipsUtil({
            options: {
              show: this.showTips,
              content: '请仔细阅读请仔细阅读请仔细阅读请仔细阅读请仔细阅读请仔细阅读请仔细阅读请仔细阅读请仔细阅读xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
              clickCallBack: (index, isChecked) => {
                ToastUtil.showToast(index === 0 ? '点击了第一个按钮' + isChecked : '点击了第二个按钮' + isChecked);
                this.showTips = false;
              }
            }
          });
          ConfirmUtil({
            options: {
              show: this.showConfirm,
              title: '这个是提示',
              content: '确认要禁止定位权限么?',
              clickCallBack: (index, isChecked) => {
                ToastUtil.showToast(index === 0 ? '点击了第一个按钮' + isChecked : '点击了第二个按钮' + isChecked);
                this.showConfirm = false;
              }
            }
          })
          AlertUtil({
            options: {
              show: this.showAlert,
              content: '这是一个警告弹出框',
              clickCallBack: (index) => {
                ToastUtil.showToast(index === 0 ? '点击了第一个按钮' : '点击了第二个按钮');
                this.showAlert = false;
              }
            }
          })
          SelectUtil({
            options: {
              show: this.showSelect,
              ctxList: ['苹果', '香蕉', '梨', '哈密瓜', '凤梨', '西瓜', '火龙果', '伊丽莎白'],
              clickCallBack: (selectData) => {
                //点击按钮时也会触发该回调,返回值为'',故需要判断当返回值不为空时进行业务操作
                if (selectData) {
                  ToastUtil.showToast('选择了' + selectData);
                }
                this.showSelect = false;
              }
            }
          })
          Button("显示loading").margin({ bottom: '10vp' }).onClick(() => {
            this.showLoading = true;
            setTimeout(() => {
              this.showLoading = false;
            }, 3000);
          })
          Button("显示Tips").margin({ bottom: '10vp' }).onClick(() => {
            this.showTips = true;
          })
          Button("显示Conform").margin({ bottom: '10vp' }).onClick(() => {
            this.showConfirm = true;
          })
          Button("显示Alert").margin({ bottom: '10vp' }).onClick(() => {
            this.showAlert = true;
          })
          Button("显示Select").margin({ bottom: '10vp' }).onClick(() => {
            this.showSelect = true;
          })
          Button("显示Exception").margin({ bottom: '10vp' }).onClick(() => {
            this.showException = true;
          })
        }
        .width('100%')
      }
      .scrollable(ScrollDirection.Vertical)

      Cascade({ show: $show, callCity: $callCity }).zIndex(999)
      ExceptionUtil({
        options: {
          show: this.showException,
          clickCallBack: (index) => {
            //index为0表示点击了左侧文字,为1表示点击了右侧图标,根据情况进行业务处理
            ToastUtil.showToast("点击了" + index);
            this.showException = false;
          }
        }
      })
    }
    .width('100%')
    .height('100%')
  }
}