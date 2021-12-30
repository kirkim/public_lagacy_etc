//
//  MyButtonStyle.swift
//  Learn_redux
//
//  Created by 김기림 on 2021/12/30.
//

import Foundation
import SwiftUI

struct MyButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20))
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(20)
    }
}

struct MyButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {
            
        }, label: {
            Text("MyButton")
                .fontWeight(.heavy)
        }).buttonStyle(MyButtonStyle())
    }
}
