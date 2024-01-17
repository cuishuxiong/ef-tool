/**
 * @Author csx
 * @DateTime 2024/1/17 14:23:01
 * @TODO MD5  MD5工具类
 */
export class MD5 {
  private static rotateLeft(value: number, shift: number): number {
    return (value << shift) | (value >>> (32 - shift));
  }

  private static convertToWordArray(str: string): number[] {
    const length32 = str.length / 4;
    const length8 = str.length;
    const result: number[] = new Array(length32);

    for (let i = 0; i < length32; i++) {
      result[i] = 0;
      for (let j = 0; j < 4; j++) {
        result[i] |= (str.charCodeAt(i * 4 + j) & 255) << (j * 8);
      }
    }

    return result;
  }

  private static utf8Encode(str: string): string {
    let result = "";

    for (let i = 0; i < str.length; i++) {
      const charCode = str.charCodeAt(i);

      if (charCode < 128) {
        result += String.fromCharCode(charCode);
      } else if (charCode < 2048) {
        result += String.fromCharCode((charCode >> 6) | 192);
        result += String.fromCharCode((charCode & 63) | 128);
      } else {
        result += String.fromCharCode((charCode >> 12) | 224);
        result += String.fromCharCode(((charCode >> 6) & 63) | 128);
        result += String.fromCharCode((charCode & 63) | 128);
      }
    }

    return result;
  }

  private static md5HexDigest(value: string): string {
    const wordArray = this.convertToWordArray(this.utf8Encode(value));
    const originalLength = value.length * 8;
    const appendOneBit = 1 << 7;
    const appendLengthBits = originalLength;

    wordArray.push(appendOneBit);

    const appendZeros = (512 + (448 - ((originalLength + 8) % 512))) % 512;
    const appendedLength = originalLength + appendZeros + 64;

    const appendedLengthLow = appendedLength & 4294967295;
    const appendedLengthHigh = (appendedLength / Math.pow(2, 32)) & 4294967295;

    wordArray.push(appendedLengthLow);
    wordArray.push(appendedLengthHigh);

    let a = 1732584193;
    let b = -271733879;
    let c = -1732584194;
    let d = 271733878;

    for (let i = 0; i < wordArray.length; i += 16) {
      const aBackup = a;
      const bBackup = b;
      const cBackup = c;
      const dBackup = d;

      for (let j = 0; j < 64; j++) {
        let f: number;
        let g: number;

        if (j < 16) {
          f = (b & c) | (~b & d);
          g = j;
        } else if (j < 32) {
          f = (d & b) | (~d & c);
          g = (5 * j + 1) % 16;
        } else if (j < 48) {
          f = b ^ c ^ d;
          g = (3 * j + 5) % 16;
        } else {
          f = c ^ (b | ~d);
          g = (7 * j) % 16;
        }

        const temp = d;
        d = c;
        c = b;
        b = b + this.rotateLeft(a + f + wordArray[i + g] + 1732584193, [7, 12, 17, 22][j % 4]);
        a = temp;
      }

      a = a + aBackup;
      b = b + bBackup;
      c = c + cBackup;
      d = d + dBackup;
    }

    return this.toHex(a) + this.toHex(b) + this.toHex(c) + this.toHex(d);
  }

  private static toHex(value: number): string {
    let result = "";

    for (let i = 0; i < 4; i++) {
      const hexValue = (value >>> (i * 8)) & 255;
      const hexString = hexValue.toString(16);

      result += hexString.length === 1 ? "0" + hexString : hexString;
    }

    return result;
  }

  /**
   * 生成MD5哈希值
   * @param value
   * @returns
   */
  public static encrypt(value: string): string {
    return this.md5HexDigest(value);
  }
}