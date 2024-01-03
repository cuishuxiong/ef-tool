/**
 * @Author csx
 * @DateTime 2023/12/29 22:05
 * @TODO HashSet  模仿Java的有序集合
 */
export class HashSet<T> {
  private items: T[];

  constructor(items?: T[]) {
    this.items = [];
    if (items) {
      this.addAll(items);
    }
  }

  add(item: T): void {
    if (!this.contains(item)) {
      this.items.push(item);
    }
  }

  addAll(items: T[]): void {
    for (const item of items) {
      this.add(item);
    }
  }

  remove(item: T): void {
    const index = this.items.indexOf(item);
    if (index > -1) {
      this.items.splice(index, 1);
    }
  }

  contains(item: T): boolean {
    return this.items.indexOf(item) !== -1;
  }

  toArray(): T[] {
    return this.items.slice();
  }

  size(): number {
    return this.items.length;
  }

  clear(): void {
    this.items = [];
  }
}