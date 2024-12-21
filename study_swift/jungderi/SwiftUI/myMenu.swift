//
//  ContentView.swift
//  Mymenu
//
//  Created by 김기림 on 2021/12/29.
//

import SwiftUI

struct ContentView: View {
    
    let animalDatas: [String] = ["🐶 나는 강아지!", "🐱 나는 고양이!", "🐵 나는 원숭이!"]
    @State private var popAlert: Bool = false
    @State private var stateMessage: String = ""
    @State private var selectedAnimal: String
    
    init () {
        selectedAnimal = self.animalDatas[0]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text(self.selectedAnimal)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                Spacer()
                Spacer()
            } // VStack
            .navigationTitle("하이요")
            .toolbar {
                Menu(content: {
                    Section(content: {
                        Button(action: {
                            self.popAlert = true
                            self.stateMessage = "오늘도 활기차게!"
                        }, label: {
                            Text("오늘도 활기차게!")
                        })
                        Button(action: {
                            self.popAlert = true
                            self.stateMessage = "오늘도 빡코딩!"
                        }, label: {
                            Text("오늘도 빡코딩!")
                        })
                    }, header: {
                        Text("상태 팝업")
                    })
                       
                    Section(content: {
                        Picker("동물선택", selection: $selectedAnimal, content: {
                            ForEach(self.animalDatas, id: \.self, content: { data in
                                Text(data).tag(data)
                            })
                        })
                    }, header: {
                        Text("동물 선택")
                    })
                }, label: {
                    Circle()
                        .frame(width: 50, height: 50, alignment: .center)
                        .overlay(
                            Image(systemName: "ellipsis")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                        )
                })
            } // toolbar
            .alert("State", isPresented: $popAlert, actions: {
            }, message: {
                Text(self.stateMessage)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
