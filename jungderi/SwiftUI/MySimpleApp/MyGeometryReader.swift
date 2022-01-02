//
//  MyGeometryReader.swift
//  practice12_21
//
//  Created by 김기림 on 2021/12/23.
//

import SwiftUI

struct MyGeometryReader: View {
    
    @State var clickedText: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Text("1")
                    .modifier(MyStyleText(bgColor: .red, width: self.clickedText == "a" ? 80 : 30, height: geometry.size.height / 3))
                    .onTapGesture {
                        self.clickedText = "a"
                    }
                Text("2")
                    .modifier(MyStyleText(bgColor: .blue, width: self.clickedText == "b" ? 80 : 30, height: geometry.size.height / 3))
                    .onTapGesture {
                        self.clickedText = "b"                    }
                Text("3")
                    .modifier(MyStyleText(bgColor: .green, width: self.clickedText == "c" ? 80 : 30, height: geometry.size.height / 3))
                    .onTapGesture {
                        self.clickedText = "c"                    }
            } // HStack
            .animation(.easeInOut(duration: 0.4), value: self.clickedText)
            .frame(width: geometry.size.width, height: geometry.size.height)
        } // GeometryReader
        .background(.black)
    }
}

struct MyStyleText: ViewModifier {
    var bgColor: Color
    var width: CGFloat
    var height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 30, weight: .bold, design: .rounded))
            .frame(width: width, height: height)
            .background(bgColor)
    }
}

struct MyGeometryReader_Previews: PreviewProvider {
    static var previews: some View {
        MyGeometryReader()
    }
}
