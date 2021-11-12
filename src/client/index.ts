import { BoardList } from './components/board/boardList.js';
import { BasicBoard } from './components/basicBoard.js';
import * as global from './global.js';

const openBoardPageBtn = document.querySelector('#nav-board')! as HTMLButtonElement;
const main = document.querySelector('.document')! as HTMLDivElement;

async function openBoardPage() {
  const data = await global.boardPage.getBoard();
  const boardList = new BoardList(data);
  const board = new BasicBoard(boardList);
  board.render(main);
}

openBoardPageBtn.addEventListener('click', openBoardPage);
