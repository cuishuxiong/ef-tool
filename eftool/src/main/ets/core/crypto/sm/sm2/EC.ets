/* eslint-disable no-case-declarations, max-len */
import { BigInteger } from '../JSBN'

/**
 * thanks for Tom Wu : http://www-cs-students.stanford.edu/~tjw/jsbn/
 *
 * Basic Javascript Elliptic Curve implementation
 * Ported loosely from BouncyCastle's Java EC code
 * Only Fp curves implemented for now
 */

/**
 * 椭圆曲线域元素
 */
class ECFieldElementFp {
  x: BigInteger
  q: BigInteger

  constructor(q: BigInteger, x: BigInteger) {
    this.x = x
    this.q = q
  }

  /**
   * 判断相等
   */
  equals(other): boolean {
    if (other === this) return true
    return (this.q.bnEquals(other.q) && this.x.bnEquals(other.x))
  }

  /**
   * 返回具体数值
   */
  toBigInteger(): BigInteger {
    return this.x
  }

  /**
   * 取反
   */
  negate() {
    return new ECFieldElementFp(this.q, this.x.bnNegate().bnMod(this.q))
  }

  /**
   * 相加
   */
  add(b) {
    return new ECFieldElementFp(this.q, this.x.bnAdd(b.toBigInteger()).bnMod(this.q))
  }

  /**
   * 相减
   */
  subtract(b) {
    return new ECFieldElementFp(this.q, this.x.bnSubtract(b.toBigInteger()).bnMod(this.q))
  }

  /**
   * 相乘
   */
  multiply(b) {
    return new ECFieldElementFp(this.q, this.x.bnMultiply(b.toBigInteger()).bnMod(this.q))
  }

  /**
   * 相除
   */
  divide(b) {
    return new ECFieldElementFp(this.q, this.x.bnMultiply(b.toBigInteger().bnModInverse(this.q)).bnMod(this.q))
  }

  /**
   * 平方
   */
  square() {
    return new ECFieldElementFp(this.q, this.x.bnSquare().bnMod(this.q))
  }
}

export class ECPointFp {
  curve: ECCurveFp
  x: ECFieldElementFp
  y: ECFieldElementFp
  z: BigInteger
  zinv: BigInteger
  private THREE = new BigInteger('3')

  constructor(curve: ECCurveFp, x: ECFieldElementFp, y: ECFieldElementFp, z?: BigInteger) {
    this.curve = curve
    this.x = x
    this.y = y
    // 标准射影坐标系：zinv == null 或 z * zinv == 1
    this.z = z == null ? this.THREE.getONE() : z
    this.zinv = null
    // TODO: compression flag
  }

  getX(): ECFieldElementFp {
    if (this.zinv === null) this.zinv = this.z.bnModInverse(this.curve.q)
    return this.curve.fromBigInteger(this.x.toBigInteger().bnMultiply(this.zinv).bnMod(this.curve.q))
  }

  getY(): ECFieldElementFp {
    if (this.zinv === null) this.zinv = this.z.bnModInverse(this.curve.q)
    return this.curve.fromBigInteger(this.y.toBigInteger().bnMultiply(this.zinv).bnMod(this.curve.q))
  }

  /**
   * 判断相等
   */
  equals(other: ECPointFp) {
    if (other === this) return true
    if (this.isInfinity()) return other.isInfinity()
    if (other.isInfinity()) return this.isInfinity()

    // u = y2 * z1 - y1 * z2
    const u = other.y.toBigInteger()
      .bnMultiply(this.z)
      .bnSubtract(this.y.toBigInteger().bnMultiply(other.z))
      .bnMod(this.curve.q)
    if (!u.bnEquals(new BigInteger(null).nbv(0))) return false

    // v = x2 * z1 - x1 * z2
    const v = other.x.toBigInteger()
      .bnMultiply(this.z)
      .bnSubtract(this.x.toBigInteger().bnMultiply(other.z))
      .bnMod(this.curve.q)
    return v.bnEquals(new BigInteger(null).nbv(0))
  }

