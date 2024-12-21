const { EROFS } = require('constants');
const fs = require('fs');


// /* 모든 api는 다음과 같이 3가지로 제공이 됩니다. */
// rename(...., callback)  // ....을 비동기로 처리하고 callback함수를 호출
// renameSync(.....)  // blocking으로 따로 callback함수를 넘겨주지않음 -->에러가 날면 골치아픔
// promises.rename().then().catch(0)  // promise 형태로 이용이 가능


// /* 에러처리 */
// rename(...., callback(error, data))
// try { renameSync(....) } catch(e) { }
// promises.rename().then().catch(0)

// /* Sync에러 예시 */
//fs.renameSync('./file.txt', './file-new.txt'); // 예시로 존재하지않은 파일 전달 에러발생
//console.log('hello');  // 위의코드가 에러가나서 실행안됨

// /* 예시 해결1 */
// // Sync는 try, catch문으로 감싸서 사용
// // 가급적 Sync 사용하지 않는 것이 좋다
// try {
// 	fs.renameSync('./text.txt', './file-new.txt');
// } catch (error) {
// 	console.error(error);
// }
// console.log('hello');

// /* 예시 해결2 */
// // Sync를 안씀
// fs.rename('./file-new.txt', './text.txt', (error) => {     // rename세번째 인자는 error에 대해서만 콜백함
// 	console.log(error);   // 에러가 안나면 null이 출력될 것임
// });
// console.log('hello');


// /* 예시 해결3 */
// // promises이용 promises는 여러가지 함수가 있음
// fs.promises
// 	.rename('./text.txt', './file-new.txt')
// 	.then(() => console.log('Done!'))
// 	.catch(console.error);
