/**
 * @Author csx
 * @DateTime 2023/12/29 21:04
 * @TODO CharUtil  字符工具类
 */
export class CharUtil {

  /**
   * 是否空白符 空白符包括空格、制表符、全角空格和不间断空格
   * @param c
   * @returns
   */
  static isBlankChar(c: number): boolean {
    return CharUtil.isWhitespace(c)
    || CharUtil.isSpaceChar(c)
    || c == 0xFEFF
    || c == 0x202A
    || c == 0x0000;
  }

  private  static isWhitespace(codePoint: number): boolean {
    const whitespaceRegex = /^\s$/;
    const character = String.fromCodePoint(codePoint);
    return whitespaceRegex.test(character);
  }

  private static isSpaceChar(codePoint: number): boolean {
    const spaceCategories = [
      "Zs", // Space separator
      "Zl", // Line separator
      "Zp" // Paragraph separator
    ];

    const character = String.fromCodePoint(codePoint);
    const category = character.charCodeAt(0).toString(16);
    return spaceCategories.includes(category);
  }
}