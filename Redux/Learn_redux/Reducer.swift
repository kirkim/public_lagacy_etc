//
//  Reducer.swift
//  Learn_redux
//
//  Created by 김기림 on 2021/12/30.
//

import Foundation

// (inout State, Action) -> Void 해당 클로져 자체를 별칭으로 리듀서로 칭함 State 와 Action을 가지고 있음
// typealias 별칭으로 만든다
typealias Reducer<State, Action> = (inout State, Action) -> Void

// 필터링을 하는 메소드
func appReducer(_ state: inout AppState, _ action: AppAction) -> Void {
    
    // 들어오는 액션에 따라 분기 처리 - 즉 필터링
    switch action {
    case .rollTheDice:
        // 앱의 상태를 변경하기
        state.currentDice = ["⚀", "⚁", "⚂", "⚃", "⚄", "⚅"].randomElement() ?? "⚀"
    }
}
