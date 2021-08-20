class Student {
	constructor(name, age) {
		this.name = name;
		this.age = age;
	}
}

const student1 = new Student("Jack", 13);
const student2 = new Student("Mini", 20);
const student3 = new Student("Kane", 32);
const student4 = new Student("Jinhi", 25);
const students = [student1, student2, student3, student4];

const result = students.find((student) => student.age === 32);

const student5 = {};
Object.assign(student5, student2);
console.log(student5);
