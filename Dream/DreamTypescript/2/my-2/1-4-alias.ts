{
  /**
   * Type Aliases
   */
  type Text = string;
  const name: Text = 'ellie';
  const address: Text = 'korea';
  type Num = number;
  type Student = {
    name: string;
    age: number;
  };
  const student: Student = {
    name: 'ellie',
    age: 12,
  };
}

{
  /**
   * String literal Types
   */

  type Name = 'name';
  let ellieName: Name;
  ellieName = 'name'; // 'name'만 할당가능
  type JSON = 'json';
	const json: JSON = 'json'; // 문자열 'json'만 할당가능
	
	type Boal = true;
	const isCat: Boal = true; // false를 할당못함 --> 대체 이걸 어디에쓸까? 1-5예시를 가보자
}
