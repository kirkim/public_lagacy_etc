{
  interface Stack<T> {
    readonly size: number;
    push(value: T): void;
    pop(): T;
  }
  type StackNode<T> = {
    readonly value: T;
    readonly next?: StackNode<T>;
  };

  class StackImpl<T> implements Stack<T> {
    private _size: number = 0;
    private head?: StackNode<T>;

    constructor(private capacity: number) {}

    get size() {
      return this._size;
    }

    push(value: T): void {
      if (this.size === this.capacity) {
        throw new Error('Stack is full!');
      }
      const node: StackNode<T> = { value, next: this.head };
      this.head = node;
      this._size++;
    }

    pop(): T {
      if (this.head == null) {
        throw new Error('Stack is empty!');
      }
      const node = this.head;
      this.head = node.next;
      this._size--;
      return node.value;
    }
  }

  /**
   *? 제네릭을 이용하면 다양한 타입을 쓸 수 있어 다음과 같이 재사용성이 높아진다.
   */
  const stack = new StackImpl(10);
  stack.push('A');
  stack.push('B');
  stack.push(3);
  stack.push({ name: 'ss' });
  stack.push(3);
  while (stack.size !== 0) {
    console.log(stack.size, stack.pop());
  }

  const stack2 = new StackImpl<string>(10);
  stack.push('A');
  stack.push('B');
  stack.push('C');
  while (stack.size !== 0) {
    console.log(stack.size, stack.pop());
  }

  const stack3 = new StackImpl<number>(10);
  stack.push(1);
  stack.push(2);
  stack.push(3);
  while (stack.size !== 0) {
    console.log(stack.size, stack.pop());
  }
}
