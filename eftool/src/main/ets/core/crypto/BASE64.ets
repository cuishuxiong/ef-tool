/**
 * @Author csx
 * @DateTime 2024/1/17 14:00:01
 * @TODO BASE64
 */
export class BASE64 {
  private lookup = []
  private revLookup = []
  private Arr = Uint8Array
  private code = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  private static base64: BASE64;

  /**
   * 构造
   */
  constructor() {
    for (let i = 0, len = this.code.length; i < len; ++i) {
      this.lookup[i] = this.code[i]
      this.revLookup[this.code.charCodeAt(i)] = i
    }
    this.revLookup['-'.charCodeAt(0)] = 62
    this.revLookup['_'.charCodeAt(0)] = 63
  }

  /**
   * 创建一个BASE64实例化对象
   * @returns
   */
  static create() {
    if (!this.base64) {
      this.base64 = new BASE64();
    }
    return this.base64;
  }


  private getLens(b64) {
    let len = b64.length

    if (len % 4 > 0) {
      throw new Error('Invalid string. Length must be a multiple of 4')
    }

    let validLen = b64.indexOf('=')
    if (validLen === -1) validLen = len

    let placeHoldersLen = validLen === len
      ? 0
      : 4 - (validLen % 4)

    return [validLen, placeHoldersLen]
  }

  /**
   * 获取字节长度
   * @param b64
   * @returns
   */
  public byteLength(b64) {
    let lens = this.getLens(b64)
    let validLen = lens[0]
    let placeHoldersLen = lens[1]
    return ((validLen + placeHoldersLen) * 3 / 4) - placeHoldersLen
  }

  private _byteLength(b64, validLen, placeHoldersLen) {
    return ((validLen + placeHoldersLen) * 3 / 4) - placeHoldersLen
  }

  /**
   * 将字符串转换为byte
   * @param b64  字符串
   * @returns byte数组
   */
  public toByteArray(b64) {
    let tmp
    let lens = this.getLens(b64)
    let validLen = lens[0]
    let placeHoldersLen = lens[1]


    let arr = new this.Arr(this._byteLength(b64, validLen, placeHoldersLen))

    let curByte = 0

    // if there are placeholders, only get up to the last complete 4 chars
    let len = placeHoldersLen > 0
      ? validLen - 4
      : validLen

    let i
    for (i = 0; i < len; i += 4) {
      tmp =
      (this.revLookup[b64.charCodeAt(i)] << 18) |
      (this.revLookup[b64.charCodeAt(i + 1)] << 12) |
      (this.revLookup[b64.charCodeAt(i + 2)] << 6) |
      this.revLookup[b64.charCodeAt(i + 3)]
      arr[curByte++] = (tmp >> 16) & 0xFF
      arr[curByte++] = (tmp >> 8) & 0xFF
      arr[curByte++] = tmp & 0xFF
    }

    if (placeHoldersLen === 2) {
      tmp =
      (this.revLookup[b64.charCodeAt(i)] << 2) |
      (this.revLookup[b64.charCodeAt(i + 1)] >> 4)
      arr[curByte++] = tmp & 0xFF
    }

    if (placeHoldersLen === 1) {
      tmp =
      (this.revLookup[b64.charCodeAt(i)] << 10) |
      (this.revLookup[b64.charCodeAt(i + 1)] << 4) |
      (this.revLookup[b64.charCodeAt(i + 2)] >> 2)
      arr[curByte++] = (tmp >> 8) & 0xFF
      arr[curByte++] = tmp & 0xFF
    }

    return arr
  }

  private tripletToBase64(num) {
    return this.lookup[num >> 18 & 0x3F] +
    this.lookup[num >> 12 & 0x3F] +
    this.lookup[num >> 6 & 0x3F] +
    this.lookup[num & 0x3F]
  }

  private encodeChunk(uint8, start, end) {
    let tmp
    let output = []
    for (let i = start; i < end; i += 3) {
      tmp =
      ((uint8[i] << 16) & 0xFF0000) +
      ((uint8[i + 1] << 8) & 0xFF00) +
      (uint8[i + 2] & 0xFF)
      output.push(this.tripletToBase64(tmp))
    }
    return output.join('')
  }

  /**
   * 将byte数组转换为字符串
   * @param uint8 byte数组
   * @returns 字符串
   */
  public fromByteArray(uint8) {
    let tmp
    let len = uint8.length
    let extraBytes = len % 3 // if we have 1 byte left, pad 2 bytes
    let parts = []
    let maxChunkLength = 16383 // must be multiple of 3

    // go through the array every three bytes, we'll deal with trailing stuff later
    for (let i = 0, len2 = len - extraBytes; i < len2; i += maxChunkLength) {
      parts.push(this.encodeChunk(uint8, i, (i + maxChunkLength) > len2 ? len2 : (i + maxChunkLength)))
    }

    // pad the end with zeros, but make sure to not forget the extra bytes
    if (extraBytes === 1) {
      tmp = uint8[len - 1]
      parts.push(
        this.lookup[tmp >> 2] +
        this.lookup[(tmp << 4) & 0x3F] +
        '=='
      )
    } else if (extraBytes === 2) {
      tmp = (uint8[len - 2] << 8) + uint8[len - 1]
      parts.push(
        this.lookup[tmp >> 10] +
        this.lookup[(tmp >> 4) & 0x3F] +
        this.lookup[(tmp << 2) & 0x3F] +
        '='
      )
    }

    return parts.join('')
  }
}