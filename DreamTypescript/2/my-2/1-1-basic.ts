{
  /**
   * JavaScript
   * Primitive: number, string, boolean, bight, symbol, null, undefined
   * Object: function, array.......
   */

  // number
  const num: number = -6;

  // string
  const str: string = 'hello';

  // boolean
  const boal: boolean = false;

  // undefined
  let name: undefined; // 💩
  let age: number | undefined; // ✨
  age = undefined;
  age = 1;
  function find(): number | undefined {
    return undefined;
  }

  // null
  let person: null; // 💩
  let person2: string | null;

  // unknown 💩 // 왠만하면 쓰지않는 것이 좋다, 타입이없는 JS를 호환하기위해 존재하는 타입
  let notSure: unknown = 0;
  notSure = 'he';
  notSure = true;

  // any 💩 // 이것도 unknown과 같이 어느 타입도 들어옴. 쓰지말자
  let anything: any = 0;
  anything = 'hello';

  // void
  function print(): void {
    console.log('hello');
    return;
  }
  let unusable: void; // 💩 이렇게는 사용안함 undefined밖에 못담음

  // never: 이함수를 호출하면 return해주는 값이 없으니 감안하고 코딩해! 명시
  function throwError(message: string): never {
    // message -> server (log)
    // * throw new Error(message);
    // * while (true) {}
    return;
  }
  let neverEnding: never; // 💩

  // object
  let obj: object; // 💩 심지어 []배열도 가능해서....
  function acceptSomeObject(obj: object) {}
  acceptSomeObject({ name: 'ellie' });
  acceptSomeObject({ animal: 'dog' });
}
