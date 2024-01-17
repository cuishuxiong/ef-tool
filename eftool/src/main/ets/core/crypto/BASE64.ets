/**
 * @Author csx
 * @DateTime 2024/1/17 14:00:01
 * @TODO BASE64
 */
export class BASE64 {

  /**
   * 加密
   * @param text  待加密字符串
   * @returns  加密后字符串
   */
  static encode(text: string): string {
    const base64Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    let encodedData = '';
    for (let i = 0; i < text.length; i += 3) {
      const char1 = text.charCodeAt(i);
      const char2 = text.charCodeAt(i + 1);
      const char3 = text.charCodeAt(i + 2);
      const enc1 = char1 >> 2;
      const enc2 = ((char1 & 3) << 4) | (char2 >> 4);
      const enc3 = ((char2 & 15) << 2) | (char3 >> 6);
      const enc4 = char3 & 63;
      encodedData += `${base64Chars.charAt(enc1)}${base64Chars.charAt(enc2)}${base64Chars.charAt(enc3)}${base64Chars.charAt(enc4)}`;
    }
    return encodedData;
  }

  /**
   * 解密
   * @param encodedData  待解密字符串
   * @returns   解密后字符串
   */
  static decode(encodedData: string): string {
    const base64Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    let text = '';
    for (let i = 0; i < encodedData.length; i += 4) {
      const enc1 = base64Chars.indexOf(encodedData.charAt(i));
      const enc2 = base64Chars.indexOf(encodedData.charAt(i + 1));
      const enc3 = base64Chars.indexOf(encodedData.charAt(i + 2));
      const enc4 = base64Chars.indexOf(encodedData.charAt(i + 3));
      const char1 = (enc1 << 2) | (enc2 >> 4);
      const char2 = ((enc2 & 15) << 4) | (enc3 >> 2);
      const char3 = ((enc3 & 3) << 6) | enc4;
      text += String.fromCharCode(char1);
      if (enc3 !== 64) {
        text += String.fromCharCode(char2);
      }
      if (enc4 !== 64) {
        text += String.fromCharCode(char3);
      }
    }
    return text;
  }

}