{
  interface Stack {
    readonly size: number;
    push(value: string): void;
    pop(): string;
  }

  class myNode {
    private value: string;
    private next: myNode | null = null;
    private pre: myNode | null = null;

    get getValue(): string {
      return this.value;
    }
    getPre(): myNode | null {
      return this.pre;
    }
    set preNode(node: myNode) {
      this.pre = node;
    }
    getNext(): myNode | null {
      return this.next;
    }
    set nextNode(node: myNode) {
      this.next = node;
    }
    constructor(value: string) {
      this.value = value;
    }
  }

  class LIFO2 implements Stack {
    private _size: number = 0;
    get size() {
      return this._size;
    }
    private node: myNode | null = null;

    push(value: string): void {
      const newNode = new myNode(value);

      if (this.node !== null) {
        this.node.nextNode = newNode;
        newNode.preNode = this.node;
      }
      this.node = newNode;
      this._size++;
    }

    pop(): string {
      if (this.node === null) {
        return '';
      }
      const result = this.node.getValue;
      if (this.node.preNode !== null) {
        this.node = this.node.getPre();
      } else {
        this.node = null;
      }
      this._size--;
      return result;
    }
  }

  const l = new LIFO2();
  l.push('1');
  l.push('2');
  l.push('3');
  console.log(l.pop());
  console.log(l.pop());
  console.log(l.pop());
  console.log(l.pop());
  l.push('4');
  console.log(l.pop());
}
