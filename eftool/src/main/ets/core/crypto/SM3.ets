/**
 * @Author csx
 * @DateTime 2024/1/17 14:07:01
 * @TODO SM3
 */
export class SM3 {
  var charSet = function () {
    this.parseUTF8 = function (B) {
      for (var B = unescape(encodeURIComponent(B)), C = B.length, D = [], A = 0; A < C; A++) {
        D[A >>> 2] |= (B.charCodeAt(A) & 255) << 24 - A % 4 * 8
      }
      return new WordArray(D, C)
    };
    this.stringifyUTF8 = function (B) {
      try {
        for (var F = decodeURIComponent, G = escape, D, I = B.words, H = B.sigBytes, B = [], C = 0; C < H; C++) {
          var E = I[C >>> 2] >>> 24 - C % 4 * 8 & 255;
          E != 0 && B.push(String.fromCharCode(E))
        }
        D = B.join("");
        return F(G(D))
      } catch (A) {
        throw Error("Malformed UTF-8 data")
      }
    };
    this.HexParse = function (B) {
      for (var C = B.length, D = [], A = 0; A < C; A += 2) {
        D[A >>> 3] |= parseInt(B.substr(A, 2), 16) << 24 - A % 8 * 4
      }
      return new WordArray(D, C / 2)
    };
    this.HexStringify = function (B) {
      for (var E = B.words, B = B.sigBytes, C = [], A = 0; A < B; A++) {
        var D = E[A >>> 2] >>> 24 - A % 4 * 8 & 255;
        C.push((D >>> 4).toString(16));
        C.push((D & 15).toString(16))
      }
      return C.join("")
    };
    return this
  },
  WordArray = function (A, B) {
    this.words = A || [];
    this.sigBytes = B != void 0 ? B : A.length * 4;
    this.getArrs = function () {
      return this.words
    };
    return this
  },
  dbits, canary = 244837814094590,
  j_lm = (canary & 16777215) == 15715070;
  var BI_FP = 52;
  var BI_RM = "0123456789abcdefghijklmnopqrstuvwxyz",
  BI_RC = [],
  rr, vv;
  rr = "0".charCodeAt(0);
  for (vv = 0; vv <= 9; ++vv) {
  BI_RC[rr++] = vv
}
rr = "a".charCodeAt(0);
for (vv = 10; vv < 36; ++vv) {
  BI_RC[rr++] = vv
}
rr = "A".charCodeAt(0);
for (vv = 10; vv < 36; ++vv) {
  BI_RC[rr++] = vv
}

function int2char(A) {
  return BI_RM.charAt(A)
}

function intAt(B, C) {
  var A = BI_RC[B.charCodeAt(C)];
  return A == null ? -1 : A
}

function IEVersion() {
  var C = navigator.userAgent;
  var A = C.indexOf("compatible") > -1 && C.indexOf("MSIE") > -1;
  var F = C.indexOf("Edge") > -1 && !A;
  var E = C.indexOf("Trident") > -1 && C.indexOf("rv:11.0") > -1;
  if (A) {
    var B = new RegExp("MSIE (\\d+\\.\\d+);");
    B.test(C);
    var D = parseFloat(RegExp["$1"]);
    if (D == 7) {
      return 7
    } else {
      if (D == 8) {
        return 8
      } else {
        if (D == 9) {
          return 9
        } else {
          if (D == 10) {
            return 10
          } else {
            return 6
          }
        }
      }
    }
  } else {
    if (F) {
      return "edge"
    } else {
      if (E) {
        return 11
      } else {
        return -1
      }
    }
  }
}

function myBrowser() {
  var B = navigator.userAgent;
  var D = B.indexOf("Opera") > -1;
  var H = B.indexOf("compatible") > -1 && B.indexOf("MSIE") > -1;
  var E = B.indexOf("Edge") > -1 && !H;
  var F = B.indexOf("Trident") > -1 && B.indexOf("rv:11.0") > -1;
  var C = B.indexOf("Firefox") > -1;
  var A = B.indexOf("Safari") > -1;
  var G = B.indexOf("Chrome") > -1;
  if (E) {
    return "edge"
  }
  if (F) {
    return "IE11"
  }
  if (C) {
    return "FF"
  }
  if (G) {
    return "FF"
  }
}
var SecureRandom = function () {
  function H(J) {
    D[C++] ^= J & 255;
    D[C++] ^= J >> 8 & 255;
    D[C++] ^= J >> 16 & 255;
    D[C++] ^= J >> 24 & 255;
    C >= G && (C -= G)
  }
  var F, D, C, G = 256;
  if (D == null) {
    D = [];
    C = 0;
    var E;
    if (myBrowser() == "FF" && window.crypto) {
      var B = new ArrayBuffer(32);
      var I = new Int8Array(B);
      window.crypto.getRandomValues(I);
      for (E = 0; E < I.length; ++E) {
        D[E] = I[E] & 255
      }
    } else {
      if (myBrowser() == "IE11") {
        var B = new ArrayBuffer(32);
        var I = new Int8Array(B);
        var A = window.crypto || window.msCrypto;
        A.getRandomValues(I);
        for (E = 0; E < I.length; ++E) {
          D[E] = I[E] & 255
        }
      } else {
        if (myBrowser() == "edge") {
          var B = new ArrayBuffer(32);
          var I = new Int8Array(B);
          var A = window.crypto || window.msCrypto;
          A.getRandomValues(I);
          for (E = 0; E < I.length; ++E) {
            D[E] = I[E] & 255
          }
        } else {}
      }
    }
    C = 0;
    H((new Date).getTime())
  }
  this.nextBytes = function (M) {
    for (var K = 0; K < M.length; ++K) {
      var J = M,
        L = K,
        N;
      if (F == null) {
        H((new Date).getTime());
        F = new prng_newstate;
        F.init(D);
        for (C = 0; C < D.length; ++C) {
          D[C] = 0
        }
        C = 0
      }
      N = F.next();
      J[L] = N
    }
  }
},
  prng_newstate = function () {
    this.j = this.i = 0;
    this.S = [];
    this.init = function (D) {
      for (var B, C, A = 0; A < 256; ++A) {
        this.S[A] = A
      }
      for (A = B = 0; A < 256; ++A) {
        B = B + this.S[A] + D[A % D.length] & 255, C = this.S[A], this.S[A] = this.S[B], this.S[B] = C
      }
      this.j = this.i = 0
    };
    this.next = function () {
      var A;
      this.i = this.i + 1 & 255;
      this.j = this.j + this.S[this.i] & 255;
      A = this.S[this.i];
      this.S[this.i] = this.S[this.j];
      this.S[this.j] = A;
      return this.S[A + this.S[this.i] & 255]
    }
  },
  ECFieldElementFp = function (A, B) {
    this.x = B;
    this.q = A
  };

function parseBigInt(A, B) {
  return new BigInteger(A, B)
}

function linebrk(B, C) {
  for (var D = "", A = 0; A + C < B.length;) {
    D += B.substring(A, A + C), A += C
  }
  return D + B.substring(A, B.length)
}

function byte2Hex(A) {
  return A < 16 ? "0" + A.toString(16) : A.toString(16)
}

function pkcs1pad2(E, B) {
  for (var C = [], D = E.length - 1; D >= 0 && B > 0;) {
    var A = E.charCodeAt(D--);
      A < 128 ? (C[--B] = A) : A > 127 && A < 2048 ? (C[--B] = A & 63 | 128, C[--B] = A >> 6 | 192) : (C[--B] = A &
    63 | 128, C[--B] = A >> 6 & 63 | 128, C[--B] = A >> 12 | 224)
  }
  C[--B] = 0;
  D = new SecureRandom;
  for (A = []; B > 2;) {
    for (A[0] = 0; A[0] == 0;) {
      D.nextBytes(A)
    }
    C[--B] = A[0]
  }
  C[--B] = 2;
  C[--B] = 0;
  return new BigInteger(C)
}

function pkcs1unpad2(E, F) {
  for (var B = E.toByteArray(), A = 0; A < B.length && B[A] == 0;) {
    ++A
  }
  if (B.length - A != F - 1 || B[A] != 2) {
    return null
  }
  for (++A; B[A] != 0;) {
    if (++A >= B.length) {
      return null
    }
  }
  for (var D = ""; ++A < B.length;) {
    var C = B[A] & 255;
      C < 128 ? (D += String.fromCharCode(C)) : C > 191 && C < 224 ? (D += String.fromCharCode((C & 31) << 6 | B[A +
    1] & 63), ++A) : (D += String.fromCharCode((C & 15) << 12 | (B[A + 1] & 63) << 6 | B[A + 2] & 63), A +=
    2)
  }
  return D
}
Array.Clear = function (A) {
  for (let elm in A) {
    A[elm] = null
  }
};
Array.Copy = function (B, A, D, C, E) {
  B = B.slice(A, A + E);
  for (A = 0; A < B.length; A++) {
    D[C] = B[A], C++
  }
};
window.Int32 = {
  minValue: -parseInt("10000000000000000000000000000000", 2),
  maxValue: parseInt("1111111111111111111111111111111", 2),
  parse: function (A) {
    if (A < this.minValue) {
      for (var A = new Number(-A), A = A.toString(2), A = A.substr(A.length - 31, 31), C = "", B = 0; B <
      A.length; B++) {
        var D = A.substr(B, 1);
        C += D == "0" ? "1" : "0"
      }
      A = parseInt(C, 2);
      return A + 1
    } else {
      if (A > this.maxValue) {
        A = Number(A).toString(2);
        A = A.substr(A.length - 31, 31);
        C = "";
        for (B = 0; B < A.length; B++) {
          D = A.substr(B, 1), C += D == "0" ? "1" : "0"
        }
        A = parseInt(C, 2);
        return -(A + 1)
      } else {
        return A
      }
    }
  },
  parseByte: function (A) {
    if (A < 0) {
      for (var A = new Number(-A), A = A.toString(2), A = A.substr(A.length - 8, 8), C = "", B = 0; B < A
        .length; B++) {
        var D = A.substr(B, 1);
        C += D == "0" ? "1" : "0"
      }
      return parseInt(C, 2) + 1
    } else {
      return A > 255 ? (A = Number(A).toString(2), parseInt(A.substr(A.length - 8, 8), 2)) : A
    }
  }
};

let KJUR;
if (typeof KJUR == "undefined" || !KJUR) {
  KJUR = {}
}
if (typeof KJUR.crypto == "undefined" || !KJUR.crypto) {
  KJUR.crypto = {}
}
if (typeof KJUR == "undefined" || !KJUR) {
  KJUR = {}
}
if (typeof KJUR.crypto == "undefined" || !KJUR.crypto) {
  KJUR.crypto = {}
}
var SboxTable = [
  [214, 144, 233, 254, 204, 225, 61, 183, 22, 182, 20, 194, 40, 251, 44, 5],
  [43, 103, 154, 118, 42, 190, 4, 195, 170, 68, 19, 38, 73, 134, 6, 153],
  [156, 66, 80, 244, 145, 239, 152, 122, 51, 84, 11, 67, 237, 207, 172, 98],
  [228, 179, 28, 169, 201, 8, 232, 149, 128, 223, 148, 250, 117, 143, 63, 166],
  [71, 7, 167, 252, 243, 115, 23, 186, 131, 89, 60, 25, 230, 133, 79, 168],
  [104, 107, 129, 178, 113, 100, 218, 139, 248, 235, 15, 75, 112, 86, 157, 53],
  [30, 36, 14, 94, 99, 88, 209, 162, 37, 34, 124, 59, 1, 33, 120, 135],
  [212, 0, 70, 87, 159, 211, 39, 82, 76, 54, 2, 231, 160, 196, 200, 158],
  [234, 191, 138, 210, 64, 199, 56, 181, 163, 247, 242, 206, 249, 97, 21, 161],
  [224, 174, 93, 164, 155, 52, 26, 85, 173, 147, 50, 48, 245, 140, 177, 227],
  [29, 246, 226, 46, 130, 102, 202, 96, 192, 41, 35, 171, 13, 83, 78, 111],
  [213, 219, 55, 69, 222, 253, 142, 47, 3, 255, 106, 114, 109, 108, 91, 81],
  [141, 27, 175, 146, 187, 221, 188, 127, 17, 217, 92, 65, 31, 16, 90, 216],
  [10, 193, 49, 136, 165, 205, 123, 189, 45, 116, 208, 18, 184, 229, 180, 176],
  [137, 105, 151, 74, 12, 150, 119, 126, 101, 185, 241, 9, 197, 110, 198, 132],
  [24, 240, 125, 236, 58, 220, 77, 32, 121, 238, 95, 62, 215, 203, 57, 72]
],
  CK = [462357, 472066609, 943670861, 1415275113, 1886879365, 2358483617, 2830087869, 3301692121, 3773296373,
    4228057617, 404694573, 876298825, 1347903077, 1819507329, 2291111581, 2762715833, 3234320085, 3705924337,
    4177462797, 337322537, 808926789, 1280531041, 1752135293, 2223739545, 2695343797, 3166948049, 3638552301,
    4110090761, 269950501, 741554753, 1213159005, 1684763257
  ],
  FK = [2746333894, 1453994832, 1736282519, 2993693404];

function bigxor(A, B) {
  return A ^ B
}

function leftshift(B, A) {
  A %= 32;
  return B << A | B >>> 32 - A
}

function prefixInteger(B, A) {
  return Array(A + 1).join("0").split("").concat(String(B).split("")).slice(-A).join("")
}

function sm4Sbox(A) {
  return SboxTable[(A & 4026531840) >>> 28][(A & 251658240) >>> 24] << 24 | SboxTable[(A & 15728640) >>> 20][(A &
  983040) >>> 16] << 16 | SboxTable[(A & 61440) >>> 12][(A & 3840) >>> 8] << 8 | SboxTable[(A & 240) >>> 4][(
    A & 15) >>> 0] << 0
}

function GET_ULONG_BE(A) {
  A = sm4Sbox(A);
  return bigxor(bigxor(bigxor(A, leftshift(A, 2)), bigxor(leftshift(A, 10), leftshift(A, 18))), leftshift(A, 24))
}

function PUT_ULONG_BE(A) {
  A = sm4Sbox(A);
  return bigxor(A, bigxor(leftshift(A, 13), leftshift(A, 23)))
}

function sm4_getkey(A) {
  var B = [],
    C = [];
  B[0] = bigxor(A[0], FK[0]);
  B[1] = bigxor(A[1], FK[1]);
  B[2] = bigxor(A[2], FK[2]);
  B[3] = bigxor(A[3], FK[3]);
  for (A = 0; A < 32; A++) {
    B[A + 4] = bigxor(B[A], PUT_ULONG_BE(bigxor(bigxor(B[A + 1], B[A + 2]), bigxor(B[A + 3], CK[A])))), C[A] = B[A +
    4].toString(16)
  }
  return C
}

function KJUR_encrypt_sm4(E, F) {
  for (var G = Math.ceil(E.length / 4), D = [], C = 0; C < G; C++) {
    for (var A = E.slice(C * 4, (C + 1) * 4), H = sm4_getkey(F), B = 0; B < 32; B++) {
      A[B + 4] = bigxor(A[B], GET_ULONG_BE(bigxor(bigxor(A[B + 1], A[B + 2]), bigxor(A[B + 3], parseInt(H[B], 16)))))
    }
    D = D.concat([A[35].toString(10), A[34].toString(10), A[33].toString(10), A[32].toString(10)])
  }
  return new WordArray(D)
}

function KJUR_decrypt_sm4(G, I) {
  for (var A = Math.ceil(G.length / 4), E = [], D = 0; D < A; D++) {
    for (var C = G.slice(D * 4, (D + 1) * 4), F = sm4_getkey(I), H = [], B = F.length - 1; B >= 0; B--) {
      H[F.length - 1 - B] = F[B]
    }
    for (B = 0; B < 32; B++) {
      C[B + 4] = bigxor(C[B], GET_ULONG_BE(bigxor(bigxor(C[B + 1], C[B + 2]), bigxor(C[B + 3], parseInt(H[B], 16)))))
    }
    E = E.concat([C[35].toString(10), C[34].toString(10), C[33].toString(10), C[32].toString(10)])
  }
  return new WordArray(E)
}

function SG_sm4encrypt(D, A) {
  if (D == undefined || A == undefined) {
    return undefined
  }
  if (D == "" || A == "") {
    return undefined
  }
  if (A.length != 16) {
    return undefined
  }
  var B = new charSet,
    C = KJUR_encrypt_sm4(B.parseUTF8(D).getArrs(), B.parseUTF8(A).getArrs());
  return B.HexStringify(C)
}

function SG_sm4decrypt(D, A) {
  if (D == undefined || A == undefined) {
    return undefined
  }
  if (D == "" || A == "") {
    return undefined
  }
  if (A.length != 16) {
    return undefined
  }
  var B = new charSet,
    C = B.HexParse(D),
    B = B.parseUTF8(A),
    C = KJUR_decrypt_sm4(C.getArrs(), B.getArrs());
  return (new charSet).stringifyUTF8(C)
}



function encryptbyBASE64(A) {
  return (new base64Obj).encryptbybase64(A)
}

function decryptbyBASE64(A) {
  return (new base64Obj).decryptbybase64(A)
}
var CryptoJS = CryptoJS || (function (A, B) {
  var L = {};
  var D = L.lib = {};
  var I = D.Base = (function () {
    function C() {}
    return {
      extend: function (O) {
        C.prototype = this;
        var P = new C();
        if (O) {
          P.mixIn(O)
        }
        if (!P.hasOwnProperty("init")) {
          P.init = function () {
            P.$super.init.apply(this, arguments)
          }
        }
        P.init.prototype = P;
        P.$super = this;
        return P
      },
      create: function () {
        var O = this.extend();
        O.init.apply(O, arguments);
        return O
      },
      init: function () {},
      mixIn: function (O) {
        for (var P in O) {
          if (O.hasOwnProperty(P)) {
            this[P] = O[P]
          }
        }
        if (O.hasOwnProperty("toString")) {
          this.toString = O.toString
        }
      },
      clone: function () {
        return this.init.prototype.extend(this)
      }
    }
  }());
  var G = D.WordArray = I.extend({
    init: function (O, C) {
      O = this.words = O || [];
      if (C != B) {
        this.sigBytes = C
      } else {
        this.sigBytes = O.length * 4
      }
    },
    toString: function (C) {
      return (C || H).stringify(this)
    },
    concat: function (P) {
      var Q = this.words;
      var T = P.words;
      var S = this.sigBytes;
      var R = P.sigBytes;
      this.clamp();
      if (S % 4) {
        for (var O = 0; O < R; O += 1) {
          var C = (T[O >>> 2] >>> (24 - (O % 4) * 8)) & 255;
          Q[(S + O) >>> 2] |= C << (24 - ((S + O) % 4) * 8)
        }
      } else {
        if (T.length > 65535) {
          for (var O = 0; O < R; O += 4) {
            Q[(S + O) >>> 2] = T[O >>> 2]
          }
        } else {
          Q.push.apply(Q, T)
        }
      }
      this.sigBytes += R;
      return this
    },
    clamp: function () {
      var O = this.words;
      var C = this.sigBytes;
      O[C >>> 2] &= 4294967295 << (32 - (C % 4) * 8);
      O.length = A.ceil(C / 4)
    },
    clone: function () {
      var C = I.clone.call(this);
      C.words = this.words.slice(0);
      return C
    },
    random: function (C) {
      var O = [];
      for (var P = 0; P < C; P += 4) {
        O.push((A.random() * 4294967296) | 0)
      }
      return new G.init(O, C)
    }
  });
  var J = L.enc = {};
  var H = J.Hex = {
    stringify: function (P) {
      var Q = P.words;
      var O = P.sigBytes;
      var C = [];
      for (var R = 0; R < O; R += 1) {
        var S = (Q[R >>> 2] >>> (24 - (R % 4) * 8)) & 255;
        C.push((S >>> 4).toString(16));
        C.push((S & 15).toString(16))
      }
      return C.join("")
    },
    parse: function (C) {
      var P = C.length;
      var Q = [];
      for (var O = 0; O < P; O += 2) {
        Q[O >>> 3] |= parseInt(C.substr(O, 2), 16) << (24 - (O % 8) * 4)
      }
      return new G.init(Q, P / 2)
    }
  };
  var K = J.Latin1 = {
    stringify: function (P) {
      var Q = P.words;
      var O = P.sigBytes;
      var C = [];
      for (var R = 0; R < O; R += 1) {
        var S = (Q[R >>> 2] >>> (24 - (R % 4) * 8)) & 255;
        C.push(String.fromCharCode(S))
      }
      return C.join("")
    },
    parse: function (C) {
      var P = C.length;
      var Q = [];
      for (var O = 0; O < P; O += 1) {
        Q[O >>> 2] |= (C.charCodeAt(O) & 255) << (24 - (O % 4) * 8)
      }
      return new G.init(Q, P)
    }
  };
  var N = J.Utf8 = {
    stringify: function (C) {
      try {
        return decodeURIComponent(escape(K.stringify(C)))
      } catch (O) {
        throw new Error("Malformed UTF-8 data")
      }
    },
    parse: function (C) {
      return K.parse(unescape(encodeURIComponent(C)))
    }
  };
  var F = D.BufferedBlockAlgorithm = I.extend({
    reset: function () {
      this._data = new G.init();
      this._nDataBytes = 0
    },
    _append: function (C) {
      if (typeof C == "string") {
        C = N.parse(C)
      }
      this._data.concat(C);
      this._nDataBytes += C.sigBytes
    },
    _process: function (Q) {
      var T = this._data;
      var C = T.words;
      var U = T.sigBytes;
      var W = this.blockSize;
      var R = W * 4;
      var P = U / R;
      if (Q) {
        P = A.ceil(P)
      } else {
        P = A.max((P | 0) - this._minBufferSize, 0)
      }
      var S = P * W;
      var V = A.min(S * 4, U);
      if (S) {
        for (var X = 0; X < S; X += W) {
          this._doProcessBlock(C, X)
        }
        var O = C.splice(0, S);
        T.sigBytes -= V
      }
      return new G.init(O, V)
    },
    clone: function () {
      var C = I.clone.call(this);
      C._data = this._data.clone();
      return C
    },
    _minBufferSize: 0
  });
  var E = D.Hasher = F.extend({
    cfg: I.extend(),
    init: function (C) {
      this.cfg = this.cfg.extend(C);
      this.reset()
    },
    reset: function () {
      F.reset.call(this);
      this._doReset()
    },
    update: function (C) {
      this._append(C);
      this._process();
      return this
    },
    finalize: function (O) {
      if (O) {
        this._append(O)
      }
      var C = this._doFinalize();
      return C
    },
    blockSize: 512 / 32,
    _createHelper: function (C) {
      return function (O, P) {
        return new C.init(P).finalize(O)
      }
    },
    _createHmacHelper: function (C) {
      return function (P, O) {
        return new M.HMAC.init(C, O).finalize(P)
      }
    }
  });
  var M = L.algo = {};
  return L
}(Math));
var dbits;
var canary = 244837814094590;
var j_lm = ((canary & 16777215) == 15715070);

function BigInteger(A, B, C) {
  if (A != null) {
    if ("number" == typeof A) {
      this.fromNumber(A, B, C)
    } else {
      if (B == null && "string" != typeof A) {
        this.fromString(A, 256)
      } else {
        this.fromString(A, B)
      }
    }
  }
}

function nbi() {
  return new BigInteger(null)
}

function am1(F, B, D, G, E, C) {
  while (--C >= 0) {
    var A = B * this[F++] + D[G] + E;
    E = Math.floor(A / 67108864);
    D[G++] = A & 67108863
  }
  return E
}

function am2(A, F, J, B, G, E) {
  var D = F & 32767,
    H = F >> 15;
  while (--E >= 0) {
    var C = this[A] & 32767;
    var K = this[A++] >> 15;
    var I = H * C + K * D;
    C = D * C + ((I & 32767) << 15) + J[B] + (G & 1073741823);
    G = (C >>> 30) + (I >>> 15) + H * K + (G >>> 30);
    J[B++] = C & 1073741823
  }
  return G
}

function am3(A, F, J, B, G, E) {
  var D = F & 16383,
    H = F >> 14;
  while (--E >= 0) {
    var C = this[A] & 16383;
    var K = this[A++] >> 14;
    var I = H * C + K * D;
    C = D * C + ((I & 16383) << 14) + J[B] + G;
    G = (C >> 28) + (I >> 14) + H * K;
    J[B++] = C & 268435455
  }
  return G
}
if (j_lm && (navigator.appName == "Microsoft Internet Explorer")) {
  BigInteger.prototype.am = am2;
  dbits = 30
} else {
  if (j_lm && (navigator.appName != "Netscape")) {
    BigInteger.prototype.am = am1;
    dbits = 26
  } else {
    BigInteger.prototype.am = am3;
    dbits = 28
  }
}
BigInteger.prototype.DB = dbits;
BigInteger.prototype.DM = ((1 << dbits) - 1);
BigInteger.prototype.DV = (1 << dbits);
var BI_FP = 52;
BigInteger.prototype.FV = Math.pow(2, BI_FP);
BigInteger.prototype.F1 = BI_FP - dbits;
BigInteger.prototype.F2 = 2 * dbits - BI_FP;
var BI_RM = "0123456789abcdefghijklmnopqrstuvwxyz";
var BI_RC = [];
var rr, vv;
rr = "0".charCodeAt(0);
for (vv = 0; vv <= 9; vv += 1) {
  BI_RC[rr++] = vv
}
rr = "a".charCodeAt(0);
for (vv = 10; vv < 36; vv += 1) {
  BI_RC[rr++] = vv
}
rr = "A".charCodeAt(0);
for (vv = 10; vv < 36; vv += 1) {
  BI_RC[rr++] = vv
}



function bnpCopyTo(A) {
  for (var B = this.t - 1; B >= 0; B -= 1) {
    A[B] = this[B]
  }
  A.t = this.t;
  A.s = this.s
}

function bnpFromInt(A) {
  this.t = 1;
  this.s = (A < 0) ? -1 : 0;
  if (A > 0) {
    this[0] = A
  } else {
    if (A < -1) {
      this[0] = A + this.DV
    } else {
      this.t = 0
    }
  }
}

function nbv(B) {
  var A = nbi();
  A.fromInt(B);
  return A
}

function bnpFromString(A, C) {
  var G;
  if (C == 16) {
    G = 4
  } else {
    if (C == 8) {
      G = 3
    } else {
      if (C == 256) {
        G = 8
      } else {
        if (C == 2) {
          G = 1
        } else {
          if (C == 32) {
            G = 5
          } else {
            if (C == 4) {
              G = 2
            } else {
              this.fromRadix(A, C);
              return
            }
          }
        }
      }
    }
  }
  this.t = 0;
  this.s = 0;
  var E = A.length,
    D = false,
    B = 0;
  while (--E >= 0) {
    var F = (G == 8) ? A[E] & 255 : intAt(A, E);
    if (F < 0) {
      if (A.charAt(E) == "-") {
        D = true
      }
      continue
    }
    D = false;
    if (B == 0) {
      this[this.t++] = F
    } else {
      if (B + G > this.DB) {
        this[this.t - 1] |= (F & ((1 << (this.DB - B)) - 1)) << B;
        this[this.t++] = (F >> (this.DB - B))
      } else {
        this[this.t - 1] |= F << B
      }
    }
    B += G;
    if (B >= this.DB) {
      B -= this.DB
    }
  }
  if (G == 8 && (A[0] & 128) != 0) {
    this.s = -1;
    if (B > 0) {
      this[this.t - 1] |= ((1 << (this.DB - B)) - 1) << B
    }
  }
  this.clamp();
  if (D) {
    BigInteger.ZERO.subTo(this, this)
  }
}

function bnpClamp() {
  var A = this.s & this.DM;
  while (this.t > 0 && this[this.t - 1] == A) {
    --this.t
  }
}

function bnToString(D) {
  if (this.s < 0) {
    return "-" + this.negate().toString(D)
  }
  var B;
  if (D == 16) {
    B = 4
  } else {
    if (D == 8) {
      B = 3
    } else {
      if (D == 2) {
        B = 1
      } else {
        if (D == 32) {
          B = 5
        } else {
          if (D == 4) {
            B = 2
          } else {
            return this.toRadix(D)
          }
        }
      }
    }
  }
  var H = (1 << B) - 1,
    E, C = false,
    G = "",
    A = this.t;
  var F = this.DB - (A * this.DB) % B;
  if (A-- > 0) {
    if (F < this.DB && (E = this[A] >> F) > 0) {
      C = true;
      G = int2char(E)
    }
    while (A >= 0) {
      if (F < B) {
        E = (this[A] & ((1 << F) - 1)) << (B - F);
        E |= this[A -= 1] >> (F += this.DB - B)
      } else {
        E = (this[A] >> (F -= B)) & H;
        if (F <= 0) {
          F += this.DB;
          A -= 1
        }
      }
      if (E > 0) {
        C = true
      }
      if (C) {
        G += int2char(E)
      }
    }
  }
  return C ? G : "0"
}

function bnNegate() {
  var A = nbi();
  BigInteger.ZERO.subTo(this, A);
  return A
}

function bnAbs() {
  return (this.s < 0) ? this.negate() : this
}

function bnCompareTo(B) {
  var A = this.s - B.s;
  if (A != 0) {
    return A
  }
  var C = this.t;
  A = C - B.t;
  if (A != 0) {
    return (this.s < 0) ? -A : A
  }
  while (--C >= 0) {
    if ((A = this[C] - B[C]) != 0) {
      return A
    }
  }
  return 0
}

function nbits(B) {
  var A = 1,
    C;
  if ((C = B >>> 16) != 0) {
    B = C;
    A += 16
  }
  if ((C = B >> 8) != 0) {
    B = C;
    A += 8
  }
  if ((C = B >> 4) != 0) {
    B = C;
    A += 4
  }
  if ((C = B >> 2) != 0) {
    B = C;
    A += 2
  }
  if ((C = B >> 1) != 0) {
    B = C;
    A += 1
  }
  return A
}

function bnBitLength() {
  if (this.t <= 0) {
    return 0
  }
  return this.DB * (this.t - 1) + nbits(this[this.t - 1] ^ (this.s & this.DM))
}

function bnpDLShiftTo(B, A) {
  var C;
  for (C = this.t - 1; C >= 0; C -= 1) {
    A[C + B] = this[C]
  }
  for (C = B - 1; C >= 0; C -= 1) {
    A[C] = 0
  }
  A.t = this.t + B;
  A.s = this.s
}

function bnpDRShiftTo(B, A) {
  for (var C = B; C < this.t; C += 1) {
    A[C - B] = this[C]
  }
  A.t = Math.max(this.t - B, 0);
  A.s = this.s
}

function bnpLShiftTo(C, B) {
  var G = C % this.DB;
  var E = this.DB - G;
  var F = (1 << E) - 1;
  var H = Math.floor(C / this.DB),
    D = (this.s << G) & this.DM,
    A;
  for (A = this.t - 1; A >= 0; A -= 1) {
    B[A + H + 1] = (this[A] >> E) | D;
    D = (this[A] & F) << G
  }
  for (A = H - 1; A >= 0; A -= 1) {
    B[A] = 0
  }
  B[H] = D;
  B.t = this.t + H + 1;
  B.s = this.s;
  B.clamp()
}

function bnpRShiftTo(B, A) {
  A.s = this.s;
  var F = Math.floor(B / this.DB);
  if (F >= this.t) {
    A.t = 0;
    return
  }
  var E = B % this.DB;
  var D = this.DB - E;
  var C = (1 << E) - 1;
  A[0] = this[F] >> E;
  for (var G = F + 1; G < this.t; G += 1) {
    A[G - F - 1] |= (this[G] & C) << D;
    A[G - F] = this[G] >> E
  }
  if (E > 0) {
    A[this.t - F - 1] |= (this.s & C) << D
  }
  A.t = this.t - F;
  A.clamp()
}

function bnpSubTo(C, A) {
  var E = 0,
    D = 0,
    B = Math.min(C.t, this.t);
  while (E < B) {
    D += this[E] - C[E];
    A[E++] = D & this.DM;
    D >>= this.DB
  }
  if (C.t < this.t) {
    D -= C.s;
    while (E < this.t) {
      D += this[E];
      A[E++] = D & this.DM;
      D >>= this.DB
    }
    D += this.s
  } else {
    D += this.s;
    while (E < C.t) {
      D -= C[E];
      A[E++] = D & this.DM;
      D >>= this.DB
    }
    D -= C.s
  }
  A.s = (D < 0) ? -1 : 0;
  if (D < -1) {
    A[E++] = this.DV + D
  } else {
    if (D > 0) {
      A[E++] = D
    }
  }
  A.t = E;
  A.clamp()
}

function bnpMultiplyTo(D, A) {
  var B = this.abs(),
    C = D.abs();
  var E = B.t;
  A.t = E + C.t;
  while (--E >= 0) {
    A[E] = 0
  }
  for (E = 0; E < C.t; E += 1) {
    A[E + B.t] = B.am(0, C[E], A, E, 0, B.t)
  }
  A.s = 0;
  A.clamp();
  if (this.s != D.s) {
    BigInteger.ZERO.subTo(A, A)
  }
}

function bnpSquareTo(A) {
  var B = this.abs();
  var D = A.t = 2 * B.t;
  while (--D >= 0) {
    A[D] = 0
  }
  for (D = 0; D < B.t - 1; D += 1) {
    var C = B.am(D, B[D], A, 2 * D, 0, 1);
    if ((A[D + B.t] += B.am(D + 1, 2 * B[D], A, 2 * D + 1, C, B.t - D - 1)) >= B.DV) {
      A[D + B.t] -= B.DV;
      A[D + B.t + 1] = 1
    }
  }
  if (A.t > 0) {
    A[A.t - 1] += B.am(D, B[D], A, 2 * D, 0, 1)
  }
  A.s = 0;
  A.clamp()
}

function bnpDivRemTo(K, E, F) {
  var P = K.abs();
  if (P.t <= 0) {
    return
  }
  var H = this.abs();
  if (H.t < P.t) {
    if (E != null) {
      E.fromInt(0)
    }
    if (F != null) {
      this.copyTo(F)
    }
    return
  }
  if (F == null) {
    F = nbi()
  }
  var A = nbi(),
    O = this.s,
    R = K.s;
  var S = this.DB - nbits(P[P.t - 1]);
  if (S > 0) {
    P.lShiftTo(S, A);
    H.lShiftTo(S, F)
  } else {
    P.copyTo(A);
    H.copyTo(F)
  }
  var Q = A.t;
  var C = A[Q - 1];
  if (C == 0) {
    return
  }
  var D = C * (1 << this.F1) + ((Q > 1) ? A[Q - 2] >> this.F2 : 0);
  var B = this.FV / D,
    M = (1 << this.F1) / D,
    N = 1 << this.F2;
  var I = F.t,
    J = I - Q,
    G = (E == null) ? nbi() : E;
  A.dlShiftTo(J, G);
  if (F.compareTo(G) >= 0) {
    F[F.t++] = 1;
    F.subTo(G, F)
  }
  BigInteger.ONE.dlShiftTo(Q, G);
  G.subTo(A, A);
  while (A.t < Q) {
    A[A.t++] = 0
  }
  while (--J >= 0) {
    var L = (F[I -= 1] == C) ? this.DM : Math.floor(F[I] * B + (F[I - 1] + N) * M);
    if ((F[I] += A.am(0, L, F, J, 0, Q)) < L) {
      A.dlShiftTo(J, G);
      F.subTo(G, F);
      while (F[I] < --L) {
        F.subTo(G, F)
      }
    }
  }
  if (E != null) {
    F.drShiftTo(Q, E);
    if (O != R) {
      BigInteger.ZERO.subTo(E, E)
    }
  }
  F.t = Q;
  F.clamp();
  if (S > 0) {
    F.rShiftTo(S, F)
  }
  if (O < 0) {
    BigInteger.ZERO.subTo(F, F)
  }
}

function bnMod(B) {
  var A = nbi();
  this.abs().divRemTo(B, null, A);
  if (this.s < 0 && A.compareTo(BigInteger.ZERO) > 0) {
    B.subTo(A, A)
  }
  return A
}

function Classic(A) {
  this.m = A
}

function cConvert(A) {
  if (A.s < 0 || A.compareTo(this.m) >= 0) {
    return A.mod(this.m)
  } else {
    return A
  }
}

function cRevert(A) {
  return A
}

function cReduce(A) {
  A.divRemTo(this.m, null, A)
}

function cMulTo(B, C, A) {
  B.multiplyTo(C, A);
  this.reduce(A)
}

function cSqrTo(B, A) {
  B.squareTo(A);
  this.reduce(A)
}
Classic.prototype.convert = cConvert;
Classic.prototype.revert = cRevert;
Classic.prototype.reduce = cReduce;
Classic.prototype.mulTo = cMulTo;
Classic.prototype.sqrTo = cSqrTo;

function bnpInvDigit() {
  if (this.t < 1) {
    return 0
  }
  var A = this[0];
  if ((A & 1) == 0) {
    return 0
  }
  var B = A & 3;
  B = (B * (2 - (A & 15) * B)) & 15;
  B = (B * (2 - (A & 255) * B)) & 255;
  B = (B * (2 - (((A & 65535) * B) & 65535))) & 65535;
  B = (B * (2 - A * B % this.DV)) % this.DV;
  return (B > 0) ? this.DV - B : -B
}

function Montgomery(A) {
  this.m = A;
  this.mp = A.invDigit();
  this.mpl = this.mp & 32767;
  this.mph = this.mp >> 15;
  this.um = (1 << (A.DB - 15)) - 1;
  this.mt2 = 2 * A.t
}

function montConvert(B) {
  var A = nbi();
  B.abs().dlShiftTo(this.m.t, A);
  A.divRemTo(this.m, null, A);
  if (B.s < 0 && A.compareTo(BigInteger.ZERO) > 0) {
    this.m.subTo(A, A)
  }
  return A
}

function montRevert(B) {
  var A = nbi();
  B.copyTo(A);
  this.reduce(A);
  return A
}

function montReduce(A) {
  while (A.t <= this.mt2) {
    A[A.t++] = 0
  }
  for (var C = 0; C < this.m.t; C += 1) {
    var D = A[C] & 32767;
    var B = (D * this.mpl + (((D * this.mph + (A[C] >> 15) * this.mpl) & this.um) << 15)) & A.DM;
    D = C + this.m.t;
    A[D] += this.m.am(0, B, A, C, 0, this.m.t);
    while (A[D] >= A.DV) {
      A[D] -= A.DV;
      A[D += 1] += 1
    }
  }
  A.clamp();
  A.drShiftTo(this.m.t, A);
  if (A.compareTo(this.m) >= 0) {
    A.subTo(this.m, A)
  }
}

function montSqrTo(B, A) {
  B.squareTo(A);
  this.reduce(A)
}

function montMulTo(B, C, A) {
  B.multiplyTo(C, A);
  this.reduce(A)
}
Montgomery.prototype.convert = montConvert;
Montgomery.prototype.revert = montRevert;
Montgomery.prototype.reduce = montReduce;
Montgomery.prototype.mulTo = montMulTo;
Montgomery.prototype.sqrTo = montSqrTo;

function bnpIsEven() {
  return ((this.t > 0) ? (this[0] & 1) : this.s) == 0
}

function bnpExp(E, C) {
  if (E > 4294967295 || E < 1) {
    return BigInteger.ONE
  }
  var A = nbi(),
    F = nbi(),
    G = C.convert(this),
    D = nbits(E) - 1;
  G.copyTo(A);
  while (--D >= 0) {
    C.sqrTo(A, F);
    if ((E & (1 << D)) > 0) {
      C.mulTo(F, G, A)
    } else {
      var B = A;
      A = F;
      F = B
    }
  }
  return C.revert(A)
}

function bnModPowInt(C, A) {
  var B;
  if (C < 256 || A.isEven()) {
    B = new Classic(A)
  } else {
    B = new Montgomery(A)
  }
  return this.exp(C, B)
}
BigInteger.prototype.copyTo = bnpCopyTo;
BigInteger.prototype.fromInt = bnpFromInt;
BigInteger.prototype.fromString = bnpFromString;
BigInteger.prototype.clamp = bnpClamp;
BigInteger.prototype.dlShiftTo = bnpDLShiftTo;
BigInteger.prototype.drShiftTo = bnpDRShiftTo;
BigInteger.prototype.lShiftTo = bnpLShiftTo;
BigInteger.prototype.rShiftTo = bnpRShiftTo;
BigInteger.prototype.subTo = bnpSubTo;
BigInteger.prototype.multiplyTo = bnpMultiplyTo;
BigInteger.prototype.squareTo = bnpSquareTo;
BigInteger.prototype.divRemTo = bnpDivRemTo;
BigInteger.prototype.invDigit = bnpInvDigit;
BigInteger.prototype.isEven = bnpIsEven;
BigInteger.prototype.exp = bnpExp;
BigInteger.prototype.toString = bnToString;
BigInteger.prototype.negate = bnNegate;
BigInteger.prototype.abs = bnAbs;
BigInteger.prototype.compareTo = bnCompareTo;
BigInteger.prototype.bitLength = bnBitLength;
BigInteger.prototype.mod = bnMod;
BigInteger.prototype.modPowInt = bnModPowInt;
BigInteger.ZERO = nbv(0);
BigInteger.ONE = nbv(1);

function bnClone() {
  var A = nbi();
  this.copyTo(A);
  return A
}

function bnIntValue() {
  if (this.s < 0) {
    if (this.t == 1) {
      return this[0] - this.DV
    } else {
      if (this.t == 0) {
        return -1
      }
    }
  } else {
    if (this.t == 1) {
      return this[0]
    } else {
      if (this.t == 0) {
        return 0
      }
    }
  }
  return ((this[1] & ((1 << (32 - this.DB)) - 1)) << this.DB) | this[0]
}

function bnByteValue() {
  return (this.t == 0) ? this.s : (this[0] << 24) >> 24
}

function bnShortValue() {
  return (this.t == 0) ? this.s : (this[0] << 16) >> 16
}

function bnpChunkSize(A) {
  return Math.floor(Math.LN2 * this.DB / Math.log(A))
}

function bnSigNum() {
  if (this.s < 0) {
    return -1
  } else {
    if (this.t <= 0 || (this.t == 1 && this[0] <= 0)) {
      return 0
    } else {
      return 1
    }
  }
}

function bnpToRadix(E) {
  if (E == null) {
    E = 10
  }
  if (this.signum() == 0 || E < 2 || E > 36) {
    return "0"
  }
  var G = this.chunkSize(E);
  var D = Math.pow(E, G);
  var F = nbv(D),
    B = nbi(),
    C = nbi(),
    A = "";
  this.divRemTo(F, B, C);
  while (B.signum() > 0) {
    A = (D + C.intValue()).toString(E).substr(1) + A;
    B.divRemTo(F, B, C)
  }
  return C.intValue().toString(E) + A
}

function bnpFromRadix(G, D) {
  this.fromInt(0);
  if (D == null) {
    D = 10
  }
  var H = this.chunkSize(D);
  var E = Math.pow(D, H),
    I = false,
    B = 0,
    F = 0;
  for (var A = 0; A < G.length; A += 1) {
    var C = intAt(G, A);
    if (C < 0) {
      if (G.charAt(A) == "-" && this.signum() == 0) {
        I = true
      }
      continue
    }
    F = D * F + C;
    if (++B >= H) {
      this.dMultiply(E);
      this.dAddOffset(F, 0);
      B = 0;
      F = 0
    }
  }
  if (B > 0) {
    this.dMultiply(Math.pow(D, B));
    this.dAddOffset(F, 0)
  }
  if (I) {
    BigInteger.ZERO.subTo(this, this)
  }
}

function bnpFromNumber(D, E, F) {
  if ("number" == typeof E) {
    if (D < 2) {
      this.fromInt(1)
    } else {
      this.fromNumber(D, F);
      if (!this.testBit(D - 1)) {
        this.bitwiseTo(BigInteger.ONE.shiftLeft(D - 1), op_or, this)
      }
      if (this.isEven()) {
        this.dAddOffset(1, 0)
      }
      while (!this.isProbablePrime(E)) {
        this.dAddOffset(2, 0);
        if (this.bitLength() > D) {
          this.subTo(BigInteger.ONE.shiftLeft(D - 1), this)
        }
      }
    }
  } else {
    var A = [],
      H = D & 7;
    A.length = (D >> 3) + 1;
    E.nextBytes(A);
    if (H > 0) {
      A[0] &= ((1 << H) - 1)
    } else {
      A[0] = 0
    }
    if (myBrowser() == "FF" && window.crypto) {
      var C = new ArrayBuffer(32);
      var G = new Int8Array(C);
      window.crypto.getRandomValues(G);
      for (F = 0; F < G.length; ++F) {
        A[F] = G[F] & 255
      }
    } else {
      if (myBrowser() == "IE11") {
        var C = new ArrayBuffer(32);
        var G = new Int8Array(C);
        var B = window.crypto || window.msCrypto;
        B.getRandomValues(G);
        for (F = 0; F < G.length; ++F) {
          A[F] = G[F] & 255
        }
      } else {
        if (myBrowser() == "edge") {
          var C = new ArrayBuffer(32);
          var G = new Int8Array(C);
          var B = window.crypto || window.msCrypto;
          B.getRandomValues(G);
          for (F = 0; F < G.length; ++F) {
            A[F] = G[F] & 255
          }
        }
      }
    }
    this.fromString(A, 256)
  }
}

function bnToByteArray() {
  var D = this.t,
    A = [];
  A[0] = this.s;
  var E = this.DB - (D * this.DB) % 8,
    B, C = 0;
  if (D-- > 0) {
    if (E < this.DB && (B = this[D] >> E) != (this.s & this.DM) >> E) {
      A[C++] = B | (this.s << (this.DB - E))
    }
    while (D >= 0) {
      if (E < 8) {
        B = (this[D] & ((1 << E) - 1)) << (8 - E);
        B |= this[D -= 1] >> (E += this.DB - 8)
      } else {
        B = (this[D] >> (E -= 8)) & 255;
        if (E <= 0) {
          E += this.DB;
          D -= 1
        }
      }
      if ((B & 128) != 0) {
        B |= -256
      }
      if (C == 0 && (this.s & 128) != (B & 128)) {
        ++C
      }
      if (C > 0 || B != this.s) {
        A[C++] = B
      }
    }
  }
  return A
}

function bnEquals(A) {
  return (this.compareTo(A) == 0)
}

function bnMin(A) {
  return (this.compareTo(A) < 0) ? this : A
}

function bnMax(A) {
  return (this.compareTo(A) > 0) ? this : A
}

function bnpBitwiseTo(C, F, A) {
  var D, E, B = Math.min(C.t, this.t);
  for (D = 0; D < B; D += 1) {
    A[D] = F(this[D], C[D])
  }
  if (C.t < this.t) {
    E = C.s & this.DM;
    for (D = B; D < this.t; D += 1) {
      A[D] = F(this[D], E)
    }
    A.t = this.t
  } else {
    E = this.s & this.DM;
    for (D = B; D < C.t; D += 1) {
      A[D] = F(E, C[D])
    }
    A.t = C.t
  }
  A.s = F(this.s, C.s);
  A.clamp()
}

function op_and(A, B) {
  return A & B
}

function bnAnd(B) {
  var A = nbi();
  this.bitwiseTo(B, op_and, A);
  return A
}

function op_or(A, B) {
  return A | B
}

function bnOr(B) {
  var A = nbi();
  this.bitwiseTo(B, op_or, A);
  return A
}

function op_xor(A, B) {
  return A ^ B
}

function bnXor(B) {
  var A = nbi();
  this.bitwiseTo(B, op_xor, A);
  return A
}

function op_andnot(A, B) {
  return A & ~B
}

function bnAndNot(B) {
  var A = nbi();
  this.bitwiseTo(B, op_andnot, A);
  return A
}

function bnNot() {
  var A = nbi();
  for (var B = 0; B < this.t; B += 1) {
    A[B] = this.DM & ~this[B]
  }
  A.t = this.t;
  A.s = ~this.s;
  return A
}

function bnShiftLeft(B) {
  var A = nbi();
  if (B < 0) {
    this.rShiftTo(-B, A)
  } else {
    this.lShiftTo(B, A)
  }
  return A
}

function bnShiftRight(B) {
  var A = nbi();
  if (B < 0) {
    this.lShiftTo(-B, A)
  } else {
    this.rShiftTo(B, A)
  }
  return A
}

function lbit(B) {
  if (B == 0) {
    return -1
  }
  var A = 0;
  if ((B & 65535) == 0) {
    B >>= 16;
    A += 16
  }
  if ((B & 255) == 0) {
    B >>= 8;
    A += 8
  }
  if ((B & 15) == 0) {
    B >>= 4;
    A += 4
  }
  if ((B & 3) == 0) {
    B >>= 2;
    A += 2
  }
  if ((B & 1) == 0) {
    ++A
  }
  return A
}

function bnGetLowestSetBit() {
  for (var A = 0; A < this.t; A += 1) {
    if (this[A] != 0) {
      return A * this.DB + lbit(this[A])
    }
  }
  if (this.s < 0) {
    return this.t * this.DB
  }
  return -1
}

function cbit(B) {
  var A = 0;
  while (B != 0) {
    B &= B - 1;
    A += 1
  }
  return A
}

function bnBitCount() {
  var A = 0,
    B = this.s & this.DM;
  for (var C = 0; C < this.t; C += 1) {
    A += cbit(this[C] ^ B)
  }
  return A
}

function bnTestBit(A) {
  var B = Math.floor(A / this.DB);
  if (B >= this.t) {
    return (this.s != 0)
  }
  return ((this[B] & (1 << (A % this.DB))) != 0)
}

function bnpChangeBit(B, C) {
  var A = BigInteger.ONE.shiftLeft(B);
  this.bitwiseTo(A, C, A);
  return A
}

function bnSetBit(A) {
  return this.changeBit(A, op_or)
}

function bnClearBit(A) {
  return this.changeBit(A, op_andnot)
}

function bnFlipBit(A) {
  return this.changeBit(A, op_xor)
}

function bnpAddTo(C, A) {
  var E = 0,
    D = 0,
    B = Math.min(C.t, this.t);
  while (E < B) {
    D += this[E] + C[E];
    A[E++] = D & this.DM;
    D >>= this.DB
  }
  if (C.t < this.t) {
    D += C.s;
    while (E < this.t) {
      D += this[E];
      A[E++] = D & this.DM;
      D >>= this.DB
    }
    D += this.s
  } else {
    D += this.s;
    while (E < C.t) {
      D += C[E];
      A[E++] = D & this.DM;
      D >>= this.DB
    }
    D += C.s
  }
  A.s = (D < 0) ? -1 : 0;
  if (D > 0) {
    A[E++] = D
  } else {
    if (D < -1) {
      A[E++] = this.DV + D
    }
  }
  A.t = E;
  A.clamp()
}

function bnAdd(B) {
  var A = nbi();
  this.addTo(B, A);
  return A
}

function bnSubtract(B) {
  var A = nbi();
  this.subTo(B, A);
  return A
}

function bnMultiply(B) {
  var A = nbi();
  this.multiplyTo(B, A);
  return A
}

function bnSquare() {
  var A = nbi();
  this.squareTo(A);
  return A
}

function bnDivide(B) {
  var A = nbi();
  this.divRemTo(B, A, null);
  return A
}

function bnRemainder(B) {
  var A = nbi();
  this.divRemTo(B, null, A);
  return A
}

function bnDivideAndRemainder(B) {
  var C = nbi(),
    A = nbi();
  this.divRemTo(B, C, A);
  return [C, A]
}

function bnpDMultiply(A) {
  this[this.t] = this.am(0, A - 1, this, 0, 0, this.t);
  ++this.t;
  this.clamp()
}

function bnpDAddOffset(A, B) {
  if (A == 0) {
    return
  }
  while (this.t <= B) {
    this[this.t++] = 0
  }
  this[B] += A;
  while (this[B] >= this.DV) {
    this[B] -= this.DV;
    if (++B >= this.t) {
      this[this.t++] = 0
    }++this[B]
  }
}

function NullExp() {}

function nNop(A) {
  return A
}

function nMulTo(B, C, A) {
  B.multiplyTo(C, A)
}

function nSqrTo(B, A) {
  B.squareTo(A)
}
NullExp.prototype.convert = nNop;
NullExp.prototype.revert = nNop;
NullExp.prototype.mulTo = nMulTo;
NullExp.prototype.sqrTo = nSqrTo;

function bnPow(A) {
  return this.exp(A, new NullExp())
}

function bnpMultiplyLowerTo(C, B, A) {
  var D = Math.min(this.t + C.t, B);
  A.s = 0;
  A.t = D;
  while (D > 0) {
    A[D -= 1] = 0
  }
  var E;
  for (E = A.t - this.t; D < E; D += 1) {
    A[D + this.t] = this.am(0, C[D], A, D, 0, this.t)
  }
  for (E = Math.min(C.t, B); D < E; D += 1) {
    this.am(0, C[D], A, D, 0, B - D)
  }
  A.clamp()
}

function bnpMultiplyUpperTo(C, B, A) {
  B -= 1;
  var D = A.t = this.t + C.t - B;
  A.s = 0;
  while (--D >= 0) {
    A[D] = 0
  }
  for (D = Math.max(B - this.t, 0); D < C.t; D += 1) {
    A[this.t + D - B] = this.am(B - D, C[D], A, 0, 0, this.t + D - B)
  }
  A.clamp();
  A.drShiftTo(1, A)
}

function Barrett(A) {
  this.r2 = nbi();
  this.q3 = nbi();
  BigInteger.ONE.dlShiftTo(2 * A.t, this.r2);
  this.mu = this.r2.divide(A);
  this.m = A
}

function barrettConvert(B) {
  if (B.s < 0 || B.t > 2 * this.m.t) {
    return B.mod(this.m)
  } else {
    if (B.compareTo(this.m) < 0) {
      return B
    } else {
      var A = nbi();
      B.copyTo(A);
      this.reduce(A);
      return A
    }
  }
}

function barrettRevert(A) {
  return A
}

function barrettReduce(A) {
  A.drShiftTo(this.m.t - 1, this.r2);
  if (A.t > this.m.t + 1) {
    A.t = this.m.t + 1;
    A.clamp()
  }
  this.mu.multiplyUpperTo(this.r2, this.m.t + 1, this.q3);
  this.m.multiplyLowerTo(this.q3, this.m.t + 1, this.r2);
  while (A.compareTo(this.r2) < 0) {
    A.dAddOffset(1, this.m.t + 1)
  }
  A.subTo(this.r2, A);
  while (A.compareTo(this.m) >= 0) {
    A.subTo(this.m, A)
  }
}

function barrettSqrTo(B, A) {
  B.squareTo(A);
  this.reduce(A)
}

function barrettMulTo(B, C, A) {
  B.multiplyTo(C, A);
  this.reduce(A)
}
Barrett.prototype.convert = barrettConvert;
Barrett.prototype.revert = barrettRevert;
Barrett.prototype.reduce = barrettReduce;
Barrett.prototype.mulTo = barrettMulTo;
Barrett.prototype.sqrTo = barrettSqrTo;

function bnModPow(J, E) {
  var A = J.bitLength(),
    C, M = nbv(1),
    H;
  if (A <= 0) {
    return M
  } else {
    if (A < 18) {
      C = 1
    } else {
      if (A < 48) {
        C = 3
      } else {
        if (A < 144) {
          C = 4
        } else {
          if (A < 768) {
            C = 5
          } else {
            C = 6
          }
        }
      }
    }
  }
  if (A < 8) {
    H = new Classic(E)
  } else {
    if (E.isEven()) {
      H = new Barrett(E)
    } else {
      H = new Montgomery(E)
    }
  }
  var K = [],
    F = 3,
    N = C - 1,
    I = (1 << C) - 1;
  K[1] = H.convert(this);
  if (C > 1) {
    var L = nbi();
    H.sqrTo(K[1], L);
    while (F <= I) {
      K[F] = nbi();
      H.mulTo(L, K[F - 2], K[F]);
      F += 2
    }
  }
  var B = J.t - 1,
    P, G = true,
    D = nbi(),
    O;
  A = nbits(J[B]) - 1;
  while (B >= 0) {
    if (A >= N) {
      P = (J[B] >> (A - N)) & I
    } else {
      P = (J[B] & ((1 << (A + 1)) - 1)) << (N - A);
      if (B > 0) {
        P |= J[B - 1] >> (this.DB + A - N)
      }
    }
    F = C;
    while ((P & 1) == 0) {
      P >>= 1;
      F -= 1
    }
    if ((A -= F) < 0) {
      A += this.DB;
      B -= 1
    }
    if (G) {
      K[P].copyTo(M);
      G = false
    } else {
      while (F > 1) {
        H.sqrTo(M, D);
        H.sqrTo(D, M);
        F -= 2
      }
      if (F > 0) {
        H.sqrTo(M, D)
      } else {
        O = M;
        M = D;
        D = O
      }
      H.mulTo(D, K[P], M)
    }
    while (B >= 0 && (J[B] & (1 << A)) == 0) {
      H.sqrTo(M, D);
      O = M;
      M = D;
      D = O;
      if (--A < 0) {
        A = this.DB - 1;
        B -= 1
      }
    }
  }
  return H.revert(M)
}

function bnGCD(C) {
  var A = (this.s < 0) ? this.negate() : this.clone();
  var B = (C.s < 0) ? C.negate() : C.clone();
  if (A.compareTo(B) < 0) {
    var E = A;
    A = B;
    B = E
  }
  var D = A.getLowestSetBit(),
    F = B.getLowestSetBit();
  if (F < 0) {
    return A
  }
  if (D < F) {
    F = D
  }
  if (F > 0) {
    A.rShiftTo(F, A);
    B.rShiftTo(F, B)
  }
  while (A.signum() > 0) {
    if ((D = A.getLowestSetBit()) > 0) {
      A.rShiftTo(D, A)
    }
    if ((D = B.getLowestSetBit()) > 0) {
      B.rShiftTo(D, B)
    }
    if (A.compareTo(B) >= 0) {
      A.subTo(B, A);
      A.rShiftTo(1, A)
    } else {
      B.subTo(A, B);
      B.rShiftTo(1, B)
    }
  }
  if (F > 0) {
    B.lShiftTo(F, B)
  }
  return B
}

function bnpModInt(B) {
  if (B <= 0) {
    return 0
  }
  var D = this.DV % B,
    A = (this.s < 0) ? B - 1 : 0;
  if (this.t > 0) {
    if (D == 0) {
      A = this[0] % B
    } else {
      for (var C = this.t - 1; C >= 0; C -= 1) {
        A = (D * A + this[C]) % B
      }
    }
  }
  return A
}

function bnModInverse(B) {
  var A = B.isEven();
  if ((this.isEven() && A) || B.signum() == 0) {
    return BigInteger.ZERO
  }
  var G = B.clone(),
    H = this.clone();
  var C = nbv(1),
    D = nbv(0),
    E = nbv(0),
    F = nbv(1);
  while (G.signum() != 0) {
    while (G.isEven()) {
      G.rShiftTo(1, G);
      if (A) {
        if (!C.isEven() || !D.isEven()) {
          C.addTo(this, C);
          D.subTo(B, D)
        }
        C.rShiftTo(1, C)
      } else {
        if (!D.isEven()) {
          D.subTo(B, D)
        }
      }
      D.rShiftTo(1, D)
    }
    while (H.isEven()) {
      H.rShiftTo(1, H);
      if (A) {
        if (!E.isEven() || !F.isEven()) {
          E.addTo(this, E);
          F.subTo(B, F)
        }
        E.rShiftTo(1, E)
      } else {
        if (!F.isEven()) {
          F.subTo(B, F)
        }
      }
      F.rShiftTo(1, F)
    }
    if (G.compareTo(H) >= 0) {
      G.subTo(H, G);
      if (A) {
        C.subTo(E, C)
      }
      D.subTo(F, D)
    } else {
      H.subTo(G, H);
      if (A) {
        E.subTo(C, E)
      }
      F.subTo(D, F)
    }
  }
  if (H.compareTo(BigInteger.ONE) != 0) {
    return BigInteger.ZERO
  }
  if (F.compareTo(B) >= 0) {
    return F.subtract(B)
  }
  if (F.signum() < 0) {
    F.addTo(B, F)
  } else {
    return F
  }
  if (F.signum() < 0) {
    return F.add(B)
  } else {
    return F
  }
}
var lowprimes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101,
  103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223,
  227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349,
  353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479,
  487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619,
  631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769,
  773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929,
  937, 941, 947, 953, 967, 971, 977, 983, 991, 997
];
var lplim = (1 << 26) / lowprimes[lowprimes.length - 1];

