{
  /**
	 {
	 * Union Types: OR   // 중요!!!
	 */
  type Direction = 'left' | 'right' | 'up' | 'down'; // 이 중에서만 선택 가능
  function move(direction: Direction) {
    console.log(direction);
  }
  move('down');

  type TileSize = 8 | 16 | 32;
  const tile: TileSize = 16;
}
{
  // 유니온 예시
  // function: login -> success, fail
  type SuccessState = {
    response: {
      body: string;
    };
  };
  type FailState = {
    reason: string;
  };
  type LoginState = SuccessState | FailState;
  function login(): LoginState {
    return {
      response: {
        body: 'logged in!',
      },
    };
  }

  // 위에 로그인 예시를 출력하는방법
  // printLoginState(state)
  // success -> 🌈 body
  // fail -> 😂 reason

  // * 방법1 💩
  function printLoginState(state: LoginState) {
    if ('response' in state) {
      console.log(`🌈  ${state.response.body}`);
    } else {
      console.log(`😂  ${state.reason}`);
    }
  }

  // * 방법2 -> 1-6챕터
}
