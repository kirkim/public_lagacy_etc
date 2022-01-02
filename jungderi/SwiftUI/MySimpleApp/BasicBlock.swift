//
//  BasicBlock.swift
//  practice12_21
//
//  Created by 김기림 on 2021/12/22.
//

import SwiftUI

struct BasicBlock: View {
    
    @State private var shouldShowAlert: Bool = false
    
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
                Button {
                    self.shouldShowAlert = true
                } label: {
                    Text("확인")
                        .frame(width:80, height:50)
                        .background(.blue)
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .alert(isPresented: $shouldShowAlert) {
                    Alert(title: Text("공부"), message: Text("공부시작"), dismissButton: .default(Text("확인")))
                }

            }.padding()
        }
        .padding()
        .background(.yellow)
        .cornerRadius(20)
    }
}

struct BasicBlock_Previews: PreviewProvider {
    static var previews: some View {
        BasicBlock()
    }
}

