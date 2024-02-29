/**
 * @Author csx
 * @DateTime 2024/2/27 21:31
 * @TODO JSBN
 */
export class BigInteger {


  // JavaScript engine analysis
  private canary = 0xdeadbeefcafe;
  private BI_RM = '0123456789abcdefghijklmnopqrstuvwxyz';
  t: number;
  s: number;
  private dbits = 28;
  public DB = this.dbits;
  public DM = (1 << this.dbits) - 1;
  public DV = 1 << this.dbits;
  private BI_FP = 52;
  private FV = Math.pow(2, this.BI_FP);
  private F1 = this.BI_FP - this.dbits;
  private F2 = 2 * this.dbits - this.BI_FP;
  private BI_RC = new Array();
  public am = this.am3;
  public readonly ZERO = this.nbv(0);
  public readonly ONE = this.nbv(1);
  private lowprimes = [
    2,
    3,
    5,
    7,
    11,
    13,
    17,
    19,
    23,
    29,
    31,
    37,
    41,
    43,
    47,
    53,
    59,
    61,
    67,
    71,
    73,
    79,
    83,
    89,
    97,
    101,
    103,
    107,
    109,
    113,
    127,
    131,
    137,
    139,
    149,
    151,
    157,
    163,
    167,
    173,
    179,
    181,
    191,
    193,
    197,
    199,
    211,
    223,
    227,
    229,
    233,
    239,
    241,
    251,
    257,
    263,
    269,
    271,
    277,
    281,
    283,
    293,
    307,
    311,
    313,
    317,
    331,
    337,
    347,
    349,
    353,
    359,
    367,
    373,
    379,
    383,
    389,
    397,
    401,
    409,
    419,
    421,
    431,
    433,
    439,
    443,
    449,
    457,
    461,
    463,
    467,
    479,
    487,
    491,
    499,
    503,
    509,
    521,
    523,
    541,
    547,
    557,
    563,
    569,
    571,
    577,
    587,
    593,
    599,
    601,
    607,
    613,
    617,
    619,
    631,
    641,
    643,
    647,
    653,
    659,
    661,
    673,
    677,
    683,
    691,
    701,
    709,
    719,
    727,
    733,
    739,
    743,
    751,
    757,
    761,
    769,
    773,
    787,
    797,
    809,
    811,
    821,
    823,
    827,
    829,
    839,
    853,
    857,
    859,
    863,
    877,
    881,
    883,
    887,
    907,
    911,
    919,
    929,
    937,
    941,
    947,
    953,
    967,
    971,
    977,
    983,
    991,
    997,
  ];
  private lplim = (1 << 26) / this.lowprimes[this.lowprimes.length - 1];


  // (public) Constructor
  constructor(a, b?, c?) {
    if (a != null)
      if ('number' == typeof a) this.bnpFromNumber(a, b, c);
      else if (b == null && 'string' != typeof a) this.bnpFromString(a, 256);
      else this.bnpFromString(a, b);
  }


  // return bigint initialized to value
  nbv(i): BigInteger {
    let r = this.nbi();
    r.bnpFromInt(i);
    return r;
  }


  // return new, unset BigInteger
  nbi(): BigInteger {
    return new BigInteger(null);
  }


  // (public) |this|
  bnAbs(): BigInteger {
    return this.s < 0 ? this.bnNegate() : this;
  }

  bnpFromInt(x) {
    this.t = 1;
    this.s = x < 0 ? -1 : 0;
    if (x > 0) this[0] = x;
    else if (x < -1) this[0] = x + this.DV;
    else this.t = 0;
  }

  // browsers slow down when dealing with 32-bit numbers.
  am3(i, x, w, j, c, n) {
    var xl = x & 0x3fff,
      xh = x >> 14;
    while (--n >= 0) {
      var l = this[i] & 0x3fff;
      var h = this[i++] >> 14;
      var m = xh * l + h * xl;
      l = xl * l + ((m & 0x3fff) << 14) + w[j] + c;
      c = (l >> 28) + (m >> 14) + xh * h;
      w[j++] = l & 0xfffffff;
    }
    return c;
  }

  // (protected) return x s.t. r^x < DV
  bnpChunkSize(r): number {
    return Math.floor((Math.LN2 * this.DB) / Math.log(r));
  }


  // (public) 0 if this == 0, 1 if this > 0
  bnSigNum() {
    if (this.s < 0) return -1;
    else if (this.t <= 0 || (this.t == 1 && this[0] <= 0)) return 0;
    else return 1;
  }

  // (protected) this *= n, this >= 0, 1 < n < DV
  bnpDMultiply(n) {
    this[this.t] = this.am(0, n - 1, this, 0, 0, this.t);
    ++this.t;
    this.bnpClamp();
  }

  // (protected) this += n << w words, this >= 0
  bnpDAddOffset(n, w) {
    if (n == 0) return;
    while (this.t <= w) this[this.t++] = 0;
    this[w] += n;
    while (this[w] >= this.DV) {
      this[w] -= this.DV;
      if (++w >= this.t) this[this.t++] = 0;
      ++this[w];
    }
  }

