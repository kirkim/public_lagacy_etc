type CoffeeCup = {
  shots: number;
  hasMilk: boolean;
};

class CoffeeMachine {
  private BEANS_GRAM_PER_SHOT = 7;
  private coffeeBeans: number = 0;
  constructor() {}

  public addCoffeeBean(beans: number) {
    this.coffeeBeans += beans;
  }

  public makeCoffee(shots: number): CoffeeCup {
    if (this.coffeeBeans < shots * this.BEANS_GRAM_PER_SHOT) {
      throw new Error('Not enough coffee beans!');
    }
    this.coffeeBeans -= shots * this.BEANS_GRAM_PER_SHOT;
    return {
      shots: shots,
      hasMilk: false,
    };
  }
}

const coffeeMachine = new CoffeeMachine();
coffeeMachine.addCoffeeBean(21);
const coffee = coffeeMachine.makeCoffee(2);
console.log(coffee);
console.log(coffeeMachine);
