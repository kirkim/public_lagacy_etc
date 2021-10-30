{
  // JavaScript 💩
  function jsAdd(num1, num2) {
    return num1 + num2;
  }

  // TypeScript ✨
  function add(num1: number, num2: number) {
    return num1 + num2;
  }
}

{
  // JavaScript 💩
  function jsFetchNum(id) {
    // code ...
    // code ...
    // code ...
    return new Promise((resolve, reject) => {
      resolve(100);
    });
  }

  // TypeScript ✨
  function jsFetchNum2(id: string): Promise<number> {
    // code ...
    // code ...
    // code ...
    return new Promise((resolve, reject) => {
      resolve(100);
    });
  }
}

{
  // JavaScript ✨ => TypeScript
  // Optional parameter
  function printName(firstName: string, lastName?: string) {
    console.log(firstName);
    console.log(lastName);
  }
  printName('Steve', 'Jobs');
  printName('Ellie');
  printName('Anna', undefined);
}
{
  // Default parameter
  function printMessage(message: string = 'default message') {
    console.log(message);
  }
  printMessage();
}
{
  // Rest parameter
  function addNumbers(...numbers: number[]): number {
    let result: number = 0;
    numbers.forEach((num) => (result += num)); // numbers.reduce((a, b) => a + b); 이방법도 있음
    return result;
  }
  console.log(addNumbers(1, 2));
  console.log(addNumbers(1, 2, 3, 4));
  console.log(addNumbers(1, 2, 3, 4, 5, 0));
}
