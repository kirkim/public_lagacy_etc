//
//  MyList.swift
//  practice12_21
//
//  Created by 김기림 on 2021/12/22.
//

import SwiftUI

struct MyList: View {
    var body: some View {
        List{
            Section {
                ForEach(1...3, id: \.self) {
                    CustomBlock(systemImage: "book", title: "책읽기 \($0)", startTime: 8, endTime: 9, bgColor: .green)
                }
            } header: {
                Text("헤더입니다")
            } footer: {
                Text("푸터입니다")
            }
            .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
            Section {
                ForEach(1...20, id: \.self) {
                    CustomBlock(systemImage: "book", title: "책읽기 \($0)", startTime: 8, endTime: 9, bgColor: .blue)
                }
            } header: {
                Text("헤더입니다")
            }
            .listRowBackground(Color.yellow)
        }.listStyle(.grouped)
            .navigationTitle(Text("내 목록"))
    }
}

struct MyList_previews: PreviewProvider {
    static var previews: some View {
        MyList()
    }
}
