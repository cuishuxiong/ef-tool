/**
 Copyright 2024 csx - @yunkss/ef_crypto

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */


import { CryptoSyncUtil } from '../util/CryptoSyncUtil';
import { buffer } from '@kit.ArkTS';

/**
 * @Author csx
 * @DateTime 2024/3/20 21:43
 * @TODO MD5  工具类 源码来自官方库  https://ohpm.openharmony.cn/#/cn/detail/@ohos%2Fchecksum
 * @Use 详细使用方法以及文档详见ohpm官网,地址https://ohpm.openharmony.cn/#/cn/detail/@yunkss%2Fef_crypto
 */
export class MD5 {
  hexcase = 0;
  b64pad = "";

  /**
   * MD5摘要
   * @param str 带摘要的字符串
   * @param resultCoding  返回结果编码方式(hex/base64)-不传默认为base64
   * @returns 摘要后的字符串
   */
  static digest(str: string, resultCoding: buffer.BufferEncoding = 'base64'): string {
    return CryptoSyncUtil.digest(str, 'MD5', resultCoding);
  }

  /**
   * 散列哈希算法
   * @param value 待处理字符
   * @param enCoding 编码格式hex/base64
   * @returns
   */
  static hash(value: string, enCoding?: string): string {
    let md = new MD5();
    if (enCoding && enCoding == 'base64') {
      let md5 = md.b64_md5(value);
      if (!md5.endsWith('==')) {
        md5 += '==';
      }
      return md5;
    }
    return md.hex_md5(value);
  }

  /**
   * hmac
   * @param key 秘钥
   * @param data  待处理字符串
   * @param enCoding 编码格式hex/base64
   * @returns
   */
  static hmac(key: string, data: string, enCoding?: string): string {
    let md = new MD5();
    if (enCoding && enCoding == 'base64') {
      let md5 = md.b64_hmac_md5(key, data);
      if (!md5.endsWith('==')) {
        md5 += '==';
      }
      return md5;
    }
    return md.hex_hmac_md5(key, data);
  }


  /*
* These are the functions you'll usually want to call
* They take string arguments and return either hex or base-64 encoded strings
*/
  hex_md5(s: string): string {
    return this.rstr2hex(this.rstr_md5(this.str2rstr_utf8(s)));
  }

  b64_md5(s: string): string {
    return this.rstr2b64(this.rstr_md5(this.str2rstr_utf8(s)));
  }

  hex_hmac_md5(k: string, d: string): string {
    return this.rstr2hex(this.rstr_hmac_md5(this.str2rstr_utf8(k), this.str2rstr_utf8(d)));
  }

  b64_hmac_md5(k: string, d: string): string {
    return this.rstr2b64(this.rstr_hmac_md5(this.str2rstr_utf8(k), this.str2rstr_utf8(d)));
  }


  /*
* Calculate the HMAC-MD5, of a key and some data (raw strings)
*/
  rstr_hmac_md5(key: string, data: string): string {
    let bkey: number[] = this.rstr2binl(key);
    if (bkey.length > 16) {
      bkey = this.binl_md5(bkey, key.length * 8);
    }

    let ipad: number[] = Array(16), opad: number[] = Array(16);
    for (let i = 0; i < 16; i++) {
      ipad[i] = bkey[i] ^ 0x36363636;
      opad[i] = bkey[i] ^ 0x5C5C5C5C;
    }

    let hash = this.binl_md5(ipad.concat(this.rstr2binl(data)), 512 + data.length * 8);
    return this.binl2rstr(this.binl_md5(opad.concat(hash), 512 + 128));
  }

  /*
* Calculate the MD5 of a raw string
*/
  rstr_md5(s: string): string {
    return this.binl2rstr(this.binl_md5(this.rstr2binl(s), s.length * 8));
  }

  /*
* Convert a raw string to a hex string
*/
  rstr2hex(input: string): string {
    try {
      this.hexcase
    } catch (e) {
      this.hexcase = 0;
    }
    let hex_tab = this.hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
    let output = "";
    let x: number;
    for (let i = 0; i < input.length; i++) {
      x = input.charCodeAt(i);
      output += hex_tab.charAt((x >> 4) & 0x0F)
        + hex_tab.charAt(x & 0x0F);
    }
    return output;
  }