  // (protected) convert from radix string
  bnpFromRadix(s, b) {
    this.bnpFromInt(0);
    if (b == null) b = 10;
    var cs = this.bnpChunkSize(b);
    var d = Math.pow(b, cs),
      mi = false,
      j = 0,
      w = 0;
    for (var i = 0; i < s.length; ++i) {
      var x = this.intAt(s, i);
      if (x < 0) {
        if (s.charAt(i) == '-' && this.bnSigNum() == 0) mi = true;
        continue;
      }
      w = b * w + x;
      if (++j >= cs) {
        this.bnpDMultiply(d);
        this.bnpDAddOffset(w, 0);
        j = 0;
        w = 0;
      }
    }
    if (j > 0) {
      this.bnpDMultiply(Math.pow(b, j));
      this.bnpDAddOffset(w, 0);
    }
    if (mi) this.ZERO.bnpSubTo(this, this);
  }

  // (protected) r = this - a
  bnpSubTo(a, r) {
    var i = 0,
      c = 0,
      m = Math.min(a.t, this.t);
    while (i < m) {
      c += this[i] - a[i];
      r[i++] = c & this.DM;
      c >>= this.DB;
    }
    if (a.t < this.t) {
      c -= a.s;
      while (i < this.t) {
        c += this[i];
        r[i++] = c & this.DM;
        c >>= this.DB;
      }
      c += this.s;
    } else {
      c += this.s;
      while (i < a.t) {
        c -= a[i];
        r[i++] = c & this.DM;
        c >>= this.DB;
      }
      c -= a.s;
    }
    r.s = c < 0 ? -1 : 0;
    if (c < -1) r[i++] = this.DV + c;
    else if (c > 0) r[i++] = c;
    r.t = i;
    r.clamp();
  }

  // (protected) set from string and radix
  bnpFromString(s, b) {
    // Auto-detect string notations
    if (!b && s.length >= 2 && s[0] === '0') {
      var isDetected = true;
      switch (s[1]) {
        case 'x': // Hexadecimal notation
          b = 16;
          break;
        case 'b': // Binary notation
          b = 2;
          break;
        case 'o': // Octal notation
          b = 8;
          break;
        default:
          isDetected = false;
      }

      // Remove the notation string if any has been detected
      if (isDetected) {
        s = s.substr(2);
      }
    }

    var k;
    if (b == 16) k = 4;
    else if (b == 8) k = 3;
    else if (b == 256) k = 8;
    // byte array
    else if (b == 2) k = 1;
    else if (b == 32) k = 5;
    else if (b == 4) k = 2;
    else {
      this.bnpFromRadix(s, b);
      // this.fromRadix(s, b);
      return;
    }
    this.t = 0;
    this.s = 0;
    var i = s.length,
      mi = false,
      sh = 0;
    while (--i >= 0) {
      var x = k == 8 ? s[i] & 0xff : this.intAt(s, i);
      if (x < 0) {
        if (s.charAt(i) == '-') mi = true;
        continue;
      }
      mi = false;
      if (sh == 0) this[this.t++] = x;
      else if (sh + k > this.DB) {
        this[this.t - 1] |= (x & ((1 << (this.DB - sh)) - 1)) << sh;
        this[this.t++] = x >> (this.DB - sh);
      } else this[this.t - 1] |= x << sh;
      sh += k;
      if (sh >= this.DB) sh -= this.DB;
    }
    if (k == 8 && (s[0] & 0x80) != 0) {
      this.s = -1;
      if (sh > 0) this[this.t - 1] |= ((1 << (this.DB - sh)) - 1) << sh;
    }
    // this.clamp();
    this.bnpClamp();
    if (mi) this.ZERO.bnpSubTo(this, this);
  }

  bnXor(a) {
    var r = this.nbi();
    this.bnpBitwiseTo(a, this.op_xor, r);
    return r;
  }

  bnClone() {
    var r = this.nbi();
    this.bnpCopyTo(r);
    return r;
  }

  bnModInverse(m: BigInteger) {
    var ac = m.bnpIsEven();
    if ((this.bnpIsEven() && ac) || m.bnSigNum() == 0) return m.ZERO;
    var u = m.bnClone(),
      v = this.bnClone();
    var a = this.nbv(1),
      b = this.nbv(0),
      c = this.nbv(0),
      d = this.nbv(1);
    while (u.bnSigNum() != 0) {
      while (u.bnpIsEven()) {
        u.bnpRShiftTo(1, u);
        if (ac) {
          if (!a.bnpIsEven() || !b.bnpIsEven()) {
            a.bnpAddTo(this, a);
            b.bnpSubTo(m, b);
          }
          a.bnpRShiftTo(1, a);
        } else if (!b.bnpIsEven()) b.bnpSubTo(m, b);
        b.bnpRShiftTo(1, b);
      }
      while (v.bnpIsEven()) {
        v.bnpRShiftTo(1, v);
        if (ac) {
          if (!c.bnpIsEven() || !d.bnpIsEven()) {
            c.bnpAddTo(this, c);
            d.bnpSubTo(m, d);
          }
          c.bnpRShiftTo(1, c);
        } else if (!d.bnpIsEven()) d.bnpSubTo(m, d);
        d.bnpRShiftTo(1, d);
      }
      if (u.bnCompareTo(v) >= 0) {
        u.bnpSubTo(v, u);
        if (ac) a.bnpSubTo(c, a);
        b.bnpSubTo(d, b);
      } else {
        v.bnpSubTo(u, v);
        if (ac) c.bnpSubTo(a, c);
        d.bnpSubTo(b, d);
      }
    }
    if (v.bnCompareTo(m.ONE) != 0) return m.ZERO;
    if (d.bnCompareTo(m) >= 0) return d.bnSubtract(m);
    if (d.bnSigNum() < 0) d.bnpAddTo(m, d);
    else return d;
    if (d.bnSigNum() < 0) return d.bnAdd(m);
    else return d;
  }

