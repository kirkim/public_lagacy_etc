//
//  MyButtonStyle.swift
//  ButtonStyle_swiftUI
//
//  Created by 김기림 on 2021/12/26.
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .cornerRadius(20)
    }
}

struct MyButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {
            
        }, label: {
            Text("호호")
        }).buttonStyle(MyButtonStyle())
    }
}
