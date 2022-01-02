//
//  ContentView.swift
//  TextInput_swiftUI
//
//  Created by 김기림 on 2021/12/27.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State var resultUsername: String = ""
    @State var resultPassword: String = ""
    
    var body: some View {
        VStack (alignment:.leading, spacing: 20){
            HStack {
                TextField("아이디", text: $username)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                Button {
                    self.username = ""
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.secondary)
                        .opacity(self.username.count > 0 ? 1 : 0)
                }
            } // HStack
            
            HStack {
                SecureField("비밀번호", text: $password)
                    .keyboardType(.decimalPad)
                Button {
                    self.username = ""
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.secondary)
                        .opacity(self.password.count > 0 ? 1 : 0)
                }
            } // HStack
            
            Button {
                self.resultUsername = self.username
                self.resultPassword = self.password
                hideKeyboard()
            } label: {
                Text("확인")
            }
            
            Text("아이디: \(self.resultUsername)")
            Text("비밀번호: \(self.resultPassword)")
        } // VStack
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