  /**
   * 是否是无穷远点
   */
  isInfinity(): boolean {
    if ((this.x === null) && (this.y === null)) return true
    return this.z.bnEquals(this.THREE.nbv(0)) && !this.y.toBigInteger().bnEquals(this.THREE.nbv(0))
  }

  /**
   * 取反，x 轴对称点
   */
  negate(): ECPointFp {
    return new ECPointFp(this.curve, this.x, this.y.negate(), this.z)
  }

  /**
   * 相加
   *
   * 标准射影坐标系：
   *
   * λ1 = x1 * z2
   * λ2 = x2 * z1
   * λ3 = λ1 − λ2
   * λ4 = y1 * z2
   * λ5 = y2 * z1
   * λ6 = λ4 − λ5
   * λ7 = λ1 + λ2
   * λ8 = z1 * z2
   * λ9 = λ3^2
   * λ10 = λ3 * λ9
   * λ11 = λ8 * λ6^2 − λ7 * λ9
   * x3 = λ3 * λ11
   * y3 = λ6 * (λ9 * λ1 − λ11) − λ4 * λ10
   * z3 = λ10 * λ8
   */
  add(b: ECPointFp) {
    if (this.isInfinity()) return b
    if (b.isInfinity()) return this

    const x1 = this.x.toBigInteger()
    const y1 = this.y.toBigInteger()
    const z1 = this.z
    const x2 = b.x.toBigInteger()
    const y2 = b.y.toBigInteger()
    const z2 = b.z
    const q = this.curve.q

    const w1 = x1.bnMultiply(z2).bnMod(q)
    const w2 = x2.bnMultiply(z1).bnMod(q)
    const w3 = w1.bnSubtract(w2)
    const w4 = y1.bnMultiply(z2).bnMod(q)
    const w5 = y2.bnMultiply(z1).bnMod(q)
    const w6 = w4.bnSubtract(w5)

    if (this.THREE.nbv(0).bnEquals(w3)) {
      if (this.THREE.nbv(0).bnEquals(w6)) {
        return this.twice() // this == b，计算自加
      }
      return this.curve.infinity // this == -b，则返回无穷远点
    }

    const w7 = w1.bnAdd(w2)
    const w8 = z1.bnMultiply(z2).bnMod(q)
    const w9 = w3.bnSquare().bnMod(q)
    const w10 = w3.bnMultiply(w9).bnMod(q)
    const w11 = w8.bnMultiply(w6.bnSquare()).bnSubtract(w7.bnMultiply(w9)).bnMod(q)

    const x3 = w3.bnMultiply(w11).bnMod(q)
    const y3 = w6.bnMultiply(w9.bnMultiply(w1).bnSubtract(w11)).bnSubtract(w4.bnMultiply(w10)).bnMod(q)
    const z3 = w10.bnMultiply(w8).bnMod(q)

    return new ECPointFp(this.curve, this.curve.fromBigInteger(x3), this.curve.fromBigInteger(y3), z3)
  }

  /**
   * 自加
   *
   * 标准射影坐标系：
   *
   * λ1 = 3 * x1^2 + a * z1^2
   * λ2 = 2 * y1 * z1
   * λ3 = y1^2
   * λ4 = λ3 * x1 * z1
   * λ5 = λ2^2
   * λ6 = λ1^2 − 8 * λ4
   * x3 = λ2 * λ6
   * y3 = λ1 * (4 * λ4 − λ6) − 2 * λ5 * λ3
   * z3 = λ2 * λ5
   */
  twice(): ECPointFp {
    if (this.isInfinity()) return this
    if (!this.y.toBigInteger().bnSigNum()) return this.curve.infinity

    const x1 = this.x.toBigInteger()
    const y1 = this.y.toBigInteger()
    const z1 = this.z
    const q = this.curve.q
    const a = this.curve.a.toBigInteger()

    const w1 = x1.bnSquare().bnMultiply(this.THREE).bnAdd(a.bnMultiply(z1.bnSquare())).bnMod(q)
    const w2 = y1.bnShiftLeft(1).bnMultiply(z1).bnMod(q)
    const w3 = y1.bnSquare().bnMod(q)
    const w4 = w3.bnMultiply(x1).bnMultiply(z1).bnMod(q)
    const w5 = w2.bnSquare().bnMod(q)
    const w6 = w1.bnSquare().bnSubtract(w4.bnShiftLeft(3)).bnMod(q)

    const x3 = w2.bnMultiply(w6).bnMod(q)
    const y3 = w1.bnMultiply(w4.bnShiftLeft(2).bnSubtract(w6)).bnSubtract(w5.bnShiftLeft(1).bnMultiply(w3)).bnMod(q)
    const z3 = w2.bnMultiply(w5).bnMod(q)

    return new ECPointFp(this.curve, this.curve.fromBigInteger(x3), this.curve.fromBigInteger(y3), z3)
  }

