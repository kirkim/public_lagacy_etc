//
//  AppState.swift
//  Learn_redux
//
//  Created by 김기림 on 2021/12/30.
//

import Foundation

// 앱의 상태 즉 데이터 -
struct AppState {
    var currentDice: String = "" {
        didSet {
            print("currnetDice: \(currentDice)", #fileID, #function)
        }
    }
}