  // (public) -this
  bnNegate(): BigInteger {
    var r = this.nbi();
    this.ZERO.bnpSubTo(this, r);
    return r;
  }

  // (protected) divide this by m, quotient and remainder to q, r (HAC 14.20)
  // r != q, this != m.  q or r may be null.
  bnpDivRemTo(m: BigInteger, q: BigInteger, r: BigInteger) {
    var pm = m.bnAbs();
    if (pm.t <= 0) return;
    var pt = this.bnAbs();
    if (pt.t < pm.t) {
      if (q != null) q.bnpFromInt(0);
      if (r != null) this.bnpCopyTo(r);
      return;
    }
    if (r == null) r = this.nbi();
    var y = this.nbi(),
      ts = this.s,
      ms = m.s;
    var nsh = this.DB - this.nbits(pm[pm.t - 1]); // normalize modulus
    if (nsh > 0) {
      pm.bnpDLShiftTo(nsh, y);
      pt.bnpDLShiftTo(nsh, r);
    } else {
      pm.bnpCopyTo(y);
      pt.bnpCopyTo(r);
    }
    var ys = y.t;
    var y0 = y[ys - 1];
    if (y0 == 0) return;
    var yt = y0 * (1 << this.F1) + (ys > 1 ? y[ys - 2] >> this.F2 : 0);
    var d1 = this.FV / yt,
      d2 = (1 << this.F1) / yt,
      e = 1 << this.F2;
    var i = r.t,
      j = i - ys,
      t = q == null ? this.nbi() : q;
    y.bnpDLShiftTo(j, t);
    if (r.bnCompareTo(t) >= 0) {
      r[r.t++] = 1;
      r.bnpSubTo(t, r);
    }
    this.ONE.bnpDLShiftTo(ys, t);
    t.bnpSubTo(y, y); // "negative" y so we can replace sub with am later
    while (y.t < ys) y[y.t++] = 0;
    while (--j >= 0) {
      // Estimate quotient digit
      var qd =
          r[--i] == y0 ? this.DM : Math.floor(r[i] * d1 + (r[i - 1] + e) * d2);
      if ((r[i] += y.am(0, qd, r, j, 0, ys)) < qd) {
        // Try it out
        y.bnpDLShiftTo(j, t);
        r.bnpSubTo(t, r);
        while (r[i] < --qd) r.bnpSubTo(t, r);
      }
    }
    if (q != null) {
      r.bnpDRShiftTo(ys, q);
      if (ts != ms) this.ZERO.bnpSubTo(q, q);
    }
    r.t = ys;
    r.bnpClamp();
    if (nsh > 0) r.bnpRShiftTo(nsh, r); // Denormalize remainder
    if (ts < 0) this.ZERO.bnpSubTo(r, r);
  }


  // (public) return value as integer
  bnIntValue(): number {
    if (this.s < 0) {
      if (this.t == 1) return this[0] - this.DV;
      else if (this.t == 0) return -1;
    } else if (this.t == 1) return this[0];
    else if (this.t == 0) return 0;
    // assumes 16 < DB < 32
    return ((this[1] & ((1 << (32 - this.DB)) - 1)) << this.DB) | this[0];
  }

  // (protected) convert to radix string
  bnpToRadix(b) {
    if (b == null) b = 10;
    if (this.bnSigNum() == 0 || b < 2 || b > 36) return '0';
    var cs = this.bnpChunkSize(b);
    var a = Math.pow(b, cs);
    var d = this.nbv(a),
      y = this.nbi(),
      z = this.nbi(),
      r = '';
    this.bnpDivRemTo(d, y, z);
    while (y.bnSigNum() > 0) {
      r = (a + z.bnIntValue()).toString(b).substr(1) + r;
      y.bnpDivRemTo(d, y, z);
    }
    return z.bnIntValue().toString(b) + r;
  }


  // (protected) r = this >> n
  bnpRShiftTo(n, r: BigInteger) {
    r.s = this.s;
    var ds = Math.floor(n / this.DB);
    if (ds >= this.t) {
      r.t = 0;
      return;
    }
    var bs = n % this.DB;
    var cbs = this.DB - bs;
    var bm = (1 << bs) - 1;
    r[0] = this[ds] >> bs;
    for (var i = ds + 1; i < this.t; ++i) {
      r[i - ds - 1] |= (this[i] & bm) << cbs;
      r[i - ds] = this[i] >> bs;
    }
    if (bs > 0) r[this.t - ds - 1] |= (this.s & bm) << cbs;
    r.t = this.t - ds;
    r.bnpClamp();
  }

  bnpBitwiseTo(a, op, r: BigInteger) {
    var i,
      f,
      m = Math.min(a.t, this.t);
    for (i = 0; i < m; ++i) r[i] = op(this[i], a[i]);
    if (a.t < this.t) {
      f = a.s & this.DM;
      for (i = m; i < this.t; ++i) r[i] = op(this[i], f);
      r.t = this.t;
    } else {
      f = this.s & this.DM;
      for (i = m; i < a.t; ++i) r[i] = op(f, a[i]);
      r.t = a.t;
    }
    r.s = op(this.s, a.s);
    r.bnpClamp();
  }

