{
  /**
   * Enum --> //! 잘 사용안함
   * 굳이 사용한다면 ? // ? 안드로이드나 ios에 데이터를 줄때 union 지원안하므로 enum을 사용
   */
  // JavaScript
  const MAX_NUM = 6;
  const MAX_STUDENTS_PER_CLASS = 10;
  const MONDAY = 0;
  const TUESDAY = 1;
  const WEDNESDAY = 2;
  const DAYS_ENUM = Object.freeze({ MONDAY: 0, TUESDAY: 1, WEDNESDAY: 2 });
  const dayOfToday = DAYS_ENUM.MONDAY;

  // TypeScript
  enum Days {
    Monday = 3, // 0 : default
    Tuesday, // 1
    Wednesday, // 2
    Thursday, // 3
    Friday, // 4
    Satarday, // 5
    Sunday, // 6
  }
  console.log(Days.Thursday);
  const day = Days.Satarday;
  console.log(day);

  // ! enum !!!!!
  // ! 문제점!!
  let day2: Days = Days.Satarday;
  day2 = 10; // enum은 type이 보장되지 않음
  console.log(day2);

  // ? --> 그 대신에 union타입을 활용
  type DaysOfWeek = 'Monday' | 'Tuesday' | 'Wednesday';
  let dayOfweek: DaysOfWeek = 'Monday';
  dayOfweek = 'Tuesday';
}
