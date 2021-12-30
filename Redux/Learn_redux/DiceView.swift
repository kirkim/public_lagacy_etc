//
//  DiceView.swift
//  Learn_redux
//
//  Created by 김기림 on 2021/12/30.
//

import Foundation
 import SwiftUI

struct DiceView: View {
    
    // 외부에서 environmentObject 로 연결됨
    @EnvironmentObject var store: AppStore

    // 주사위 굴리기 액션을 실행
    func rollTheDice() {
        print(#fileID, #function, #line)
        self.store.dispatch(action: .rollTheDice)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text(self.store.state.currentDice)
                .font(.system(size: 300, weight: .bold, design: .monospaced))
                .foregroundColor(Color(hue: 0.288, saturation: 0.64, brightness: 0.891))
            Button(action: {
                self.rollTheDice()
            }, label: {
                Text("랜덤 주사위 굴리기")
                    .fontWeight(.black)
            }).buttonStyle(MyButtonStyle())
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
//        DiceView()
        Text("")
    }
}
