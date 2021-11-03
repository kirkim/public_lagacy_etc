const x = {};
const y = {};
console.log(x);
console.log(y);
console.log(x.toString());
console.log(x.__proto__ === y.__proto__);

const array = [];
console.log(array);

console.clear();
function CoffeeMachine(beans) {
  this.beans = beans;
  // Instance member level
  this.makeCoffee = (shots) => {
    console.log('making...');
  };
}

// Prototype memlevel
CoffeeMachine.prototype.makeCoffee = (shots) => {
  console.log('making...');
};
const machine1 = new CoffeeMachine(10);
const machine2 = new CoffeeMachine(20);
console.log(machine1);
console.log(machine2);

function LatteMachine(milk) {
  this.milk = milk;
}
// 이런식으로 js에서도 상속처럼 만들 수 있다. prototype을 이용하면...(코드를 재사용하기위해 사용)
LatteMachine.prototype = Object.create(CoffeeMachine.prototype);

const latteMachine = new LatteMachine(123);
console.log(latteMachine);
latteMachine.makeCoffee();