function bnIsProbablePrime(C) {
  var D, B = this.abs();
  if (B.t == 1 && B[0] <= lowprimes[lowprimes.length - 1]) {
    for (D = 0; D < lowprimes.length; D += 1) {
      if (B[0] == lowprimes[D]) {
        return true
      }
    }
    return false
  }
  if (B.isEven()) {
    return false
  }
  D = 1;
  while (D < lowprimes.length) {
    var A = lowprimes[D],
      E = D + 1;
    while (E < lowprimes.length && A < lplim) {
      A *= lowprimes[E++]
    }
    A = B.modInt(A);
    while (D < E) {
      if (A % lowprimes[D++] == 0) {
        return false
      }
    }
  }
  return B.millerRabin(C)
}

function bnpMillerRabin(G) {
  var H = this.subtract(BigInteger.ONE);
  var C = H.getLowestSetBit();
  if (C <= 0) {
    return false
  }
  var F = H.shiftRight(C);
  G = (G + 1) >> 1;
  if (G > lowprimes.length) {
    G = lowprimes.length
  }
  var E = nbi();
  for (var A = 0; A < G; A += 1) {
    var ua = new Uint8Array(1);
    ua[0] = 0;
    if (window.crypto && window.crypto.getRandomValues) {
      window.crypto.getRandomValues(ua)
    }
    E.fromInt(lowprimes[Math.floor(ua[0] * lowprimes.length / 256)]);
    var D = E.modPow(F, this);
    if (D.compareTo(BigInteger.ONE) != 0 && D.compareTo(H) != 0) {
      var B = 1;
      while (B++ < C && D.compareTo(H) != 0) {
        D = D.modPowInt(2, this);
        if (D.compareTo(BigInteger.ONE) == 0) {
          return false
        }
      }
      if (D.compareTo(H) != 0) {
        return false
      }
    }
  }
  return true
}
BigInteger.prototype.chunkSize = bnpChunkSize;
BigInteger.prototype.toRadix = bnpToRadix;
BigInteger.prototype.fromRadix = bnpFromRadix;
BigInteger.prototype.fromNumber = bnpFromNumber;
BigInteger.prototype.bitwiseTo = bnpBitwiseTo;
BigInteger.prototype.changeBit = bnpChangeBit;
BigInteger.prototype.addTo = bnpAddTo;
BigInteger.prototype.dMultiply = bnpDMultiply;
BigInteger.prototype.dAddOffset = bnpDAddOffset;
BigInteger.prototype.multiplyLowerTo = bnpMultiplyLowerTo;
BigInteger.prototype.multiplyUpperTo = bnpMultiplyUpperTo;
BigInteger.prototype.modInt = bnpModInt;
BigInteger.prototype.millerRabin = bnpMillerRabin;
BigInteger.prototype.clone = bnClone;
BigInteger.prototype.intValue = bnIntValue;
BigInteger.prototype.byteValue = bnByteValue;
BigInteger.prototype.shortValue = bnShortValue;
BigInteger.prototype.signum = bnSigNum;
BigInteger.prototype.toByteArray = bnToByteArray;
BigInteger.prototype.equals = bnEquals;
BigInteger.prototype.min = bnMin;
BigInteger.prototype.max = bnMax;
BigInteger.prototype.and = bnAnd;
BigInteger.prototype.or = bnOr;
BigInteger.prototype.xor = bnXor;
BigInteger.prototype.andNot = bnAndNot;
BigInteger.prototype.not = bnNot;
BigInteger.prototype.shiftLeft = bnShiftLeft;
BigInteger.prototype.shiftRight = bnShiftRight;
BigInteger.prototype.getLowestSetBit = bnGetLowestSetBit;
BigInteger.prototype.bitCount = bnBitCount;
BigInteger.prototype.testBit = bnTestBit;
BigInteger.prototype.setBit = bnSetBit;
BigInteger.prototype.clearBit = bnClearBit;
BigInteger.prototype.flipBit = bnFlipBit;
BigInteger.prototype.add = bnAdd;
BigInteger.prototype.subtract = bnSubtract;
BigInteger.prototype.multiply = bnMultiply;
BigInteger.prototype.divide = bnDivide;
BigInteger.prototype.remainder = bnRemainder;
BigInteger.prototype.divideAndRemainder = bnDivideAndRemainder;
BigInteger.prototype.modPow = bnModPow;
BigInteger.prototype.modInverse = bnModInverse;
BigInteger.prototype.pow = bnPow;
BigInteger.prototype.gcd = bnGCD;
BigInteger.prototype.isProbablePrime = bnIsProbablePrime;
BigInteger.prototype.square = bnSquare;


