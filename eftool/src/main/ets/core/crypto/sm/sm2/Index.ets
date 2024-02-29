import { BigInteger } from '../JSBN'
import { ASN1 } from './ASN'
import { Utils } from './Utils'
import { sm3 } from './SM3'


const {G, curve, n} = Utils.generateEcparam()
const C1C2C3 = 0

/**
 * @Author csx
 * @DateTime 2024/2/29 11:54:02
 * @TODO Index
 */
export class Index {


  /**
   * 加密
   */
  static doEncrypt(msg, publicKey, cipherMode = 1) {
    msg = typeof msg === 'string' ? Utils.hexToArray(Utils.utf8ToHex(msg)) : Array.prototype.slice.call(msg)
    publicKey = Utils.getGlobalCurve().decodePointHex(publicKey) // 先将公钥转成点

    const keypair = Utils.generateKeyPairHex()
    const k = new BigInteger(keypair.privateKey, 16) // 随机数 k

    // c1 = k * G
    let c1 = keypair.publicKey
    if (c1.length > 128) c1 = c1.substr(c1.length - 128)

    // (x2, y2) = k * publicKey
    const p = publicKey.multiply(k)
    const x2 = Utils.hexToArray(Utils.leftPad(p.getX().toBigInteger().toRadix(16), 64))
    const y2 = Utils.hexToArray(Utils.leftPad(p.getY().toBigInteger().toRadix(16), 64))

    // c3 = hash(x2 || msg || y2)
    const c3 = Utils.arrayToHex(sm3([].concat(x2, msg, y2)))

    let ct = 1
    let offset = 0
    let t = [] // 256 位
    const z = [].concat(x2, y2)
    const nextT = () => {
      // (1) Hai = hash(z || ct)
      // (2) ct++
      t = sm3([...z, ct >> 24 & 0x00ff, ct >> 16 & 0x00ff, ct >> 8 & 0x00ff, ct & 0x00ff])
      ct++
      offset = 0
    }
    nextT() // 先生成 Ha1

    for (let i = 0, len = msg.length; i < len; i++) {
      // t = Ha1 || Ha2 || Ha3 || Ha4
      if (offset === t.length) nextT()

      // c2 = msg ^ t
      msg[i] ^= t[offset++] & 0xff
    }
    const c2 = Utils.arrayToHex(msg)

    return cipherMode === C1C2C3 ? c1 + c2 + c3 : c1 + c3 + c2
  }

  /**
   * 解密
   */
  static doDecrypt(encryptData, privateKey, cipherMode = 1, {
    output = 'string',
  } = {}) {
    privateKey = new BigInteger(privateKey, 16)

    let c3 = encryptData.substr(128, 64)
    let c2 = encryptData.substr(128 + 64)

    if (cipherMode === C1C2C3) {
      c3 = encryptData.substr(encryptData.length - 64)
      c2 = encryptData.substr(128, encryptData.length - 128 - 64)
    }

    const msg = Utils.hexToArray(c2)
    const c1 = Utils.getGlobalCurve().decodePointHex('04' + encryptData.substr(0, 128))

    const p = c1.multiply(privateKey)
    const x2 = Utils.hexToArray(Utils.leftPad(p.getX().toBigInteger().toRadix(16), 64))
    const y2 = Utils.hexToArray(Utils.leftPad(p.getY().toBigInteger().toRadix(16), 64))

    let ct = 1
    let offset = 0
    let t = [] // 256 位
    const z = [].concat(x2, y2)
    const nextT = () => {
      // (1) Hai = hash(z || ct)
      // (2) ct++
      t = sm3([...z, ct >> 24 & 0x00ff, ct >> 16 & 0x00ff, ct >> 8 & 0x00ff, ct & 0x00ff])
      ct++
      offset = 0
    }
    nextT() // 先生成 Ha1

    for (let i = 0, len = msg.length; i < len; i++) {
      // t = Ha1 || Ha2 || Ha3 || Ha4
      if (offset === t.length) nextT()

      // c2 = msg ^ t
      msg[i] ^= t[offset++] & 0xff
    }

    // c3 = hash(x2 || msg || y2)
    const checkC3 = Utils.arrayToHex(sm3([].concat(x2, msg, y2)))

    if (checkC3 === c3.toLowerCase()) {
      return output === 'array' ? msg : Utils.arrayToUtf8(msg)
    } else {
      return output === 'array' ? [] : ''
    }
  }

