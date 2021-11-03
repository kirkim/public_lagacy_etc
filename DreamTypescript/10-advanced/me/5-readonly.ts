{
  type ToDo = {
    title: string;
    description: string;
  };

  function display(todo: Readonly<ToDo>) {
    // ?<<<<<<<<< Readonly 클릭해서 구경해보자!
    //* todo.title = 'ajaj'; // 오류 발생
  }
}