var rng_psize = 256;
var rng_state;
var rng_pool;
var rng_pptr;

function rng_seed_int(A) {
  rng_pool[rng_pptr++] ^= A & 255;
  rng_pool[rng_pptr++] ^= (A >> 8) & 255;
  rng_pool[rng_pptr++] ^= (A >> 16) & 255;
  rng_pool[rng_pptr++] ^= (A >> 24) & 255;
  if (rng_pptr >= rng_psize) {
    rng_pptr -= rng_psize
  }
}

function rng_seed_time() {
  rng_seed_int(new Date().getTime())
}
if (rng_pool == null) {
  rng_pool = [];
  rng_pptr = 0;
  var t;
  if (window.crypto && window.crypto.getRandomValues) {
    var ua = new Uint8Array(32);
    window.crypto.getRandomValues(ua);
    for (t = 0; t < 32; t += 1) {
      rng_pool[rng_pptr++] = ua[t]
    }
  }
  if (navigator.appName == "Netscape" && navigator.appVersion < "5" && window.crypto) {
    var z = window.crypto.random(32);
    for (t = 0; t < z.length; t += 1) {
      rng_pool[rng_pptr++] = z.charCodeAt(t) & 255
    }
  }
  rng_pptr = 0;
  rng_seed_time()
}

