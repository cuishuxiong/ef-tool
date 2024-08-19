# <center>ef_crypto_dto</center>

# <center>V1.0.1(API12)</center>

--------------------------------------------------------------------------------

## 📚简介

`ef_crypto_dto`是`eftool`的加密包.提供了AES、RSA、SM2等基础操作,与之前保持一致返回结果为OutDTO

### 本版本延续了eftool之前的版本,返回结果均为OutDTO类型,如希望返回结果更纯粹不使用OutDTO,建议使用ef_crypto

> 你可以引入使用，也可以**拷贝**和修改使用，如需分享扩展
> ### **希望可以注明原出处即可**
> 也希望能把bug及时反馈回来。

> 我努力健全**中文**注释，为源码学习者提供良好地学习环境，争取做到人人都能看得懂。

## 🛠️包含组件

### 异步方式

| 模块     | 介绍                                   |
|--------|--------------------------------------|
| RSA    | 提RSA供生成密钥加解密验签等系列方法(基于HarmonyOS API) |
| AES    | 提供AES生成密钥加解密等系列方法(基于HarmonyOS API)   |
| DES    | 提供3DES生成密钥加解密等系列方法(基于HarmonyOS API)  |
| SM2    | 提供SM2生成密钥加解密等系列方法(基于HarmonyOS API)   |
| SM3    | 提供SM3生成摘要,HMAC等系列方法(基于HarmonyOS API) |
| SM4    | 提供SM4生成密钥加解密等系列方法(基于HarmonyOS API)   |
| SHA    | 提供SHA生成摘要,HMAC等系列方法(基于HarmonyOS API) |
| ECDSA  | 提供ECDSA签名验签等系列方法(基于HarmonyOS API)    |
| ECDH   | 提供ecdh动态协商密钥系列方法(基于HarmonyOS API)    |
| X25519 | 提供x25519动态协商密钥等系列方法(基于HarmonyOS API) |

### 同步方式

| 模块         | 介绍                                       |
|------------|------------------------------------------|
| RSASync    | 提供RSA同步方式生成密钥加解密验签等系列方法(基于HarmonyOS API) |
| AESSync    | 提供AES同步方式生成密钥加解密等系列方法(基于HarmonyOS API)   |
| DESSync    | 提供3DES同步方式生成密钥加解密等系列方法(基于HarmonyOS API)  |
| SM2Sync    | 提供SM2同步方式生成密钥加解密等系列方法(基于HarmonyOS API)   |
| SM3Sync    | 提供SM3同步方式生成摘要,HMAC等系列方法(基于HarmonyOS API) |
| SM4Sync    | 提供SM4同步方式生成密钥加解密等系列方法(基于HarmonyOS API)   |
| SHASync    | 提供SHA同步方式生成摘要,HMAC等系列方法(基于HarmonyOS API) |
| MD5        | 提供MD5生成摘要等系列方法(基于HarmonyOS API)          |
| ECDSASync  | 提供ECDSA同步方式签名验签等系列方法(基于HarmonyOS API)    |
| ECDHSync   | 提供ecdh同步方式动态协商密钥系列方法(基于HarmonyOS API)    |
| X25519Sync | 提供x25519同步方式动态协商密钥等系列方法(基于HarmonyOS API) |
| SHA1       | 提供SHA1的散列哈希算法                            |
| SM2Convert | 提供SM2ASN1与C1C3C2转换类                      |

## 📦安装

### 🍊ohpm

* 执行安装命令

```
ohpm install @yunkss/ef_crypto_dto
```

* 特殊说明

> ef_crypto_dto依赖于ef_core,故将依赖引入为dependencies方式,即开发者在使用ef_crypto_dto时无需自行引入ef_core,ef_crypto_dto会自动下载对应依赖版本

## 📦使用

### 1.在项目中引入插件

```
import { SM2, SM2Sync, AES, AESSync,xxxx} from '@yunkss/ef_crypto_dto'
```

类按需引入,项目需要使用那个就引入

### 2.ef_crypto_dto使用API

#### 异步方式

##### 1.RSA的方法【返回结果均为OutDTO对象】

* generateRSAKey 生成1024位RSA的非对称密钥

```
    const rsa = await RSA.generateRSAKey();
    console.error("generateRSAKey:" + rsa.getSuccess() + "---" + rsa.getMsg()
    + "\n" + "公钥:" + rsa.getDataRow().publicKey + "私钥:" + rsa.getDataRow().privateKey)
```

* generate2048RSAKey 生成2048位RSA的非对称密钥

```
    const rsa = await RSA.generate2048RSAKey();
    console.error("generateRSAKey:" + rsa.getSuccess() + "---" + rsa.getMsg()
    + "\n" + "公钥:" + rsa.getDataRow().publicKey + "私钥:" + rsa.getDataRow().privateKey)
```

* encodePKCS1 1024位加密

```
    let encode = await RSA.encodePKCS1('测试RSA-PKCS1加密字符串CSX~~', rsa.getDataRow().publicKey);
    this.message = encode.getDataRow();
```

* encodePKCS1Segment 1024位分段加密

```
    let encode = await RSA.encodePKCS1Segment('测试RSA-PKCS1分段加密字符串CSX~~', rsa.getDataRow().publicKey);
    this.message = encode.getDataRow();
```

* encode2048PKCS1 2048位加密

```
    let encode = await RSA.encode2048PKCS1('测试RSA-PKCS12048位加密字符串CSX~~', rsa.getDataRow().publicKey);
    this.message = encode.getDataRow();
```

* encode2048PKCS1Segment 2048位分段加密

```
    let encode = await RSA.encode2048PKCS1Segment('测试RSA-PKCS12048位分段加密字符串CSX~~', rsa.getDataRow().publicKey);
    this.message = encode.getDataRow();
```

* decodePKCS1 1024位解密

```
    let decode = await RSA.decodePKCS1(encode.getDataRow(), rsa.getDataRow().privateKey);
    this.message = decode.getDataRow();
```

* decodePKCS1Segment 1024位分段解密

```
    let decode = await RSA.decodePKCS1Segment(encode.getDataRow(), rsa.getDataRow().privateKey);
    this.message = decode.getDataRow();
```

* decode2048PKCS1 2048位解密

```
    let decode = await RSA.decode2048PKCS1(encode.getDataRow(), rsa.getDataRow().privateKey);
    this.message = decode.getDataRow();
```

* decode2048PKCS1Segment 2048位分段解密

```
    let decode = await RSA.decode2048PKCS1Segment(encode.getDataRow(), rsa.getDataRow().privateKey);
    this.message = decode.getDataRow();
```

* signPKCS1 1024位签名

```
    let sign = await RSA.signPKCS1('这个是RSA的验签字符串~~', rsa.getDataRow().privateKey);
    this.message = sign.getDataRow();
```

* sign2048PKCS1 2048位签名

```
    let sign = await RSA.sign2048PKCS1('这个是RSA的2048位验签字符串~~', rsa.getDataRow().privateKey);
    this.message = sign.getDataRow();
```

* verifyPKCS1 1024位验签

```
    let verify = await RSA.verifyPKCS1(sign.getDataRow(), '这个是RSA的验签字符串~~', rsa.getDataRow().publicKey);
    this.message = verify.getMsg();
```

* verify2048PKCS1 2048位验签

```
    let verify = await RSA.verify2048PKCS1(sign.getDataRow(), '这个是RSA的2048位验签字符串~~', rsa.getDataRow().publicKey);
    this.message = verify.getMsg();
```

* pemToStrKey 将pem文件中的数据转换成公钥字符串支持1024/2048字节

```
    //1024位示例
    //pem中数据支持没有回车符、换行符也支持每行以'\r\n'符结束
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
```

