{
  class LIFO {
    private stack: string[] = [];
    private index: number = 0;
    constructor() {}

    public push(value: string): void {
      this.stack.push(value);
      this.index++;
    }

    public pop(): string {
      if (this.index === 0) {
        throw new Error('stack is empty');
      }
      const result = this.stack.splice(--this.index, 1);
      return result[0];
    }
  }

  const lifo = new LIFO();
  lifo.push('kirkim');
  lifo.push('2');
  lifo.push('3');
  lifo.push('4');
  const sample = lifo.pop();
  const sample2 = lifo.pop();
  console.log(sample);
  console.log(sample2);
}
