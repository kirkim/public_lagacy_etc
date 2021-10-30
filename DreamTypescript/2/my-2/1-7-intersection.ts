{
  /**
   * Intersection Types: &
   */
  type Student = {
    name: string;
    score: number;
  };

  type Worker = {
    empolyeeId: number;
    work: () => void;
  };

	// ! intersection은 모든 타입을 선언해줘야 에러가 발생하지않는다
  function internWork(person: Student & Worker) {
    console.log(person.name, person.empolyeeId, person.work());
  }
  internWork({
    name: 'ellie',
    score: 1,
    empolyeeId: 123,
    work: () => {},
  });
}
