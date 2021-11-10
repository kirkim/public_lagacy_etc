import React, { memo } from 'react';

//* memo는 PureComponent와 같은 역할을 한다.
const HabitAddForm = memo((props) => {
  const formRef = React.createRef();
  const inputRef = React.createRef();

  const onSubmit = (event) => {
    event.preventDefault();
    const name = inputRef.current.value;
    name && props.onAdd(name);
    //inputRef.current.value = '';
    formRef.current.reset();
  };
  return (
    <form ref={formRef} className="add-form" onSubmit={onSubmit}>
      <input ref={inputRef} type="text" className="add-input" placeholder="Habit" />
      <button className="add-button">Add</button>
    </form>
  );
});

//! 클래스로 구현한 버전
// class HabitAddForm extends PureComponent {
//   formRef = React.createRef();
//   inputRef = React.createRef();

//   onSubmit = (event) => {
//     event.preventDefault();
//     const name = this.inputRef.current.value;
//     name && this.props.onAdd(name);
//     //this.inputRef.current.value = '';
//     this.formRef.current.reset();
//   };

//   render() {
//     return (
//       <form ref={this.formRef} className="add-form" onSubmit={this.onSubmit}>
//         <input ref={this.inputRef} type="text" className="add-input" placeholder="Habit" />
//         <button className="add-button">Add</button>
//       </form>
//     );
//   }
// }

export default HabitAddForm;