```
    //2048位示例
    //pem中数据支持没有回车符、换行符也支持每行以'\r\n'符结束
    let pubKey = RSA.pemToStrKey(`-----BEGIN PUBLIC KEY-----
                MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1nwHtqSbMNwjHKutrLUI
                +dMBCtoRb/SSY00ujBMsNPFdERxaizxgWVZbypVqgj3/4ZsZw9R65OyQu6oLqjA9
                Wk2nVLpPRtZNjwJgNRB4pYKf+RmLn35UdpIQC9/1+UUeoelboLEMCamCeXPCT5dv
                xqVheO+S6IOLiN6XGbkNZM2VBNtmAhIUVDLct2yH5YbD6plC8Tg+iMbiigG7r7Cs
                JE+Go5tb3BZjUYiF8fJ5ZKYCATkK4lO39rsXU8AAnw0duAq7LHk6xacwjyUA57S8
                0S3LFHcOyP7UoNfQ+cbV/z+72sYJV4RwO6AeE2Muz8jYR1GlcCW1wYBGNOpyRVKg
                4QIDAQAB
                -----END PUBLIC KEY-----`);
    let encode = await RSA.encode2048PKCS1('测试2048位RSA-PKCS1加密字符串CSX~~', pubKey);
    this.message = encode.getDataRow();
    //2048位pem私钥
    let priKey = RSA.pemToStrKey(`-----BEGIN RSA PRIVATE KEY-----
                MIIEpAIBAAKCAQEA1nwHtqSbMNwjHKutrLUI+dMBCtoRb/SSY00ujBMsNPFdERxa
                izxgWVZbypVqgj3/4ZsZw9R65OyQu6oLqjA9Wk2nVLpPRtZNjwJgNRB4pYKf+RmL
                n35UdpIQC9/1+UUeoelboLEMCamCeXPCT5dvxqVheO+S6IOLiN6XGbkNZM2VBNtm
                AhIUVDLct2yH5YbD6plC8Tg+iMbiigG7r7CsJE+Go5tb3BZjUYiF8fJ5ZKYCATkK
                4lO39rsXU8AAnw0duAq7LHk6xacwjyUA57S80S3LFHcOyP7UoNfQ+cbV/z+72sYJ
                V4RwO6AeE2Muz8jYR1GlcCW1wYBGNOpyRVKg4QIDAQABAoIBAB2ckhQNNb/RJKfY
                q+mkNNEI6KPu52llgrBi/4InQ3srt4WdPILsmwC6g4G8jy/cD2++UhhPRYhFgNXn
                7CRa9J17CxcPgdJt09dipJWu6HkxR5TEihpC/rZABCcfjH4VpN0FsrjEuLy8wl6y
                NKl4Zt4uBv8DVGz1fFYxJPtQKSE5YBSbvMD1thhViKOSyYp/pQfu00oz7/XK6iDE
                oHAhcdTBcBl9YW2WaXCnuX02FQkO5h8kjJbQd6pW4EfLLUxKjwcxcJ61DswcAaPw
                PN4+bgiwMak8H3IFrZVP24qs4ZOT3Yh7dl75OZXw7XcuBxsR/eCDlIe5VSSS+MId
                JCc42uECgYEA8jbvO07ESaVYvdij21knF+5Tdjg5rG2q0qsocWlxsE+8IkjzRAgF
                oovXqwoyDkhFJ/1N/PEnBqiQngbUhRSst49ICCQVv+fzRX2WjUNg4k2FtLO0jwgL
                Z+E6grMkMkv7VDIxyWlY5rYUC1yw6USFjgyMGQaWps8o4+JLsGJd9PsCgYEA4rER
                ecoYZndLRGmqMtmGZATDyNh6jGXzGF4XgHahnbhqgw3+7aTDXpA9W1TdGeBI4cQ9
                HQMjroJ+X/yx2JWysimnFxMXuU4eXZo3vMuebXB3lRe2QcloO1HobeSdUCosJ3qa
                Ks+f3UtN9Q8ZiPb5P0tA/fIbe6cwwQTQ1FLbQtMCgYEA0DpD3lOv0bRRHxygeVEi
                l6Muo0Jg6oh5Q5UbNqy0rSNPFJZsc/8FgSEBrqwcLkUZFvDf2+UhbMr7UK+Egkgs
                171Y6o7DF/D7JbF6/USAhOyqVpfrUM9UpuBs4bHKG2dQ0Kg6PvHPGMBNaRsth8x9
                mInW4yjT2OHdQFPqR9+48IMCgYBJXXkEa21+K/mGCJR2pIOj9w7N/5GZwpzsM/dz
                MfGYM8j05SCuFHbOMexJlKuB5l5wAqysqQlxPvZbZlLAf6I3mtdi1mEFLc0SCgkj
                5to9HPr2m5f2rpI3MIkCl8x510w28qzWUh+w5OA0AVEITLXZ0CcWiLZwTGmw7jgP
                n0kq1QKBgQDWDHZaEGCAYPxytix3tTCG3EIly8+fQJGt1lc0vgiiFcS0cW2pBbko
                rVvbu1gSJnmvj0dIObp55wwFBs30xEiMfli+83srOur6nxYUDgn9rqGcufn6hOeH
                ++y1uOHhOenfUTy51Gy1Dlv+maJ3LZ0ZnqPnbBdhZ1RtXFnczVKeFg==
                -----END RSA PRIVATE KEY-----`)
    let decode = await RSA.decode2048PKCS1(encode.getDataRow(), priKey);
```

##### 2.AES的方法【返回结果均为OutDTO对象】

* generateAESKey 生成AES的对称密钥

```
    const aes = await  AES.generateAESKey();
    console.error("是否成功:" + aes.getSuccess() + "消息===:" + aes.getMsg() + "密钥======:", aes.getDataRow());
```

* generateAESKey128 生成128位AES的对称密钥

```
    const aes = await  AES.generateAESKey128();
    console.error("是否成功:" + aes.getSuccess() + "消息===:" + aes.getMsg() + "密钥======:", aes.getDataRow());
```

* encodeGCM 加密-GCM模式

```
    let encodeGCM = await AES.encodeGCM('测试加密字符串Test!', aes.getDataRow());
    this.message = encodeGCM.getDataRow();
```

* decodeGCM 解密-GCM模式

```
    let decodeGCM = await AES.decodeGCM(encodeGCM.getDataRow(), aes.getDataRow());
    this.message = decodeGCM.getDataRow();
```

* encodeCBC 加密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
    let encode = await AES.encodeCBC('测试CBC加密字符串Test!', aes.getDataRow(), iv.getDataRow());
    this.message = encode.getDataRow();
```

* decodeCBC 解密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
    let decode = await AES.decodeCBC(encode.getDataRow(),aes.getDataRow(), iv.getDataRow());
    this.message = decode.getDataRow();
```

* encodeCBC128 加密-CBC模式-128位 需要传入iv偏移量字符串(IV生成详见RandomUtil)(1.1.13+)

```
    let encode = await AES.encodeCBC128('测试CBC加密字符串Test!','TESTsdiloia20230','ass3[2K8%fw68sw7');
    this.message = encode.getDataRow();
```

* decodeCBC128 解密-CBC模式-128位 需要传入iv偏移量字符串(IV生成详见RandomUtil)(1.1.13+)

```
    let decode = await AES.decodeCBC128(encode.getDataRow(),'TESTsdiloia20230','ass3[2K8%fw68sw7');
    this.message = decode.getDataRow();
```

* encodeECB 加密-ECB模式

```
    let encode = await AES.encodeECB('此处为共享密钥加密的数据~~~~~~', aesKey);
    this.message = encode.getDataRow();
```

* decodeECB 解密-ECB模式

```
    let decode = await AES.decodeECB(encode.getDataRow(), aesKey);
    this.message = decode.getDataRow();
```

* encodeECB128 加密-ECB模式-128位

```
    let encode = await AES.encodeECB128('此处为共享密钥加密的数据~~~~~~', aesKey);
    this.message = encode.getDataRow();
```

* decodeECB128 解密-ECB模式-128位

```
    let decode = await AES.decodeECB128(encode.getDataRow(), aesKey);
    this.message = decode.getDataRow();
```

##### 3.3DES的方法【返回结果均为OutDTO对象】

* generate3DESKey 生成3DES的对称密钥

```
    let des = await DES.generate3DESKey();
    console.error("是否成功:" + des.getSuccess() + "消息===:" + des.getMsg() + "密钥======:", des.getDataRow());
```

* encodeECB 加密-ECB模式

```
    let encodeECB = await DES.encodeECB('测试3DES-ECB加密字符串Test!', des.getDataRow());
    this.message = encodeECB.getDataRow();
```

* decodeECB 解密-ECB模式

```
    let decodeECB = await DES.decodeECB(encodeECB.getDataRow(), des.getDataRow());
    this.message = decodeECB.getDataRow();
```

* encodeCBC 加密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
    let encodeCBC = await DES.encodeCBC('测试3DES-CBC加密字符串Test!', des.getDataRow(), iv.getDataRow());
    this.message = encodeCBC.getDataRow();
```

* decodeCBC 解密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
    let decodeCBC = await DES.decodeCBC(encodeCBC.getDataRow(), des.getDataRow(), iv.getDataRow());
    this.message = decodeCBC.getDataRow();
```

##### 4.SM2的方法【返回结果均为OutDTO对象】

* generateSM2Key 生成SM2的非对称密钥

```
    let sm2 = await SM2.generateSM2Key();
    console.error("generateSM2Key:" + sm2.getSuccess() + "---" + sm2.getMsg()
    + "\n" + "公钥:" + sm2.getDataRow().publicKey + "私钥:" + sm2.getDataRow().privateKey)
```

* encode 加密

```
    let encode = await SM2.encode('测试SM2加密字符串CSX~~', sm2.getDataRow().publicKey);
    this.message = encode.getDataRow();
```

* decode 解密

```
    let decode = await SM2.decode(encode.getDataRow(), sm2.getDataRow().privateKey);
    this.message = decode.getDataRow();
```

* sign 签名

```
    let sign = await SM2.sign('这个是SM2的验签字符串~~', sm2.getDataRow().privateKey);
    this.message = sign.getDataRow();
```

* verify 验签

```
    let verify = await SM2.verify(sign.getDataRow(), '这个是SM2的验签字符串~~', sm2.getDataRow().publicKey);
    this.message = verify.getMsg();
```

* convertSM2PubKey 将服务器端生成的16进制的长度为130位的04开头的C1C3C2格式的SM2公钥转换为前端所需的ASN

```
    //C1C3C2格式的公钥字符串
    let pk = '04ba3bc3c5834d9ad1a7d81c4b49cf1209d2f28e4a97c73b75d6561792a2bfafe811e0284692006b0ce1b51f8aadfd65241d80eb979365048253408f5d705ec17b';
    //转换后的ASN.1格式的字符串
    let s = await SM2.convertSM2PubKey(pk);
    let code = await SM2.encode('加密字符~~~~~', s.getDataRow());
    let ddd = code.getDataRow();
```

* convertSM2PriKey 将服务器端生成的16进制的长度为64位的C1C3C2格式的SM2私钥转换为前端所需的ASN

```
    //C1C3C2格式的私钥字符串
    let pik = '7713d336bcbbffb8b7f9cab8db984a5c989a0b07697f569a06d5cd38e1351d07';
    //转换后的ASN.1格式的字符串
    let dc = await SM2.convertSM2PriKey(pik);
    let aaaa = await SM2.decode(ddd, dc.getDataRow());
    this.message = aaaa.getDataRow();
```

##### 5.SM3的方法【返回结果均为OutDTO对象】

* digest SM3摘要

```
    let sm3 = await SM3.digest('使用SM3进行摘要数据~~~');
    this.message = sm3.getDataRow();
```

* hmac 消息认证码计算

```
    let hmac1 = await SM3.hmac('这个是SM3的HMAC~~~');
    this.message = hmac1.getDataRow();
```

##### 6.SM4的方法【返回结果均为OutDTO对象】

* generateSM4Key 生成SM4的对称密钥

```
    let sm4 = await SM4.generateSM4Key();
    console.error("是否成功:" + sm4.getSuccess() + "消息===:" + sm4.getMsg() + "密钥======:", sm4.getDataRow());
```

* encodeECB 加密-ECB模式

```
    let encodeECB = await SM4.encodeECB('测试SM4加密字符串Test!', sm4.getDataRow());
    this.message = encodeECB.getDataRow();
```

* decodeECB 解密-ECB模式

```
    let decodeECB = await SM4.decodeECB(encodeECB.getDataRow(), sm4.getDataRow());
    this.message = decodeECB.getDataRow();
```

* encodeCBC 加密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
    let encodeCBC = await SM4.encodeCBC('测试SM4的CBC加密字符串Test!', sm4.getDataRow(), iv.getDataRow());
    this.message = encodeCBC.getDataRow();