  /**
   * 签名
   */
  static doSignature(msg, privateKey, {
    pointPool, der, hash, publicKey, userId
  }) {
    let hashHex = typeof msg === 'string' ? Utils.utf8ToHex(msg) : Utils.arrayToHex(msg)

    if (hash) {
      // sm3杂凑
      publicKey = publicKey || Index.getPublicKeyFromPrivateKey(privateKey)
      hashHex = Index.getHash(hashHex, publicKey, userId)
    }

    const dA = new BigInteger(privateKey, 16)
    const e = new BigInteger(hashHex, 16)

    // k
    let k = null
    let r = null
    let s = null

    do {
      do {
        let point
        if (pointPool && pointPool.length) {
          point = pointPool.pop()
        } else {
          point = Index.getPoint()
        }
        k = point.k

        // r = (e + x1) mod n
        r = e.bnAdd(point.x1).bnMod(n)
      } while (r.equals(r.ZERO) || r.add(k).equals(n))

      // s = ((1 + dA)^-1 * (k - r * dA)) mod n
      s = dA.bnAdd(r.ONE).bnModInverse(n).bnMultiply(k.subtract(r.multiply(dA))).bnMod(n)
    } while (s.equals(s.ZERO))

    if (der) return ASN1.encodeDer(r, s) // asn.1 der 编码

    return Utils.leftPad(r.toString(16), 64) + Utils.leftPad(s.toString(16), 64)
  }

  /**
   * 验签
   */
  static doVerifySignature(msg, signHex, publicKey, {der, hash, userId= '1234567812345678'}) {
    let hashHex = typeof msg === 'string' ? Utils.utf8ToHex(msg) : Utils.arrayToHex(msg)

    if (hash) {
      // sm3杂凑
      hashHex = Index.getHash(hashHex, publicKey, userId)
    }

    let r;
    let
      s
    if (der) {
      const decodeDerObj = ASN1.decodeDer(signHex) // asn.1 der 解码
      r = decodeDerObj.r
      s = decodeDerObj.s
    } else {
      r = new BigInteger(signHex.substring(0, 64), 16)
      s = new BigInteger(signHex.substring(64), 16)
    }

    const PA = curve.decodePointHex(publicKey)
    const e = new BigInteger(hashHex, 16)

    // t = (r + s) mod n
    const t = r.add(s).mod(n)

    if (t.equals(e.ZERO)) return false

    // x1y1 = s * G + t * PA
    const x1y1 = G.multiply(s).add(PA.multiply(t))

    // R = (e + x1) mod n
    const R = e.bnMod(x1y1.getX().toBigInteger()).bnMod(n)

    return r.equals(R)
  }

  /**
   * sm3杂凑算法
   */
  static getHash(hashHex, publicKey, userId = '1234567812345678') {
    // z = hash(entl || userId || a || b || gx || gy || px || py)
    userId = Utils.utf8ToHex(userId)
    const a = Utils.leftPad(G.curve.a.toBigInteger().toRadix(16), 64)
    const b = Utils.leftPad(G.curve.b.toBigInteger().toRadix(16), 64)
    const gx = Utils.leftPad(G.getX().toBigInteger().toRadix(16), 64)
    const gy = Utils.leftPad(G.getY().toBigInteger().toRadix(16), 64)
    let px
    let py
    if (publicKey.length === 128) {
      px = publicKey.substr(0, 64)
      py = publicKey.substr(64, 64)
    } else {
      const point = G.curve.decodePointHex(publicKey)
      px = Utils.leftPad(point.getX().toBigInteger().toRadix(16), 64)
      py = Utils.leftPad(point.getY().toBigInteger().toRadix(16), 64)
    }
    const data = Utils.hexToArray(userId + a + b + gx + gy + px + py)

    const entl = userId.length * 4
    data.unshift(entl & 0x00ff)
    data.unshift(entl >> 8 & 0x00ff)

    const z = sm3(data)

    // e = hash(z || msg)
    return Utils.arrayToHex(sm3(z.concat(Utils.hexToArray(hashHex))))
  }

  /**
   * 计算公钥
   */
  static getPublicKeyFromPrivateKey(privateKey) {
    const PA = G.multiply(new BigInteger(privateKey, 16))
    const x = Utils.leftPad(PA.getX().toBigInteger().toString(16), 64)
    const y = Utils.leftPad(PA.getY().toBigInteger().toString(16), 64)
    return '04' + x + y
  }

  /**
   * 获取椭圆曲线点
   */
  static getPoint() {
    const keypair = Utils.generateKeyPairHex()
    const PA = curve.decodePointHex(keypair.publicKey)
    // keypair.k = new BigInteger(keypair.privateKey, 16)
    // keypair.x1 = PA.getX().toBigInteger()
    return keypair
  }
}