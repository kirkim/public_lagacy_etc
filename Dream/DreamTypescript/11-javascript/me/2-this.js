console.log(this);

function simpleFunc() {
  console.log(this);
}
simpleFunc();
console.clear();

class Counter {
  count = 0;
  increase = function () {
    console.log(this);
  };
}

const counter = new Counter();
counter.increase();

//* 1. 변수에 그냥 할당 -> 정보 잃어버림
const caller = counter.increase;
//const caller = counter.increase.bind(counter); //* 이런식으로 일리리 바인드로 묶어야됨
caller();
//! 그대신에 increase함수를 arrow함수로 만들어도 가능

//* 2. 바인드에 할당
class Bob {}
const bob = new Bob();
bob.run = counter.increase;
bob.run();

//? 어쩌면 class안에서 함수를 선언할 때는 arrow함수가 좋을 수 있음