  /*
* Convert a raw string to a base-64 string
*/
  rstr2b64(input: string): string {
    try {
      this.b64pad
    } catch (e) {
      this.b64pad = '';
    }
    let tab = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    let output = "";
    let len: number = input.length;
    for (let i = 0; i < len; i += 3) {
      let triplet = (input.charCodeAt(i) << 16)
        | (i + 1 < len ? input.charCodeAt(i + 1) << 8 : 0)
        | (i + 2 < len ? input.charCodeAt(i + 2) : 0);
      for (let j = 0; j < 4; j++) {
        if (i * 8 + j * 6 > input.length * 8) {
          output += this.b64pad;
        } else {
          output += tab.charAt((triplet >>
            6 * (3 - j)) & 0x3F);
        }
      }
    }
    return output;
  }

  /*
* Encode a string as utf-8.
* For efficiency, this assumes the input is valid utf-16.
*/
  str2rstr_utf8(input: string): string {
    let output = "";
    let i = -1;
    let x: number, y: number;

    while (++i < input.length) {
      /* Decode utf-16 surrogate pairs */
      x = input.charCodeAt(i);
      y = i + 1 < input.length ? input.charCodeAt(i + 1) : 0;
      if (0xD800 <= x && x <= 0xDBFF && 0xDC00 <= y && y <= 0xDFFF) {
        x = 0x10000 + ((x & 0x03FF) << 10) + (y & 0x03FF);
        i++;
      }

      /* Encode output as utf-8 */
      if (x <= 0x7F) {
        output += String.fromCharCode(x);
      } else if (x <= 0x7FF) {
        output += String.fromCharCode(0xC0 | ((x >> 6) & 0x1F),
          0x80 | (x & 0x3F));
      } else if (x <= 0xFFFF) {
        output += String.fromCharCode(0xE0 | ((x >> 12) & 0x0F),
          0x80 | ((x >> 6) & 0x3F),
          0x80 | (x & 0x3F));
      } else if (x <= 0x1FFFFF) {
        output += String.fromCharCode(0xF0 | ((x >> 18) & 0x07),
          0x80 | ((x >> 12) & 0x3F),
          0x80 | ((x >> 6) & 0x3F),
          0x80 | (x & 0x3F));
      }
    }
    return output;
  }

  /*
* Encode a string as utf-16
*/
  str2rstr_utf16le(input: string): string {
    let output = "";
    for (let i = 0; i < input.length; i++) {
      output += String.fromCharCode(input.charCodeAt(i) & 0xFF,
        (input.charCodeAt(i) >> 8) & 0xFF);
    }
    return output;
  }

  str2rstr_utf16be(input: string): string {
    let output = "";
    for (let i = 0; i < input.length; i++) {
      output += String.fromCharCode((input.charCodeAt(i) >> 8) & 0xFF,
        input.charCodeAt(i) & 0xFF);
    }
    return output;
  }

  /*
* Convert a raw string to an array of little-endian words
* Characters >255 have their high-byte silently ignored.
*/
  // rstr2binl(input: string): number[] {
  //   let output: number[] = Array(input.length > 2);
  //   for (let i = 0; i < output.length; i++) {
  //     output[i] = 0;
  //   }
  //   for (let i = 0; i < input.length * 8; i += 8) {
  //     output[i>5] |= (input.charCodeAt(i / 8) & 0xFF) << (i % 32);
  //   }
  //   return output;
  // }

  rstr2binl(input: string): number[] {
    // 初始化 output 数组
    let output: number[] = new Array(Math.ceil(input.length / 4)).fill(0);

    for (let i = 0; i < input.length * 8; i += 8) {
      // 计算索引和位移
      const index = Math.floor(i / 32);
      const bitPosition = i % 32;

      // 更新 output 数组
      output[index] |= (input.charCodeAt(Math.floor(i / 8)) & 0xFF) << bitPosition;
    }

    return output;
  }

  /*
* Convert an array of little-endian words to a string
*/
  // binl2rstr(input: number[]): string {
  //   let output = "";
  //   for (let i = 0; i < input.length * 32; i += 8) {
  //     output += String.fromCharCode((input[i>5] >> (i % 32)) & 0xFF);
  //   }
  //   return output;
  // }

  binl2rstr(input: number[]): string {
    let output = "";
    for (let i = 0; i < input.length * 32; i += 8) {
      // 计算在 input 数组中的索引
      const index = Math.floor(i / 32);
      // 计算位移
      const bitPosition = i % 32;
      // 提取字符
      const charCode = (input[index] >> bitPosition) & 0xFF;
      output += String.fromCharCode(charCode);
    }
    return output;
  }

