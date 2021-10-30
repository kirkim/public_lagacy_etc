{
  interface Stack {
    readonly size: number;
    push(value: string): void;
    pop(): string;
  }

  //* 데이터 타입을 정의 할때는 불변성을 유지하는 것이 좋음!! readonly사용
  type StackNode = {
    readonly value: string;

    //*next: StackNode | undefined;  //? 이방법은 구식의 방법
    readonly next?: StackNode;
  };

  class StackImpl implements Stack {
    private _size: number = 0;
    private head?: StackNode;

    //* 옵션이기는 하나 보통 자료구조를 만들때 capacity(용량)을 정해서 생성하도록 만듬
    constructor(private capacity: number) {}

    get size() {
      return this._size;
    }

    push(value: string): void {
      if (this.size === this.capacity) {
        throw new Error('Stack is full!');
      }
      const node: StackNode = { value, next: this.head };
      this.head = node;
      this._size++;
    }

    //pop(): string | undefined 와 같이 `undefined`리턴 옵션을 주게되면 사용하는 곳에서
    //         계속해서 null 체크를 해야되므로 안좋음...
    pop(): string {
      // js와 연동해서 사용하다보면 `null`이 할당되는 경우가 있다.
      // null 혹은 undefined일경우 그냥 `== null`로 작성하자
      if (this.head == null) {
        throw new Error('Stack is empty!');
      }
      const node = this.head;
      this.head = node.next;
      this._size--;
      return node.value;
    }
  }

  const stack = new StackImpl(10);
  stack.push('A');
  stack.push('B');
  stack.push('C');
  while (stack.size !== 0) {
    console.log(stack.size, stack.pop());
  }
}