  // (public) this << n
  bnShiftLeft(n: number) {
    var r = this.nbi();
    if (n < 0) this.bnpRShiftTo(-n, r);
    else this.bnpLShiftTo(n, r);
    return r;
  }

  // (public) return string representation in given radix
  bnToString(b): string {
    if (this.s < 0) return '-' + this.bnNegate().bnToString(b);
    var k;
    if (b == 16) k = 4;
    else if (b == 8) k = 3;
    else if (b == 2) k = 1;
    else if (b == 32) k = 5;
    else if (b == 4) k = 2;
    else return this.bnpToRadix(b);
    var km = (1 << k) - 1,
      d,
      m = false,
      r = '',
      i = this.t;
    var p = this.DB - ((i * this.DB) % k);
    if (i-- > 0) {
      if (p < this.DB && (d = this[i] >> p) > 0) {
        m = true;
        r = this.int2char(d);
      }
      while (i >= 0) {
        if (p < k) {
          d = (this[i] & ((1 << p) - 1)) << (k - p);
          d |= this[--i] >> (p += this.DB - k);
        } else {
          d = (this[i] >> (p -= k)) & km;
          if (p <= 0) {
            p += this.DB;
            --i;
          }
        }
        if (d > 0) m = true;
        if (m) r += this.int2char(d);
      }
    }
    return m ? r : '0';
  }

  // (public) true iff nth bit is set
  bnTestBit(n) {
    var j = Math.floor(n / this.DB);
    if (j >= this.t) return this.s != 0;
    return (this[j] & (1 << n % this.DB)) != 0;
  }

  // (protected) this op (1<<n)
  bnpChangeBit(n, op): BigInteger {
    var r = this.ONE.bnShiftLeft(n);
    this.bnpBitwiseTo(r, op, r);
    return r;
  }

  op_or(x: number, y: number): number {
    return x | y;
  }

  op_andnot(x: number, y: number): number {
    return x & ~y;
  }

  // (public) this | (1<<n)
  bnSetBit(n: number): BigInteger {
    return this.bnpChangeBit(n, this.op_or);
  }

  // (public) this & ~(1<<n)
  bnClearBit(n: number): BigInteger {
    return this.bnpChangeBit(n, this.op_andnot);
  }

  op_xor(x: number, y: number): number {
    return x ^ y;
  }

  // (public) this ^ (1<<n)
  bnFlipBit(n: number): BigInteger {
    return this.bnpChangeBit(n, this.op_xor);
  }

  // (protected) r = this + a
  bnpAddTo(a: BigInteger, r: BigInteger) {
    var i = 0,
      c = 0,
      m = Math.min(a.t, this.t);
    while (i < m) {
      c += this[i] + a[i];
      r[i++] = c & this.DM;
      c >>= this.DB;
    }
    if (a.t < this.t) {
      c += a.s;
      while (i < this.t) {
        c += this[i];
        r[i++] = c & this.DM;
        c >>= this.DB;
      }
      c += this.s;
    } else {
      c += this.s;
      while (i < a.t) {
        c += a[i];
        r[i++] = c & this.DM;
        c >>= this.DB;
      }
      c += a.s;
    }
    r.s = c < 0 ? -1 : 0;
    if (c > 0) r[i++] = c;
    else if (c < -1) r[i++] = this.DV + c;
    r.t = i;
    r.bnpClamp();
  }

  // (public) this + a
  bnAdd(a: BigInteger): BigInteger {
    var r = this.nbi();
    this.bnpAddTo(a, r);
    return r;
  }

  // (public) this - a
  bnSubtract(a: BigInteger): BigInteger {
    var r = this.nbi();
    this.bnpSubTo(a, r);
    return r;
  }

  // (public) this * a
  bnMultiply(a: BigInteger): BigInteger {
    var r = this.nbi();
    this.bnpMultiplyTo(a, r);
    return r;
  }

  // (public) this^2
  bnSquare(): BigInteger {
    var r = this.nbi();
    this.bnpSquareTo(r);
    return r;
  }

  // (public) this / a
  bnDivide(a: BigInteger): BigInteger {
    var r = this.nbi();
    this.bnpDivRemTo(a, r, null);
    return r;
  }

  // (public) this % a
  bnRemainder(a: BigInteger): BigInteger {
    var r = this.nbi();
    this.bnpDivRemTo(a, null, r);
    return r;
  }

  // (public) [this/a,this%a]
  bnDivideAndRemainder(a: BigInteger): Array<BigInteger> {
    var q = this.nbi(),
      r = this.nbi();
    this.bnpDivRemTo(a, q, r);
    return new Array(q, r);
  }

  bnpModInt(n: number): number {
    if (n <= 0) return 0;
    var d = this.DV % n,
      r = this.s < 0 ? n - 1 : 0;
    if (this.t > 0)
      if (d == 0) r = this[0] % n;
      else for (var i = this.t - 1; i >= 0; --i) r = (d * r + this[i]) % n;
    return r;
  }

  lbit(x): number {
    if (x == 0) return -1;
    var r = 0;
    if ((x & 0xffff) == 0) {
      x >>= 16;
      r += 16;
    }
    if ((x & 0xff) == 0) {
      x >>= 8;
      r += 8;
    }
    if ((x & 0xf) == 0) {
      x >>= 4;
      r += 4;
    }
    if ((x & 3) == 0) {
      x >>= 2;
      r += 2;
    }
    if ((x & 1) == 0) ++r;
    return r;
  }

