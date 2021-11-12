import { BoardList } from './board/boardList.js';
import { BaseComponent } from './components.js';

export class BasicBoard extends BaseComponent<HTMLElement> {
  constructor(list: BoardList) {
    super(`${list.render()}`);
  }
}