```

* decodeCBC 解密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
    let decodeCBC = await SM4.decodeCBC(encodeCBC.getDataRow(), sm4.getDataRow(), iv.getDataRow());
    this.message = decodeCBC.getDataRow();
```

##### 7.SHA的方法【返回结果均为OutDTO对象】

* digest 摘要方法

```
    let digest = await SHA.digest('这个是SHA的摘要方法~~');
    this.message = digest.getDataRow();
```

* digestSHA1 SHA1摘要

```
    let digest = await SHA.digestSHA1('这个是SHA的摘要方法~~');
    this.message = digest.getDataRow();
```

* digestSHA224 SHA224摘要

```
    let digest = await SHA.digestSHA224('这个是SHA的摘要方法~~');
    this.message = digest.getDataRow();
```

* digestSHA384 SHA384摘要

```
    let digest = await SHA.digestSHA384('这个是SHA的摘要方法~~');
    this.message = digest.getDataRow();
```

* digestSHA512 SHA512摘要

```
    let digest = await SHA.digestSHA512('这个是SHA的摘要方法~~');
    this.message = digest.getDataRow();
```

* hmac 消息认证码计算

```
    let hmac2 = await SHA.hmac('这个是SHA的HMAC');
    this.message = hmac2.getDataRow();
```

##### 8.ECDSA的方法【返回结果均为OutDTO对象】

* generateECDSAKey 生成ECDSA的非对称密钥

```
    let ecdsa = await ECDSA.generateECDSAKey();
    console.error("generateECDSAKey:" + ecdsa.getSuccess() + "---" + ecdsa.getMsg()
    + "\n" + "公钥:" + ecdsa.getDataRow().publicKey + "私钥:" + ecdsa.getDataRow().privateKey)
```

* sign 签名

```
    let sign = await ECDSA.sign('这个是ECDSA的验签字符串~~', ecdsa.getDataRow().privateKey);
    this.message = sign.getDataRow();
```

* verify 验签

```
    let verify = await ECDSA.verify(sign.getDataRow(), '这个是ECDSA的验签字符串~~', ecdsa.getDataRow().publicKey);
    this.message = verify.getMsg();
```

##### 9.ECDH的方法【返回结果均为OutDTO对象】

* ecdh 动态协商密钥,要求密钥长度为256位的非对称密钥

```
    //1.测试随机生成的一种256长度的字符串公私钥秘钥
    let ecdsa = await ECDSA.generateECDSAKey();
    //将对方的公钥和自己的私钥传入生成256位的共享秘钥
    let symKey = await ECDH.ecdh(ecdsa.getDataRow().publicKey, ecdsa.getDataRow().privateKey);
    //可以进行对称加密 注意对称加解密也需要为256位
    let encode = await CryptoUtil.encodeECB('测试共享密钥加密数据~~~', symKey.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = encode.getDataRow();
    //对称解密
    let decode = await CryptoUtil.decodeECB(encode.getDataRow(), symKey.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = decode.getDataRow();
    
```

```
    //2.测试随机生成的一种256长度的字节流Uint8Array形式的公私钥秘钥
    // 创建非对称密钥生成器
    let rsaGenerator = crypto.createAsyKeyGenerator('ECC256');
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseKeyPair = await rsaGenerator.generateKeyPair();
    // 转换成可以读懂的公私钥字符串
    let pubKey = promiseKeyPair.pubKey.getEncoded().data;
    let priKey = promiseKeyPair.priKey.getEncoded().data;
    //获取到贡献密钥
    let symKey = await ECDH.ecdh(pubKey, priKey);
    //可以进行对称加密 注意对称加解密也需要为256位
    let encode = await CryptoUtil.encodeECB('测试共享密钥加密数据~~~', symKey.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = encode.getDataRow();
    //对称解密
    let decode = await CryptoUtil.decodeECB(encode.getDataRow(), symKey.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = decode.getDataRow();
```

##### 10.X25519的方法【返回结果均为OutDTO对象】

* x25519 X25519动态协商密钥,要求密钥长度为256位的非对称密钥

```
    //1.测试随机生成的一种256长度的字符串公私钥秘钥
    let x25519Key = await CryptoUtil.generateCryptoKey('X25519');
    //将对方的公钥和自己的私钥传入生成256位的共享秘钥
    let x25519 = await X25519.x25519(x25519Key.getDataRow().publicKey, x25519Key.getDataRow().privateKey);
    this.message = x25519.getDataRow();
    //可以进行对称加密 注意对称加解密也需要为256位
    let encode = await CryptoUtil.encodeECB('测试共享密钥加密数据~~~', x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = encode.getDataRow();
    //对称解密
    let decode = await CryptoUtil.decodeECB(encode.getDataRow(), x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = decode.getDataRow();
```

```
    //2.测试随机生成的一种256长度的字节流Uint8Array形式的公私钥秘钥
    let rsaGenerator = crypto.createAsyKeyGenerator('X25519');
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseKeyPair = await rsaGenerator.generateKeyPair();
    // 转换成可以读懂的公私钥字符串
    let pubKey = promiseKeyPair.pubKey.getEncoded().data;
    let priKey = promiseKeyPair.priKey.getEncoded().data;
    let x25519 = await X25519.x25519(pubKey, priKey);
    //可以进行对称加密 注意对称加解密也需要为256位
    let encode = await CryptoUtil.encodeECB('测试共享密钥加密数据~~~', x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = encode.getDataRow();
    //对称解密
    let decode = await CryptoUtil.decodeECB(encode.getDataRow(), x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = decode.getDataRow();
```

#### 同步方式

##### 1.RSASync的方法【返回结果均为OutDTO对象】

* generateRSAKey 生成1024位RSA的非对称密钥

```
   /**
   * 生成RSA的非对称密钥
   * @param resultCoding 生成RSA秘钥的字符串格式(hex/base64)-默认不传为base64格式
   * @returns RSA密钥{publicKey:公钥,privateKey:私钥}
   */
   let key = RSASync.generateRSAKey();  //base64格式
   let keyHex = RSASync.generateRSAKey('hex');   //hex格式

```

* generate2048RSAKey 生成2048位RSA的非对称密钥

```
   /**
   * 生成2048位RSA的非对称密钥
   * @param resultCoding 生成RSA秘钥的字符串格式(hex/base64)-默认不传为base64格式
   * @returns 2048位RSA密钥{publicKey:2048位公钥,privateKey:2048位私钥}
   */
   let key = RSASync.generate2048RSAKey();  //base64格式
   let keyHex = RSASync.generate2048RSAKey('hex');   //hex格式
```

* encodePKCS1 1024位加密

```
   /**
   * 1024位加密
   * @param str  待加密的字符串
   * @param pubKey  RSA公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   */
   
   //key为base64格式，加密后生成为base64
   let encode1024 = RSASync.encodePKCS1('测试RSA1024加密~~~', key.getDataRow().publicKey, 'base64');
   //key为hex格式,加密后生成默认为base64
   let encodeHex = RSASync.encodePKCS1('测试RSA1024-HEX加密~~~', keyHex.getDataRow().publicKey, 'hex');
   //key为hex格式,加密后生成格式为hex
   let encodeHex = RSASync.encodePKCS1('测试RSA1024-HEX加密~~~', keyHex.getDataRow().publicKey, 'hex', 'hex');
   
   //pem格式的key
   let pemPubKey = `-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDOKeI9M56EDZ7yLJB56lKWb180
eGfPrYiAG9IbjEEK8FfNvZuDrCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQC
HMy+lrOq3rpeDfFiiT7zwvXft2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1
eTXVu7hjXEqmrGXmgwIDAQAB
-----END PUBLIC KEY-----`;
   //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //加密后生成内容为hex格式
   let encodePem = RSASync.encodePKCS1('测试pem格式的1024位RSA加密~~', pemPubKey, 'base64', 'hex', true);
   
```

* encodePKCS1Segment 1024位分段加密

```
   /**
   * 加密-分段
   * @param str  待加密的字符串
   * @param pubKey  RSA公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   */
   
   //key为base64格式，加密后生成为base64
   let encode1024 = RSASync.encodePKCS1Segment('测试RSA1024加密~~~', key.getDataRow().publicKey, 'base64');
   //key为hex格式,加密后生成默认为base64
   let encodeHex = RSASync.encodePKCS1Segment('测试RSA1024-HEX加密~~~', keyHex.getDataRow().publicKey, 'hex');
   //key为hex格式,加密后生成格式为hex
   let encodeHex = RSASync.encodePKCS1Segment('测试RSA1024-HEX加密~~~', keyHex.getDataRow().publicKey, 'hex', 'hex');
   
   //pem格式的key
   let pemPubKey = `-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDOKeI9M56EDZ7yLJB56lKWb180
eGfPrYiAG9IbjEEK8FfNvZuDrCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQC
HMy+lrOq3rpeDfFiiT7zwvXft2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1
eTXVu7hjXEqmrGXmgwIDAQAB
-----END PUBLIC KEY-----`;
   //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //加密后生成内容为hex格式
   let encodePem = RSASync.encodePKCS1Segment('测试pem格式的1024位RSA加密~~', pemPubKey, 'base64', 'hex', true);
   
```

* encode2048PKCS1 2048位加密

```
   /**
   * 2048位加密
   * @param str  待加密的字符串
   * @param pubKey  2048位RSA公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   */
   
   //key为base64格式，加密后生成为base64
   let encode1024 = RSASync.encode2048PKCS1('测试RSA1024加密~~~', key.getDataRow().publicKey, 'base64');
   //key为hex格式,加密后生成默认为base64
   let encodeHex = RSASync.encode2048PKCS1('测试RSA1024-HEX加密~~~', keyHex.getDataRow().publicKey, 'hex');
   //key为hex格式,加密后生成格式为hex
   let encodeHex = RSASync.encode2048PKCS1('测试RSA1024-HEX加密~~~', keyHex.getDataRow().publicKey, 'hex', 'hex');
   
   //pem格式的key
   let pemPubKey = `-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDOKeI9M56EDZ7yLJB56lKWb180
eGfPrYiAG9IbjEEK8FfNvZuDrCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQC
HMy+lrOq3rpeDfFiiT7zwvXft2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1
eTXVu7hjXEqmrGXmgwIDAQAB
-----END PUBLIC KEY-----`;
   //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //加密后生成内容为hex格式
   let encodePem = RSASync.encode2048PKCS1('测试pem格式的1024位RSA加密~~', pemPubKey, 'base64', 'hex', true);
   
```