  /*
* Calculate the MD5 of an array of little-endian words, and a bit length.
*/
  binl_md5(x: number[], len: number): number[] {

    /* append padding */
    const index = Math.floor(len / 32); // 根据需要计算索引
    const bitPosition = len % 32; // 计算位移
    x[index] |= 0x80 << bitPosition;


    // x[len > 5] |= 0x80 << ((len) % 32);
    x[(((len + 64) >> 9) << 4) + 14] = len;

    let a = 1732584193;
    let b = -271733879;
    let c = -1732584194;
    let d = 271733878;

    for (let i = 0; i < x.length; i += 16) {
      let olda = a;
      let oldb = b;
      let oldc = c;
      let oldd = d;

      a = this.md5_ff(a, b, c, d, x[i+ 0], 7, -680876936);
      d = this.md5_ff(d, a, b, c, x[i+ 1], 12, -389564586);
      c = this.md5_ff(c, d, a, b, x[i+ 2], 17, 606105819);
      b = this.md5_ff(b, c, d, a, x[i+ 3], 22, -1044525330);
      a = this.md5_ff(a, b, c, d, x[i+ 4], 7, -176418897);
      d = this.md5_ff(d, a, b, c, x[i+ 5], 12, 1200080426);
      c = this.md5_ff(c, d, a, b, x[i+ 6], 17, -1473231341);
      b = this.md5_ff(b, c, d, a, x[i+ 7], 22, -45705983);
      a = this.md5_ff(a, b, c, d, x[i+ 8], 7, 1770035416);
      d = this.md5_ff(d, a, b, c, x[i+ 9], 12, -1958414417);
      c = this.md5_ff(c, d, a, b, x[i+10], 17, -42063);
      b = this.md5_ff(b, c, d, a, x[i+11], 22, -1990404162);
      a = this.md5_ff(a, b, c, d, x[i+12], 7, 1804603682);
      d = this.md5_ff(d, a, b, c, x[i+13], 12, -40341101);
      c = this.md5_ff(c, d, a, b, x[i+14], 17, -1502002290);
      b = this.md5_ff(b, c, d, a, x[i+15], 22, 1236535329);

      a = this.md5_gg(a, b, c, d, x[i+ 1], 5, -165796510);
      d = this.md5_gg(d, a, b, c, x[i+ 6], 9, -1069501632);
      c = this.md5_gg(c, d, a, b, x[i+11], 14, 643717713);
      b = this.md5_gg(b, c, d, a, x[i+ 0], 20, -373897302);
      a = this.md5_gg(a, b, c, d, x[i+ 5], 5, -701558691);
      d = this.md5_gg(d, a, b, c, x[i+10], 9, 38016083);
      c = this.md5_gg(c, d, a, b, x[i+15], 14, -660478335);
      b = this.md5_gg(b, c, d, a, x[i+ 4], 20, -405537848);
      a = this.md5_gg(a, b, c, d, x[i+ 9], 5, 568446438);
      d = this.md5_gg(d, a, b, c, x[i+14], 9, -1019803690);
      c = this.md5_gg(c, d, a, b, x[i+ 3], 14, -187363961);
      b = this.md5_gg(b, c, d, a, x[i+ 8], 20, 1163531501);
      a = this.md5_gg(a, b, c, d, x[i+13], 5, -1444681467);
      d = this.md5_gg(d, a, b, c, x[i+ 2], 9, -51403784);
      c = this.md5_gg(c, d, a, b, x[i+ 7], 14, 1735328473);
      b = this.md5_gg(b, c, d, a, x[i+12], 20, -1926607734);

      a = this.md5_hh(a, b, c, d, x[i+ 5], 4, -378558);
      d = this.md5_hh(d, a, b, c, x[i+ 8], 11, -2022574463);
      c = this.md5_hh(c, d, a, b, x[i+11], 16, 1839030562);
      b = this.md5_hh(b, c, d, a, x[i+14], 23, -35309556);
      a = this.md5_hh(a, b, c, d, x[i+ 1], 4, -1530992060);
      d = this.md5_hh(d, a, b, c, x[i+ 4], 11, 1272893353);
      c = this.md5_hh(c, d, a, b, x[i+ 7], 16, -155497632);
      b = this.md5_hh(b, c, d, a, x[i+10], 23, -1094730640);
      a = this.md5_hh(a, b, c, d, x[i+13], 4, 681279174);
      d = this.md5_hh(d, a, b, c, x[i+ 0], 11, -358537222);
      c = this.md5_hh(c, d, a, b, x[i+ 3], 16, -722521979);
      b = this.md5_hh(b, c, d, a, x[i+ 6], 23, 76029189);
      a = this.md5_hh(a, b, c, d, x[i+ 9], 4, -640364487);
      d = this.md5_hh(d, a, b, c, x[i+12], 11, -421815835);
      c = this.md5_hh(c, d, a, b, x[i+15], 16, 530742520);
      b = this.md5_hh(b, c, d, a, x[i+ 2], 23, -995338651);

      a = this.md5_ii(a, b, c, d, x[i+ 0], 6, -198630844);
      d = this.md5_ii(d, a, b, c, x[i+ 7], 10, 1126891415);
      c = this.md5_ii(c, d, a, b, x[i+14], 15, -1416354905);
      b = this.md5_ii(b, c, d, a, x[i+ 5], 21, -57434055);
      a = this.md5_ii(a, b, c, d, x[i+12], 6, 1700485571);
      d = this.md5_ii(d, a, b, c, x[i+ 3], 10, -1894986606);
      c = this.md5_ii(c, d, a, b, x[i+10], 15, -1051523);
      b = this.md5_ii(b, c, d, a, x[i+ 1], 21, -2054922799);
      a = this.md5_ii(a, b, c, d, x[i+ 8], 6, 1873313359);
      d = this.md5_ii(d, a, b, c, x[i+15], 10, -30611744);
      c = this.md5_ii(c, d, a, b, x[i+ 6], 15, -1560198380);
      b = this.md5_ii(b, c, d, a, x[i+13], 21, 1309151649);
      a = this.md5_ii(a, b, c, d, x[i+ 4], 6, -145523070);
      d = this.md5_ii(d, a, b, c, x[i+11], 10, -1120210379);
      c = this.md5_ii(c, d, a, b, x[i+ 2], 15, 718787259);
      b = this.md5_ii(b, c, d, a, x[i+ 9], 21, -343485551);

      a = this.safe_add(a, olda);
      b = this.safe_add(b, oldb);
      c = this.safe_add(c, oldc);
      d = this.safe_add(d, oldd);
    }
    return Array(a, b, c, d);
  }

