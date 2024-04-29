import {
  OutDTO,
  Logger,
  ToastUtil,
  ActionUtil,
  DialogUtil,
  AES,
  SM4,
  RSA,
  SM2,
  DES,
  ECDSA,
  JSONObject,
  ECDH,
  CryptoUtil,
  X25519,
  SM3,
  MD5,
  SHA,
  JSONArray,
  LoadingUtil,
  TipsUtil,
  ConfirmUtil,
  AlertUtil,
  SelectUtil,
  JSONUtil,
  ExceptionUtil,
  Cascade,
  DateConst,
  AuthUtil,
  WindowUtil,
  NotificationUtil,
  LocationUtil,
  efAxios,
  efAxiosParams,
  efClientApi,
  RandomUtil
} from '@yunkss/eftool'
import { image } from '@kit.ImageKit';
import { common } from '@kit.AbilityKit';

class Message {
  msg: string = '';
}

class User {
  id?: string;
  name?: string;

  constructor(id: string, name: string) {
    this.name = name;
    this.id = id;
  }
}

class UserQuery extends User {
  constructor(id: string, name: string) {
    super(id, name);
  }
}

class UserDTO extends User {
  token: string = '';

  constructor(id: string, name: string) {
    super(id, name);
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
  bottomRectHeight: string = AppStorage.get<number>('bottomHeight') + 'px';

  aboutToAppear(): void {
    this.test();
    // this.testCrypto();
  }

  async dingWei() {
    let result = await AuthUtil.checkPermissions('ohos.permission.APPROXIMATELY_LOCATION');
    if (!result) {
      AuthUtil.reqPermissionsFromUser('ohos.permission.APPROXIMATELY_LOCATION', (index: number) => {
        ToastUtil.showToast(index == 1 ? '授权成功' : '用户取消授权~');
      })
    } else {
      ToastUtil.showToast('用户已授权~');
    }
  }

  async notice() {
    await NotificationUtil.authorizeNotification((index: number) => {
      ToastUtil.showToast(index > 0 ? '已经授予通知权限' : '用户禁止授权,请用户在设置中操作');
    });

  }

  async sendRequest() {
    efAxiosParams.baseURL = 'http://192.168.1.126:18088';
    // efAxiosParams.baseURL = 'http://192.168.0.103:18088';
    efAxiosParams.isAllEncrypt = true;
    efAxiosParams.sm2PubKey = '04ba3bc3c5834d9ad1a7d81c4b49cf1209d2f28e4a97c73b75d6561792a2bfafe811e0284692006b0ce1b51f8aadfd65241d80eb979365048253408f5d705ec17b';

    //如果不需要响应数据转换为OutDTO则将efAxiosParams.isConvertDTO设置为false
    // efAxiosParams.isConvertDTO = false;

    // const loginNoDTO = await efClientApi.post<UserQuery,UserDTO>('/api/eftool/login', {
    //   'account': 'efadmin',
    //   'pwd': '123456'
    // }, {
    //   'csxTest': '1212121212'
    // });
    // if (loginNoDTO.token) {
    //   ToastUtil.showToast('登录成功,token为:'+loginNoDTO.token);
    // }

    //模拟登录
    const login = await efClientApi.post<UserQuery, OutDTO<UserDTO>>('/api/eftool/login', {
      'account': 'efadmin',
      'pwd': '123456'
    }, {
      'csxTest': '1212121212'
    });
    //登录成功
    if (login.getSuccess()) {
      //登录成功将token赋值，后续需要
      efAxiosParams.tokenValue = login.getDataRow().token;
      //模拟测试post请求
      const post = await efClientApi.post<UserQuery, OutDTO<Record<string, Object>>>('/api/eftool/post', {
        'nickName': 'post请求参数',
        'name': '测试入参'
      });
      if (post.getSuccess()) {
        ToastUtil.showToast(JSONUtil.toJSONString(post.getDataRow()));
      }
      //模拟测试get请求
      const get = await efClientApi.get<OutDTO<Record<string, Object>>>('/api/eftool/get/11111111');
      if (get.getSuccess()) {
        ToastUtil.showToast(JSONUtil.toJSONString(get.getDataRow()));
      }
      //模拟测试delete请求
      const del = await efClientApi.delete<OutDTO<Record<string, Object>>>('/api/eftool/delete/1212133');
      if (del.getSuccess()) {
        ToastUtil.showToast(JSONUtil.toJSONString(del.getDataRow()));
      }
      //模拟测试put请求
      const put = await efClientApi.put<UserQuery, OutDTO<Record<string, Object>>>('/api/eftool/put', {
        'id': '11111'
      });
      if (put.getSuccess()) {
        ToastUtil.showToast(JSONUtil.toJSONString(put.getDataRow()));
      }
    } else {
      //登录失败
      ToastUtil.showToast(login.getMsg());
    }
  }

  async pushBasic() {
    await NotificationUtil.publishBasic({
      text: '推送通知内容！！！！！！！！！！！！！！！！！！！！',
      title: '抢票时间到',
      additionalText: '这个是additionalText',
      isOngoing: true,
      isStopwatch: true,
      label: '普通通知',
      callBack: (noticeId: number) => {
        ToastUtil.showToast('通知推送成功:' + noticeId);
      }
    })
  }

  async pushLong() {
    await NotificationUtil.publishLongText({
      text: '推送长文本内容！！！！！！！！！！！！！！！！！！！！',
      title: '抢票时间到11111111111',
      longText: '展出差出差出差出差展出差出差出差出差展出差出差出差出差展出差出差出差出差展出差出差出差出差展出差出差出差出差展出差出差出差出差展出差出差出差出差展出差出差出差出差展出差出差出差出差展出差出差出差出差',
      expandedTitle: '展开的副标题',
      briefText: '这个是概要',
      isOngoing: true,
      isStopwatch: true,
      label: '长文本通知',
      callBack: (noticeId: number) => {
        ToastUtil.showToast('通知推送成功:' + noticeId);
      }
    })
  }

  async pushMulti() {
    await NotificationUtil.publishMultiLine({
      text: '推送通知内容！！！！！！！！！！！！！！！！！！！！',
      title: '抢票时间到',
      additionalText: '这个是additionalText',
      expandedTitle: '多文本的展开',
      briefText: '多文本的概要',
      longText: '第一行的内容,第二行的内容,第三行的内容,第四行的内容,第无行的内容',
      isOngoing: true,
      isStopwatch: true,
      label: '普通通知',
      callBack: (noticeId: number) => {
        ToastUtil.showToast('通知推送成功:' + noticeId);
      }
    })
  }

  async cancelN() {

    NotificationUtil.cancelNotice(10011, () => {
      ToastUtil.showToast('取消通知成功~');
    });
  }

  async pushPicture() {
    await NotificationUtil.publishPicture({
      text: '222222',
      title: '抢票时间到',
      expandedTitle: '多文本的展开',
      briefText: '多文本的概要',
      isOngoing: true,
      isStopwatch: true,
      label: '图片通知',
      picture: await image.createImageSource((getContext(this) as common.UIAbilityContext).resourceManager.getMediaContentSync($r("app.media.startIcon"))
        .buffer).createPixelMap(),
      callBack: (noticeId: number) => {
        ToastUtil.showToast('通知推送成功:' + noticeId);
      }
    })
  }

  async openWin() {
    await WindowUtil.createWindow({
      contentRouter: 'pages/Welcome',
      callBack: () => {
        //此处如果创建完窗口有业务需求则自定义
        ToastUtil.showToast('窗口已创建~');
      }
    })
  }

  cancel() {
    ToastUtil.showToast('点击了取消')
  }

  ok() {
    ToastUtil.showToast('点击了确定')
  }

  async geoLocation() {
    let result = await LocationUtil.getGeoLocation();
    this.message = result.getDataRow();
  }

  async add2location() {
    let res = await LocationUtil.address2Location('北京市顺义区后沙峪裕祥花园');
    this.message = res.getDataRow().latitude + '-------' + res.getDataRow().longitude;
  }

  async geoConvert() {
    let result = await LocationUtil.geoConvert(40.102248232795134, 116.54190501929297);
    if (result.placeName) {
      this.message = result.placeName;
    }
  }

  async getCountryCode() {
    let res = await LocationUtil.getCountryCode();
    this.message = res.getDataRow();
  }

  async testCrypto() {

    //获取iv
    let iv = await RandomUtil.generateIV();

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
    let sm4 = await SM4.generateSM4Key();
    this.message = sm4.getDataRow();
    // let encodeECB = await SM4.encodeECB('测试SM4加密字符串Test!', sm4.getDataRow());
    // this.message = encodeECB.getDataRow();
    // let decodeECB = await SM4.decodeECB(encodeECB.getDataRow(), sm4.getDataRow());
    // this.message = decodeECB.getDataRow();
    let encodeCBC = await SM4.encodeCBC('测试SM4的CBC加密字符串Test!', sm4.getDataRow(), iv.getDataRow());
    this.message = encodeCBC.getDataRow();
    let decodeCBC = await SM4.decodeCBC(encodeCBC.getDataRow(), sm4.getDataRow(), iv.getDataRow());
    this.message = decodeCBC.getDataRow();

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
    // let rsa = await RSA.generate2048RSAKey();
    // this.message = rsa.getDataRow().publicKey;
    // let encode = await RSA.encode2048PKCS1Segment('测试RSA-2048-PKCS1分段加密字符串CSX测试RSA-2048-PKCS1分段加密字符串CSX测试RSA-2048-PKCS1分段加密字符串CSX测试RSA-2048-PKCS1分段加密字符串CSX测试RSA-2048-PKCS1分段加密字符串CSX测试RSA-2048-PKCS1分段加密字符串CSX测试RSA-2048-PKCS1分段加密字符串CSX~~', rsa.getDataRow()
    //   .publicKey);
    // this.message = encode.getDataRow();
    // let decode = await RSA.decode2048PKCS1Segment(encode.getDataRow(), rsa.getDataRow().privateKey);
    // this.message = decode.getDataRow();
    // let encode = await RSA.encode2048PKCS1('测试RSA-2048-PKCS1加密字符串CSX~~', rsa.getDataRow().publicKey);
    // this.message = encode.getDataRow();
    // let decode = await RSA.decode2048PKCS1(encode.getDataRow(), rsa.getDataRow().privateKey);
    // this.message = decode.getDataRow();
    // let sign = await RSA.sign2048PKCS1('这个是2048位RSA的验签字符串~~', rsa.getDataRow().privateKey);
    // this.message = sign.getDataRow();
    // let verify = await RSA.verify2048PKCS1(sign.getDataRow(), '这个是2048位RSA的验签字符串~~', rsa.getDataRow()
    //   .publicKey);
    // this.message = verify.getMsg();
    // let rsa = await RSA.generateRSAKey();
    // this.message = rsa.getDataRow().publicKey;
    //2048位pem公钥
    // let pubKey = RSA.pemToStrKey(`-----BEGIN PUBLIC KEY-----
    //             MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1nwHtqSbMNwjHKutrLUI
    //             +dMBCtoRb/SSY00ujBMsNPFdERxaizxgWVZbypVqgj3/4ZsZw9R65OyQu6oLqjA9
    //             Wk2nVLpPRtZNjwJgNRB4pYKf+RmLn35UdpIQC9/1+UUeoelboLEMCamCeXPCT5dv
    //             xqVheO+S6IOLiN6XGbkNZM2VBNtmAhIUVDLct2yH5YbD6plC8Tg+iMbiigG7r7Cs
    //             JE+Go5tb3BZjUYiF8fJ5ZKYCATkK4lO39rsXU8AAnw0duAq7LHk6xacwjyUA57S8
    //             0S3LFHcOyP7UoNfQ+cbV/z+72sYJV4RwO6AeE2Muz8jYR1GlcCW1wYBGNOpyRVKg
    //             4QIDAQAB
    //             -----END PUBLIC KEY-----`);
    // let encode = await RSA.encode2048PKCS1('测试2048位RSA-PKCS1加密字符串CSX~~', pubKey);
    // this.message = encode.getDataRow();
    //2048位pem私钥
    // let priKey = RSA.pemToStrKey(`-----BEGIN RSA PRIVATE KEY-----
    //             MIIEpAIBAAKCAQEA1nwHtqSbMNwjHKutrLUI+dMBCtoRb/SSY00ujBMsNPFdERxa
    //             izxgWVZbypVqgj3/4ZsZw9R65OyQu6oLqjA9Wk2nVLpPRtZNjwJgNRB4pYKf+RmL
    //             n35UdpIQC9/1+UUeoelboLEMCamCeXPCT5dvxqVheO+S6IOLiN6XGbkNZM2VBNtm
    //             AhIUVDLct2yH5YbD6plC8Tg+iMbiigG7r7CsJE+Go5tb3BZjUYiF8fJ5ZKYCATkK
    //             4lO39rsXU8AAnw0duAq7LHk6xacwjyUA57S80S3LFHcOyP7UoNfQ+cbV/z+72sYJ
    //             V4RwO6AeE2Muz8jYR1GlcCW1wYBGNOpyRVKg4QIDAQABAoIBAB2ckhQNNb/RJKfY
    //             q+mkNNEI6KPu52llgrBi/4InQ3srt4WdPILsmwC6g4G8jy/cD2++UhhPRYhFgNXn
    //             7CRa9J17CxcPgdJt09dipJWu6HkxR5TEihpC/rZABCcfjH4VpN0FsrjEuLy8wl6y
    //             NKl4Zt4uBv8DVGz1fFYxJPtQKSE5YBSbvMD1thhViKOSyYp/pQfu00oz7/XK6iDE
    //             oHAhcdTBcBl9YW2WaXCnuX02FQkO5h8kjJbQd6pW4EfLLUxKjwcxcJ61DswcAaPw
    //             PN4+bgiwMak8H3IFrZVP24qs4ZOT3Yh7dl75OZXw7XcuBxsR/eCDlIe5VSSS+MId
    //             JCc42uECgYEA8jbvO07ESaVYvdij21knF+5Tdjg5rG2q0qsocWlxsE+8IkjzRAgF
    //             oovXqwoyDkhFJ/1N/PEnBqiQngbUhRSst49ICCQVv+fzRX2WjUNg4k2FtLO0jwgL
    //             Z+E6grMkMkv7VDIxyWlY5rYUC1yw6USFjgyMGQaWps8o4+JLsGJd9PsCgYEA4rER
    //             ecoYZndLRGmqMtmGZATDyNh6jGXzGF4XgHahnbhqgw3+7aTDXpA9W1TdGeBI4cQ9
    //             HQMjroJ+X/yx2JWysimnFxMXuU4eXZo3vMuebXB3lRe2QcloO1HobeSdUCosJ3qa
    //             Ks+f3UtN9Q8ZiPb5P0tA/fIbe6cwwQTQ1FLbQtMCgYEA0DpD3lOv0bRRHxygeVEi
    //             l6Muo0Jg6oh5Q5UbNqy0rSNPFJZsc/8FgSEBrqwcLkUZFvDf2+UhbMr7UK+Egkgs
    //             171Y6o7DF/D7JbF6/USAhOyqVpfrUM9UpuBs4bHKG2dQ0Kg6PvHPGMBNaRsth8x9
    //             mInW4yjT2OHdQFPqR9+48IMCgYBJXXkEa21+K/mGCJR2pIOj9w7N/5GZwpzsM/dz
    //             MfGYM8j05SCuFHbOMexJlKuB5l5wAqysqQlxPvZbZlLAf6I3mtdi1mEFLc0SCgkj
    //             5to9HPr2m5f2rpI3MIkCl8x510w28qzWUh+w5OA0AVEITLXZ0CcWiLZwTGmw7jgP
    //             n0kq1QKBgQDWDHZaEGCAYPxytix3tTCG3EIly8+fQJGt1lc0vgiiFcS0cW2pBbko
    //             rVvbu1gSJnmvj0dIObp55wwFBs30xEiMfli+83srOur6nxYUDgn9rqGcufn6hOeH
    //             ++y1uOHhOenfUTy51Gy1Dlv+maJ3LZ0ZnqPnbBdhZ1RtXFnczVKeFg==
    //             -----END RSA PRIVATE KEY-----`)
    // let decode = await RSA.decode2048PKCS1(encode.getDataRow(), priKey);
    // this.message = decode.getDataRow();
    // let sign = await RSA.signPKCS1('这个是RSA的验签字符串~~', rsa.getDataRow().privateKey);
    // this.message = sign.getDataRow();
    // let verify = await RSA.verifyPKCS1(sign.getDataRow(), '这个是RSA的验签字符串~~', rsa.getDataRow().publicKey);
    // this.message = verify.getMsg();

    // let pubKey = RSA.pemToStrKey(`-----BEGIN PUBLIC KEY-----
    //             MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1nwHtqSbMNwjHKutrLUI
    //             +dMBCtoRb/SSY00ujBMsNPFdERxaizxgWVZbypVqgj3/4ZsZw9R65OyQu6oLqjA9
    //             Wk2nVLpPRtZNjwJgNRB4pYKf+RmLn35UdpIQC9/1+UUeoelboLEMCamCeXPCT5dv
    //             xqVheO+S6IOLiN6XGbkNZM2VBNtmAhIUVDLct2yH5YbD6plC8Tg+iMbiigG7r7Cs
    //             JE+Go5tb3BZjUYiF8fJ5ZKYCATkK4lO39rsXU8AAnw0duAq7LHk6xacwjyUA57S8
    //             0S3LFHcOyP7UoNfQ+cbV/z+72sYJV4RwO6AeE2Muz8jYR1GlcCW1wYBGNOpyRVKg
    //             4QIDAQAB
    //             -----END PUBLIC KEY-----`);
    // let pubKey = '0462f1582e89f99f9b10c6ba139f101db7cf8b28b3f864c1b9eócef9ec7d1565650db62ad8cc1978e9a55fa3bfbcdc2a94fa1386ccad7ebea1cefe8348e226e73b';
    // RSA.pemToStrKey(`-----BEGIN PUBLIC KEY-----
    //               MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEFbL2rINkPPjHL8YOR535rJIKKG+V
    //               /NKFdFFDSfGZjkI+tK4Rvig/LD/TFeFbtQwKYJsKXeeadNbTCiiU/KZ1JQ==
    //               -----END PUBLIC KEY-----`);
    // let eee = await CryptoUtil.convertPubKeyFromStr(pubKey,'ECC256');

    // let ecdas = await ECDSA.generateECDSAKey();
    // let res = await ECDH.ecdh(pubKey, ecdas.getDataRow().privateKey);
    // let aesKey = res.getDataRow();

    // let encode = await AES.encodeECB('此处为共享密钥加密的数据~~~~~~', aesKey);
    // this.message = encode.getDataRow();

    // let decode = await AES.decodeECB(encode.getDataRow(), aesKey);
    // this.message = decode.getDataRow();


    //SM2
    let sm2 = await SM2.generateSM2Key();
    this.message = sm2.getDataRow().publicKey;
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

  async testJSONObject(): Promise<void> {


    // let jsonObj = new JSONObject();
    // jsonObj.set("id", "100010");
    // jsonObj.set("age", 27);
    // jsonObj.set("sex", true);
    // jsonObj.set("birth", new Date());
    // let user = new JSONObject();
    // user.set("uid", "121212");
    // user.set("uName", "测试嵌套对象");
    // jsonObj.set("user", user);
    // jsonObj.set("person", new User('objId', 'objName'));
    // jsonObj.set("name", "test字符串");
    //
    // let st = jsonObj.toString();
    //
    // this.message = st;
    //
    // Logger.debug('1111', '111');

    let pk = '04ba3bc3c5834d9ad1a7d81c4b49cf1209d2f28e4a97c73b75d6561792a2bfafe811e0284692006b0ce1b51f8aadfd65241d80eb979365048253408f5d705ec17b';

    let s = await SM2.convertSM2PubKey(pk);

    let code = await SM2.encode('加密字符~~~~~', s.getDataRow());

    let ddd = code.getDataRow();

    let pik = '7713d336bcbbffb8b7f9cab8db984a5c989a0b07697f569a06d5cd38e1351d07';

    let dc = await SM2.convertSM2PriKey(pik);

    let aaaa = await SM2.decode(ddd, dc.getDataRow());

    this.message = aaaa.getDataRow();

    let userList = new Array<User>();
    userList.push(new User('2345', '测试用户1'));
    userList.push(new User('7844', '测试用户2'));
    let person = new Person('测试', 12, true, new Date(), new User("uuid", "打撒吃的是草动次打次"), userList);

    let j = JSONObject.from<Person>(person);

    let str = j.toString();

    this.message = str;


  }

  test(): void {
    // this.message = this.bottomRectHeight;
    //存入字符串
    // CacheUtil.save<string>("str", "测试存入字符串");
    //存入对象T
    let userList = new Array<User>();
    userList.push(new User('2345', '测试用户1'));
    userList.push(new User('7844', '测试用户2'));
    let person = new Person('测试', 12, true, new Date(), new User("uuid", "打撒吃的是草动次打次"), userList);


    let str1 = JSONUtil.toJSONString(person, DateConst.YMD_HLINE_HMS);

    Logger.error(str1, "11111111111")

    // let p = JSONUtil.parseObject<Person>(str1, DateConst.YMD_HLINE_HMS);

    // Logger.debug(p.name, p.user.name + p.list[0].name);

    // let listStr = JSONUtil.toJSONString(userList);

    // let uList = JSONUtil.parseArray<User>(listStr);
    // uList.forEach(item => {
    //   Logger.error(item.id, item.name);
    // })

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
          Button("测试JSONObject").margin({ bottom: '10vp' }).onClick(() => {
            this.testJSONObject();
          })
          Button("测试JSONUtil").margin({ bottom: '10vp' }).onClick(() => {
            this.test();
          })
          Button("发送post请求").margin({ bottom: '10vp' }).onClick(() => {
            this.sendRequest();
          })
          Button("默认toast").margin({ bottom: '10vp' }).onClick(() => {
            ToastUtil.showToast('duration:2000,bottom:10vp');
            this.testCrypto();
          })
          Button("打开窗口").margin({ bottom: '10vp' }).onClick(() => {
            this.openWin();
          })
          Button("级联菜选择器").margin({ bottom: '10vp' }).onClick(() => {
            this.show = !this.show;
          })
          Button("校验是否授予权限").margin({ bottom: '10vp' }).onClick(() => {
            this.dingWei();
          })
          Button("校验是否授予通知权限").margin({ bottom: '10vp' }).onClick(() => {
            this.notice();
          })
          Button("推送文本通知").margin({ bottom: '10vp' }).onClick(() => {
            this.pushBasic();
          })
          Button("推送长文本通知").margin({ bottom: '10vp' }).onClick(() => {
            this.pushLong();
          })
          Button("推送多文本通知").margin({ bottom: '10vp' }).onClick(() => {
            this.pushMulti();
          })
          Button("推送图片通知").margin({ bottom: '10vp' }).onClick(() => {
            this.pushPicture();
          })
          Button("清除通知角标/通知").margin({ bottom: '10vp' }).onClick(() => {
            NotificationUtil.clearBadge();
            NotificationUtil.clearNotice();
          })
          Button('获取当前定位').margin({ bottom: '10vp' }).onClick(() => {
            this.geoLocation();
          })
          Button('根据经纬度获取Location信息').margin({ bottom: '10vp' }).onClick(() => {
            this.geoConvert();
          })
          Button('根据地理位置获取定位信息').margin({ bottom: '10vp' }).onClick(() => {
            this.add2location();
          })
          Button('获取国家码').margin({ bottom: '10vp' }).onClick(() => {
            this.getCountryCode();
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
        .padding({ top: 20 })
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

    // .margin({ bottom: this.bottomRectHeight })
  }
}