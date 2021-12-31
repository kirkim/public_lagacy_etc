//
//  ContentView.swift
//  lksjflksjflsdjfljsalkfjl
//
//  Created by 김기림 on 2021/12/31.
//

import SwiftUI

struct ContentView: View {

    @State private var oCnt: Int = 0
    
    @State private var temp: String = "noChanged"
    private var temp2: String = "noChanged"
    @State var sss = Sample(string: "hello")
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("inout: \(self.temp)")
                Text("set: \(sss.myProperty)")
                Button(action: {
                    changeInOut(value: &self.temp)
                    sss.myProperty = "Sdf"
                }, label: {
                    Text("변경")
                })
                
                Text("Count: \(self.oCnt)")
                NavigationLink(destination: {
                    SecondPageView(oCnt: $oCnt)
                }) {
                    Text("다음 페이지")
                }
            } // VStack
            .font(.system(size: 40))
        } // NavigationView
    }
    
}
struct Sample: View {
    private var _myProperty: String
        
    var myProperty: String {
        get {
            return _myProperty
        }
        set {
            return _myProperty = newValue
        }
    }
    
    init(string: String) {
        self._myProperty = string
    }
    
    var body: some View {
        VStack {
            Button(action: {
                
            }, label: {
                
            })
        }
    }
}

func changeInOut( value: inout String) {
    value = "changed"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