function rng_get_byte() {
  if (rng_state == null) {
    rng_seed_time();
    rng_state = prng_newstate();
    rng_state.init(rng_pool);
    for (rng_pptr = 0; rng_pptr < rng_pool.length; rng_pptr += 1) {
      rng_pool[rng_pptr] = 0
    }
    rng_pptr = 0
  }
  return rng_state.next()
}

function rng_get_bytes(A) {
  var B;
  for (B = 0; B < A.length; B += 1) {
    A[B] = rng_get_byte()
  }
}

SecureRandom.prototype.nextBytes = rng_get_bytes;


function feFpEquals(A) {
  if (A == this) {
    return true
  }
  return (this.q.equals(A.q) && this.x.equals(A.x))
}

function feFpToBigInteger() {
  return this.x
}

function feFpNegate() {
  return new ECFieldElementFp(this.q, this.x.negate().mod(this.q))
}

function feFpAdd(A) {
  return new ECFieldElementFp(this.q, this.x.add(A.toBigInteger()).mod(this.q))
}

function feFpSubtract(A) {
  return new ECFieldElementFp(this.q, this.x.subtract(A.toBigInteger()).mod(this.q))
}

function feFpMultiply(A) {
  return new ECFieldElementFp(this.q, this.x.multiply(A.toBigInteger()).mod(this.q))
}

