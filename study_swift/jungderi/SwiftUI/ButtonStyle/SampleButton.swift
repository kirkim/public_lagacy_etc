//
//  SampleButton.swift
//  ButtonStyle_swiftUI
//
//  Created by 김기림 on 2021/12/27.
//

import SwiftUI

struct SampleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .padding()
            .background(.gray)
            .cornerRadius(20)
            .scaleEffect(configuration.isPressed ? 1.5 : 1.0)
            .onTapGesture {
                print("click!")
            }

    }
}

struct SampleButton_Previews: PreviewProvider {
    static var previews: some View {
        Button {
            print("preview")
        } label: {
            Text("hello")
        }.buttonStyle(SampleButton())
    }
}