* encode2048PKCS1Segment 2048位分段加密

```
   /**
   * 2048位加密-分段
   * @param str  待加密的字符串
   * @param pubKey  2048位RSA公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   */
    
    //key为base64格式，加密后生成为base64
   let encode1024 = RSASync.encode2048PKCS1Segment('测试RSA1024加密~~~', key.getDataRow().publicKey, 'base64');
   //key为hex格式,加密后生成默认为base64
   let encodeHex = RSASync.encode2048PKCS1Segment('测试RSA1024-HEX加密~~~', keyHex.getDataRow().publicKey, 'hex');
   //key为hex格式,加密后生成格式为hex
   let encodeHex = RSASync.encode2048PKCS1Segment('测试RSA1024-HEX加密~~~', keyHex.getDataRow().publicKey, 'hex', 'hex');
   
   //pem格式的key
   let pemPubKey = `-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDOKeI9M56EDZ7yLJB56lKWb180
eGfPrYiAG9IbjEEK8FfNvZuDrCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQC
HMy+lrOq3rpeDfFiiT7zwvXft2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1
eTXVu7hjXEqmrGXmgwIDAQAB
-----END PUBLIC KEY-----`;
   //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //加密后生成内容为hex格式
   let encodePem = RSASync.encode2048PKCS1Segment('测试pem格式的1024位RSA加密~~', pemPubKey, 'base64', 'hex', true);
```

* decodePKCS1 1024位解密

```
   /**
   * 解密
   * @param decodeStr  待解密的字符串
   * @param priKey    RSA私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   */
    
    //key为base64,待解密内容不传默认为base64格式
    let decode1024 = RSASync.decodePKCS1(encode1024.getDataRow(), key1024.getDataRow().privateKey, 'base64');
    //key为hex,待解密内容不传默认为base64格式
    let decode1024Hex = RSASync.decodePKCS1(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex');
    //key为hex,待解密内容为hex格式
    let decode1024Hex = RSASync.decodePKCS1(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex', 'hex');
    
    //pem格式的key
    let pemPriKey = `-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDOKeI9M56EDZ7yLJB56lKWb180eGfPrYiAG9IbjEEK8FfNvZuD
rCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQCHMy+lrOq3rpeDfFiiT7zwvXf
t2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1eTXVu7hjXEqmrGXmgwIDAQAB
AoGAS/36S67kRi6zIPc2RgoOaS8iO7gKI+4GO5qFpuva6cpPwyGZ2j4vpnooLlgC
GqBe+Z7AhGzB90D45TQXlexwJ6xrXDN/9w0mCPItTfe5QxtvK2i0z9unoYXJcNwN
rSbbv1mBzJHybXcZgt9J2zFnsohAFPWGKVZrhDfyiecS0pkCQQD3WMY+hZVX5CLD
ojfUrfiSXDh+qd+aeo6dMYDYaOhW23oJ0OHNm6vYKZ+xiEf3OB0BduZofSWHALim
qVFF1bg1AkEA1WBGYd+/FHku+t17G6xRnWuDWI6A3ZyVuGv3wfRL5W8hKiJ1Urk3
ftllxQ4YVEIgaeET/0xSQ9H5KB2px+Gq1wJAGjJHxMVnHMjnuaqLmTXXtsCXpyqc
qQLD6fgdOk5aFSDnmvSJhbowCBPYevgBDzjdMZODMZvXhqXX6KbUGb5Z5QJBAJ+R
OdEjtA+peFqemtvdB8PDjRwCpZgU61pZU5S2DrPrYU/TKQ3N+RRhm1u76LHKKddE
POIkvzh8o+k+FaOmvU0CQBNhCHc2ufGNc88MZmTwxHpGom177f9p/YPiYcg5w3Ej
8xL+hatfA2Ls3Wg/P3gfm8raHbWzC3ge/JSk/LC/ygk=
-----END RSA PRIVATE KEY-----`;
    //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //加密后生成内容为hex格式
    let decodePem = RSASync.decodePKCS1(encodePem.getDataRow(), pemPriKey, 'base64', 'hex', true);
```

* decodePKCS1Segment 1024位分段解密

```
   /**
   * 解密-分段
   * @param decodeStr  待解密的字符串
   * @param priKey    RSA私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   */
   
   //key为base64,待解密内容不传默认为base64格式
    let decode1024 = RSASync.decodePKCS1Segment(encode1024.getDataRow(), key1024.getDataRow().privateKey, 'base64');
    //key为hex,待解密内容不传默认为base64格式
    let decode1024Hex = RSASync.decodePKCS1Segment(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex');
    //key为hex,待解密内容为hex格式
    let decode1024Hex = RSASync.decodePKCS1Segment(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex', 'hex');
    
    //pem格式的key
    let pemPriKey = `-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDOKeI9M56EDZ7yLJB56lKWb180eGfPrYiAG9IbjEEK8FfNvZuD
rCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQCHMy+lrOq3rpeDfFiiT7zwvXf
t2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1eTXVu7hjXEqmrGXmgwIDAQAB
AoGAS/36S67kRi6zIPc2RgoOaS8iO7gKI+4GO5qFpuva6cpPwyGZ2j4vpnooLlgC
GqBe+Z7AhGzB90D45TQXlexwJ6xrXDN/9w0mCPItTfe5QxtvK2i0z9unoYXJcNwN
rSbbv1mBzJHybXcZgt9J2zFnsohAFPWGKVZrhDfyiecS0pkCQQD3WMY+hZVX5CLD
ojfUrfiSXDh+qd+aeo6dMYDYaOhW23oJ0OHNm6vYKZ+xiEf3OB0BduZofSWHALim
qVFF1bg1AkEA1WBGYd+/FHku+t17G6xRnWuDWI6A3ZyVuGv3wfRL5W8hKiJ1Urk3
ftllxQ4YVEIgaeET/0xSQ9H5KB2px+Gq1wJAGjJHxMVnHMjnuaqLmTXXtsCXpyqc
qQLD6fgdOk5aFSDnmvSJhbowCBPYevgBDzjdMZODMZvXhqXX6KbUGb5Z5QJBAJ+R
OdEjtA+peFqemtvdB8PDjRwCpZgU61pZU5S2DrPrYU/TKQ3N+RRhm1u76LHKKddE
POIkvzh8o+k+FaOmvU0CQBNhCHc2ufGNc88MZmTwxHpGom177f9p/YPiYcg5w3Ej
8xL+hatfA2Ls3Wg/P3gfm8raHbWzC3ge/JSk/LC/ygk=
-----END RSA PRIVATE KEY-----`;
    //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //加密后生成内容为hex格式
    let decodePem = RSASync.decodePKCS1Segment(encodePem.getDataRow(), pemPriKey, 'base64', 'hex', true);
```

* decode2048PKCS1 2048位解密

```
   /**
   * 2048位解密
   * @param decodeStr  待解密的字符串
   * @param priKey    2048位RSA私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   */
   
   //key为base64,待解密内容不传默认为base64格式
    let decode1024 = RSASync.decode2048PKCS1(encode1024.getDataRow(), key1024.getDataRow().privateKey, 'base64');
    //key为hex,待解密内容不传默认为base64格式
    let decode1024Hex = RSASync.decode2048PKCS1(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex');
    //key为hex,待解密内容为hex格式
    let decode1024Hex = RSASync.decode2048PKCS1(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex', 'hex');
    
    //pem格式的key
    let pemPriKey = `-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDOKeI9M56EDZ7yLJB56lKWb180eGfPrYiAG9IbjEEK8FfNvZuD
rCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQCHMy+lrOq3rpeDfFiiT7zwvXf
t2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1eTXVu7hjXEqmrGXmgwIDAQAB
AoGAS/36S67kRi6zIPc2RgoOaS8iO7gKI+4GO5qFpuva6cpPwyGZ2j4vpnooLlgC
GqBe+Z7AhGzB90D45TQXlexwJ6xrXDN/9w0mCPItTfe5QxtvK2i0z9unoYXJcNwN
rSbbv1mBzJHybXcZgt9J2zFnsohAFPWGKVZrhDfyiecS0pkCQQD3WMY+hZVX5CLD
ojfUrfiSXDh+qd+aeo6dMYDYaOhW23oJ0OHNm6vYKZ+xiEf3OB0BduZofSWHALim
qVFF1bg1AkEA1WBGYd+/FHku+t17G6xRnWuDWI6A3ZyVuGv3wfRL5W8hKiJ1Urk3
ftllxQ4YVEIgaeET/0xSQ9H5KB2px+Gq1wJAGjJHxMVnHMjnuaqLmTXXtsCXpyqc
qQLD6fgdOk5aFSDnmvSJhbowCBPYevgBDzjdMZODMZvXhqXX6KbUGb5Z5QJBAJ+R
OdEjtA+peFqemtvdB8PDjRwCpZgU61pZU5S2DrPrYU/TKQ3N+RRhm1u76LHKKddE
POIkvzh8o+k+FaOmvU0CQBNhCHc2ufGNc88MZmTwxHpGom177f9p/YPiYcg5w3Ej
8xL+hatfA2Ls3Wg/P3gfm8raHbWzC3ge/JSk/LC/ygk=
-----END RSA PRIVATE KEY-----`;
    //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //加密后生成内容为hex格式
    let decodePem = RSASync.decode2048PKCS1(encodePem.getDataRow(), pemPriKey, 'base64', 'hex', true);
```

* decode2048PKCS1Segment 2048位分段解密

```
   /**
   * 2048位解密-分段
   * @param decodeStr  待解密的字符串
   * @param priKey    2048位RSA私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   */
   
   //key为base64,待解密内容不传默认为base64格式
    let decode1024 = RSASync.decode2048PKCS1Segment(encode1024.getDataRow(), key1024.getDataRow().privateKey, 'base64');
    //key为hex,待解密内容不传默认为base64格式
    let decode1024Hex = RSASync.decode2048PKCS1Segment(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex');
    //key为hex,待解密内容为hex格式
    let decode1024Hex = RSASync.decode2048PKCS1Segment(encode1024Hex.getDataRow(), key1024Hex.getDataRow().privateKey, 'hex', 'hex');
    
    //pem格式的key
    let pemPriKey = `-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDOKeI9M56EDZ7yLJB56lKWb180eGfPrYiAG9IbjEEK8FfNvZuD
rCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQCHMy+lrOq3rpeDfFiiT7zwvXf
t2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1eTXVu7hjXEqmrGXmgwIDAQAB
AoGAS/36S67kRi6zIPc2RgoOaS8iO7gKI+4GO5qFpuva6cpPwyGZ2j4vpnooLlgC
GqBe+Z7AhGzB90D45TQXlexwJ6xrXDN/9w0mCPItTfe5QxtvK2i0z9unoYXJcNwN
rSbbv1mBzJHybXcZgt9J2zFnsohAFPWGKVZrhDfyiecS0pkCQQD3WMY+hZVX5CLD
ojfUrfiSXDh+qd+aeo6dMYDYaOhW23oJ0OHNm6vYKZ+xiEf3OB0BduZofSWHALim
qVFF1bg1AkEA1WBGYd+/FHku+t17G6xRnWuDWI6A3ZyVuGv3wfRL5W8hKiJ1Urk3
ftllxQ4YVEIgaeET/0xSQ9H5KB2px+Gq1wJAGjJHxMVnHMjnuaqLmTXXtsCXpyqc
qQLD6fgdOk5aFSDnmvSJhbowCBPYevgBDzjdMZODMZvXhqXX6KbUGb5Z5QJBAJ+R
OdEjtA+peFqemtvdB8PDjRwCpZgU61pZU5S2DrPrYU/TKQ3N+RRhm1u76LHKKddE
POIkvzh8o+k+FaOmvU0CQBNhCHc2ufGNc88MZmTwxHpGom177f9p/YPiYcg5w3Ej
8xL+hatfA2Ls3Wg/P3gfm8raHbWzC3ge/JSk/LC/ygk=
-----END RSA PRIVATE KEY-----`;
    //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //加密后生成内容为hex格式
    let decodePem = RSASync.decode2048PKCS1Segment(encodePem.getDataRow(), pemPriKey, 'base64', 'hex', true);
```

* signPKCS1 1024位签名

```
   /**
   * 签名-PKCS1
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   * @returns OutDTO<string> 签名对象
   */
   
   //pem格式的key
   let pemPriKey = `-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDOKeI9M56EDZ7yLJB56lKWb180eGfPrYiAG9IbjEEK8FfNvZuD
rCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQCHMy+lrOq3rpeDfFiiT7zwvXf
t2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1eTXVu7hjXEqmrGXmgwIDAQAB
AoGAS/36S67kRi6zIPc2RgoOaS8iO7gKI+4GO5qFpuva6cpPwyGZ2j4vpnooLlgC
GqBe+Z7AhGzB90D45TQXlexwJ6xrXDN/9w0mCPItTfe5QxtvK2i0z9unoYXJcNwN
rSbbv1mBzJHybXcZgt9J2zFnsohAFPWGKVZrhDfyiecS0pkCQQD3WMY+hZVX5CLD
ojfUrfiSXDh+qd+aeo6dMYDYaOhW23oJ0OHNm6vYKZ+xiEf3OB0BduZofSWHALim
qVFF1bg1AkEA1WBGYd+/FHku+t17G6xRnWuDWI6A3ZyVuGv3wfRL5W8hKiJ1Urk3
ftllxQ4YVEIgaeET/0xSQ9H5KB2px+Gq1wJAGjJHxMVnHMjnuaqLmTXXtsCXpyqc
qQLD6fgdOk5aFSDnmvSJhbowCBPYevgBDzjdMZODMZvXhqXX6KbUGb5Z5QJBAJ+R
OdEjtA+peFqemtvdB8PDjRwCpZgU61pZU5S2DrPrYU/TKQ3N+RRhm1u76LHKKddE
POIkvzh8o+k+FaOmvU0CQBNhCHc2ufGNc88MZmTwxHpGom177f9p/YPiYcg5w3Ej
8xL+hatfA2Ls3Wg/P3gfm8raHbWzC3ge/JSk/LC/ygk=
-----END RSA PRIVATE KEY-----`;
   //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //签名后的内容格式为base64
   let sign = RSASync.signPKCS1('待签名的RSA的pem格式的字符串~', pemPriKey, 'base64', 'base64', true);

```

* sign2048PKCS1 2048位签名

```
   /**
   * 2048位签名-PKCS1
   * @param str  需要签名的字符串
   * @param priKey  2048位私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   * @returns OutDTO<string> 签名对象
   */
   
   //pem格式的key
   let pemPriKey = `-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDOKeI9M56EDZ7yLJB56lKWb180eGfPrYiAG9IbjEEK8FfNvZuD
rCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQCHMy+lrOq3rpeDfFiiT7zwvXf
t2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1eTXVu7hjXEqmrGXmgwIDAQAB
AoGAS/36S67kRi6zIPc2RgoOaS8iO7gKI+4GO5qFpuva6cpPwyGZ2j4vpnooLlgC
GqBe+Z7AhGzB90D45TQXlexwJ6xrXDN/9w0mCPItTfe5QxtvK2i0z9unoYXJcNwN
rSbbv1mBzJHybXcZgt9J2zFnsohAFPWGKVZrhDfyiecS0pkCQQD3WMY+hZVX5CLD
ojfUrfiSXDh+qd+aeo6dMYDYaOhW23oJ0OHNm6vYKZ+xiEf3OB0BduZofSWHALim
qVFF1bg1AkEA1WBGYd+/FHku+t17G6xRnWuDWI6A3ZyVuGv3wfRL5W8hKiJ1Urk3
ftllxQ4YVEIgaeET/0xSQ9H5KB2px+Gq1wJAGjJHxMVnHMjnuaqLmTXXtsCXpyqc
qQLD6fgdOk5aFSDnmvSJhbowCBPYevgBDzjdMZODMZvXhqXX6KbUGb5Z5QJBAJ+R
OdEjtA+peFqemtvdB8PDjRwCpZgU61pZU5S2DrPrYU/TKQ3N+RRhm1u76LHKKddE
POIkvzh8o+k+FaOmvU0CQBNhCHc2ufGNc88MZmTwxHpGom177f9p/YPiYcg5w3Ej
8xL+hatfA2Ls3Wg/P3gfm8raHbWzC3ge/JSk/LC/ygk=
-----END RSA PRIVATE KEY-----`;
   //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //签名后的内容格式为base64
   let sign = RSASync.sign2048PKCS1('待签名的RSA的pem格式的字符串~', pemPriKey, 'base64', 'base64', true);
```

* verifyPKCS1 1024位验签

```
   /**
   * 验签-PKCS1
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  RSA公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
   
   //pem格式的key
   let pemPubKey = `-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDOKeI9M56EDZ7yLJB56lKWb180
eGfPrYiAG9IbjEEK8FfNvZuDrCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQC
HMy+lrOq3rpeDfFiiT7zwvXft2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1
eTXVu7hjXEqmrGXmgwIDAQAB
-----END PUBLIC KEY-----`;
   //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //待验签的内容为base64 
   let verify =RSASync.verifyPKCS1(sign.getDataRow(), '待签名的RSA的pem格式的字符串~', pemPubKey, 'base64', 'base64', true);

```

* verify2048PKCS1 2048位验签

```
   /**
   * 2048位验签-PKCS1
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  2048位RSA公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @param isPem 秘钥是否为pem格式 - 默认为false
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
   
   //pem格式的key
   let pemPubKey = `-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDOKeI9M56EDZ7yLJB56lKWb180
eGfPrYiAG9IbjEEK8FfNvZuDrCGqCEXc7L/W/kojj9Fnxae5aRMAvd7PLaTD3UQC
HMy+lrOq3rpeDfFiiT7zwvXft2IGTlWYn29vA5g2elb0x7+WIhwQBByubor+YAr1
eTXVu7hjXEqmrGXmgwIDAQAB
-----END PUBLIC KEY-----`;
   //key为pem格式时最后一个参数isPem需要为true
   //key为base64格式
   //待验签的内容为base64 
   let verify =RSASync.verify2048PKCS1(sign.getDataRow(), '待签名的RSA的pem格式的字符串~', pemPubKey, 'base64', 'base64', true);
```

* <s>pemToStrKey 将pem文件中的数据转换成公钥字符串支持1024/2048字节(RSASync中的加解密方法已经支持pem格式密钥)</s>

##### 2.AESSync的方法【返回结果均为OutDTO对象】

* generateAESKey 生成AES的对称密钥

```
    /**
    * 生成AES的对称密钥-默认base64
    * @param resultCoding 生成AES秘钥的字符串格式(hex/base64)-默认不传为base64格式
    * @returns AES密钥
    */
    //默认生成base64格式
    let key = AESSync.generateAESKey();
    //生成hex格式
    let keyHex = AESSync.generateAESKey('hex');
```

* generateAESKey128 生成128位AES的对称密钥

```
    /**
    * 生成AES的对称密钥-128位-默认base64
    * @param resultCoding 生成AES秘钥的字符串格式(hex/base64)-默认不传为base64格式
    * @returns AES密钥-128位
    */ 
    //默认生成base64格式
    let key = AESSync.generateAESKey128();
    //生成hex格式
    let keyHex = AESSync.generateAESKey128('hex');
```

* generateAESKey192 生成192位AES的对称密钥

```
    /**
    * 生成AES的对称密钥-192位-默认base64
    * @param resultCoding 生成AES秘钥的字符串格式(hex/base64)-默认不传为base64格式
    * @returns AES密钥-192位
    */ 
    //默认生成base64格式
    let key = AESSync.generateAESKey192();
    //生成hex格式
    let keyHex = AESSync.generateAESKey192('hex');
```

* encodeGCM 加密-GCM模式

```
   /**
   * 加密-GCM模式
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   //key为base64格式,返回结果格式不传默认为base64
    let gcmEncode = AESSync.encodeGCM('测试AES-GCM加密~~~~', key.getDataRow(), 'base64');
```

* decodeGCM 解密-GCM模式

```
   /**
   * 解密-GCM模式
   * @param str  加密的字符串
   * @param aesKey  AES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   */
   //key为base64格式,待解密数据格式不传默认为base64
   let gcmDecode = AESSync.decodeGCM(gcmEncode.getDataRow(), key.getDataRow(), 'base64');
```

