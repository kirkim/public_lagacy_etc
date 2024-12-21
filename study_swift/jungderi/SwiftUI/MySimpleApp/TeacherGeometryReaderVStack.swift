//
//  MyGeometryReaderVStack.swift
//  practice12_21
//
//  Created by 김기림 on 2021/12/23.
//

import SwiftUI

enum Index {
    case one, two, three
}

struct TeacherGeometryReaderVStack: View {
    
    @State var index : Index = .one
    
//    let centerPosition : (GeometryProxy) -> CGPoint = { proxy in
//        return CGPoint(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
//    }
    func centerPosition(_ proxy: GeometryProxy) -> CGPoint {
        return CGPoint(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
    }

    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                Button(action: {
                    withAnimation {
                        self.index = .one
                    }
                }) {
                    Text("1")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .frame(width: 100, height: geometry.size.height / 3)
                        .padding(.horizontal, self.index == .one ? 50 : 0)
                        .foregroundColor(.white)
                        .background(.red)
                }
                Button(action: {
                    withAnimation {
                        self.index = .two
                    }
                }) {
                    Text("2")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .frame(width: 100, height: geometry.size.height / 3)
                        .padding(.horizontal, self.index == .two ? 50 : 0)
                        .foregroundColor(.white)
                        .background(.blue)
                }
                Button(action: {
                    withAnimation {
                        self.index = .three
                    }
                }) {
                    Text("3")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .frame(width: 100, height: geometry.size.height / 3)
                        .padding(.horizontal, self.index == .three ? 50 : 0)
                        .foregroundColor(.white)
                        .background(.green)
                }
            } // VStack
//            .position(CGPoint(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY))
            .position(centerPosition(geometry))
        } // GeometryReader
        .background(.yellow)
        .edgesIgnoringSafeArea(.all)
    }
}

struct TeacherGeometryReaderVStack_Previews: PreviewProvider {
    static var previews: some View {
        TeacherGeometryReaderVStack()
    }
}
