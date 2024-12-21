{
  // Array
  const fruits: string[] = ['🍅', '🍒']; // readonly 이용가능
  const scores: Array<number> = [1, 3, 4];
  function printArray(fuits: readonly string[]) {}
  //function printArray(fuits: readonly Array<number>) {} 이건 아직 허용안됨
}

{
  /* 2.8 */
  // Tuple: 서로다른 type을 담을 수 있음
  let student: [string, number];
  student = ['name', 123];
  student[0]; // name
  student[1]; // 123
  // 위처럼 튜플로 사용하면 가독성이 떨어짐
  // -> interface, type alias, class를 대신 사용한다.

  const [name, age] = student;
}
