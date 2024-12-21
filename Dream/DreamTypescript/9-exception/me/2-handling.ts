{
  /**
   *todo 무조건 catch로 에러를 잡는게 좋지만은 않다. 그냥 에러를 던져주는게 나을 수도...
   *todo 에러처리는 유의미하게 처리할 수 있는 곳에서 처리하는게 났다. 아래의 App단계에서 처리한 것 처럼..
   */

  class NetworkClient {
    tryConnect(): void {
      throw new Error('no netWork!');
    }
  }

  class UserService {
    constructor(private client: NetworkClient) {}

    login() {
      this.client.tryConnect(); // 이곳에서 try, catch를 해도 되지만 에러처리가 무의미하므로 app단계에서 처리하는게 나을 수도있다.
    }
  }

  class App {
    constructor(private userService: UserService) {}
    run() {
      try {
        this.userService.login();
      } catch (error) {
        // show dialog to user
      }
    }
  }

  const client = new NetworkClient();
  const service = new UserService(client);
  const app = new App(service);
  app.run();
}
