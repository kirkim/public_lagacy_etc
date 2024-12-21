const TOKEN = 'token';

export default class TokenStorage {
  saveToken(userId, token) {
    localStorage.setItem(
      TOKEN,
      JSON.stringify({ token: token, userId: userId })
    );
  }

  getToken() {
    return JSON.parse(localStorage.getItem(TOKEN)).token;
  }
  getUserId() {
    return JSON.parse(localStorage.getItem(TOKEN)).userId;
  }

  clearToken() {
    localStorage.clear(TOKEN);
  }
}
