//
//  CustomTapView.swift
//  practice12_21
//
//  Created by 김기림 on 2021/12/24.
//

import SwiftUI

enum tabIndex: Int, CaseIterable {
    case first
    case second
    case third
    
//    var index1: Int {
//        switch self {
//        case .first:
//            return 1
//        case .second:
//            return 2
//        case .third:
//            return 3
//        default:
//            return 0
//        }
//    }
}

struct MyCustomTapView: View {
    
    @State var currentView: tabIndex = .first
    
    let tabPosition : (GeometryProxy) -> CGPoint = { proxy in
        return CGPoint(x: proxy.frame(in: .local).maxX / (CGFloat(tabIndex.allCases.count) * 2),
                       y: proxy.frame(in: .local).minY + proxy.size.width / 10 )
    }
    
    let tabItemWidth : (GeometryProxy) -> CGFloat = { proxy in
        return proxy.size.width / 5
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                self.MyView(tabIndex: self.currentView)
                Circle()
                    .frame(width: 90, height: 90)
                    .offset(x: -proxy.size.width / 3, y: 10)
                    .offset(x: (proxy.size.width / 3) * CGFloat(tabIndex.index1))
                VStack {
                    HStack(alignment: .top, spacing: 0) {
                        Button(action: {
                            self.currentView = .first
                        }) {
                            MyTabItem(proxy: proxy,
                                      image: "hare",
                                      text: "first",
                                      isClicked: self.currentView == .first ? true : false)
                        }
                        .position(tabPosition(proxy))
                        Button(action: {
                            self.currentView = .second
                        }) {
                            MyTabItem(proxy: proxy,
                                      image: "tortoise",
                                      text: "second",
                                      isClicked: self.currentView == .second ? true : false)
                        }
                        .position(tabPosition(proxy))
                        
                        Button(action: {
                            self.currentView = .third
                        }) {
                            MyTabItem(proxy: proxy,
                                      image: "person",
                                      text: "Third",
                                      isClicked: self.currentView == .third ? true : false)
                        }
                        .position(tabPosition(proxy))
                    } // HStack
                    .animation(.easeInOut(duration: 0.4), value: self.currentView)
                    .frame(height: 50)
                    .background(.green)
                } // ZStack
            }
            .background(.yellow)
        } // GeometryReader
    }
    
    func MyTabItem(proxy: GeometryProxy, image: String, text: String, isClicked: Bool) -> AnyView {
        return AnyView (
            ZStack {
                if isClicked == true {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: tabItemWidth(proxy), height: proxy.size.width)
                }
                VStack {
                    Image(systemName: image)
                        .scaleEffect(isClicked ? 1.5 : 1.0)
                    Text(text)
                }
            }
        )
    }
    
    func MyView(tabIndex: tabIndex) -> AnyView {
        switch tabIndex {
        case .first:
            return AnyView(ContentViewOne())
        case .second:
            return AnyView(ContentViewTwo())
        case .third:
            return AnyView(ContentViewThree())
        }
    }
}

struct ContentViewOne: View {
    var body: some View {
        ZStack {
            Color(.yellow).edgesIgnoringSafeArea(.all)
            Text("첫번째 뷰 입니당")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.gray)
        }
    }
}

struct ContentViewTwo: View {
    var body: some View {
        ZStack {
            Color(.orange).edgesIgnoringSafeArea(.all)
            Text("두번째 뷰 입니당")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
    }
}

struct ContentViewThree: View {
    var body: some View {
        ZStack {
            Color(.gray).edgesIgnoringSafeArea(.all)
            Text("세번째 뷰 입니당")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
        }
    }
}


struct MyCustomTapView_Previews: PreviewProvider {
    static var previews: some View {
        MyCustomTapView()
    }
}