function feFpSquare() {
  return new ECFieldElementFp(this.q, this.x.square().mod(this.q))
}

function feFpDivide(A) {
  return new ECFieldElementFp(this.q, this.x.multiply(A.toBigInteger().modInverse(this.q)).mod(this.q))
}
ECFieldElementFp.prototype.equals = feFpEquals;
ECFieldElementFp.prototype.toBigInteger = feFpToBigInteger;
ECFieldElementFp.prototype.negate = feFpNegate;
ECFieldElementFp.prototype.add = feFpAdd;
ECFieldElementFp.prototype.subtract = feFpSubtract;
ECFieldElementFp.prototype.multiply = feFpMultiply;
ECFieldElementFp.prototype.square = feFpSquare;
ECFieldElementFp.prototype.divide = feFpDivide;

function ECPointFp(D, A, B, C) {
  this.curve = D;
  this.x = A;
  this.y = B;
  if (C == null) {
    this.z = BigInteger.ONE
  } else {
    this.z = C
  }
  this.zinv = null
}

function pointFpGetX() {
  if (this.zinv == null) {
    this.zinv = this.z.modInverse(this.curve.q)
  }
  return this.curve.fromBigInteger(this.x.toBigInteger().multiply(this.zinv).mod(this.curve.q))
}

function pointFpGetY() {
  if (this.zinv == null) {
    this.zinv = this.z.modInverse(this.curve.q)
  }
  return this.curve.fromBigInteger(this.y.toBigInteger().multiply(this.zinv).mod(this.curve.q))
}

function pointFpEquals(C) {
  if (C == this) {
    return true
  }
  if (this.isInfinity()) {
    return C.isInfinity()
  }
  if (C.isInfinity()) {
    return this.isInfinity()
  }
  var A, B;
  A = C.y.toBigInteger().multiply(this.z).subtract(this.y.toBigInteger().multiply(C.z)).mod(this.curve.q);
  if (!A.equals(BigInteger.ZERO)) {
    return false
  }
  B = C.x.toBigInteger().multiply(this.z).subtract(this.x.toBigInteger().multiply(C.z)).mod(this.curve.q);
  return B.equals(BigInteger.ZERO)
}

function pointFpIsInfinity() {
  if ((this.x == null) && (this.y == null)) {
    return true
  }
  return this.z.equals(BigInteger.ZERO) && !this.y.toBigInteger().equals(BigInteger.ZERO)
}

function pointFpNegate() {
  return new ECPointFp(this.curve, this.x, this.y.negate(), this.z)
}

function pointFpAdd(F) {
  if (this.isInfinity()) {
    return F
  }
  if (F.isInfinity()) {
    return this
  }
  var L = F.y.toBigInteger().multiply(this.z).subtract(this.y.toBigInteger().multiply(F.z)).mod(this.curve.q);
  var M = F.x.toBigInteger().multiply(this.z).subtract(this.x.toBigInteger().multiply(F.z)).mod(this.curve.q);
  if (BigInteger.ZERO.equals(M)) {
    if (BigInteger.ZERO.equals(L)) {
      return this.twice()
    }
    return this.curve.getInfinity()
  }
  var B = new BigInteger("3");
  var N = this.x.toBigInteger();
  var O = this.y.toBigInteger();
  var D = F.x.toBigInteger();
  var E = F.y.toBigInteger();
  var I = M.square();
  var K = I.multiply(M);
  var G = N.multiply(I);
  var H = L.square().multiply(this.z);
  var A = H.subtract(G.shiftLeft(1)).multiply(F.z).subtract(K).multiply(M).mod(this.curve.q);
  var J = G.multiply(B).multiply(L).subtract(O.multiply(K)).subtract(H.multiply(L)).multiply(F.z).add(L.multiply(K)).mod(
    this.curve.q);
  var C = K.multiply(this.z).multiply(F.z).mod(this.curve.q);
  return new ECPointFp(this.curve, this.curve.fromBigInteger(A), this.curve.fromBigInteger(J), C)
}

function pointFpTwice() {
  if (this.isInfinity()) {
    return this
  }
  if (this.y.toBigInteger().signum() == 0) {
    return this.curve.getInfinity()
  }
  var B = new BigInteger("3");
  var E = this.x.toBigInteger();
  var J = this.y.toBigInteger();
  var D = J.multiply(this.z);
  var F = D.multiply(J).mod(this.curve.q);
  var C = this.curve.a.toBigInteger();
  var I = E.square().multiply(B);
  if (!BigInteger.ZERO.equals(C)) {
    I = I.add(this.z.square().multiply(C))
  }
  I = I.mod(this.curve.q);
  var A = I.square().subtract(E.shiftLeft(3).multiply(F)).shiftLeft(1).multiply(D).mod(this.curve.q);
  var G = I.multiply(B).multiply(E).subtract(F.shiftLeft(1)).shiftLeft(2).multiply(F).subtract(I.square().multiply(I))
    .mod(this.curve.q);
  var H = D.square().multiply(D).shiftLeft(3).mod(this.curve.q);
  return new ECPointFp(this.curve, this.curve.fromBigInteger(A), this.curve.fromBigInteger(G), H)
}

function pointFpMultiply(B) {
  if (this.isInfinity()) {
    return this
  }
  if (B.signum() == 0) {
    return this.curve.getInfinity()
  }
  var F = B;
  var H = F.multiply(new BigInteger("3"));
  var E = this.negate();
  var D = this;
  var A;
  for (A = H.bitLength() - 2; A > 0; A -= 1) {
    D = D.twice();
    var C = H.testBit(A);
    var G = F.testBit(A);
    if (C != G) {
      D = D.add(C ? this : E)
    }
  }
  return D
}

function pointFpMultiplyTwo(E, A, F) {
  var D;
  if (E.bitLength() > F.bitLength()) {
    D = E.bitLength() - 1
  } else {
    D = F.bitLength() - 1
  }
  var B = this.curve.getInfinity();
  var C = this.add(A);
  while (D >= 0) {
    B = B.twice();
    if (E.testBit(D)) {
      if (F.testBit(D)) {
        B = B.add(C)
      } else {
        B = B.add(this)
      }
    } else {
      if (F.testBit(D)) {
        B = B.add(A)
      }
    }
    D -= 1
  }
  return B
}
ECPointFp.prototype.getX = pointFpGetX;
ECPointFp.prototype.getY = pointFpGetY;
ECPointFp.prototype.equals = pointFpEquals;
ECPointFp.prototype.isInfinity = pointFpIsInfinity;
ECPointFp.prototype.negate = pointFpNegate;
ECPointFp.prototype.add = pointFpAdd;
ECPointFp.prototype.twice = pointFpTwice;
ECPointFp.prototype.multiply = pointFpMultiply;
ECPointFp.prototype.multiplyTwo = pointFpMultiplyTwo;

function ECCurveFp(C, A, B) {
  this.q = C;
  this.a = this.fromBigInteger(A);
  this.b = this.fromBigInteger(B);
  this.infinity = new ECPointFp(this, null, null)
}

function curveFpGetQ() {
  return this.q
}

function curveFpGetA() {
  return this.a
}

function curveFpGetB() {
  return this.b
}

function curveFpEquals(A) {
  if (A == this) {
    return true
  }
  return (this.q.equals(A.q) && this.a.equals(A.a) && this.b.equals(A.b))
}

function curveFpGetInfinity() {
  return this.infinity
}

function curveFpFromBigInteger(A) {
  return new ECFieldElementFp(this.q, A)
}