  bnGetLowestSetBit(): number {
    for (var i = 0; i < this.t; ++i)
      if (this[i] != 0) return i * this.DB + this.lbit(this[i]);
    if (this.s < 0) return this.t * this.DB;
    return -1;
  }

  bnShiftRight(n: number): BigInteger {
    var r = this.nbi();
    if (n < 0) this.bnpLShiftTo(-n, r);
    else this.bnpRShiftTo(n, r);
    return r;
  }

  // (public) this^e % m (HAC 14.85)
  bnModPow(e: BigInteger, m: BigInteger) {
    var i = e.bnBitLength(),
      k,
      r = this.nbv(1),
      z;
    if (i <= 0) return r;
    else if (i < 18) k = 1;
    else if (i < 48) k = 3;
    else if (i < 144) k = 4;
    else if (i < 768) k = 5;
    else k = 6;
    if (i < 8) z = new Classic(m);
    else if (m.bnpIsEven()) z = new Barrett(m);
    else z = new Montgomery(m);

    // precomputation
    var g = new Array(),
      n = 3,
      k1 = k - 1,
      km = (1 << k) - 1;
    g[1] = z.convert(this);
    if (k > 1) {
      var g2 = this.nbi();
      z.sqrTo(g[1], g2);
      while (n <= km) {
        g[n] = this.nbi();
        z.mulTo(g2, g[n - 2], g[n]);
        n += 2;
      }
    }

    var j = e.t - 1,
      w,
      is1 = true,
      r2 = this.nbi(),
      t;
    i = this.nbits(e[j]) - 1;
    while (j >= 0) {
      if (i >= k1) w = (e[j] >> (i - k1)) & km;
      else {
        w = (e[j] & ((1 << (i + 1)) - 1)) << (k1 - i);
        if (j > 0) w |= e[j - 1] >> (this.DB + i - k1);
      }

      n = k;
      while ((w & 1) == 0) {
        w >>= 1;
        --n;
      }
      if ((i -= n) < 0) {
        i += this.DB;
        --j;
      }
      if (is1) {
        // ret == 1, don't bother squaring or multiplying it
        g[w].copyTo(r);
        is1 = false;
      } else {
        while (n > 1) {
          z.sqrTo(r, r2);
          z.sqrTo(r2, r);
          n -= 2;
        }
        if (n > 0) z.sqrTo(r, r2);
        else {
          t = r;
          r = r2;
          r2 = t;
        }
        z.mulTo(r2, g[w], r);
      }

      while (j >= 0 && (e[j] & (1 << i)) == 0) {
        z.sqrTo(r, r2);
        t = r;
        r = r2;
        r2 = t;
        if (--i < 0) {
          i = this.DB - 1;
          --j;
        }
      }
    }
    return z.revert(r);
  }


  bnpMillerRabin(t: number): boolean {
    var n1 = this.bnSubtract(this.ONE);
    var k = n1.bnGetLowestSetBit();
    if (k <= 0) return false;
    var r = n1.bnShiftRight(k);
    t = (t + 1) >> 1;
    if (t > this.lowprimes.length) t = this.lowprimes.length;
    var a = this.nbi();
    for (var i = 0; i < t; ++i) {
      //Pick bases at random, instead of starting at 2
      a.bnpFromInt(this.lowprimes[Math.floor(Math.random() * this.lowprimes.length)]);
      var y = a.bnModPow(r, this);
      if (y.compareTo(this.ONE) != 0 && y.compareTo(n1) != 0) {
        var j = 1;
        while (j++ < k && y.compareTo(n1) != 0) {
          y = y.modPowInt(2, this);
          if (y.compareTo(this.ONE) == 0) return false;
        }
        if (y.compareTo(n1) != 0) return false;
      }
    }
    return true;
  }

  bnIsProbablePrime(t) {
    var i,
      x = this.bnAbs();
    if (x.t == 1 && x[0] <= this.lowprimes[this.lowprimes.length - 1]) {
      for (i = 0; i < this.lowprimes.length; ++i)
        if (x[0] == this.lowprimes[i]) return true;
      return false;
    }
    if (x.bnpIsEven()) return false;
    i = 1;
    while (i < this.lowprimes.length) {
      var m = this.lowprimes[i],
        j = i + 1;
      while (j < this.lowprimes.length && m < this.lplim) m *= this.lowprimes[j++];
      m = x.bnpModInt(m);
      while (i < j) if (m % this.lowprimes[i++] == 0) return false;
    }
    return x.bnpMillerRabin(t);
  }


  // (protected) alternate constructor
  bnpFromNumber(a: number, b: SecureRandom, c?) {
    if ('number' == typeof b) {
      // new BigInteger(int,int,RNG)
      if (a < 2) this.bnpFromInt(1);
      else {
        this.bnpFromNumber(a, c);
        if (!this.bnTestBit(a - 1))
        // force MSB set
          this.bnpBitwiseTo(this.ONE.bnShiftLeft(a - 1), this.op_or, this);
        if (this.bnpIsEven()) this.bnpDAddOffset(1, 0); // force odd
        while (!this.bnIsProbablePrime(b)) {
          this.bnpDAddOffset(2, 0);
          if (this.bnBitLength() > a)
            this.bnpSubTo(this.ONE.bnShiftLeft(a - 1), this);
        }
      }
    } else {
      // new BigInteger(int,RNG)
      var x = new Array(),
        t = a & 7;
      x.length = (a >> 3) + 1;
      b.rng_get_bytes(x);
      if (t > 0) x[0] &= (1 << t) - 1;
      else x[0] = 0;
      this.bnpFromString(x, 256);
    }
  }