  /*
* These functions implement the four basic operations the algorithm uses.
*/
  md5_cmn(q: number, a: number, b: number, x: number, s: number, t: number): number {
    return this.safe_add(this.bit_rol(this.safe_add(this.safe_add(a, q), this.safe_add(x, t)), s), b);
  }

  md5_ff(a: number, b: number, c: number, d: number, x: number, s: number, t: number): number {
    return this.md5_cmn((b & c) | ((~b) & d), a, b, x, s, t);
  }

  md5_gg(a: number, b: number, c: number, d: number, x: number, s: number, t: number): number {
    return this.md5_cmn((b & d) | (c & (~d)), a, b, x, s, t);
  }

  md5_hh(a: number, b: number, c: number, d: number, x: number, s: number, t: number): number {
    return this.md5_cmn(b ^ c ^ d, a, b, x, s, t);
  }

  md5_ii(a: number, b: number, c: number, d: number, x: number, s: number, t: number): number {
    return this.md5_cmn(c ^ (b | (~d)), a, b, x, s, t);
  }

  /*
* Add integers, wrapping at 2^32. This uses 16-bit operations internally
* to work around bugs in some JS interpreters.
*/
  // safe_add(x: number, y: number): number {
  //   let lsw = (x & 0xFFFF) + (y & 0xFFFF);
  //   let msw = (x > 16) + (y > 16) + (lsw > 16);
  //   return (msw << 16) | (lsw & 0xFFFF);
  // }
  safe_add(x: number, y: number): number {
    let lsw = (x & 0xFFFF) + (y & 0xFFFF); // 计算低16位的和
    let msw = (x >>> 16) + (y >>> 16) + (lsw >>> 16); // 计算高16位的和，注意用无符号右移运算符
    return (msw << 16) | (lsw & 0xFFFF); // 组合高16位和低16位
  }

  /*
* Bitwise rotate a 32-bit number to the left.
*/
  bit_rol(num: number, cnt: number): number {
    return (num << cnt) | (num >> (32 - cnt));
  }
}