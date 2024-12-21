// https://github.com/microsoft/TypeScript/blob/master/lib/lib.es5.d.ts
Array;

// 타입을 확인하는 여러방법이 있지만 as 로 타입을 강제해줄 수 있지만
// `is`를 사용하여 타입일 경우만으로 정의하여 안전하게 사용할 수 있다.

// function isFish(pet: Fish | Bird): pet is Fish {
//   return (pet as Fish).swim !== undefined;
// }

class Animal {}
class Cat extends Animal {
  isCat: boolean = true;
}
class Dog extends Animal {
  isDog: boolean = false;
}

const animals: Animal[] = [new Cat(), new Cat(), new Dog()];
function isCat(animal: Animal): animal is Cat {
  return (animal as Cat).isCat !== undefined;
}

console.log(animals.every<Cat>(isCat));