  int2char(n) {
    return this.BI_RM.charAt(n);
  }

  intAt(s, i) {
    var c = this.BI_RC[s.charCodeAt(i)];
    return c == null ? -1 : c;
  }

  // (protected) copy this to r
  bnpCopyTo(r) {
    for (var i = this.t - 1; i >= 0; --i) r[i] = this[i];
    r.t = this.t;
    r.s = this.s;
  }


  // (protected) clamp off excess high words
  bnpClamp() {
    var c = this.s & this.DM;
    while (this.t > 0 && this[this.t - 1] == c) --this.t;
  }


  // (public) return + if this > a, - if this < a, 0 if equal
  bnCompareTo(a: BigInteger) {
    var r = this.s - a.s;
    if (r != 0) return r;
    var i = this.t;
    r = i - a.t;
    if (r != 0) return this.s < 0 ? -r : r;
    while (--i >= 0) if ((r = this[i] - a[i]) != 0) return r;
    return 0;
  }

  // returns bit length of the integer x
  nbits(x) {
    var r = 1,
      t;
    if ((t = x >>> 16) != 0) {
      x = t;
      r += 16;
    }
    if ((t = x >> 8) != 0) {
      x = t;
      r += 8;
    }
    if ((t = x >> 4) != 0) {
      x = t;
      r += 4;
    }
    if ((t = x >> 2) != 0) {
      x = t;
      r += 2;
    }
    if ((t = x >> 1) != 0) {
      x = t;
      r += 1;
    }
    return r;
  }

  // (public) return the number of bits in "this"
  bnBitLength() {
    if (this.t <= 0) return 0;
    return (
      this.DB * (this.t - 1) + this.nbits(this[this.t - 1] ^ (this.s & this.DM))
    );
  }

  // (protected) r = this << n*DB
  bnpDLShiftTo(n, r) {
    var i;
    for (i = this.t - 1; i >= 0; --i) r[i + n] = this[i];
    for (i = n - 1; i >= 0; --i) r[i] = 0;
    r.t = this.t + n;
    r.s = this.s;
  }

  // (protected) r = this >> n*DB
  bnpDRShiftTo(n, r) {
    for (var i = n; i < this.t; ++i) r[i - n] = this[i];
    r.t = Math.max(this.t - n, 0);
    r.s = this.s;
  }

  // (protected) r = lower n words of "this * a", a.t <= n
  // "this" should be the larger one if appropriate.
  bnpMultiplyLowerTo(a: BigInteger, n: number, r: BigInteger) {
    var i = Math.min(this.t + a.t, n);
    r.s = 0; // assumes a,this >= 0
    r.t = i;
    while (i > 0) r[--i] = 0;
    var j;
    for (j = r.t - this.t; i < j; ++i)
      r[i + this.t] = this.am(0, a[i], r, i, 0, this.t);
    for (j = Math.min(a.t, n); i < j; ++i) this.am(0, a[i], r, i, 0, n - i);
    r.bnpClamp();
  }

  // (protected) r = "this * a" without lower n words, n > 0
  // "this" should be the larger one if appropriate.
  bnpMultiplyUpperTo(a: BigInteger, n: number, r: BigInteger) {
    --n;
    var i = (r.t = this.t + a.t - n);
    r.s = 0; // assumes a,this >= 0
    while (--i >= 0) r[i] = 0;
    for (i = Math.max(n - this.t, 0); i < a.t; ++i)
      r[this.t + i - n] = this.am(n - i, a[i], r, 0, 0, this.t + i - n);
    r.bnpClamp();
    r.bnpDRShiftTo(1, r);
  }

  // (protected) r = this << n
  bnpLShiftTo(n, r: BigInteger) {
    var bs = n % this.DB;
    var cbs = this.DB - bs;
    var bm = (1 << cbs) - 1;
    var ds = Math.floor(n / this.DB),
      c = (this.s << bs) & this.DM,
      i;
    for (i = this.t - 1; i >= 0; --i) {
      r[i + ds + 1] = (this[i] >> cbs) | c;
      c = (this[i] & bm) << bs;
    }
    for (i = ds - 1; i >= 0; --i) r[i] = 0;
    r[ds] = c;
    r.t = this.t + ds + 1;
    r.s = this.s;
    r.bnpClamp();
  }


  // (protected) r = this * a, r != this,a (HAC 14.12)
  // "this" should be the larger one if appropriate.
  bnpMultiplyTo(a: BigInteger, r: BigInteger) {
    var x = this.bnAbs(),
      y = a.bnAbs();
    var i = x.t;
    r.t = i + y.t;
    while (--i >= 0) r[i] = 0;
    for (i = 0; i < y.t; ++i) r[i + x.t] = x.am(0, y[i], r, i, 0, x.t);
    r.s = 0;
    r.bnpClamp();
    if (this.s != a.s) this.ZERO.bnpSubTo(r, r);
  }