function curveFpDecodePointHex(B) {
  switch (parseInt(B.substr(0, 2), 16)) {
    case 0:
      return this.infinity;
    case 2:
    case 3:
      return null;
    case 4:
    case 6:
    case 7:
      var A = (B.length - 2) / 2;
      var C = B.substr(2, A);
      var D = B.substr(A + 2, A);
      return new ECPointFp(this, this.fromBigInteger(new BigInteger(C, 16)), this.fromBigInteger(new BigInteger(D,
        16)));
    default:
      return null
  }
}
ECCurveFp.prototype.getQ = curveFpGetQ;
ECCurveFp.prototype.getA = curveFpGetA;
ECCurveFp.prototype.getB = curveFpGetB;
ECCurveFp.prototype.equals = curveFpEquals;
ECCurveFp.prototype.getInfinity = curveFpGetInfinity;
ECCurveFp.prototype.fromBigInteger = curveFpFromBigInteger;
ECCurveFp.prototype.decodePointHex = curveFpDecodePointHex;
ECFieldElementFp.prototype.getByteLength = function () {
  return Math.floor((this.toBigInteger().bitLength() + 7) / 8)
};
ECPointFp.prototype.getEncoded = function (E) {
  var D = function (G, F) {
    var H = G.toByteArrayUnsigned();
    if (F < H.length) {
      H = H.slice(H.length - F)
    } else {
      while (F > H.length) {
        H.unshift(0)
      }
    }
    return H
  };
  var A = this.getX().toBigInteger();
  var B = this.getY().toBigInteger();
  var C = D(A, 32);
  if (E) {
    if (B.isEven()) {
      C.unshift(2)
    } else {
      C.unshift(3)
    }
  } else {
    C.unshift(4);
    C = C.concat(D(B, 32))
  }
  return C
};
ECPointFp.decodeFrom = function (H, F) {
  var E = F[0];
  var G = F.length - 1;
  var B = F.slice(1, 1 + G / 2);
  var C = F.slice(1 + G / 2, 1 + G);
  B.unshift(0);
  C.unshift(0);
  var D = new BigInteger(B);
  var A = new BigInteger(C);
  return new ECPointFp(H, H.fromBigInteger(D), H.fromBigInteger(A))
};
ECPointFp.decodeFromHex = function (H, E) {
  var D = E.substr(0, 2);
  var F = E.length - 2;
  var G = E.substr(2, F / 2);
  var C = E.substr(2 + F / 2, F / 2);
  var A = new BigInteger(G, 16);
  var B = new BigInteger(C, 16);
  return new ECPointFp(H, H.fromBigInteger(A), H.fromBigInteger(B))
};
ECPointFp.prototype.add2D = function (C) {
  if (this.isInfinity()) {
    return C
  }
  if (C.isInfinity()) {
    return this
  }
  if (this.x.equals(C.x)) {
    if (this.y.equals(C.y)) {
      return this.twice()
    }
    return this.curve.getInfinity()
  }
  var F = C.x.subtract(this.x);
  var B = C.y.subtract(this.y);
  var A = B.divide(F);
  var D = A.square().subtract(this.x).subtract(C.x);
  var E = A.multiply(this.x.subtract(D)).subtract(this.y);
  return new ECPointFp(this.curve, D, E)
};
ECPointFp.prototype.twice2D = function () {
  if (this.isInfinity()) {
    return this
  }
  if (this.y.toBigInteger().signum() == 0) {
    return this.curve.getInfinity()
  }
  var C = this.curve.fromBigInteger(BigInteger.valueOf(2));
  var E = this.curve.fromBigInteger(BigInteger.valueOf(3));
  var A = this.x.square().multiply(E).add(this.curve.a).divide(this.y.multiply(C));
  var B = A.square().subtract(this.x.multiply(C));
  var D = A.multiply(this.x.subtract(B)).subtract(this.y);
  return new ECPointFp(this.curve, B, D)
};
ECPointFp.prototype.multiply2D = function (B) {
  if (this.isInfinity()) {
    return this
  }
  if (B.signum() == 0) {
    return this.curve.getInfinity()
  }
  var F = B;
  var H = F.multiply(new BigInteger("3"));
  var E = this.negate();
  var D = this;
  var A;
  for (A = H.bitLength() - 2; A > 0; A -= 1) {
    D = D.twice();
    var C = H.testBit(A);
    var G = F.testBit(A);
    if (C != G) {
      D = D.add2D(C ? this : E)
    }
  }
  return D
};
ECPointFp.prototype.isOnCurve = function () {
  var A = this.getX().toBigInteger();
  var B = this.getY().toBigInteger();
  var C = this.curve.getA().toBigInteger();
  var D = this.curve.getB().toBigInteger();
  var E = this.curve.getQ();
  var F = B.multiply(B).mod(E);
  var G = A.multiply(A).multiply(A).add(C.multiply(A)).add(D).mod(E);
  return F.equals(G)
};
ECPointFp.prototype.toString = function () {
  return "(" + this.getX().toBigInteger().toString() + "," + this.getY().toBigInteger().toString() + ")"
};
ECPointFp.prototype.validate = function () {
  var A = this.curve.getQ();
  if (this.isInfinity()) {
    throw new Error("Point is at infinity.")
  }
  var C = this.getX().toBigInteger();
  var B = this.getY().toBigInteger();
  if (C.compareTo(BigInteger.ONE) < 0 || C.compareTo(A.subtract(BigInteger.ONE)) > 0) {
    throw new Error("x coordinate out of bounds")
  }
  if (B.compareTo(BigInteger.ONE) < 0 || B.compareTo(A.subtract(BigInteger.ONE)) > 0) {
    throw new Error("y coordinate out of bounds")
  }
  if (!this.isOnCurve()) {
    throw new Error("Point is not on the curve.")
  }
  if (this.multiply(A).isInfinity()) {
    throw new Error("Point is not a scalar multiple of G.")
  }
  return true
};
if (typeof KJUR == "undefined" || !KJUR) {
  KJUR = {}
}
if (typeof KJUR.crypto == "undefined" || !KJUR.crypto) {
  KJUR.crypto = {}
}
KJUR.crypto.ECDSA = function (F) {
  var D = "secp256r1";
  var G = null;
  var H = null;
  var A = null;
  var C = new SecureRandom();
  var B = null;
  this.type = "EC";

  function E(M, J, N, K) {
    var L = Math.max(J.bitLength(), K.bitLength());
    var S = M.add2D(N);
    var O = M.curve.getInfinity();
    for (var I = L - 1; I >= 0; I -= 1) {
      O = O.twice2D();
      O.z = BigInteger.ONE;
      if (J.testBit(I)) {
        if (K.testBit(I)) {
          O = O.add2D(S)
        } else {
          O = O.add2D(M)
        }
      } else {
        if (K.testBit(I)) {
          O = O.add2D(N)
        }
      }
    }
    return O
  }
  this.getBigRandom = function (I) {
    return new BigInteger(I.bitLength(), C).mod(I.subtract(BigInteger.ONE)).add(BigInteger.ONE)
  };
  this.setNamedCurve = function (I) {
    this.ecparams = KJUR.crypto.ECParameterDB.getByName(I);
    this.prvKeyHex = null;
    this.pubKeyHex = null;
    this.curveName = I
  };
  this.setPrivateKeyHex = function (I) {
    this.isPrivate = true;
    this.prvKeyHex = I
  };
  this.setPublicKeyHex = function (I) {
    this.isPublic = true;
    this.pubKeyHex = I
  };
  this.getPublicKeyXYHex = function () {
    var K = this.pubKeyHex;
    if (K.substr(0, 2) !== "04") {
      throw "this method supports uncompressed format(04) only"
    }
    var J = this.ecparams.keylen / 4;
    if (K.length !== 2 + J * 2) {
      throw "malformed public key hex length"
    }
    var I = {};
    I.x = K.substr(2, J);
    I.y = K.substr(2 + J);
    return I
  };
  this.getShortNISTPCurveName = function () {
    var I = this.curveName;
    if (I === "secp256r1" || I === "NIST P-256" || I === "P-256" || I === "prime256v1") {
      return "P-256"
    }
    if (I === "secp384r1" || I === "NIST P-384" || I === "P-384") {
      return "P-384"
    }
    return null
  };
  this.generateKeyPairHex = function () {
    var Q = this.ecparams["n"];
    var I = this.getBigRandom(Q);
    var N = this.ecparams["G"].multiply(I);
    var P = N.getX().toBigInteger();
    var O = N.getY().toBigInteger();
    var J = this.ecparams["keylen"] / 4;
    var L = ("0000000000" + I.toString(16)).slice(-J);
    var M = ("0000000000" + P.toString(16)).slice(-J);
    var R = ("0000000000" + O.toString(16)).slice(-J);
    var K = "04" + M + R;
    this.setPrivateKeyHex(L);
    this.setPublicKeyHex(K);
    return {
      "ecprvhex": L,
      "ecpubhex": K
    }
  };
  this.signWithMessageHash = function (I) {
    return this.signHex(I, this.prvKeyHex)
  };
  this.signHex = function (N, R) {
    var L = new BigInteger(R, 16);
    var J = this.ecparams["n"];
    var M = new BigInteger(N, 16);
    do {
      var I = this.getBigRandom(J);
      var S = this.ecparams["G"];
      var K = S.multiply(I);
      var O = K.getX().toBigInteger().mod(J)
    } while (O.compareTo(BigInteger.ZERO) <= 0);
    var P = I.modInverse(J).multiply(M.add(L.multiply(O))).mod(J);
    return KJUR.crypto.ECDSA.biRSSigToASN1Sig(O, P)
  };
  this.sign = function (M, I) {
    var N = I;
    var K = this.ecparams["n"];
    var O = BigInteger.fromByteArrayUnsigned(M);
    do {
      var J = this.getBigRandom(K);
      var S = this.ecparams["G"];
      var L = S.multiply(J);
      var P = L.getX().toBigInteger().mod(K)
    } while (P.compareTo(BigInteger.ZERO) <= 0);
    var R = J.modInverse(K).multiply(O.add(N.multiply(P))).mod(K);
    return this.serializeSig(P, R)
  };
  this.verifyWithMessageHash = function (J, I) {
    return this.verifyHex(J, I, this.pubKeyHex)
  };
  this.verifyHex = function (N, J, P) {
    var O, L;
    var I = KJUR.crypto.ECDSA.parseSigHex(J);
    O = I.r;
    L = I.s;
    var K;
    K = ECPointFp.decodeFromHex(this.ecparams["curve"], P);
    var M = new BigInteger(N, 16);
    return this.verifyRaw(M, O, L, K)
  };
  this.verify = function (L, K, P) {
    var N, O;
    if (Bitcoin.Util.isArray(K)) {
      var I = this.parseSig(K);
      N = I.r;
      O = I.s
    } else {
      if ("object" === typeof K && K.r && K.s) {
        N = K.r;
        O = K.s
      } else {
        throw "Invalid value for signature"
      }
    }
    var J;
    if (P instanceof ECPointFp) {
      J = P
    } else {
      if (Bitcoin.Util.isArray(P)) {
        J = ECPointFp.decodeFrom(this.ecparams["curve"], P)
      } else {
        throw "Invalid format for pubkey value, must be byte array or ECPointFp"
      }
    }
    var M = BigInteger.fromByteArrayUnsigned(L);
    return this.verifyRaw(M, N, O, J)
  };
  this.verifyRaw = function (M, P, R, J) {
    var T = this.ecparams["n"];
    var I = this.ecparams["G"];
    if (P.compareTo(BigInteger.ONE) < 0 || P.compareTo(T) >= 0) {
      return false
    }
    if (R.compareTo(BigInteger.ONE) < 0 || R.compareTo(T) >= 0) {
      return false
    }
    var K = R.modInverse(T);
    var L = M.multiply(K).mod(T);
    var S = P.multiply(K).mod(T);
    var N = I.multiply(L).add(J.multiply(S));
    var O = N.getX().toBigInteger().mod(T);
    return O.equals(P)
  };
  this.serializeSig = function (I, J) {
    var K = I.toByteArraySigned();
    var L = J.toByteArraySigned();
    var M = [];
    M.push(2);
    M.push(K.length);
    M = M.concat(K);
    M.push(2);
    M.push(L.length);
    M = M.concat(L);
    M.unshift(M.length);
    M.unshift(48);
    return M
  };
  this.parseSig = function (M) {
    var J;
    if (M[0] != 48) {
      throw new Error("Signature not a valid DERSequence")
    }
    J = 2;
    if (M[J] != 2) {
      throw new Error("First element in signature must be a DERInteger")
    }
    var K = M.slice(J + 2, J + 2 + M[J + 1]);
    J += 2 + M[J + 1];
    if (M[J] != 2) {
      throw new Error("Second element in signature must be a DERInteger")
    }
    var L = M.slice(J + 2, J + 2 + M[J + 1]);
    J += 2 + M[J + 1];
    var I = BigInteger.fromByteArrayUnsigned(K);
    var N = BigInteger.fromByteArrayUnsigned(L);
    return {
      r: I,
      s: N
    }
  };
  this.parseSigCompact = function (K) {
    if (K.length !== 65) {
      throw "Signature has the wrong length"
    }
    var L = K[0] - 27;
    if (L < 0 || L > 7) {
      throw "Invalid signature type"
    }
    var J = this.ecparams["n"];
    var I = BigInteger.fromByteArrayUnsigned(K.slice(1, 33)).mod(J);
    var M = BigInteger.fromByteArrayUnsigned(K.slice(33, 65)).mod(J);
    return {
      r: I,
      s: M,
      i: L
    }
  };
  if (F !== undefined) {
    if (F["curve"] !== undefined) {
      this.curveName = F["curve"]
    }
  }
  if (this.curveName === undefined) {
    this.curveName = D
  }
  this.setNamedCurve(this.curveName);
  if (F !== undefined) {
    if (F["prv"] !== undefined) {
      this.setPrivateKeyHex(F["prv"])
    }
    if (F["pub"] !== undefined) {
      this.setPublicKeyHex(F["pub"])
    }
  }
};
KJUR.crypto.ECDSA.parseSigHex = function (A) {
  var C = KJUR.crypto.ECDSA.parseSigHexInHexRS(A);
  var B = new BigInteger(C.r, 16);
  var D = new BigInteger(C.s, 16);
  return {
    "r": B,
    "s": D
  }
};
KJUR.crypto.ECDSA.parseSigHexInHexRS = function (B) {
  if (B.substr(0, 2) != "30") {
    throw "signature is not a ASN.1 sequence"
  }
  var C = ASN1HEX.getPosArrayOfChildren_AtObj(B, 0);
  if (C.length != 2) {
    throw "number of signature ASN.1 sequence elements seem wrong"
  }
  var F = C[0];
  var E = C[1];
  if (B.substr(F, 2) != "02") {
    throw "1st item of sequene of signature is not ASN.1 integer"
  }
  if (B.substr(E, 2) != "02") {
    throw "2nd item of sequene of signature is not ASN.1 integer"
  }
  var A = ASN1HEX.getHexOfV_AtObj(B, F);
  var D = ASN1HEX.getHexOfV_AtObj(B, E);
  return {
    "r": A,
    "s": D
  }
};
KJUR.crypto.ECDSA.asn1SigToConcatSig = function (A) {
  var B = KJUR.crypto.ECDSA.parseSigHexInHexRS(A);
  var D = B.r;
  var C = B.s;
  if (D.substr(0, 2) == "00" && (((D.length / 2) * 8) % (16 * 8)) == 8) {
    D = D.substr(2)
  }
  if (C.substr(0, 2) == "00" && (((C.length / 2) * 8) % (16 * 8)) == 8) {
    C = C.substr(2)
  }
  if ((((D.length / 2) * 8) % (16 * 8)) != 0) {
    throw "unknown ECDSA sig r length error"
  }
  if ((((C.length / 2) * 8) % (16 * 8)) != 0) {
    throw "unknown ECDSA sig s length error"
  }
  return D + C
};
KJUR.crypto.ECDSA.concatSigToASN1Sig = function (A) {
  if ((((A.length / 2) * 8) % (16 * 8)) != 0) {
    throw "unknown ECDSA concatinated r-s sig  length error"
  }
  var C = A.substr(0, A.length / 2);
  var B = A.substr(A.length / 2);
  return KJUR.crypto.ECDSA.hexRSSigToASN1Sig(C, B)
};
KJUR.crypto.ECDSA.hexRSSigToASN1Sig = function (C, B) {
  var A = new BigInteger(C, 16);
  var D = new BigInteger(B, 16);
  return KJUR.crypto.ECDSA.biRSSigToASN1Sig(A, D)
};
KJUR.crypto.ECDSA.biRSSigToASN1Sig = function (B, E) {
  var C = new KJUR.asn1.DERInteger({
    "bigint": B
  });
  var A = new KJUR.asn1.DERInteger({
    "bigint": E
  });
  var D = new KJUR.asn1.DERSequence({
    "array": [C, A]
  });
  return D.getEncodedHex()
};
(function () {
  var F = CryptoJS;
  var E = F.lib;
  var H = E.WordArray;
  var D = E.Hasher;
  var G = F.algo;
  var B = [];
  var A = G.SM3 = D.extend({
    _doReset: function () {
      this._hash = new H.init([1937774191, 1226093241, 388252375, 3666478592, 2842636476,
        372324522, 3817729613, 2969243214
      ])
    },
    _doProcessBlock: function (R, S) {
      var Q = this._hash.words;
      var K = Q[0];
      var L = Q[1];
      var N = Q[2];
      var O = Q[3];
      var P = Q[4];
      for (var C = 0; C < 80; C += 1) {
        if (C < 16) {
          B[C] = R[S + C] | 0
        } else {
          var I = B[C - 3] ^ B[C - 8] ^ B[C - 14] ^ B[C - 16];
          B[C] = (I << 1) | (I >>> 31)
        }
        var J = ((K << 5) | (K >>> 27)) + P + B[C];
        if (C < 20) {
          J += ((L & N) | (~L & O)) + 1518500249
        } else {
          if (C < 40) {
            J += (L ^ N ^ O) + 1859775393
          } else {
            if (C < 60) {
              J += ((L & N) | (L & O) | (N & O)) - 1894007588
            } else {
              J += (L ^ N ^ O) - 899497514
            }
          }
        }
        P = O;
        O = N;
        N = (L << 30) | (L >>> 2);
        L = K;
        K = J
      }
      Q[0] = (Q[0] + K) | 0;
      Q[1] = (Q[1] + L) | 0;
      Q[2] = (Q[2] + N) | 0;
      Q[3] = (Q[3] + O) | 0;
      Q[4] = (Q[4] + P) | 0
    },
    _doFinalize: function () {
      var K = this._data;
      var J = K.words;
      var C = this._nDataBytes * 8;
      var I = K.sigBytes * 8;
      J[I >>> 5] |= 128 << (24 - I % 32);
      J[(((I + 64) >>> 9) << 4) + 14] = Math.floor(C / 4294967296);
      J[(((I + 64) >>> 9) << 4) + 15] = C;
      K.sigBytes = J.length * 4;
      this._process();
      return this._hash
    },
    clone: function () {
      var C = D.clone.call(this);
      C._hash = this._hash.clone();
      return C
    }
  });
  F.SM3 = D._createHelper(A);
  F.HmacSM3 = D._createHmacHelper(A)
}());

