//
//  ContentView.swift
//  myVGrid
//
//  Created by 김기림 on 2021/12/29.
//

import SwiftUI

enum GridStyle: String, Identifiable, CaseIterable {
    case simpleTable = "list.bullet"
    case detail = "square.grid.2x2.fill"
    case block = "square.grid.3x3.fill"
    
    var id: String { self.rawValue }
}

struct DataSchema: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let content: String
}

extension DataSchema {
    static var dummyDatas: [DataSchema] {
        (1...2000).map { (index: Int) in
            DataSchema(title: "title\(index)", content: "sss")
        }
    }
}

struct ContentView: View {
    
    let dummyDatas = DataSchema.dummyDatas
    @State var selectedGridStyle: GridStyle = .simpleTable
    
    var body: some View {
        VStack {
            Text("MY VGrid!")
            Picker("Grid Style", selection: $selectedGridStyle, content: {
                ForEach(GridStyle.allCases, id: \.id, content: {
                    Image(systemName: $0.rawValue).tag($0)
                })
            }).pickerStyle(SegmentedPickerStyle())
                .padding()
            ScrollView {
                switch self.selectedGridStyle {
                case .simpleTable:
                    SimpleTable()
                case .detail:
                    DetailGrid(datas: self.dummyDatas)
                case .block:
                    Block()
                }
            } // ScrollView
        } // VStack
    }
}

struct SimpleTable: View {
    var body: some View {
        LazyVGrid(columns: [GridItem(.fixed(UIScreen.main.bounds.width))], content: {
            ForEach(1..<500, content: { index in
                HStack {
                    Image(systemName: "book.fill")
                    VStack {
                        Text("Book \(index)")
                        Text("책을 읽읍시다!")
                    } // VStack
                } // HStack
                .padding()
                .frame(width: UIScreen.main.bounds.width - 50)
                .background(.yellow)
                .cornerRadius(20)
            })
        }) // LazyGrid
            .padding()
    }
}

struct DetailGrid: View {
    
    let dummyDatas: [DataSchema]
    
    init (datas: [DataSchema]) {
        self.dummyDatas = datas
    }
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(minimum: 200)), GridItem(.flexible(minimum: 200))], content: {
            ForEach(self.dummyDatas, id: \.self, content: { (data: DataSchema) in
                Rectangle().foregroundColor(.green)
                    .frame(height: 150)
                    .overlay(
                        VStack {
                            Circle()
                                .frame(width: 60, height: 60, alignment: .center)
                                .foregroundColor(.blue)
                            Text(data.title)
                            Text(data.content)
                        }
                    )
            })
        }) // LazyGrid
        .padding(.horizontal)
    }
}

struct Block: View {
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 150))], content: {
            ForEach(0..<51, content: { index in
                Rectangle()
                    .frame(height: 100)
                    .foregroundColor(Color(red: 1, green: 0.5, blue: (Double(index)/50)))
                    .overlay(
                        Text("\(Double(index)/50)")
                    )
            })
        })
        .padding()
    }
}

extension Color {
    init(hexcode: String) {
        let scanner = Scanner(string: hexcode)
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0x00ff00) >> 8
        let blue = rgbValue & 0x0000ff
        
        self.init(red: Double(red) / 0xff, green: Double(green) / 0xff, blue: Double(blue) / 0xff)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