  // (protected) r = this^2, r != this (HAC 14.16)
  bnpSquareTo(r: BigInteger) {
    var x = this.bnAbs();
    var i = (r.t = 2 * x.t);
    while (--i >= 0) r[i] = 0;
    for (i = 0; i < x.t - 1; ++i) {
      var c = x.am(i, x[i], r, 2 * i, 0, 1);
      if (
        (r[i + x.t] += x.am(i + 1, 2 * x[i], r, 2 * i + 1, c, x.t - i - 1)) >=
        x.DV
      ) {
        r[i + x.t] -= x.DV;
        r[i + x.t + 1] = 1;
      }
    }
    if (r.t > 0) r[r.t - 1] += x.am(i, x[i], r, 2 * i, 0, 1);
    r.s = 0;
    r.bnpClamp();
  }


  // (public) this mod a
  bnMod(a: BigInteger): BigInteger {
    var r = this.nbi();
    this.bnAbs().bnpDivRemTo(a, null, r);
    if (this.s < 0 && r.bnCompareTo(this.ZERO) > 0) a.bnpSubTo(r, r);
    return r;
  }

  bnEquals(a) {
    return this.bnCompareTo(a) == 0;
  }


  // (protected) return "-1/this % 2^DB"; useful for Mont. reduction
  // justification:
  //         xy == 1 (mod m)
  //         xy =  1+km
  //   xy(2-xy) = (1+km)(1-km)
  // x[y(2-xy)] = 1-k^2m^2
  // x[y(2-xy)] == 1 (mod m^2)
  // if y is 1/x mod m, then y(2-xy) is 1/x mod m^2
  // should reduce x and y(2-xy) by m^2 at each step to keep size bounded.
  // JS multiply "overflows" differently from C/C++, so care is needed here.
  bnpInvDigit() {
    if (this.t < 1) return 0;
    var x = this[0];
    if ((x & 1) == 0) return 0;
    var y = x & 3; // y == 1/x mod 2^2
    y = (y * (2 - (x & 0xf) * y)) & 0xf; // y == 1/x mod 2^4
    y = (y * (2 - (x & 0xff) * y)) & 0xff; // y == 1/x mod 2^8
    y = (y * (2 - (((x & 0xffff) * y) & 0xffff))) & 0xffff; // y == 1/x mod 2^16
    // last step - calculate inverse mod DV directly;
    // assumes 16 < DB <= 32 and assumes ability to handle 48-bit ints
    y = (y * (2 - ((x * y) % this.DV))) % this.DV; // y == 1/x mod 2^dbits
    // we really want the negative inverse, and -DV < y < DV
    return y > 0 ? this.DV - y : -y;
  }

  // (protected) true iff this is even
  bnpIsEven() {
    return (this.t > 0 ? this[0] & 1 : this.s) == 0;
  }

  // (protected) this^e, e < 2^32, doing sqr and mul with "r" (HAC 14.79)
  bnpExp(e, z) {
    if (e > 0xffffffff || e < 1) return this.ONE;
    var r = this.nbi(),
      r2 = this.nbi(),
      g = z.convert(this),
      i = this.nbits(e) - 1;
    g.copyTo(r);
    while (--i >= 0) {
      z.sqrTo(r, r2);
      if ((e & (1 << i)) > 0) z.mulTo(r2, g, r);
      else {
        var t = r;
        r = r2;
        r2 = t;
      }
    }
    return z.revert(r);
  }

  // (public) this^e % m, 0 <= e < 2^32
  bnModPowInt(e, m) {
    var z;
    if (e < 256 || m.isEven()) z = new Classic(m);
    else z = new Montgomery(m);
    return this.bnpExp(e, z);
  }
}

class Classic {
  private m: BigInteger;

  constructor(m: BigInteger) {
    this.m = m
  }

  cConvert(x: BigInteger) {
    if (x.s < 0 || x.bnCompareTo(this.m) >= 0) return x.bnMod(this.m);
    else return x;
  }

  cRevert(x: BigInteger): BigInteger {
    return x;
  }

  cReduce(x: BigInteger) {
    x.bnpDivRemTo(this.m, null, x);
  }

  cMulTo(x: BigInteger, y: BigInteger, r: BigInteger) {
    x.bnpMultiplyTo(y, r);
    this.cRevert(r);
  }

  cSqrTo(x: BigInteger, r: BigInteger) {
    x.bnpSquareTo(r);
    this.cReduce(r);
  }
}

class Barrett {
  private m: BigInteger;
  r2: BigInteger;
  q3: BigInteger;
  mu: BigInteger;

  constructor(m: BigInteger) {
    let bigInt: BigInteger = new BigInteger(null);
    this.r2 = bigInt.nbi();
    this.q3 = bigInt.nbi();
    bigInt.ONE.bnpDLShiftTo(2 * m.t, this.r2);
    this.mu = this.r2.bnDivide(m);
    this.m = m;
  }

  barrettConvert(x: BigInteger): BigInteger {
    if (x.s < 0 || x.t > 2 * this.m.t) return x.bnMod(this.m);
    else if (x.bnCompareTo(this.m) < 0) return x;
    else {
      var r = this.m.nbi();
      x.bnpCopyTo(r);
      this.barrettReduce(r);
      return r;
    }
  }

  barrettRevert(x: BigInteger): BigInteger {
    return x;
  }

  // x = x mod m (HAC 14.42)
  barrettReduce(x: BigInteger) {
    x.bnpDRShiftTo(this.m.t - 1, this.r2);
    if (x.t > this.m.t + 1) {
      x.t = this.m.t + 1;
      x.bnpClamp();
    }
    this.mu.bnpMultiplyUpperTo(this.r2, this.m.t + 1, this.q3);
    this.m.bnpMultiplyLowerTo(this.q3, this.m.t + 1, this.r2);
    while (x.bnCompareTo(this.r2) < 0) x.bnpDAddOffset(1, this.m.t + 1);
    x.bnpSubTo(this.r2, x);
    while (x.bnCompareTo(this.m) >= 0) x.bnpSubTo(this.m, x);
  }

