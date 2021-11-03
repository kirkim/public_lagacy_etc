/**
 * Let's make a game 🕹
 */
{
  //MY Solution@@@@@@
  type directionType = 'up' | 'down' | 'left' | 'right';
  type Position = {
    x: number;
    y: number;
  };
  const position: Position = {
    x: 0,
    y: 0,
  };
  function move(directionType: directionType): void {
    switch (directionType) {
      case 'up':
        position.y++;
        break;
      case 'down':
        position.y--;
        break;
      case 'left':
        position.x--;
        break;
      case 'right':
        position.x++;
        break;
    }
  }
}

//TC Solution@@@@@@
const position = { x: 0, y: 0 };
function move(direction: 'up' | 'down' | 'left' | 'right') {
  switch (direction) {
    case 'up':
      position.y++;
      break;
    case 'down':
      position.y--;
      break;
    case 'left':
      position.x--;
      break;
    case 'right':
      position.x++;
      break;
    default:
      throw new Error(`unknown direction: ${direction}`);
  }
}

console.log(position); // { x: 0, y: 0}
move('up');
console.log(position); // { x: 0, y: 1}
move('down');
console.log(position); // { x: 0, y: 0}
move('left');
console.log(position); // { x: -1, y: 0}
move('right');
console.log(position); // { x: 0, y: 0}
