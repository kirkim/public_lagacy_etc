//
//  ContentView.swift
//  lksjflksjflsdjfljsalkfjl
//
//  Created by 김기림 on 2021/12/31.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var oC = ObserverC()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(oC.count)")
                Button(action: {
                    self.oC.count += 1
                }, label: {
                    Text("카운터 늘리기")
                })
                NavigationLink(destination: SecondPageView(oC: self.oC)) {
                    Text("다음페이지")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
