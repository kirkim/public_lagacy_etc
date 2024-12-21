//
//  ContentView.swift
//  pickerView
//
//  Created by 김기림 on 2021/12/28.
//

import SwiftUI

enum MyColor: String, CaseIterable, Identifiable {
    case red
    case green
    case blue
    case black
    
    var id: String { self.rawValue }
}

struct ContentView: View {
    
    @State private var selectIndex: Int = 0
    @State private var selectColor: MyColor = .red
    @State private var color: Color = .red
    
    func findColor() -> Color {
        switch self.selectColor {
        case .red:
            return Color.red
        case .green:
            return Color.green
        case .blue:
            return Color.blue
        case .black:
            return Color.black
        }
    }
    
    var body: some View {
        VStack(spacing: 50) {
            
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(self.findColor())
            Text("\(self.selectColor.rawValue)")
            
            Picker("test1", selection: $selectColor, content: {
                Text("레드").tag(MyColor.red)
                Text("그린").tag(MyColor.green)
                Text("블루").tag(MyColor.blue)
                Text("블랙").tag(MyColor.black)
            }).pickerStyle(SegmentedPickerStyle())
            
            Picker("test2", selection: $selectColor, content: {
                Text("레드").tag(MyColor.red)
                Text("그린").tag(MyColor.green)
                Text("블루").tag(MyColor.blue)
                Text("블랙").tag(MyColor.black)
            })
                .frame(width: 80, height: 130)
                .cornerRadius(10)
                .border(self.findColor(), width: 10)
                .pickerStyle(WheelPickerStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
