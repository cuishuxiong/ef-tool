/**
 * @Author csx
 * @DateTime 2024/1/17 14:46:01
 * @TODO RSA
 */
export class RSA {
  private static modExp(base: number, exponent: number, modulus: number): number {
    if (modulus === 1) return 0;
    let result = 1;
    base = base % modulus;
    while (exponent > 0) {
      if (exponent % 2 === 1) {
        result = (result * base) % modulus;
      }
      exponent = exponent >> 1;
      base = (base * base) % modulus;
    }
    return result;
  }

  private static stringToAsciiArray(message: string): number[] {
    const asciiArray: number[] = [];
    for (let i = 0; i < message.length; i++) {
      asciiArray.push(message.charCodeAt(i));
    }
    return asciiArray;
  }

  private static asciiArrayToString(array: number[]): string {
    let result: string = '';
    for (let i = 0; i < array.length; i++) {
      result += String.fromCharCode(array[i]);
    }
    return result;
  }

  private static isPrime(num: number): boolean {
    if (num <= 1) return false;
    if (num <= 3) return true;
    if (num % 2 === 0 || num % 3 === 0) return false;
    let i = 5;
    while (i * i <= num) {
      if (num % i === 0 || num % (i + 2) === 0) return false;
      i += 6;
    }
    return true;
  }

  private static gcd(a: number, b: number): number {
    if (b === 0) return a;
    return this.gcd(b, a % b);
  }

  private static modInverse(a: number, m: number): number {
    for (let x = 1; x < m; x++) {
      if ((a * x) % m === 1) return x;
    }
    return 1;
  }

  public static generateKeyPair(bitLength: number): {
    publicKey: PublicKey;
    privateKey: PrivateKey
  } {
    let p = 0, q = 0, n = 0, phi = 0, e = 0, d = 0;

    // 选择两个大素数 p 和 q
    do {
      p = 2 * Math.floor(Math.random() * 100) + 1;
    } while (!this.isPrime(p));

    do {
      q = 2 * Math.floor(Math.random() * 100) + 1;
    } while (!this.isPrime(q));

    // 计算 n 和 phi
    n = p * q;
    phi = (p - 1) * (q - 1);

    // 选择 e，使得 1 < e < phi 且 e 与 phi 互质
    do {
      e = 2 * Math.floor(Math.random() * phi - 2) + 1;
    } while (this.gcd(e, phi) !== 1);

    // 计算 d，使得 e * d ≡ 1 (mod phi)
    d = this.modInverse(e, phi);

    const publicKey: PublicKey = { e, n };
    const privateKey: PrivateKey = { d, n };

    return { publicKey, privateKey };
  }

  public static encrypt(message: string, publicKey: PublicKey): number[] {
    const asciiArray = this.stringToAsciiArray(message);
    const encryptedArray: number[] = [];
    for (let i = 0; i < asciiArray.length; i++) {
      const encryptedValue = this.modExp(asciiArray[i], publicKey.e, publicKey.n);
      encryptedArray.push(encryptedValue);
    }
    return encryptedArray;
  }

  public static decrypt(encryptedMessage: number[], privateKey: PrivateKey): string {
    const decryptedArray: number[] = [];
    for (let i = 0; i < encryptedMessage.length; i++) {
      const decryptedValue = this.modExp(encryptedMessage[i], privateKey.d, privateKey.n);
      decryptedArray.push(decryptedValue);
    }
    return this.asciiArrayToString(decryptedArray);
  }
}

interface PublicKey {
  e: number;
  n: number;
}

interface PrivateKey {
  d: number;
  n: number;
}