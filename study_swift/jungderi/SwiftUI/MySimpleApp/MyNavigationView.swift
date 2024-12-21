//
//  MyNavigationView.swift
//  practice12_21
//
//  Created by 김기림 on 2021/12/22.
//

import SwiftUI

struct MyNavigationView: View {
    var body: some View {
        VStack {
            Image("me")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width:200)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .strokeBorder(lineWidth: 8)
                        .foregroundColor(.green)
                ) // Image
                .padding()
            Text("42Seoul Kirkim")
                .font(.system(size: 30))
                .padding(.bottom, 10)
            Text("iOS 개발 파이팅하자!")
                .font(.system(size: 20))
            HStack {
                NavigationLink {
                    MyWebView(url: "https://kirkim.github.io")
                        .navigationTitle(Text("개인 블로그"))
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Text("개인 블로그")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .padding()
                        .background(.red)
                        .cornerRadius(20)
                }
                NavigationLink {
                    MyWebView(url: "https://github.com/kirkim")
                        .navigationTitle(Text("Github"))
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Text("Github")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .padding()
                        .background(.green)
                        .cornerRadius(20)
                }
            } // HStack
            Spacer()
        } // VStack
        .navigationTitle(Text("내 프로필"))
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: Text("네비게이션 링크 입니다")) {
                    Image(systemName: "gear")
                }
            }
        } // toolbar
    }
}

struct MyNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MyNavigationView()
    }
}