function SM3Digest() {
  this.BYTE_LENGTH = 64;
  this.xBuf = [];
  this.xBufOff = 0;
  this.byteCount = 0;
  this.DIGEST_LENGTH = 32;
  this.v0 = [1937774191, 1226093241, 388252375, -628488704, -1452330820, 372324522, -477237683, -1325724082];
  this.v = [0, 0, 0, 0, 0, 0, 0, 0];
  this.v_ = [0, 0, 0, 0, 0, 0, 0, 0];
  this.X0 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  this.X = [68];
  this.xOff = 0;
  this.T_00_15 = 2043430169;
  this.T_16_63 = 2055708042;
  if (arguments.length > 0) {
    this.InitDigest(arguments[0])
  } else {
    this.Init()
  }
}
SM3Digest.prototype = {
  Init: function () {
    this.xBuf = [0, 0, 0, 0];
    this.Reset()
  },
  InitDigest: function (A) {
    this.xBuf = [A.xBuf.length];
    Array.Copy(A.xBuf, 0, this.xBuf, 0, A.xBuf.length);
    this.xBufOff = A.xBufOff;
    this.byteCount = A.byteCount;
    Array.Copy(A.X, 0, this.X, 0, A.X.length);
    this.xOff = A.xOff;
    Array.Copy(A.v, 0, this.v, 0, A.v.length)
  },
  GetDigestSize: function () {
    return this.DIGEST_LENGTH
  },
  Reset: function () {
    this.byteCount = 0;
    this.xBufOff = 0;
    Array.Clear(this.xBuf, 0, this.xBuf.length);
    Array.Copy(this.v0, 0, this.v, 0, this.v0.length);
    this.xOff = 0;
    Array.Copy(this.X0, 0, this.X, 0, this.X0.length)
  },
  GetByteLength: function () {
    return this.BYTE_LENGTH
  },
  ProcessBlock: function () {
    var A;
    var J = this.X;
    var B = [64];
    for (A = 16; A < 68; A += 1) {
      J[A] = this.P1(J[A - 16] ^ J[A - 9] ^ (roateLeft(J[A - 3], 15))) ^ (roateLeft(J[A - 13], 7)) ^ J[A -
      6]
    }
    for (A = 0; A < 64; A += 1) {
      B[A] = J[A] ^ J[A + 4]
    }
    var E = this.v;
    var H = this.v_;
    Array.Copy(E, 0, H, 0, this.v0.length);
    var F, D, C, I, G;
    for (A = 0; A < 16; A += 1) {
      G = roateLeft(H[0], 12);
      F = G + H[4] + roateLeft(this.T_00_15, A);
      F = roateLeft(F, 7);
      D = F ^ G;
      C = this.FF_00_15(H[0], H[1], H[2]) + H[3] + D + B[A];
      I = this.GG_00_15(H[4], H[5], H[6]) + H[7] + F + J[A];
      H[3] = H[2];
      H[2] = roateLeft(H[1], 9);
      H[1] = H[0];
      H[0] = C;
      H[7] = H[6];
      H[6] = roateLeft(H[5], 19);
      H[5] = H[4];
      H[4] = this.P0(I)
    }
    for (A = 16; A < 64; A += 1) {
      G = roateLeft(H[0], 12);
      F = G + H[4] + roateLeft(this.T_16_63, A);
      F = roateLeft(F, 7);
      D = F ^ G;
      C = this.FF_16_63(H[0], H[1], H[2]) + H[3] + D + B[A];
      I = this.GG_16_63(H[4], H[5], H[6]) + H[7] + F + J[A];
      H[3] = H[2];
      H[2] = roateLeft(H[1], 9);
      H[1] = H[0];
      H[0] = C;
      H[7] = H[6];
      H[6] = roateLeft(H[5], 19);
      H[5] = H[4];
      H[4] = this.P0(I)
    }
    for (A = 0; A < 8; A += 1) {
      E[A] ^= (H[A])
    }
    this.xOff = 0;
    Array.Copy(this.X0, 0, this.X, 0, this.X0.length)
  },
  ProcessWord: function (C, B) {
    var A = C[B] << 24;
    A |= (C[B += 1] & 255) << 16;
    A |= (C[B += 1] & 255) << 8;
    A |= (C[B += 1] & 255);
    this.X[this.xOff] = A;
    if (++this.xOff == 16) {
      this.ProcessBlock()
    }
  },
  ProcessLength: function (A) {
    if (this.xOff > 14) {
      this.ProcessBlock()
    }
    this.X[14] = (this.URShiftLong(A, 32));
    this.X[15] = (A & (4294967295))
  },
  IntToBigEndian: function (B, C, A) {
    C[A] = (B >>> 24 & 255);
    C[A += 1] = (B >>> 16 & 255);
    C[A += 1] = (B >>> 8 & 255);
    C[A += 1] = (B & 255)
  },
  DoFinal: function (B, A) {
    this.Finish();
    for (var C = 0; C < 8; C += 1) {
      this.IntToBigEndian(this.v[C], B, A + C * 4)
    }
    this.Reset();
    return this.DIGEST_LENGTH
  },
  Update: function (A) {
    this.xBuf[this.xBufOff++] = A;
    if (this.xBufOff == this.xBuf.length) {
      this.ProcessWord(this.xBuf, 0);
      this.xBufOff = 0
    }
    this.byteCount++
  },
  BlockUpdate: function (B, A, C) {
    while ((this.xBufOff != 0) && (C > 0)) {
      this.Update(B[A]);
      A += 1;
      C -= 1
    }
    while (C > this.xBuf.length) {
      this.ProcessWord(B, A);
      A += this.xBuf.length;
      C -= this.xBuf.length;
      this.byteCount += this.xBuf.length
    }
    while (C > 0) {
      this.Update(B[A]);
      A += 1;
      C -= 1
    }
  },
  Finish: function () {
    var A = (this.byteCount << 3);
    this.Update((128));
    while (this.xBufOff != 0) {
      this.Update((0))
    }
    this.ProcessLength(A);
    this.ProcessBlock()
  },
  ROTATE: function (A, B) {
    return (A << B) | (this.URShift(A, (32 - B)))
  },
  P0: function (A) {
    return ((A) ^ roateLeft((A), 9) ^ roateLeft((A), 17))
  },
  P1: function (A) {
    return ((A) ^ roateLeft((A), 15) ^ roateLeft((A), 23))
  },
  FF_00_15: function (A, B, C) {
    return (A ^ B ^ C)
  },
  FF_16_63: function (A, B, C) {
    return ((A & B) | (A & C) | (B & C))
  },
  GG_00_15: function (A, B, C) {
    return (A ^ B ^ C)
  },
  GG_16_63: function (A, B, C) {
    return ((A & B) | (~A & C))
  },
  URShift: function (B, A) {
    console.error(B);
    if (B > Int32.maxValue || B < Int32.minValue) {
      console.error(B);
      B = IntegerParse(B)
    }
    if (B >= 0) {
      return B >> A
    } else {
      return (B >> A) + (2 << ~A)
    }
  },
  URShiftLong: function (H, G) {
    var J;
    var L = new BigInteger();
    L.fromInt(H);
    if (L.signum() >= 0) {
      J = L.shiftRight(G).intValue()
    } else {
      var E = new BigInteger();
      E.fromInt(2);
      var A = ~G;
      var C = "";
      if (A < 0) {
        var D = 64 + A;
        for (var I = 0; I < D; I += 1) {
          C += "0"
        }
        var F = new BigInteger();
        F.fromInt(H >> G);
        var B = new BigInteger("10" + C, 2);
        C = B.toRadix(10);
        var K = B.add(F);
        J = K.toRadix(10)
      } else {
        C = E.shiftLeft((~G)).intValue();
        J = (H >> G) + C
      }
    }
    return J
  },
  GetZ: function (H, A, F) {
    var E = CryptoJS.enc.Utf8.parse(F);
    var K = E.words.length * 4 * 8;
    this.Update((K >> 8 & 255));
    this.Update((K & 255));
    var L = this.GetWords(E.toString());
    this.BlockUpdate(L, 0, L.length);
    var G = this.GetWords(H.curve.a.toBigInteger().toRadix(16));
    var M = this.GetWords(H.curve.b.toBigInteger().toRadix(16));
    var D = this.GetWords(H.getX().toBigInteger().toRadix(16));
    var B = this.GetWords(H.getY().toBigInteger().toRadix(16));
    var J = this.GetWords(A.substr(0, 64));
    var I = this.GetWords(A.substr(64, 64));
    this.BlockUpdate(G, 0, G.length);
    this.BlockUpdate(M, 0, M.length);
    this.BlockUpdate(D, 0, D.length);
    this.BlockUpdate(B, 0, B.length);
    this.BlockUpdate(J, 0, J.length);
    this.BlockUpdate(I, 0, I.length);
    var C = [this.GetDigestSize()];
    this.DoFinal(C, 0);
    return C
  },
  GetWords: function (A) {
    var B = [];
    var C = A.length;
    for (var D = 0; D < C; D += 2) {
      B[B.length] = parseInt(A.substr(D, 2), 16)
    }
    return B
  },
  GetHex: function (A) {
    var C = [];
    var E = 0;
    for (var D = 0; D < A.length * 2; D += 2) {
      C[D >>> 3] |= parseInt(A[E]) << (24 - (D % 8) * 4);
      E += 1
    }
    var B = new CryptoJS.lib.WordArray.init(C, A.length);
    return B
  }
};
Array.Clear = function (B, A, C) {
  for (let elm in B) {
    B[elm] = null
  }
};
Array.Copy = function (B, E, C, A, F) {
  var D = B.slice(E, E + F);
  for (var G = 0; G < D.length; G += 1) {
    C[A] = D[G];
    A += 1
  }
};

function roateLeft(A, B) {
  return (A << B) | (A >>> -B)
}
window.Int32 = {
  minValue: -parseInt("10000000000000000000000000000000", 2),
  maxValue: parseInt("1111111111111111111111111111111", 2),
  parse: function (C) {
    if (C < this.minValue) {
      var E = new Number(-C);
      var G = E.toString(2);
      var D = G.substr(G.length - 31, 31);
      var B = "";
      for (var A = 0; A < D.length; A += 1) {
        var F = D.substr(A, 1);
        B += F == "0" ? "1" : "0"
      }
      var H = parseInt(B, 2);
      return (H + 1)
    } else {
      if (C > this.maxValue) {
        var E = Number(C);
        var G = E.toString(2);
        var D = G.substr(G.length - 31, 31);
        var B = "";
        for (var A = 0; A < D.length; A += 1) {
          var F = D.substr(A, 1);
          B += F == "0" ? "1" : "0"
        }
        var H = parseInt(B, 2);
        return -(H + 1)
      } else {
        return C
      }
    }
  },
  parseByte: function (A) {
    if (A > 255) {
      var B = 255 & A;
      return B
    }
    if (A < -256) {
      var B = 255 & A;
      B = 255 ^ B;
      return (B + 1)
    } else {
      return A
    }
  }
};

function IntegerParse(A) {
  if (A > 2147483647 || A < -2147483648) {
    var B = 4294967295 & A;
    if (B > 2147483647) {
      B = 2147483647 & A;
      B = 2147483647 ^ B;
      return -(B + 1)
    }
    return B
  } else {
    return A
  }
}
KJUR.crypto.SM3withSM2 = function (F) {
  var D = "sm2";
  var G = null;
  var H = null;
  var A = null;
  var C = new SecureRandom();
  var B = null;
  this.type = "SM2";

  function E(M, J, N, K) {
    var L = Math.max(J.bitLength(), K.bitLength());
    var S = M.add2D(N);
    var O = M.curve.getInfinity();
    for (var I = L - 1; I >= 0; --I) {
      O = O.twice2D();
      O.z = BigInteger.ONE;
      if (J.testBit(I)) {
        if (K.testBit(I)) {
          O = O.add2D(S)
        } else {
          O = O.add2D(M)
        }
      } else {
        if (K.testBit(I)) {
          O = O.add2D(N)
        }
      }
    }
    return O
  }
  this.getBigRandom = function (I) {
    return new BigInteger(I.bitLength(), C).mod(I.subtract(BigInteger.ONE)).add(BigInteger.ONE)
  };
  this.setNamedCurve = function (I) {
    this.ecparams = KJUR.crypto.ECParameterDB.getByName(I);
    this.prvKeyHex = null;
    this.pubKeyHex = null;
    this.curveName = I
  };
  this.setPrivateKeyHex = function (I) {
    this.isPrivate = true;
    this.prvKeyHex = I
  };
  this.setPublicKeyHex = function (I) {
    this.isPublic = true;
    this.pubKeyHex = I
  };
  this.generateKeyPairHex = function () {
    var Q = this.ecparams["n"];
    var I = this.getBigRandom(Q);
    var N = this.ecparams["G"].multiply(I);
    var P = N.getX().toBigInteger();
    var O = N.getY().toBigInteger();
    var J = this.ecparams["keylen"] / 4;
    var L = ("0000000000" + I.toString(16)).slice(-J);
    var M = ("0000000000" + P.toString(16)).slice(-J);
    var R = ("0000000000" + O.toString(16)).slice(-J);
    var K = "04" + M + R;
    this.setPrivateKeyHex(L);
    this.setPublicKeyHex(K);
    return {
      "ecprvhex": L,
      "ecpubhex": K
    }
  };
  this.signWithMessageHash = function (I) {
    return this.signHex(I, this.prvKeyHex)
  };
  this.signHex = function (R, V) {
    var O = new BigInteger(V, 16);
    var K = this.ecparams["n"];
    var P = new BigInteger(R, 16);
    var J = null;
    var L = null;
    var S = null;
    var T = null;
    var I = O;
    do {
      do {
        var X = this.generateKeyPairHex();
        J = new BigInteger(X.ecprvhex, 16);
        var W = X.ecpubhex;
        L = ECPointFp.decodeFromHex(this.ecparams["curve"], W);
        S = P.add(L.getX().toBigInteger());
        S = S.mod(K)
      } while (S.equals(BigInteger.ZERO) || S.add(J).equals(K));
      var N = I.add(BigInteger.ONE);
      N = N.modInverse(K);
      T = S.multiply(I);
      T = J.subtract(T).mod(K);
      T = N.multiply(T).mod(K)
    } while (T.equals(BigInteger.ZERO));
    var U = S.toRadix(16);
    var Q = T.toRadix(16);
    if (U.length != 64) {
      for (var O = 64 - U.length, M = 0; M < O; M++) {
        U = "0" + U
      }
    }
    if (Q.length != 64) {
      for (var O = 64 - Q.length, M = 0; M < O; M++) {
        Q = "0" + Q
      }
    }
    return U + Q
  };
  this.sign = function (M, I) {
    var N = I;
    var K = this.ecparams["n"];
    var O = BigInteger.fromByteArrayUnsigned(M);
    do {
      var J = this.getBigRandom(K);
      var S = this.ecparams["G"];
      var L = S.multiply(J);
      var P = L.getX().toBigInteger().mod(K)
    } while (P.compareTo(BigInteger.ZERO) <= 0);
    var R = J.modInverse(K).multiply(O.add(N.multiply(P))).mod(K);
    return this.serializeSig(P, R)
  };
  this.verifyWithMessageHash = function (J, I) {
    return this.verifyHex(J, I, this.pubKeyHex)
  };
  this.verifyHex = function (N, I, P) {
    var O, L;
    O = I.substr(0, 64);
    L = I.substr(64, 64);
    var R = new BigInteger(O, 16);
    var J = new BigInteger(L, 16);
    var K;
    K = ECPointFp.decodeFromHex(this.ecparams["curve"], P);
    var M = new BigInteger(N, 16);
    return this.verifyRaw(M, R, J, K)
  };
  this.verify = function (L, K, P) {
    var N, O;
    if (Bitcoin.Util.isArray(K)) {
      var I = this.parseSig(K);
      N = I.r;
      O = I.s
    } else {
      if ("object" === typeof K && K.r && K.s) {
        N = K.r;
        O = K.s
      } else {
        throw "Invalid value for signature"
      }
    }
    var J;
    if (P instanceof ECPointFp) {
      J = P
    } else {
      if (Bitcoin.Util.isArray(P)) {
        J = ECPointFp.decodeFrom(this.ecparams["curve"], P)
      } else {
        throw "Invalid format for pubkey value, must be byte array or ECPointFp"
      }
    }
    var M = BigInteger.fromByteArrayUnsigned(L);
    return this.verifyRaw(M, N, O, J)
  };
  this.verifyRaw = function (M, N, O, J) {
    var S = this.ecparams["n"];
    var I = this.ecparams["G"];
    var P = N.add(O).mod(S);
    if (P.equals(BigInteger.ZERO)) {
      return false
    }
    if (N.compareTo(BigInteger.ONE) < 0 || N.compareTo(S) >= 0) {
      return false
    }
    if (O.compareTo(BigInteger.ONE) < 0 || O.compareTo(S) >= 0) {
      return false
    }
    if (J.isOnCurve() == 0) {
      return false
    }
    var L = I.multiply(O);
    L = L.add(J.multiply(P));
    var K = M.add(L.getX().toBigInteger()).mod(S);
    return N.equals(K)
  };
  this.serializeSig = function (I, J) {
    var K = I.toByteArraySigned();
    var L = J.toByteArraySigned();
    var M = [];
    M.push(2);
    M.push(K.length);
    M = M.concat(K);
    M.push(2);
    M.push(L.length);
    M = M.concat(L);
    M.unshift(M.length);
    M.unshift(48);
    return M
  };
  this.parseSig = function (M) {
    var J;
    if (M[0] != 48) {
      throw new Error("Signature not a valid DERSequence")
    }
    J = 2;
    if (M[J] != 2) {
      throw new Error("First element in signature must be a DERInteger")
    }
    var K = M.slice(J + 2, J + 2 + M[J + 1]);
    J += 2 + M[J + 1];
    if (M[J] != 2) {
      throw new Error("Second element in signature must be a DERInteger")
    }
    var L = M.slice(J + 2, J + 2 + M[J + 1]);
    J += 2 + M[J + 1];
    var I = BigInteger.fromByteArrayUnsigned(K);
    var N = BigInteger.fromByteArrayUnsigned(L);
    return {
      r: I,
      s: N
    }
  };
  this.parseSigCompact = function (K) {
    if (K.length !== 65) {
      throw "Signature has the wrong length"
    }
    var L = K[0] - 27;
    if (L < 0 || L > 7) {
      throw "Invalid signature type"
    }
    var J = this.ecparams["n"];
    var I = BigInteger.fromByteArrayUnsigned(K.slice(1, 33)).mod(J);
    var M = BigInteger.fromByteArrayUnsigned(K.slice(33, 65)).mod(J);
    return {
      r: I,
      s: M,
      i: L
    }
  };
  if (F !== undefined) {
    if (F["curve"] !== undefined) {
      this.curveName = F["curve"]
    }
  }
  if (this.curveName === undefined) {
    this.curveName = D
  }
  this.setNamedCurve(this.curveName);
  if (F !== undefined) {
    if (F["prv"] !== undefined) {
      this.setPrivateKeyHex(F["prv"])
    }
    if (F["pub"] !== undefined) {
      this.setPublicKeyHex(F["pub"])
    }
  }
};
KJUR.crypto.ECParameterDB = new function () {
  var A = {};
  var B = {};

  function C(D) {
    return new BigInteger(D, 16)
  }
  this.getByName = function (D) {
    var E = D;
    if (typeof B[E] != "undefined") {
      E = B[D]
    }
    if (typeof A[E] != "undefined") {
      return A[E]
    }
    throw "unregistered EC curve name: " + E
  };
  this.regist = function (J, X, N, V, F, T, Q, W, O, M, E, R) {
    A[J] = {};
    var H = C(N);
    var L = C(V);
    var P = C(F);
    var K = C(T);
    var I = C(Q);
    var U = new ECCurveFp(H, L, P);
    var D = U.decodePointHex("04" + W + O);
    A[J]["name"] = J;
    A[J]["keylen"] = X;
    A[J]["curve"] = U;
    A[J]["G"] = D;
    A[J]["n"] = K;
    A[J]["h"] = I;
    A[J]["oid"] = E;
    A[J]["info"] = R;
    for (var S = 0; S < M.length; S += 1) {
      B[M[S]] = J
    }
  }
};
KJUR.crypto.ECParameterDB.regist("secp128r1", 128, "FFFFFFFDFFFFFFFFFFFFFFFFFFFFFFFF",
  "FFFFFFFDFFFFFFFFFFFFFFFFFFFFFFFC", "E87579C11079F43DD824993C2CEE5ED3", "FFFFFFFE0000000075A30D1B9038A115", "1",
  "161FF7528B899B2D0C28607CA52C5B86", "CF5AC8395BAFEB13C02DA292DDED7A83", [], "",
  "secp128r1 : SECG curve over a 128 bit prime field");
