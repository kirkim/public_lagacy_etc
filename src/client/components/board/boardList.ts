import { PostDetail } from './postDetail.js';
import { TPosts } from '../../clientType/clientType.js';

export class BoardList {
  constructor(private data: TPosts) {
    this.render();
  }

  render() {
    let render = '';
    this.data.forEach((post) => {
      const title = `<div class="board-title"><span id-data="${post.id}">${post.title}</span></div>`;
      const titleLink = document.querySelector('.board-title span')! as HTMLSpanElement;
      titleLink.addEventListener('click', () => {
        const detail = new PostDetail(post);
        console.log(detail);
      });
      render = render + `<li>${title}</li>`;
    });
    return `<ul>${render}</ul>`;
  }
}
