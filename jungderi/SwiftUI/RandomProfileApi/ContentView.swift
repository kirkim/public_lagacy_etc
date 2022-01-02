//
//  ContentView.swift
//  RandomProfileApi
//
//  Created by 김기림 on 2021/12/31.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var randomUserViewModel = RandomUserViewModel()
    
    var body: some View {
        
        List(randomUserViewModel.randomUsers) { aRandomUser in
            RandomUserRowView(aRandomUser)
        }
        
        
//        List(0...100, id: \.self) { _ in
//            RandomUserRowView()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
