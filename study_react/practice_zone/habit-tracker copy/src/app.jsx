import { Component } from 'react';
import './app.css';
import Habits from './components/habits';

class App extends Component {
  state = {
    habitCnt: 0,
    habits: [
      { id: 1, name: 'Running', count: 0 },
      { id: 2, name: 'Studying', count: 0 },
      { id: 3, name: 'Coding', count: 0 },
    ],
  };

  handleIncrement = (habit) => {
    const copy = [...this.state.habits];
    const index = copy.indexOf(habit);
    copy[index].count++;
    this.setState({ habits: copy });
    this.updateHabitCnt(copy);
  };

  handleDecrement = (habit) => {
    const copy = [...this.state.habits];
    const index = copy.indexOf(habit);
    const count = copy[index].count - 1;
    copy[index].count = count < 0 ? 0 : count;
    this.setState({ habits: copy });
    this.updateHabitCnt(copy);
  };

  handleDelete = (habit) => {
    const copy = this.state.habits.filter((item) => item.id !== habit.id);
    this.setState({ habits: copy });
    this.updateHabitCnt(copy);
  };

  addHabit = (name) => {
    const newHabit = { id: Date.now(), name: name, count: 0 };
    const copy = [newHabit, ...this.state.habits];
    this.setState({ habits: copy });
  };

  handleAddHabit = () => {
    const inputForm = document.querySelector('#add__input');
    const value = inputForm.value;
    if (value !== '') {
      this.addHabit(value);
    }
    inputForm.value = '';
  };

  handleResetHabits = () => {
    const copy = [...this.state.habits];
    copy.map((habit) => (habit.count = 0));
    this.setState({ habits: copy, habitCnt: 0 });
  };

  updateHabitCnt = (copy) => {
    let habitCnt = 0;
    copy.forEach((habit) => {
      if (habit.count > 0) {
        habitCnt++;
      }
    });
    this.setState({ habitCnt });
  };

  render() {
    return (
      <>
        <div className="navbar">
          <i className="fas fa-leaf navbar-logo"></i>
          <span>Habit Tracker</span>
          <span className="navbar-count">{this.state.habitCnt}</span>
        </div>
        <div>
          <input className="add-input" id="add__input" type="text" placeholder="Habit" />
          <button className="add-button" onClick={this.handleAddHabit}>
            Add
          </button>
        </div>
        <Habits
          habits={this.state.habits}
          onIncrement={this.handleIncrement}
          onDecrement={this.handleDecrement}
          onDelete={this.handleDelete}
        />
        <button className="habits-reset" onClick={this.handleResetHabits}>
          reset
        </button>
      </>
    );
  }
}

export default App;
