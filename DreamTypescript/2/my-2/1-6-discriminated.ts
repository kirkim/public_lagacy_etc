{
  // 유니온 예시
  // function: login -> success, fail
  type SuccessState = {
    result: 'success';
    response: {
      body: string;
    };
  };
  type FailState = {
    result: 'fail';
    reason: string;
  };
  type LoginState = SuccessState | FailState;

  function login(): LoginState {
    return {
      result: 'success',
      response: {
        body: 'logged in!',
      },
    };
  }

  // * 방법2
  function printLoginState(state: LoginState) {
    if (state.result === 'success') {
      console.log(`🌈  ${state.response.body}`);
    } else {
      console.log(`😂  ${state.reason}`);
    }
  }

  printLoginState(login());
}
