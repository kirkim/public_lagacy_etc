const path = require('path');

console.log(__dirname);
console.log(__filename);

console.log(path.sep);
console.log(path.delimiter);


// basename
console.log(path.basename(__filename));
console.log(path.basename(__filename, '.js'));


// dirname
console.log(path.dirname(__filename));

// extension
console.log(path.extname(__filename));


//parse
const parsed = path.parse(__filename);
console.log(parsed);

const str = path.format(parsed);
console.log(str);

// isAbsolute
console.log('isAbsolute?', path.isAbsolute(__dirname));  // /Users/
console.log('isAbsolute?', path.isAbsolute('../'));

// normalize
console.log(path.normalize('./folder///////sub'));

// join
console.log(__dirname + '/' + 'image');  // 이러면 window운영체제에서 오류❌
console.log(__dirname + path.sep + 'image');  // 이런식으로 해결
console.log(path.join(__dirname, 'image'));  // join을 써도 가능 편함
