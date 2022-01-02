//
//  SecondPageView.swift
//  lksjflksjflsdjfljsalkfjl
//
//  Created by 김기림 on 2021/12/31.
//

import SwiftUI

struct SecondPageView: View {
    @ObservedObject var oC: ObserverC
    
    var body: some View {
        VStack(spacing: 30) {
            Text("두번째 페이지 입니다.")
                .font(.system(size: 50, weight: .heavy, design: .rounded))
            Button(action: {
                self.oC.count += 1
            }, label: {
                Text("카운터 늘리기")
            })
            Text("count: \(oC.count)")
                .font(.system(size: 30))
            NavigationLink(destination: {
//                ThirdPageView().environmentObject(oC)
                ThirdPageView(oC: self.oC)
            }) {
                Text("세번째 페이지로")
            }
        }
    }
}

struct SecondPageView_Previews: PreviewProvider {
    static var previews: some View {
//        SecondPageView()
        Text("sdf")
    }
}
