//
//  ContentView.swift
//  practice12_21
//
//  Created by 김기림 on 2021/12/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        NavigationLink(destination: MyList()) {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 30, weight: .regular, design: .rounded))
                                .foregroundColor(.black)
                        }
                        Spacer()
                        NavigationLink(destination: MyNavigationView()) {
                            Image(systemName: "person.crop.circle")
                                .font(.system(size: 30, weight: .regular, design: .rounded))
                                .foregroundColor(.black)
                        }
                    }.padding()
                    Text("Kirkim의 일정표")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding()
                    ScrollView {
                        VStack(spacing: 15) {
                            BasicBlock()
                            CustomBlock(systemImage: "mic", title: "노래강좌", startTime: 9, endTime: 10)
                            CustomBlock(systemImage: "rectangle.on.rectangle", title: "미러링 강좌", startTime: 13, endTime: 14, bgColor: Color.green)
                            CustomBlock(systemImage: "person.3", title: "토론 수업", startTime: 16, endTime: 18, bgColor: .teal)
                            CustomBlock(systemImage: "bolt", title: "전기 수업", startTime: 19, endTime: 20, bgColor: .orange)
                            CustomBlock(systemImage: "play.rectangle", title: "유튜브 수업", startTime: 21, endTime: 23, bgColor: .red)
                        }.padding()
                    }
                }
                Circle()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.yellow)
                    .overlay(
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 50))
                    )
                    .padding(10)
                    .shadow(radius: 20)
            }.edgesIgnoringSafeArea(.bottom) // ZStack
                .navigationTitle(Text("뒤로가기"))
                .navigationBarHidden(true)
        } // NavigationView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
