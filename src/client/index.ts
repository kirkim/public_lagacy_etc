import BoardPage from './components/board.js';
import HttpClient from './network/http.js';

const baseURL = `http://localhost:8080`;
const httpClient = new HttpClient(baseURL);
const boardPage = new BoardPage(httpClient);
const openBoardPageBtn = document.querySelector('#nav-board')! as HTMLButtonElement;

async function openBoardPage() {
  await boardPage.getBoard();
}

openBoardPageBtn.addEventListener('click', openBoardPage);
