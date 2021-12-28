//
//  ContentView.swift
//  PopUpView_Practice
//
//  Created by 김기림 on 2021/12/28.
//

import SwiftUI
import ExytePopupView

struct ContentView: View {
    
    @State var showBottomSolidMessage = false
    @State var showBottomSimpleMessage = false
    @State var showTopSimpleMessage = false
    
    func createBottomSolidMessage() -> some View {
        ZStack(alignment: .top){
            LinearGradient(
                            colors: [.purple, .blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
            HStack {
                Image(systemName: "book.fill")
                VStack{
                    Text("바텀 팝업")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                    Text("아래에서 올라오는 팝업입니다.")
                } // VStack
            } // HStack
            .padding(.top)
        } // ZStack
        .frame(width: UIScreen.main.bounds.width, height: 100)
        .foregroundColor(.white)
    }
    
    func createBottomSimpleMessage() -> some View {
        HStack(alignment: .top) {
            Image(systemName: "play.rectangle.fill")
                .foregroundColor(.red)
                .font(.system(size: 40))
            VStack(spacing:20) {
                Text("유튜브")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                Text("유튜브 구독자 알림이 도착하였습니다!")
                    .frame(width: 200, alignment: .center)
                    .lineLimit(2)
            }
            .foregroundColor(.white)
        } // HStack
        .padding(5)
        .frame(width: 300, height: 150)
        .background(.gray)
        .cornerRadius(20)
    }
    
    func createTopSimpleMessage() -> some View {
        HStack(alignment: .top, spacing: 20) {
            Image("cuteDog")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 60, height: 60)
                .cornerRadius(20)
            VStack(alignment: .leading, spacing: 10) {
                Text("Cute Dog")
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                Text("This dog is very cute white dog!\nand you can touch this dog anytime you want!")
            }
            .foregroundColor(.white)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 50, alignment: .leading)
        .background(Color.init(hexcode: "f6e446"))
        .cornerRadius(20)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    self.showBottomSolidMessage = true
                } label: {
                    Text("바텀 Solid 팝업")
                }.buttonStyle(MyButtonStyle(color: .purple))
                
                Button {
                    self.showBottomSimpleMessage = true
                } label: {
                    Text("바텀 Simple 팝업")
                }.buttonStyle(MyButtonStyle(color: .gray))
                
                Button {
                    self.showTopSimpleMessage = true
                } label: {
                    Text("탑 simple 팝업")
                }.buttonStyle(MyButtonStyle(color: Color(hexcode: "f6e446")))

            }
        }
        .popup(isPresented: $showBottomSolidMessage, type: .toast, position: .bottom, animation: .easeInOut(duration: 0.4), autohideIn: 2, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: true, view: {createBottomSolidMessage()})
        .popup(isPresented: $showBottomSimpleMessage, type: .floater(verticalPadding: 30), position: .bottom, animation: .easeOut, autohideIn: 2, dragToDismiss: false, closeOnTap: false, closeOnTapOutside: false, view: {createBottomSimpleMessage()})
        .popup(isPresented: $showTopSimpleMessage, type: .floater(verticalPadding: 40), position: .top, animation: .linear(duration: 0.5), autohideIn: 3, dragToDismiss: false, closeOnTap: true, closeOnTapOutside: false, view: {createTopSimpleMessage()})
    }
}

struct MyButtonStyle: ButtonStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .frame(width: 200)
            .foregroundColor(.white)
            .background(self.color)
            .cornerRadius(30)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
