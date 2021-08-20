// Q1. make a string out of an array
{
	const fruits = ['apple', 'banana', 'orange'];
	let result;
	result = fruits.join();
	console.log(result);
}

// Q2. make an array out of a string
{
	console.clear();
	const fruits = '🍎, 🥝, 🍌, 🍒';
	const result = fruits.split(", ");
	console.log(result);
}

8// Q3. make this array look like this: [5, 4, 3, 2, 1]
{
	console.clear();
	const array = [1, 2, 3, 4, 5];
	array.reverse();
	console.log(array);
}

// Q4. make new array without the first two elements
{
	console.clear();
	const array = [1, 2, 3, 4, 5];
	const array2 = [];
	Object.assign(array2, array);
	array2.shift();
	array2.shift();
	console.log(array2);
}

class Student {
	constructor(name, age, enrolled, score) {
	  this.name = name;
	  this.age = age;
	  this.enrolled = enrolled;
	  this.score = score;
	}
}
const students = [
	new Student('A', 29, true, 45),
	new Student('B', 28, false, 80),
	new Student('C', 30, true, 90),
	new Student('D', 40, false, 66),
	new Student('E', 18, true, 88),
];

// Q5. find a student with the score 90
{
	console.clear();
	const result = students.find((student) => student.score === 90);
	console.log(result);
}

// Q6. make an array of enrolled students
{
	console.clear();
	const result = [];
	students.forEach((student) => result.push(student));
	console.log(result);
}

// Q7. make an array containing only the students' scores
// result should be: [45, 80, 90, 66, 88]
{
	console.clear();
	/*
	const result = [];
	students.forEach((student) => result.push(student.score));
	console.log(result);*/
	const result = students.map((student) => student.score);
	console.log(result);
}

// Q8. check if there is a student with the score lower than 50
{
	console.clear();
	/*
	let result;
	result = students.filter((student) => student.score < 50);
	console.log(result);*/
	const result = students.some((student) => student.score < 50);
	//const result = !students.every((student) => student.score >= 50);
	console.log(result);
}

// Q9. compute students' average score
{
	console.clear();

/*	let result = 0;
	students.forEach((student) => result += student.score);
	result = result / (students.length);
	console.log(result);*/
	let result = students.reduce((prev, student) => prev + student.score, 0);
	result = result / students.length;
	console.log(result);
}

// Q10. make a string containing all the scores
// result should be: '45, 80, 90, 66, 88'
{
	console.clear();
	const result = students.map((student) => student.score).join(", ");
	console.log(result);
}

// Bonus! do Q10 sorted in ascending order
// result should be: '45, 66, 80, 88, 90'
{
	console.clear();
	const result = students.map((student) => student.score).sort().join(", ");
	console.log(result);
}
