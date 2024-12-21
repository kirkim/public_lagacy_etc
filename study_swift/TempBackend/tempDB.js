let data = {
  resultCount: 10,
  results: [
    {
      username: 'kirkim',
      age: 30,
      gender: 'male',
    },
    {
      username: 'Jane',
      age: 22,
      gender: 'female',
    },
    {
      username: 'Jack',
      age: 25,
      gender: 'male',
    },
    {
      username: 'Bill',
      age: 33,
      gender: 'male',
    },
    {
      username: 'Minji',
      age: 28,
      gender: 'female',
    },
    {
      username: 'David',
      age: 38,
      gender: 'male',
    },
    {
      username: 'Kane',
      age: 30,
      gender: 'male',
    },
    {
      username: 'Son',
      age: 31,
      gender: 'male',
    },
    {
      username: 'Jisoo',
      age: 26,
      gender: 'female',
    },
    {
      username: 'Rose',
      age: 24,
      gender: 'female',
    },
  ],
};
// for (let i = 0; i < 100000; i++) {
//   data.results.push({ username: 'temp', age: 22, gender: 'male' });
// }
export async function getAllDatas() {
  return data;
}
