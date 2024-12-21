{
  //* 특정 타입만 가능...
  function checkNotNullBad(arg: number | null): number {
    if (arg == null) {
      throw new Error('not valid number!');
    }
    return arg;
  }

  //* 모든 타입이 가능하지만 타입이 보장되지 않음...
  function checkNotNull(arg: any | null): any {
    if (arg == null) {
      throw new Error('not valid number!');
    }
    return arg;
  }

  //* 제네릭을 사용하면 어떤타입을 사용하든 타입을 보장받을 수 있다.
  function checkNotNull<T>(arg: T | null): T {
    if (arg == null) {
      throw new Error('not valid number!');
    }
    return arg;
  }
}
