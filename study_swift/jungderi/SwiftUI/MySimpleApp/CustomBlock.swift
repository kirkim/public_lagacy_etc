//
//  CustomBlock.swift
//  practice12_21
//
//  Created by 김기림 on 2021/12/22.
//

import SwiftUI

struct CustomBlock: View {
    private let systemImagename: String
    private let blockTitle: String
    private let startTime: Int
    private let endTime: Int
    private let bgColor: Color
    
    init(systemImage: String = "circle.grid.cross", title: String = "Temp title", startTime: Int = 8, endTime: Int = 9, bgColor: Color = Color.purple) {
        self.systemImagename = systemImage
        self.blockTitle = title
        self.startTime = startTime
        self.endTime = endTime
        self.bgColor = bgColor
    }
    
    var body: some View {
        HStack (alignment: .center){
            Image(systemName: self.systemImagename)
                .font(.system(size: 60))
                .foregroundColor(.white)
                .padding()
            VStack (alignment:.leading) {
                Divider().opacity(0)
                Text("\(self.blockTitle)")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                Spacer().frame(height: 5)
                Text("\(self.startTime):00 ~ \(self.endTime):00")
                    .foregroundColor(.white)
            }
        }
        .background(self.bgColor)
        .cornerRadius(20)
    }
}

struct CustomBlock_Previews: PreviewProvider {
    static var previews: some View {
        CustomBlock()
    }
}
