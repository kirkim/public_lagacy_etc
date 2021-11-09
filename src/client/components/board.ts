import HttpClient from '../network/http';

export default class BoardPage {
  constructor(private http: HttpClient) {}

  async getBoard() {
    const data = await this.http.fetch(`/board`, {
      method: 'GET',
    });
    console.log(data);
  }
}
