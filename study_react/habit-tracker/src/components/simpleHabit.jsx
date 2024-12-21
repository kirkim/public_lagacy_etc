import React, { useCallback, useEffect, useState } from 'react';

//! 클래스는 render()함수만 호출되는반면(나머지는 처음에만 호출),,
//! 반면에 함수는 코드블럭 전체가 다시 호출됨
//? 그런데 useState()같은 경우 reactAPI로 react가 알아서 기억하고 있음(메모리에 저장) --> 리엑트 훅개념
const SimpleHabit = (props) => {
  const [count, setCount] = useState(0);
  //const spanRef = React.createRef(); //=>함수가 호출될 때마다 업데이트됨...안좋음
  const spanRef = React.useRef(); // 한번만 만들고 메모리에 저장하고 사용

  // useCallback()는 react가 자동으로 캐시를 해서 리로딩되는 것을 막아줌, 조심해야할 점이 있음
  const handleIncrement = useCallback(() => {
    setCount(count + 1);
  });

  // useEffect()는 업데이트 될때마다 호출됨
  // 기존의 componentDidMount와 componentDidUpdate 이 두가지가 필요할때 중복해서 쓸필요가 없어짐
  useEffect(() => {
    console.log(`mounted & updated!: ${count}`);
  }, [count]); // 두번째인자는 count가 변경될때마다 호출, []로 적으면 처음에 마운트될때만 호출됨
  return (
    <li className="habit">
      <span ref={spanRef} className="habit-name">
        Reading
      </span>
      <span className="habit-count">{count}</span>
      <button className="habit-button habit-increase" onClick={handleIncrement}>
        <i className="fas fa-plus-square"></i>
      </button>
    </li>
  );
};

export default SimpleHabit;
