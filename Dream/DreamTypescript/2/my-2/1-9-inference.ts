/**
 * Type Inference
 */

let text = 'hello';
text = 1; // 다른 type이면 에러경고를 노출해줌

// 파라미터에 type을 명시해주지 않으면 자동으로 any //
function print(message = 'hello') {
  console.log(message);
}
print('hello');
print(1); // 다른 type이면 에러경고를 노출해줌

function add(x: number, y: number) {
  return x + y; // 연산 뒤 자동으로 type이 추론됨
}
const result = add(1, 2); // result도 type이 number로 자동 추론

// !!!!!
// ! 하 지 만  type을 함수에서는 type을 명시해주는게 좋다.
// ? 팀 프로젝트할때 어떻게 type을 명시할 것 인지도 정하자!