KJUR.crypto.ECParameterDB.regist("secp160k1", 160, "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFAC73", "0", "7",
  "0100000000000000000001B8FA16DFAB9ACA16B6B3", "1", "3B4C382CE37AA192A4019E763036F4F5DD4D7EBB",
  "938CF935318FDCED6BC28286531733C3F03C4FEE", [], "", "secp160k1 : SECG curve over a 160 bit prime field");
KJUR.crypto.ECParameterDB.regist("secp160r1", 160, "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFF",
  "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFC", "1C97BEFC54BD7A8B65ACF89F81D4D4ADC565FA45",
  "0100000000000000000001F4C8F927AED3CA752257", "1", "4A96B5688EF573284664698968C38BB913CBFC82",
  "23A628553168947D59DCC912042351377AC5FB32", [], "", "secp160r1 : SECG curve over a 160 bit prime field");
KJUR.crypto.ECParameterDB.regist("secp192k1", 192, "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFEE37", "0", "3",
  "FFFFFFFFFFFFFFFFFFFFFFFE26F2FC170F69466A74DEFD8D", "1", "DB4FF10EC057E9AE26B07D0280B7F4341DA5D1B1EAE06C7D",
  "9B2F2F6D9C5628A7844163D015BE86344082AA88D95E2F9D", []);
KJUR.crypto.ECParameterDB.regist("secp192r1", 192, "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFF",
  "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFC", "64210519E59C80E70FA7E9AB72243049FEB8DEECC146B9B1",
  "FFFFFFFFFFFFFFFFFFFFFFFF99DEF836146BC9B1B4D22831", "1", "188DA80EB03090F67CBF20EB43A18800F4FF0AFD82FF1012",
  "07192B95FFC8DA78631011ED6B24CDD573F977A11E794811", []);
KJUR.crypto.ECParameterDB.regist("secp224r1", 224, "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000001",
  "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFE",
  "B4050A850C04B3ABF54132565044B0B7D7BFD8BA270B39432355FFB4",
  "FFFFFFFFFFFFFFFFFFFFFFFFFFFF16A2E0B8F03E13DD29455C5C2A3D", "1",
  "B70E0CBD6BB4BF7F321390B94A03C1D356C21122343280D6115C1D21",
  "BD376388B5F723FB4C22DFE6CD4375A05A07476444D5819985007E34", []);
KJUR.crypto.ECParameterDB.regist("secp256k1", 256, "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F",
  "0", "7", "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141", "1",
  "79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798",
  "483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8", []);
KJUR.crypto.ECParameterDB.regist("secp256r1", 256, "FFFFFFFF00000001000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF",
  "FFFFFFFF00000001000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFC",
  "5AC635D8AA3A93E7B3EBBD55769886BC651D06B0CC53B0F63BCE3C3E27D2604B",
  "FFFFFFFF00000000FFFFFFFFFFFFFFFFBCE6FAADA7179E84F3B9CAC2FC632551", "1",
  "6B17D1F2E12C4247F8BCE6E563A440F277037D812DEB33A0F4A13945D898C296",
  "4FE342E2FE1A7F9B8EE7EB4A7C0F9E162BCE33576B315ECECBB6406837BF51F5", ["NIST P-256", "P-256", "prime256v1"]);
KJUR.crypto.ECParameterDB.regist("secp384r1", 384,
  "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFF0000000000000000FFFFFFFF",
  "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFF0000000000000000FFFFFFFC",
  "B3312FA7E23EE7E4988E056BE3F82D19181D9C6EFE8141120314088F5013875AC656398D8A2ED19D2A85C8EDD3EC2AEF",
  "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7634D81F4372DDF581A0DB248B0A77AECEC196ACCC52973", "1",
  "AA87CA22BE8B05378EB1C71EF320AD746E1D3B628BA79B9859F741E082542A385502F25DBF55296C3A545E3872760AB7",
  "3617de4a96262c6f5d9e98bf9292dc29f8f41dbd289a147ce9da3113b5f0b8c00a60b1ce1d7e819d7a431d7c90ea0e5f", [
    "NIST P-384", "P-384"
  ]);
KJUR.crypto.ECParameterDB.regist("secp521r1", 521,
  "1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
  "1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC",
  "051953EB9618E1C9A1F929A21A0B68540EEA2DA725B99B315F3B8B489918EF109E156193951EC7E937B1652C0BD3BB1BF073573DF883D2C34F1EF451FD46B503F00",
  "1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA51868783BF2F966B7FCC0148F709A5D03BB5C9B8899C47AEBB6FB71E91386409",
  "1",
  "C6858E06B70404E9CD9E3ECB662395B4429C648139053FB521F828AF606B4D3DBAA14B5E77EFE75928FE1DC127A2FFA8DE3348B3C1856A429BF97E7E31C2E5BD66",
  "011839296a789a3bc0045c8a5fb42c7d1bd998f54449579b446817afbd17273e662c97ee72995ef42640c550b9013fad0761353c7086a272c24088be94769fd16650",
  ["NIST P-521", "P-521"]);
KJUR.crypto.ECParameterDB.regist("sm2", 256, "FFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFF",
  "FFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFC",
  "28E9FA9E9D9F5E344D5A9E4BCF6509A7F39789F515AB8F92DDBCBD414D940E93",
  "FFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFF7203DF6B21C6052B53BBF40939D54123", "1",
  "32C4AE2C1F1981195F9904466A39C9948FE30BBFF2660BE1715A4589334C74C7",
  "BC3736A2F4F6779C59BDCEE36B692153D0A9877CC62A474002DF32E52139F0A0", ["sm2", "SM2"]);

function SM2Cipher(A) {
  this.ct = 1;
  this.p2 = null;
  this.sm3keybase = null;
  this.sm3c3 = null;
  this.key = new Array(32);
  this.keyOff = 0;
  if (typeof (A) != "undefined") {
    this.cipherMode = A
  } else {
    this.cipherMode = SM2CipherMode.C1C3C2
  }
}
SM2Cipher.prototype = {
  getHexString: function (A) {
    if ((A.length & 1) == 0) {
      return A
    } else {
      return "0" + A
    }
  },
  hex2Byte: function (A) {
    if (A > 127 || A < -128) {
      var B = 255 & A;
      if (B > 127) {
        B = 127 & A;
        B = 127 ^ B;
        return -(B + 1)
      }
      return B
    } else {
      return A
    }
  },
  Reset: function () {
    this.sm3keybase = new SM3Digest();
    this.sm3c3 = new SM3Digest();
    var B = this.p2.getX().toBigInteger().toRadix(16);
    var C = this.p2.getY().toBigInteger().toRadix(16);
    if (B.length != 64) {
      for (var F = 64 - B.length, E = 0; E < F; E++) {
        B = "0" + B
      }
    }
    if (C.length != 64 && C.length != 64) {
      F = 64 - C.length;
      for (E = 0; E < F; E++) {
        C = "0" + C
      }
    }
    var A = this.GetWords(B);
    var D = this.GetWords(C);
    this.sm3c3.BlockUpdate(A, 0, A.length);
    this.sm3keybase.BlockUpdate(A, 0, A.length);
    this.sm3keybase.BlockUpdate(D, 0, D.length);
    this.ct = 1;
    this.NextKey()
  },
  NextKey: function () {
    var A = new SM3Digest(this.sm3keybase);
    A.Update(this.ct >> 24 & 255);
    A.Update(this.ct >> 16 & 255);
    A.Update(this.ct >> 8 & 255);
    A.Update(this.ct & 255);
    A.DoFinal(this.key, 0);
    this.keyOff = 0;
    this.ct++
  },
  InitEncipher: function (E) {
    var F = null;
    var D = null;
    var A = new KJUR.crypto.ECDSA({
      "curve": "sm2"
    });
    var B = A.generateKeyPairHex();
    F = new BigInteger(B.ecprvhex, 16);
    var C = B.ecpubhex;
    D = ECPointFp.decodeFromHex(A.ecparams["curve"], C);
    this.p2 = E.multiply(F);
    this.Reset();
    return D
  },
  EncryptBlock: function (B) {
    this.sm3c3.BlockUpdate(B, 0, B.length);
    for (var A = 0; A < B.length; A++) {
      if (this.keyOff == this.key.length) {
        this.NextKey()
      }
      B[A] ^= this.key[this.keyOff++]
    }
  },
  InitDecipher: function (A, B) {
    this.p2 = B.multiply(A);
    this.Reset()
  },
  DecryptBlock: function (B) {
    for (var A = 0; A < B.length; A++) {
      if (this.keyOff == this.key.length) {
        this.NextKey()
      }
      B[A] ^= this.key[this.keyOff++]
    }
    this.sm3c3.BlockUpdate(B, 0, B.length)
  },
  Dofinal: function (A) {
    var B = this.p2.getY().toBigInteger().toRadix(16);
    if (B.length != 64 && B.length != 64) {
      var D = 64 - B.length;
      for (let c = 0; c < D; c++) {
        B = "0" + B
      }
    }
    var C = this.GetWords(B);
    this.sm3c3.BlockUpdate(C, 0, C.length);
    this.sm3c3.DoFinal(A, 0);
    this.Reset()
  },
  Encrypt: function (I, F) {
    var B = new Array(F.length);
    Array.Copy(F, 0, B, 0, F.length);
    var A = this.InitEncipher(I);
    this.EncryptBlock(B);
    var J = new Array(32);
    this.Dofinal(J);
    var G;
    var H = A.getX().toBigInteger().toRadix(16);
    var E = A.getY().toBigInteger().toRadix(16);
    if (H.length != 64) {
      for (var D = 64 - H.length, C = 0; C < D; C++) {
        H = "0" + H
      }
    }
    if (E.length != 64 && E.length != 64) {
      D = 64 - E.length;
      for (C = 0; C < D; C++) {
        E = "0" + E
      }
    }
    switch (this.cipherMode) {
      case SM2CipherMode.C1C3C2:
        G = H + E + this.GetHex(J).toString() + this.GetHex(B).toString();
        break;
      case SM2CipherMode.C1C2C3:
        G = A.getX().toBigInteger().toRadix(16) + A.getY().toBigInteger().toRadix(16) + this.GetHex(B).toString() +
        this.GetHex(J).toString();
        break;
      default:
        throw new Error("[SM2:Decrypt]invalid type cipherMode(" + this.cipherMode + ")")
    }
    return G
  },
  GetWords: function (A) {
    var B = [];
    var C = A.length;
    for (var D = 0; D < C; D += 2) {
      B[B.length] = parseInt(A.substr(D, 2), 16)
    }
    return B
  },
  GetHex: function (A) {
    var C = new Array(32);
    var E = 0;
    for (var D = 0; D < A.length * 2; D += 2) {
      C[D >>> 3] |= parseInt(A[E]) << (24 - (D % 8) * 4);
      E++
    }
    var B = new CryptoJS.lib.WordArray.init(C, A.length);
    return B
  },
  Decrypt: function (M, E) {
    var K = E;
    var L = K.substr(0, 64);
    var I = K.substr(0 + L.length, 64);
    var J;
    var N;
    var C = new KJUR.crypto.ECDSA({
      "curve": "sm2"
    });
    var H = C.ecparams["n"];
    if (M.compareTo(H.subtract(BigInteger.ONE)) > 0) {
      return undefined
    }
    if (M.compareTo(BigInteger.ONE) < 0) {
      return undefined
    }
    switch (this.cipherMode) {
      case SM2CipherMode.C1C3C2:
        N = K.substr(L.length + I.length, 64);
        encrypData = K.substr(L.length + I.length + 64);
        break;
      case SM2CipherMode.C1C2C3:
        encrypData = K.substr(L.length + I.length, K.length - L.length - I.length - 64);
        N = K.substr(K.length - 64);
        break;
      default:
        throw new Error("[SM2:Decrypt]invalid type cipherMode(" + this.cipherMode + ")")
    }
    var G = this.GetWords(encrypData);
    var A = this.CreatePoint(L, I);
    if (A == undefined) {
      return undefined
    }
    this.InitDecipher(M, A);
    this.DecryptBlock(G);
    var O = new Array(32);
    this.Dofinal(O);
    var D = ((this.GetHex(O).toString().toLowerCase()) == (N.toLowerCase()));
    if (D) {
      var B = this.GetHex(G);
      var F = CryptoJS.enc.Utf8.stringify(B);
      return F
    } else {
      throw new Error("[SM2:Decrypt] C3 is not match!");
      return ""
    }
  },
  CreatePoint: function (B, C) {
    var A = new KJUR.crypto.ECDSA({
      "curve": "sm2"
    });
    var D = A.ecparams["curve"];
    var E = "04" + B + C;
    var F = ECPointFp.decodeFromHex(A.ecparams["curve"], E);
    if (F.isOnCurve() == 0) {
      return undefined
    }
    return F
  }
};
window.SM2CipherMode = {
  C1C2C3: 0,
  C1C3C2: 1
};

function SG_sm2Encrypt(E, A) {
  if (E == undefined || A == undefined) {
    return undefined
  }
  if (E == "" || A == "") {
    return undefined
  }
  if (A.length != 130) {
    return undefined
  }
  var F = CryptoJS.enc.Utf8.parse(E);
  var H = A;
  var D = H.substr(0, 2);
  if (D != "04") {
    return undefined
  }
  if (H.length > 64 * 2) {
    H = H.substr(H.length - 64 * 2)
  }
  var I = H.substr(0, 64);
  var J = H.substr(64);
  var C = new SM2Cipher(1);
  var B = C.CreatePoint(I, J);
  if (B == undefined) {
    return undefined
  }
  F = C.GetWords(F.toString());
  var G = C.Encrypt(B, F);
  return "04" + G
}

function SG_sm2Decrypt(F, E) {
  if (F == undefined || E == undefined) {
    return undefined
  }
  if (F == "" || E == "") {
    return undefined
  }
  if (E.length != 64) {
    return undefined
  }
  if (F.length <= 194) {
    return undefined
  }
  var B = F.substr(0, 2);
  if (B != "04") {
    return undefined
  }
  F = F.substr(2);
  var D = new BigInteger(E, 16);
  var A = new SM2Cipher(1);
  var C = A.Decrypt(D, F);
  return C
}

function SG_sm3encrypt(E) {
  if (E == undefined) {
    return undefined
  }
  if (E == "") {
    return undefined
  }
  var B = CryptoJS.enc.Utf8.parse(E);
  var C = new SM3Digest();
  B = C.GetWords(B.toString());
  C.BlockUpdate(B, 0, B.length);
  var A = new Array(32);
  C.DoFinal(A, 0);
  var D = C.GetHex(A).toString();
  return D
}

function SG_sm2generateKeyPair() {
  var A = new KJUR.crypto.ECDSA({
    "curve": "SM2"
  });
  return A.generateKeyPairHex()
};
function generateSM4Key() {
  var R = new SecureRandom();
  var A = new Array(16);
  R.nextBytes(A);
  var D = new SM3Digest().GetHex(A);
  return D.toString()
};
export {
  SG_sm2Decrypt,
  SG_sm2Encrypt,
  SG_sm4decrypt,
  SG_sm4encrypt,
  SG_sm3encrypt,
  generateSM4Key
};

}