* encodeCBC 加密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
   /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @param iv   iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   //key为base64格式,返回格式默认不传为base64
   let encodeCBC = AESSync.encodeCBC('测试AES-CBC加密~~~~', key.getDataRow(), iv.getDataRow(), 'base64');
   //key为hex格式，返回格式为hex
   let encodeCBC = AESSync.encodeCBC('测试AES-CBC加密~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
   //key为hex格式,返回格式默认不传为base64
   let encodeCBC = AESSync.encodeCBC('测试AES-CBC加密~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   //key为普通字符串utf8格式,返回格式默认不传为base64
   let encode2 = AESSync.encodeCBC("测试AES外部传入key/iv加密~~~", "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8');
   //key为普通字符串utf8格式,返回格式为hex
   let encode2 = AESSync.encodeCBC("测试AES外部传入key/iv加密~~~", "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8', 'hex');
```

* decodeCBC 解密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
   /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey AES密钥
   * @param iv  iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
   //key为base64,待解密格式不传默认为base64
   let decode = AESSync.decodeCBC(encode.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64');
   //key为hex格式,待解密格式为hex
   let decodeHex = AESSync.decodeCBC(encodeHex.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
   //key为hex,待解密格式不传默认为base64
   let decodeBase64 = AESSync.decodeCBC(encodeBase64.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   //key为普通字符串utf8,待解密格式不传默认为base64
   let decode2 = AESSync.decodeCBC(encode2.getDataRow(), "TESTsdiloia20230ass3[2K8%fw68sw7", "ass3[2K8%fw68sw7", 'utf8');
   
```

* encodeCBC128 加密-CBC模式-128位 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
   /**
   * 加密-CBC模式-128位
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @param iv   iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   //key为base64格式,返回格式默认不传为base64
   let encodeCBC = AESSync.encodeCBC128('测试AES-128-CBC加密~~~~', key.getDataRow(), iv.getDataRow(), 'base64');
   //key为hex格式，返回格式为hex
   let encodeCBC = AESSync.encodeCBC128('测试AES-128-CBC加密~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
   //key为hex格式,返回格式默认不传为base64
   let encodeCBC = AESSync.encodeCBC128('测试AES-128-CBC加密~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   //key为普通字符串utf8格式,返回格式默认不传为base64
   let encode2 = AESSync.encodeCBC128("测试AES外部传入-128key/iv加密~~~", "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8');
   //key为普通字符串utf8格式,返回格式为hex
   let encode2 = AESSync.encodeCBC128("测试AES外部传入-128key/iv加密~~~", "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8', 'hex');
```

* decodeCBC128 解密-CBC模式-128位 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
   /**
   * 解密-CBC模式-128位
   * @param str  加密的字符串
   * @param aesKey AES密钥
   * @param iv  iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
   //key为base64,待解密格式不传默认为base64
   let decode = AESSync.decodeCBC128(encode.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64');
   //key为hex格式,待解密格式为hex
   let decodeHex = AESSync.decodeCBC128(encodeHex.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
   //key为hex,待解密格式不传默认为base64
   let decodeBase64 = AESSync.decodeCBC128(encodeBase64.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   //key为普通字符串utf8,待解密格式不传默认为base64
   let decode2 = AESSync.decodeCBC128(encode2.getDataRow(), "TESTsdiloia20230ass3[2K8%fw68sw7", "ass3[2K8%fw68sw7", 'utf8');
  
```

* encodeCBC192 加密-CBC模式-192位 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
   /**
   * 加密-CBC模式-192位
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @param iv   iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   //key为base64格式,返回格式默认不传为base64
   let encodeCBC = AESSync.encodeCBC192('测试AES-192-CBC加密~~~~', key.getDataRow(), iv.getDataRow(), 'base64');
   //key为hex格式，返回格式为hex
   let encodeCBC = AESSync.encodeCBC192('测试AES-192-CBC加密~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
   //key为hex格式,返回格式默认不传为base64
   let encodeCBC = AESSync.encodeCBC192('测试AES-192-CBC加密~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   //key为普通字符串utf8格式,返回格式默认不传为base64
   let encode2 = AESSync.encodeCBC192("测试AES外部传入-192key/iv加密~~~", "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8');
   //key为普通字符串utf8格式,返回格式为hex
   let encode2 = AESSync.encodeCBC192("测试AES外部传入-192key/iv加密~~~", "TESTsdiloia20230", "ass3[2K8%fw68sw7", 'utf8', 'hex');
```

* decodeCBC192 解密-CBC模式-192位 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
   /**
   * 解密-CBC模式-192位
   * @param str  加密的字符串
   * @param aesKey AES密钥
   * @param iv  iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
   
   //key为base64,待解密格式不传默认为base64
   let decode = AESSync.decodeCBC192(encode.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64');
   //key为hex格式,待解密格式为hex
   let decodeHex = AESSync.decodeCBC192(encodeHex.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
   //key为hex,待解密格式不传默认为base64
   let decodeBase64 = AESSync.decodeCBC192(encodeBase64.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   //key为普通字符串utf8,待解密格式不传默认为base64
   let decode2 = AESSync.decodeCBC192(encode2.getDataRow(), "TESTsdiloia20230ass3[2K8%fw68sw7", "ass3[2K8%fw68sw7", 'utf8');
  
```

* encodeECB 加密-ECB模式

```
   /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param aesKey   AES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   //key为base64,输出格式不传默认为base64
   let ecbEncode = AESSync.encodeECB('测试AES-ECB加密~', keyHex.getDataRow(), 'base64');
   //key为hex,输出格式为hex
   let ecbEncodeHex = AESSync.encodeECB('测试AES-ECB加密~', keyHex.getDataRow(), 'hex', 'hex');
   //key为hex,输出格式不传默认为base64
   let ecbEncodeBase64 = AESSync.encodeECB('测试AES-ECB加密~', keyHex.getDataRow(), 'hex');
   //key为普通字符串utf8,输出格式不传默认为base64
   let encode1 = AESSync.encodeECB('测试AES外部传入key加密~~~~', '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
   
```

* decodeECB 解密-ECB模式

```
    /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param aesKey AES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
   //key为base64,待解密数据格式不传默认为base64
   let ecbDecode = AESSync.decodeECB(ecbEncode.getDataRow(), keyHex.getDataRow(), 'base64');
   //key为hex,待解密数据格式为hex
   let ecbDecodeHex = AESSync.decodeECB(ecbEncodeHex.getDataRow(), keyHex.getDataRow(), 'hex', 'hex');
   //key为hex,待解密数据格式不传默认为base64
   let ecbDecodBase64 = AESSync.decodeECB(ecbEncodeBase64.getDataRow(), keyHex.getDataRow(), 'hex');
   //key为普通字符串utf8,待解密数据格式不传默认为base64
   let decode1 = AESSync.decodeECB(encode1.getDataRow(), '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
```

* encodeECB128 加密-ECB模式-128位

```
    /**
   * 加密-ECB模式-128位
   * @param str  待加密的字符串
   * @param aesKey   AES密钥-128位
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   //key为base64,输出格式不传默认为base64
   let ecbEncode = AESSync.encodeECB128('测试AES-ECB加密~', keyHex.getDataRow(), 'base64');
   //key为hex,输出格式为hex
   let ecbEncodeHex = AESSync.encodeECB128('测试AES-ECB加密~', keyHex.getDataRow(), 'hex', 'hex');
   //key为hex,输出格式不传默认为base64
   let ecbEncodeBase64 = AESSync.encodeECB128('测试AES-ECB加密~', keyHex.getDataRow(), 'hex');
   //key为普通字符串utf8,输出格式不传默认为base64
   let encode1 = AESSync.encodeECB128('测试AES外部传入key加密~~~~', '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
   
```

* decodeECB128 解密-ECB模式-128位

```
   /**
   * 解密-ECB模式-128位
   * @param str  加密的字符串
   * @param aesKey AES密钥-128位
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
   //key为base64,待解密数据格式不传默认为base64
   let ecbDecode = AESSync.decodeECB128(ecbEncode.getDataRow(), keyHex.getDataRow(), 'base64');
   //key为hex,待解密数据格式为hex
   let ecbDecodeHex = AESSync.decodeECB128(ecbEncodeHex.getDataRow(), keyHex.getDataRow(), 'hex', 'hex');
   //key为hex,待解密数据格式不传默认为base64
   let ecbDecodBase64 = AESSync.decodeECB128(ecbEncodeBase64.getDataRow(), keyHex.getDataRow(), 'hex');
   //key为普通字符串utf8,待解密数据格式不传默认为base64
   let decode1 = AESSync.decodeECB128(encode1.getDataRow(), '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
```

* encodeECB192 加密-ECB模式-192位

```
   /**
   * 加密-ECB模式-192位
   * @param str  待加密的字符串
   * @param aesKey   AES密钥-192位
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   //key为base64,输出格式不传默认为base64
   let ecbEncode = AESSync.encodeECB192('测试AES-ECB加密~', keyHex.getDataRow(), 'base64');
   //key为hex,输出格式为hex
   let ecbEncodeHex = AESSync.encodeECB192('测试AES-ECB加密~', keyHex.getDataRow(), 'hex', 'hex');
   //key为hex,输出格式不传默认为base64
   let ecbEncodeBase64 = AESSync.encodeECB192('测试AES-ECB加密~', keyHex.getDataRow(), 'hex');
   //key为普通字符串utf8,输出格式不传默认为base64
   let encode1 = AESSync.encodeECB192('测试AES外部传入key加密~~~~', '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
   
```

* decodeECB192 解密-ECB模式-192位

```
   /**
   * 解密-ECB模式-192位
   * @param str  加密的字符串
   * @param aesKey AES密钥-192位
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
   //key为base64,待解密数据格式不传默认为base64
   let ecbDecode = AESSync.decodeECB192(ecbEncode.getDataRow(), keyHex.getDataRow(), 'base64');
   //key为hex,待解密数据格式为hex
   let ecbDecodeHex = AESSync.decodeECB192(ecbEncodeHex.getDataRow(), keyHex.getDataRow(), 'hex', 'hex');
   //key为hex,待解密数据格式不传默认为base64
   let ecbDecodBase64 = AESSync.decodeECB192(ecbEncodeBase64.getDataRow(), keyHex.getDataRow(), 'hex');
   //key为普通字符串utf8,待解密数据格式不传默认为base64
   let decode1 = AESSync.decodeECB192(encode1.getDataRow(), '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
```

##### 3.3DESSync的方法【返回结果均为OutDTO对象】

* generate3DESKey 生成3DES的对称密钥

```
   /**
   * 生成3DES的对称密钥
   * @param resultCoding 生成3DES秘钥的字符串格式(hex/base64)-默认不传为base64格式
   * @returns 3DES密钥
   */
   //默认生成base64格式
   let key = DESSync.generate3DESKey();
   //生成hex格式
   let keyHex = DESSync.generate3DESKey('hex');
```

* encodeECB 加密-ECB模式

```
   /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param desKey   3DES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   let encodeEcb = DESSync.encodeECB('', key.getDataRow(), 'base64');
   let encodeEcbH = DESSync.encodeECB('', key.getDataRow(), 'base64', 'hex');
   let encodeEcbHex = DESSync.encodeECB('', keyHex.getDataRow(), 'hex');
   let encodeEcbHexH = DESSync.encodeECB('', keyHex.getDataRow(), 'hex', 'hex');
```

* decodeECB 解密-ECB模式

```
   /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param desKey  3DES密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   */
   let decodeEcb = DESSync.decodeECB(encodeEcb.getDataRow(), key.getDataRow(), 'base64');
   let decodeEcbH = DESSync.decodeECB(encodeEcbH.getDataRow(), key.getDataRow(), 'base64', 'hex');
   let decodeEcbHex = DESSync.decodeECB(encodeEcbHex.getDataRow(), keyHex.getDataRow(), 'hex');
   let decodeEcbHexH = DESSync.decodeECB(encodeEcbHexH.getDataRow(), keyHex.getDataRow(), 'hex', 'hex');
```

* encodeCBC 加密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
    /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param aesKey   3DES密钥
   * @param iv   iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  加密后数据的编码方式(hex/base64)-不传默认为base64
   * @returns
   */
   let encodeCbc = DESSync.encodeCBC('', key.getDataRow(), iv.getDataRow(), 'base64');
   let encodeCbcH = DESSync.encodeCBC('', key.getDataRow(), iv.getDataRow(), 'base64', 'hex');
   let encodeCbcHex = DESSync.encodeCBC('', keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   let encodeCbcHexH = DESSync.encodeCBC('', keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
```

* decodeCBC 解密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
    /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey 3DES密钥
   * @param iv  iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
   let decodeCbc = DESSync.decodeCBC(encodeCbc.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64');
    let decodeCbcH = DESSync.decodeCBC(encodeCbcH.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64', 'hex');
    let decodeCbcHex = DESSync.decodeCBC(encodeCbcHex.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
    let decodeCbcHexH = DESSync.decodeCBC(encodeCbcHexH.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
```

##### 4.SM2Sync的方法【返回结果均为OutDTO对象】

* generateSM2Key 生成SM2的非对称密钥

```
   /**
   * 生成SM2的非对称密钥
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns SM2密钥{publicKey:公钥,privateKey:私钥}
   */
   let key = SM2Sync.generateSM2Key();
```

* encode 加密

```
   /**
   * 加密
   * @param encodeStr  待加密的字符串
   * @param pubKey  SM2公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   */
   let encode = SM2Sync.encode('测试SM2的加密~~~~', key.getDataRow().publicKey, 'base64');
   let encode = SM2Sync.encode('测试SM2的加密~~~~', key.getDataRow().publicKey, 'base64', 'hex');
```

* decode 解密

```
   /**
   * 解密
   * @param decodeStr  待解密的字符串
   * @param priKey    SM2私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   */
   let decode = SM2Sync.decode(encode.getDataRow(), key.getDataRow().privateKey, 'base64');
   let decode = SM2Sync.decode(encode.getDataRow(), key.getDataRow().privateKey, 'base64', 'hex');
```

* sign 签名

```
   /**
   * 签名
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns OutDTO<string> 签名对象
   */
   let sign = SM2Sync.sign('测试SM2的加密~~~~', key.getDataRow().privateKey, 'base64');
```

* verify 验签

```
   /**
   * 验签
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  SM2公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
   let verify = SM2Sync.verify(sign.getDataRow(), '测试SM2的加密~~~~', key.getDataRow().publicKey, 'base64');
```

* convertSM2PubKey 将服务器端生成的16进制的长度为130位的04开头的C1C3C2格式的SM2公钥转换为前端所需的ASN

```
    //C1C3C2格式的公钥字符串
    let pk = '04ba3bc3c5834d9ad1a7d81c4b49cf1209d2f28e4a97c73b75d6561792a2bfafe811e0284692006b0ce1b51f8aadfd65241d80eb979365048253408f5d705ec17b';
    //转换后的ASN.1格式的字符串
    let s = await SM2.convertSM2PubKey(pk);
    let code = await SM2.encode('加密字符~~~~~', s.getDataRow());
    let ddd = code.getDataRow();
```

* convertSM2PriKey 将服务器端生成的16进制的长度为64位的C1C3C2格式的SM2私钥转换为前端所需的ASN

```
    //C1C3C2格式的私钥字符串
    let pik = '7713d336bcbbffb8b7f9cab8db984a5c989a0b07697f569a06d5cd38e1351d07';
    //转换后的ASN.1格式的字符串
    let dc = await SM2.convertSM2PriKey(pik);
    let aaaa = await SM2.decode(ddd, dc.getDataRow());
    this.message = aaaa.getDataRow();
```

##### 5.SM3Sync的方法【返回结果均为OutDTO对象】

* digest SM3摘要

```
   /**
   * SM3摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
   let digest = SM3Sync.digest('测试SM3的digest~~~~');
```

* hmac 消息认证码计算

```
   /**
   * 消息认证码计算
   * @param str  计算字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns
   */
   let hmac = SM3Sync.hmac('测试SM3的hmac~~~~');
```

##### 6.SM4Sync的方法【返回结果均为OutDTO对象】

* generateSM4Key 生成SM4的对称密钥

```
   /**
   * 生成SM4的对称密钥
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns SM4密钥
   */
   let key = SM4Sync.generateSM4Key();
   let keyHex = SM4Sync.generateSM4Key('hex');
```

* encodeECB 加密-ECB模式

```
   /**
   * 加密-ECB模式
   * @param str  待加密的字符串
   * @param sm4Key   SM4密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns
   */
   let ecbEncode = SM4Sync.encodeECB('测试SM4-ECB加密-base64~', key.getDataRow(), 'base64');
   let ecbEncodeHex = SM4Sync.encodeECB('测试SM4-ECB加密-hex~', keyHex.getDataRow(), 'hex', 'hex');
   let ecbEncodeBase64 = SM4Sync.encodeECB('测试SM4-ECB加密-hex-base64~', keyHex.getDataRow(), 'hex');
   let encode1 = SM4Sync.encodeECB('测试SM4外部传入key加密~~~~', '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
```

* decodeECB 解密-ECB模式

```
   /**
   * 解密-ECB模式
   * @param str  加密的字符串
   * @param sm4Key  SM4密钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   */
   let ecbDecode = SM4Sync.decodeECB(ecbEncode.getDataRow(), key.getDataRow(), 'base64');
   let ecbDecodeHex = SM4Sync.decodeECB(ecbEncodeHex.getDataRow(), keyHex.getDataRow(), 'hex', 'hex');
   let ecbDecodBase64 = SM4Sync.decodeECB(ecbEncodeBase64.getDataRow(), keyHex.getDataRow(), 'hex');
   decode1 = SM4Sync.decodeECB(encode1.getDataRow(), '4eS1Q15z1@TFTe%eEf23fGFZf)2Rs588', 'utf8');
```

* encodeCBC 加密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
   /**
   * 加密-CBC模式
   * @param str  待加密的字符串
   * @param aesKey   SM4密钥
   * @param iv   iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns
   */
   let encode = SM4Sync.encodeCBC('测试SM4-CBC加密~~~~', key.getDataRow(), iv.getDataRow(), 'base64');
   let encodeHex = SM4Sync.encodeCBC('测试SM4-CBC加密-hex~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
   let encodeBase64 = SM4Sync.encodeCBC('测试SM4-CBC加密-base64~~~~', keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   let encode2 = SM4Sync.encodeCBC("测试SM4外部传入key/iv加密~~~", "TESTsdiloia20230ass3[2K8%fw68sw7","ass3[2K8%fw68sw7", 'utf8');
   
```

* decodeCBC 解密-CBC模式 需要传入iv偏移量字符串(IV生成详见RandomUtil)

```
   /**
   * 解密-CBC模式
   * @param str  加密的字符串
   * @param aesKey SM4密钥
   * @param iv  iv偏移量字符串
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns
   */
   let decode = SM4Sync.decodeCBC(encode.getDataRow(), key.getDataRow(), iv.getDataRow(), 'base64');
   let decodeHex = SM4Sync.decodeCBC(encodeHex.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex', 'hex');
   let decodeBase64 = SM4Sync.decodeCBC(encodeBase64.getDataRow(), keyHex.getDataRow(), ivHex.getDataRow(), 'hex');
   let decode2 = SM4Sync.decodeCBC(encode2.getDataRow(), "TESTsdiloia20230ass3[2K8%fw68sw7", "ass3[2K8%fw68sw7", 'utf8');
```

##### 7.SHASync的方法【返回结果均为OutDTO对象】

* digest 摘要方法

```
   /**
   * SHA256摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
   let digest = SHASync.digest('测试SHASync~~~~~');
```

* digestSHA1 SHA1摘要

```
   /**
   * SHA1摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
   let digest = SHASync.digestSHA1('这个是SHA的摘要方法~~');
   this.message = digest.getDataRow();
```

* digestSHA224 SHA224摘要

```
   /**
   * SHA224摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
   let digest = SHASync.digestSHA224('这个是SHA的摘要方法~~');
   this.message = digest.getDataRow();
```

* digestSHA384 SHA384摘要

```
   /**
   * SHA384摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
   let digest = SHASync.digestSHA384('这个是SHA的摘要方法~~');
   this.message = digest.getDataRow();
```

* digestSHA512 SHA512摘要

```
   /**
   * SHA512摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 摘要后的字符串
   */
   let digest = SHASync.digestSHA512('这个是SHA的摘要方法~~');
   this.message = digest.getDataRow();
```

* hmac 消息认证码计算

```
   /**
   * 消息认证码计算
   * @param str  计算字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns
   */
   let hmac2 = SHASync.hmac('这个是SHA的HMAC');
   this.message = hmac2.getDataRow();
```

##### 8.MD5的方法【返回结果均为OutDTO对象】

* digest 摘要方法

```
   /**
   * MD5摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-不传默认为base64
   * @returns 摘要后的字符串
   */
   let md5 = MD5Sync.digest('使用MD5进行摘要~~~');
   this.message = md5.getDataRow();
```

* hash 散列哈希算法

```
   //默认不传编码格式为hex
   let hash = MD5.hash('测试MD5散列算法hex~~~');
   if (hash.getSuccess()) {
     this.msg = hash.getDataRow();
   }
   //传入base64表示生成的为base64的散列值
   let hash64 = MD5.hash('测试MD5散列算法base64~~~', 'base64');
   if (hash64.getSuccess()) {
     this.msg = hash64.getDataRow();
   }
```

* hmac hmac

```
  //生成16位的key
  let key = RandomUtil.generateIV();

  //默认不传编码格式为hex
  let hmac = MD5.hmac(key.getDataRow(), '测试MD5-hmac算法hex~~~~~');
  if (hmac.getSuccess()) {
    this.msg = hmac.getDataRow();
  }
  //传入base64表示生成的为base64的hmac值
  let hmac64 = MD5.hmac(key.getDataRow(), '测试MD5-hmac算法base64~~~~~', 'base64');
  if (hmac64.getSuccess()) {
    this.msg = hmac64.getDataRow();
  }
```

##### 9.ECDSASync的方法【返回结果均为OutDTO对象】

* generateECDSAKey 生成ECDSA的非对称密钥

```
   /**
   * 生成ECDSA的非对称密钥
   * @param resultCoding 生成ECDSA秘钥的字符串格式-默认不传为base64格式
   * @returns ECDSA密钥{publicKey:公钥,privateKey:私钥}
   */
   let ecdsa = ECDSASync.generateECDSAKey();
   console.error("generateECDSAKey:" + ecdsa.getSuccess() + "---" + ecdsa.getMsg()
   + "\n" + "公钥:" + ecdsa.getDataRow().publicKey + "私钥:" + ecdsa.getDataRow().privateKey)
```

* sign 签名

```
   /**
   * 签名
   * @param str  需要签名的字符串
   * @param priKey  私钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64) - 不传默认为base64
   * @returns OutDTO<string> 签名对象
   */
   let sign = ECDSASync.sign('这个是ECDSA的验签字符串~~', ecdsa.getDataRow().privateKey);
   this.message = sign.getDataRow();
```

* verify 验签

```
   /**
   * 验签
   * @param signStr  已签名的字符串
   * @param verifyStr  需要验签的字符串
   * @param pubKey  公钥
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param dataCoding  入参字符串编码方式(hex/base64) - 不传默认为base64
   * @returns 验签结果OutDTO对象,其中Msg为验签结果
   */
   let verify = ECDSASync.verify(sign.getDataRow(), '这个是ECDSA的验签字符串~~', ecdsa.getDataRow().publicKey);
   this.message = verify.getMsg();
```

##### 10.ECDHSync的方法【返回结果均为OutDTO对象】

* ecdh 动态协商密钥,要求密钥长度为256位的非对称密钥

```
   /**
   * ecdh动态协商密钥,要求密钥长度为256位的非对称密钥
   * @param pubKey  符合256位的非对称密钥的公钥字符串或Uint8Array字节流  【一般为外部传入】
   * @param priKey  符合256位的非对称密钥的私钥字符串或Uint8Array字节流  【一般为本项目】
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns ECC256共享密钥
   */
```

```
    //1.测试随机生成的一种256长度的字符串公私钥秘钥
    //模拟当前项目的公钥
    let sm2Key = CryptoSyncUtil.generateCryptoKey('ECC256', 'base64');
    //模拟外部传入的私钥
    let eccKey = CryptoSyncUtil.generateCryptoKey('ECC256', 'base64');
    //动态协商
    let shareKey = ECDHSync.ecdh(sm2Key.getDataRow().publicKey, eccKey.getDataRow().privateKey, 'base64', 'base64');
    this.msg = "生成的共享密钥为:" + shareKey.getDataRow();

    //模拟加密
    let shareEncode = AESSync.encodeECB('使用ECDH共享密钥加密数据测试~~~~', shareKey.getDataRow(), 'base64');
    this.msg = shareEncode.getDataRow();
    //动态协商解密key
    let decodeKey = ECDHSync.ecdh(eccKey.getDataRow().publicKey, sm2Key.getDataRow().privateKey, 'base64', 'base64');
    //解密
    let shareDecode = AESSync.decodeECB(shareEncode.getDataRow(), decodeKey.getDataRow(), 'base64');
    this.msg = "共享密钥解密结果为:" + shareDecode.getDataRow();
    
```

```
    //2.测试随机生成的一种256长度的字节流Uint8Array形式的公私钥秘钥
    // 创建非对称密钥生成器
    let rsaGenerator = crypto.createAsyKeyGenerator('ECC256');
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseKeyPair = await rsaGenerator.generateKeyPair();
    // 转换成可以读懂的公私钥字符串
    let pubKey = promiseKeyPair.pubKey.getEncoded().data;
    let priKey = promiseKeyPair.priKey.getEncoded().data;
    //获取到贡献密钥
    let shareKey = ECDHSync.ecdh(pubKey, priKey);
    
    //模拟加密
    let shareEncode = AESSync.encodeECB('使用ECDH共享密钥加密数据测试~~~~', shareKey.getDataRow(), 'base64');
    this.msg = shareEncode.getDataRow();
    
    //解密
    let shareDecode = AESSync.decodeECB(shareEncode.getDataRow(), decodeKey.getDataRow(), 'base64');
    this.msg = "共享密钥解密结果为:" + shareDecode.getDataRow();
    
```

##### 11.X25519Sync的方法【返回结果均为OutDTO对象】

* x25519 X25519动态协商密钥,要求密钥长度为256位的非对称密钥

```
    /**
   * X25519动态协商密钥,要求密钥长度为256位的非对称密钥
   * @param pubKey  符合非对称密钥的公钥字符串或Uint8Array字节流  【一般为外部传入】
   * @param priKey  符合非对称密钥的私钥字符串或Uint8Array字节流  【一般为本项目】
   * @param keyCoding  密钥编码方式(utf8/hex/base64) 普通字符串则选择utf8格式
   * @param resultCoding  返回结果编码方式(hex/base64)-默认不传为base64格式
   * @returns 256位共享密钥字符串
   */
```

```
    //1.测试随机生成的一种256长度的字符串公私钥秘钥
    let x25519Key = await CryptoUtil.generateCryptoKey('X25519');
    //将对方的公钥和自己的私钥传入生成256位的共享秘钥
    let x25519 = X25519Sync.x25519(x25519Key.getDataRow().publicKey, x25519Key.getDataRow().privateKey);
    this.message = x25519.getDataRow();
    //可以进行对称加密 注意对称加解密也需要为256位
    let encode = await CryptoUtil.encodeECB('测试共享密钥加密数据~~~', x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = encode.getDataRow();
    //对称解密
    let decode = await CryptoUtil.decodeECB(encode.getDataRow(), x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = decode.getDataRow();
```

```
    //2.测试随机生成的一种256长度的字节流Uint8Array形式的公私钥秘钥
    let rsaGenerator = crypto.createAsyKeyGenerator('X25519');
    // 通过非对称密钥生成器，随机生成非对称密钥
    let promiseKeyPair = await rsaGenerator.generateKeyPair();
    // 转换成可以读懂的公私钥字符串
    let pubKey = promiseKeyPair.pubKey.getEncoded().data;
    let priKey = promiseKeyPair.priKey.getEncoded().data;
    let x25519 = await X25519Sync.x25519(pubKey, priKey);
    //可以进行对称加密 注意对称加解密也需要为256位
    let encode = await CryptoUtil.encodeECB('测试共享密钥加密数据~~~', x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = encode.getDataRow();
    //对称解密
    let decode = await CryptoUtil.decodeECB(encode.getDataRow(), x25519.getDataRow(), 'AES256', 'AES256|ECB|PKCS7');
    this.message = decode.getDataRow();
```

##### 12.SHA1的方法【返回结果均为OutDTO对象】

* hash 散列哈希算法

```
  let sha1 = SHA1.hash('测试SHA1散列算法~~~~~~~');
  if (sha1.getSuccess()) {
    this.msg = sha1.getDataRow();
  }
```

##### 13.SM2Convert的方法

* i2dSM2 C1C3C2格式的字符串转换成ASN.1格式的字符

```
    //创建转换类
    // let convert = new SM2Convert();
    //转换格式
    let asnKey = convert.i2dSM2('04开头的C1C3C2格式的加密字符串');
```

* i2cSM2 C1C2C3格式的字符串转换成ASN.1格式的字符

```
    //创建转换类
    // let convert = new SM2Convert();
    //转换格式
    let asnKey = convert.i2cSM2('04开头的C1C2C3格式的加密字符串');
```

* d2i ASN.1格式的字符串转换成C1C3C2格式的字符

```
    //生成ASN1的key
    let result = SM2Sync.generateSM2Key('hex');
    //获取ASN1公钥
    let pubKey = result.getDataRow().publicKey;
    //加密
    let encode = SM2Sync.encode('测试SM2加密格式转换~~', pubKey,'hex');
    //创建转换类
    let convert = new SM2Convert();
    //转换
    let sm2X509Encode = convert.d2i(encode.getDataRow());
    this.msg = sm2X509Encode;
```

* d2c ASN.1格式的字符串转换成C1C2C3格式的字符

```
    //生成ASN1的key
    let result = SM2Sync.generateSM2Key('hex');
    //获取ASN1公钥
    let pubKey = result.getDataRow().publicKey;
    //加密
    let encode = SM2Sync.encode('测试SM2加密格式转换~~', pubKey,'hex');
    //创建转换类
    let convert = new SM2Convert();
    //转换
    let sm2X509Encode = convert.d2c(encode.getDataRow());
    this.msg = sm2X509Encode;
```

## [eftool](https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Feftool)工具类ohpm地址

## star `ef_crypto_dto` 希望您可以动一动小手点点小⭐⭐

## 👴希望大家如有好的需求踊跃提交,如有问题请前往gitee提交issue，我闲暇时间会扩充与修复优化