  // r = x^2 mod m; x != r
  barrettSqrTo(x: BigInteger, r: BigInteger) {
    x.bnpSquareTo(r);
    this.barrettReduce(r);
  }

  // r = x*y mod m; x,y != r
  barrettMulTo(x: BigInteger, y: BigInteger, r: BigInteger) {
    x.bnpMultiplyTo(y, r);
    this.barrettReduce(r);
  }
}

class Montgomery {
  private m: BigInteger;
  mp: number;
  mpl: number;
  mph: number;
  um: number;
  mt2: number;

  constructor(m: BigInteger) {
    this.m = m;
    this.mp = m.bnpInvDigit();
    this.mpl = this.mp & 0x7fff;
    this.mph = this.mp >> 15;
    this.um = (1 << (m.DB - 15)) - 1;
    this.mt2 = 2 * m.t;
  }

  // xR mod m
  montConvert(x: BigInteger) {
    var r = this.m.nbi();
    x.bnAbs().bnpDLShiftTo(this.m.t, r);
    r.bnpDivRemTo(this.m, null, r);
    if (x.s < 0 && r.bnCompareTo(this.m.ZERO) > 0) this.m.bnpSubTo(r, r);
    return r;
  }

  // x/R mod m
  montRevert(x: BigInteger): BigInteger {
    var r = this.m.nbi();
    x.bnpCopyTo(r);
    this.montReduce(r);
    return r;
  }

  // x = x/R mod m (HAC 14.32)
  montReduce(x: BigInteger) {
    while (
      x.t <= this.mt2 // pad x so am has enough room later
    )
      x[x.t++] = 0;
    for (var i = 0; i < this.m.t; ++i) {
      // faster way of calculating u0 = x[i]*mp mod DV
      var j = x[i] & 0x7fff;
      var u0 =
        (j * this.mpl +
        (((j * this.mph + (x[i] >> 15) * this.mpl) & this.um) << 15)) &
        x.DM;
      // use am to combine the multiply-shift-add into one call
      j = i + this.m.t;
      x[j] += this.m.am(0, u0, x, i, 0, this.m.t);
      // propagate carry
      while (x[j] >= x.DV) {
        x[j] -= x.DV;
        x[++j]++;
      }
    }
    x.bnpClamp();
    x.bnpDRShiftTo(this.m.t, x);
    if (x.bnCompareTo(this.m) >= 0) x.bnpSubTo(this.m, x);
  }

  // r = "x^2/R mod m"; x != r
  montSqrTo(x: BigInteger, r: BigInteger) {
    x.bnpSquareTo(r);
    this.montReduce(r);
  }

  // r = "xy/R mod m"; x,y != r
  montMulTo(x: BigInteger, y: BigInteger, r: BigInteger) {
    x.bnpMultiplyTo(y, r);
    this.montReduce(r);
  }
}

class Arcfour {
  i: number;
  j: number;
  S: any[];

  constructor() {
    this.i = 0;
    this.j = 0;
    this.S = new Array();
  }

  init(key) {
    var i, j, t;
    for (i = 0; i < 256; ++i) this.S[i] = i;
    j = 0;
    for (i = 0; i < 256; ++i) {
      j = (j + this.S[i] + key[i % key.length]) & 255;
      t = this.S[i];
      this.S[i] = this.S[j];
      this.S[j] = t;
    }
    this.i = 0;
    this.j = 0;
  }

  next() {
    var t;
    this.i = (this.i + 1) & 255;
    this.j = (this.j + this.S[this.i]) & 255;
    t = this.S[this.i];
    this.S[this.i] = this.S[this.j];
    this.S[this.j] = t;
    return this.S[(t + this.S[this.i]) & 255];
  }
}

export class SecureRandom {
  private rng_state;
  private rng_pool;
  private rng_pptr;
  private rng_psize = 256;

  rng_get_bytes(ba) {
    var i;
    for (i = 0; i < ba.length; ++i) ba[i] = this.rng_get_byte();
  }

  rng_seed_time() {
    this.rng_seed_int(new Date().getTime());
  }

  prng_newstate() {
    return new Arcfour();
  }

  rng_seed_int(x) {
    this.rng_pool[this.rng_pptr++] ^= x & 255;
    this.rng_pool[this.rng_pptr++] ^= (x >> 8) & 255;
    this.rng_pool[this.rng_pptr++] ^= (x >> 16) & 255;
    this.rng_pool[this.rng_pptr++] ^= (x >> 24) & 255;
    if (this.rng_pptr >= this.rng_psize) this.rng_pptr -= this.rng_psize;
  }

  rng_get_byte() {
    if (this.rng_state == null) {
      this.rng_seed_time();
      this.rng_state = this.prng_newstate();
      this.rng_state.init(this.rng_pool);
      for (this.rng_pptr = 0; this.rng_pptr < this.rng_pool.length; ++this.rng_pptr)
        this.rng_pool[this.rng_pptr] = 0;
      this.rng_pptr = 0;
      //rng_pool = null;
    }
    // TODO: allow reseeding after first request
    return this.rng_state.next();
  }
}