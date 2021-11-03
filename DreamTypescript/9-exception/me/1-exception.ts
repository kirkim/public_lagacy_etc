// Java: Exception
// JavaScript: Error

//const array = new Array(11000000000000000);

//? 컴파일 단계에서 에러처리 예시
// {
//   function move(direction: 'up' | 'down' | 'left' | 'right' | 'jump') {
//     switch (direction) {
//       case 'up':
//         position.y++;
//         break;
//       case 'down':
//         position.y--;
//         break;
//       case 'left':
//         position.x--;
//         break;
//       case 'right':
//         position.x++;
//         break;
//       default:
//         const invalid: never = direction; // 'jump'를 핸들링하지않아 컴파일단계에서 오류확인 가능
//         throw new Error(`unknown direction: ${invalid}`);
//     }
//   }
// }

//todo Error(Exception) Handling: try -> catch -> finally
function readFile(fileName: string): string {
  if (fileName === 'not exist!💩') {
    throw new Error(`file not exist! ${fileName}`);
  }
  return 'file contents';
}

function closeFile(fileName: string) {
  //
}

const fileName = 'dsds';

try {
  console.log(readFile(fileName));
} catch (error) {
  console.log(`catched!!`);
} finally {
  closeFile(fileName);
  console.log('finally!!');
}
