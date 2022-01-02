//
//  ThirdPageView.swift
//  lksjflksjflsdjfljsalkfjl
//
//  Created by 김기림 on 2021/12/31.
//

import SwiftUI

struct ThirdPageView: View {
    
    @ObservedObject var oC: ObserverC
    
    var body: some View {
        VStack (spacing: 30) {
            Text("세번째 페이지 입니다.")
                .font(.system(size: 50, weight: .heavy, design: .rounded))
            Button(action: {
                self.oC.count += 1
            }, label: {
                Text("카운터 늘리기")
            })
            Text("count: \(oC.count)")
                .font(.system(size: 30))
        }
    }
}

struct ThirdPageView_Previews: PreviewProvider {
    static var previews: some View {
//        ThirdPageView()
        Text("sdfsdf")
    }
}