  /**
   * 倍点计算
   */
  multiply(k: BigInteger): ECPointFp {
    if (this.isInfinity()) return this
    if (!k.bnSigNum()) return this.curve.infinity

    // 使用加减法
    const k3 = k.bnMultiply(this.THREE)
    const neg = this.negate()
    let Q: ECPointFp = this;

    for (let i = k3.bnBitLength() - 2; i > 0; i--) {
      Q = this.twice()

      const k3Bit = k3.bnTestBit(i)
      const kBit = k.bnTestBit(i)

      if (k3Bit !== kBit) {
        Q = Q.add(k3Bit ? this : neg)
      }
    }

    return Q
  }
}

/**
 * 椭圆曲线 y^2 = x^3 + ax + b
 */
export class ECCurveFp {
  q: BigInteger
  a: ECFieldElementFp
  b: ECFieldElementFp
  infinity: ECPointFp
  private TWO = new BigInteger('2')

  constructor(q: BigInteger, a: BigInteger, b: BigInteger) {
    this.q = q
    this.a = this.fromBigInteger(a)
    this.b = this.fromBigInteger(b)
    this.infinity = new ECPointFp(this, null, null) // 无穷远点
  }

  /**
   * 判断两个椭圆曲线是否相等
   */
  equals(other: ECCurveFp): boolean {
    if (other === this) return true
    return (this.q.bnEquals(other.q) && this.a.equals(other.a) && this.b.equals(other.b))
  }

  /**
   * 生成椭圆曲线域元素
   */
  fromBigInteger(x: BigInteger): ECFieldElementFp {
    return new ECFieldElementFp(this.q, x)
  }

  /**
   * 解析 16 进制串为椭圆曲线点
   */
  decodePointHex(s: string): ECPointFp {
    switch (parseInt(s.substr(0, 2), 16)) {
    // 第一个字节
      case 0:
        return this.infinity
      case 2:
      case 3:
      // 压缩
        const x = this.fromBigInteger(new BigInteger(s.substr(2), 16))
      // 对 p ≡ 3 (mod4)，即存在正整数 u，使得 p = 4u + 3
      // 计算 y = (√ (x^3 + ax + b) % p)^(u + 1) modp
        let y = this.fromBigInteger(x.multiply(x.square())
          .add(
            x.multiply(this.a)
          )
          .add(this.b)
          .toBigInteger()
          .bnModPow(
            this.q.bnDivide(new BigInteger('4')).bnAdd(this.TWO.nbv(1)), this.q
          ))
      // 算出结果 2 进制最后 1 位不等于第 1 个字节减 2 则取反
        if (!y.toBigInteger().bnMod(this.TWO).bnEquals(new BigInteger(s.substr(0, 2), 16).bnSubtract(this.TWO))) {
          y = y.negate()
        }
        return new ECPointFp(this, x, y)
      case 4:
      case 6:
      case 7:
        const len = (s.length - 2) / 2
        const xHex = s.substr(2, len)
        const yHex = s.substr(len + 2, len)

        return new ECPointFp(this, this.fromBigInteger(new BigInteger(xHex, 16)), this.fromBigInteger(new BigInteger(yHex, 16)))
      default:
      // 不支持
        return null
    }
  }
}