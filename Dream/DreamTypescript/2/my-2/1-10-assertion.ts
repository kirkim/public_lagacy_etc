{
  /**
   * Type Assertions 💩
   */
  function jsStrFunc(): any {
    return 2;
  }
  const result = jsStrFunc();
  console.log(result.length); // ..length의 미리보기가 안뜸
  console.log((result as string).length); // string임을 확신할 때 사용, type을 틀려도 경고를 안줌
  // * 그렇기 때문에 정말로 type을 확신할때만 써야한다.
}

{
  const wrong: any = 5;
  console.log((wrong as Array<number>).push(1)); // push함수가 없어서 에러가남 😱

  function findNumbers(): number[] | undefined {
    return undefined;
  }
  const numbers = findNumbers();
  numbers!.push(2); // 여기에 !를 붙이면 절대적으로 확신  😱
}

{
  /* 좋은 예시 */
  const button = document.querySelector('class')!; // 100%있을때 ! 를 붙일 수 있음
  if (button) {
    button.nodeValue; // 여기는 true일때만 들어오므로 경고를 안붐
  }
}
