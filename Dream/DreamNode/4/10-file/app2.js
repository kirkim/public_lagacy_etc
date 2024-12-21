const fs = require('fs').promises;

// read a file
fs.readFile('./text.txt', 'utf8') // 2번째 인자 안적으면 유니코드출력
  .then((data) => console.log(data))
  .catch(console.error);

// writing a file
fs.writeFile('./file.txt', 'Hello, Dream coders! :)')
  .catch(console.error);

fs.appendFile('./file.txt', 'Hello, Dream coders! :)')
  .catch(console.error);

// copy
fs.copyFile('./file.txt', './file2.txt') // 비동기적으로 처리하기 때문에 위에 코드가 실행하기전에 복사해버림
  .catch(console.error);

// 위의 비동기 복사 해결
fs.appendFile('./file.txt', 'Hello, Dream coders! :)')
  .then(() => {
	fs.copyFile('./file.txt', './file2.txt')
		.catch(console.error);
  })
  .catch(console.error);


// folder
fs.mkdir('sub-folder')
  .catch(console.error);


fs.readdir('./') //
  .then(console.log)
  .catch(console.error);
