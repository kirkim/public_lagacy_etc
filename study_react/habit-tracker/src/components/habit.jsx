import React, { PureComponent } from 'react';

class Habit extends PureComponent {
  //todo '라이프사이클'함수가 있는데 공부해보자
  // 컴포넌트가 생성될때 호출됨
  componentDidMount() {
    //? 1. 실시간채팅 소켓 초기화
    //? 2. 타이머시작 지점
    console.log(`habit: ${this.props.habit.name} mounted`);
  }

  // 컴포넌트가 삭제되기전에 호출됨
  componentWillUnmount() {
    //? 리소스 지우는 로직
    console.log(`habit: ${this.props.habit.name} will unmount`);
  }
  handleIncrement = () => {
    this.props.onIncrement(this.props.habit);
  };

  handleDecrement = () => {
    this.props.onDecrement(this.props.habit);
  };

  handleDelete = () => {
    this.props.onDelete(this.props.habit);
  };

  render() {
    const { name, count } = this.props.habit;
    return (
      <li className="habit">
        <span className="habit-name">{name}</span>
        <span className="habit-count">{count}</span>
        <button className="habit-button habit-increase" onClick={this.handleIncrement}>
          <i className="fas fa-plus-square"></i>
        </button>
        <button className="habit-button habit-decrease" onClick={this.handleDecrement}>
          <i className="fas fa-minus-square"></i>
        </button>
        <button className="habit-button habit-delete" onClick={this.handleDelete}>
          <i className="fas fa-trash"></i>
        </button>
      </li>
    );
  }
}

export default Habit;
