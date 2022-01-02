//
//  MyButtonStyle.swift
//  ButtonStyle_swiftUI
//
//  Created by 김기림 on 2021/12/26.
//

import SwiftUI

enum ButtonType {
    case tap
    case long
    case rotation
    case small
    case blur
}

struct MyButtonStyle: ButtonStyle {
    
    var color: Color
    var type: ButtonType
    
    func makeBody(configuration: Configuration) -> some View {
        switch self.type {
        case .tap:
            configuration.label
                .modifier(MyLabel(color: self.color))
                .scaleEffect(configuration.isPressed ? 1.5 : 1.0)
                .onTapGesture(perform: {
                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                    impactMed.impactOccurred()
                    print("tap click!")
                })
        case .long:
            configuration.label
                .modifier(MyLabel(color: self.color))
                .scaleEffect(configuration.isPressed ? 1.5 : 1.0)
                .onLongPressGesture(perform: {
                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                    impactMed.impactOccurred()
                    print("long click!")
                })
        case .rotation:
            configuration.label
                .modifier(MyLabel(color: self.color))
                .rotationEffect(configuration.isPressed ? .degrees(90) : .degrees(0))
        case .small:
            configuration.label
                .modifier(MyLabel(color: self.color))
                .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
                .opacity(configuration.isPressed ?  0.5 : 1.0)
        case .blur:
            configuration.label
                .modifier(MyLabel(color: self.color))
                .blur(radius: configuration.isPressed ? 10 : 0)
        }
    }
}

struct MyLabel: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .padding()
            .background(self.color)
            .cornerRadius(20)
    }
}

struct MyButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {
            print("호호")
        }, label: {
            Text("호호")
        }).buttonStyle(MyButtonStyle(color: .red, type: .long))
    }
}
