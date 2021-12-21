//
//  ContentView.swift
//  practice12_21
//
//  Created by 김기림 on 2021/12/21.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        Text("hi")
    }
}

struct BasicBlock: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Kirkim의 SwifUI공부")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding(.bottom, 5)
            Text("2021-12-21 ~")
                .font(.system(size: 20, weight: .light, design: .rounded))
                .foregroundColor(.gray)
            HStack {
                Image("1")
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                Image("2")
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                Image("3")
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                Spacer()
                Text("확인")
                    .frame(width:100, height:50)
                    .background(.blue)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }.padding()
        }
        .padding()
        .background(.yellow)
        .cornerRadius(20)
    }
}

struct ContentBlock: View {
    private let systemImagename: String
    private let blockTitle: String
    private let startTime: Int
    private let endTime: Int
    
    init(systemImage: String = "circle.grid.cross", title: String = "Temp title", startTime: Int = 8, endTime: Int = 9) {
        self.systemImagename = systemImage
        self.blockTitle = title
        self.startTime = startTime
        self.endTime = endTime
    }
    
    var body: some View {
        HStack (alignment: .center, spacing: 20){
            Image(systemName: self.systemImagename)
                .font(.system(size: 60))
                .foregroundColor(.white)
            VStack (alignment:.leading) {
                Divider().opacity(0)
                Text("\(self.blockTitle)")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                Spacer().frame(height: 5)
                Text("\(self.startTime):00 ~ \(self.endTime):00")
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(.purple)
        .cornerRadius(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentBlock()
    }
}
