//
//  ContentView.swift
//  ButtonStyle_swiftUI
//
//  Created by 김기림 on 2021/12/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {
                print("탭")
            }, label: {
                Text("탭")
            }).buttonStyle(MyButtonStyle(color: .blue, type: .tap))
            
            Button(action: {
                print("롱탭")
            }, label: {
                Text("롱탭")
            }).buttonStyle(MyButtonStyle(color: .green, type: .long))
            
            Button(action: {
                print("축소탭")
            }, label: {
                Text("축소탭")
            }).buttonStyle(MyButtonStyle(color: .yellow, type: .small))

            Button(action: {
                print("회전탭")
            }, label: {
                Text("회전탭")
            }).buttonStyle(MyButtonStyle(color: .red, type: .rotation))
            
            Button(action: {
                print("블러탭")
            }, label: {
                Text("블러탭")
            }).buttonStyle(MyButtonStyle(color: .black, type: .blur))
            
            Button(action: {
                print("샘플버튼")
            }, label: {
                Text("샘플버튼")
            }).buttonStyle(SampleButton())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
