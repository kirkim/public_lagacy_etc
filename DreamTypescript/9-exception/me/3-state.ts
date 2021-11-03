{
  /**
   * todo 좀 더 세부적으로 에러를 처리해보기
   */
  //   class TimeoutError extends Error {}
  //   class OfflineError extends Error {}

  type NetworkErrorState = {
    result: 'fail';
    reason: 'offline' | 'down' | 'timeout';
  };

  type SuccessState = {
    result: 'success';
  };

  type ResultState = SuccessState | NetworkErrorState;
  class NetworkClient {
    tryConnect(): ResultState {}
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
