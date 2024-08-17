/**
 Copyright 2024 csx - @yunkss/ef_crypto_dto

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

/**
 * @Author csx
 * @DateTime 2024/3/18 10:39:03
 * @TODO SM2Sequence   SM2转换序列
 */
export class SM2Sequence {
  private c1x: string = "";

  public set C1x(value: string) {
    this.c1x = value;
  }

  public get C1x(): string {
    return this.c1x;
  }

  private c1y: string = "";

  public set C1y(value: string) {
    this.c1y = value;
  }

  public get C1y(): string {
    return this.c1y;
  }

  private c2: string = "";

  public set C2(value: string) {
    this.c2 = value;
  }

  public get C2(): string {
    return this.c2;
  }

  private c3: string = "";

  public set C3(value: string) {
    this.c3 = value;
  }

  public get C3(): string {
    return this.c3;
  }

  public toString(): string {
    return JSON.stringify(this);
  }
}