//
//  RandomUserRowView.swift
//  RandomProfileApi
//
//  Created by 김기림 on 2022/01/01.
//

import SwiftUI

struct RandomUserRowView: View {
    
    var randomUser : RandomUser
    
    init(_ randomUser: RandomUser) {
        self.randomUser = randomUser
    }
    
    var body: some View {
        HStack {
            ProfileImgView(imageUrl: randomUser.profileImgUrl)
            Text("\(randomUser.description)")
                .font(.system(size: 25, weight: .heavy, design: .rounded))
                .lineLimit(2)
                .minimumScaleFactor(0.5)
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .leading)
            .padding(.vertical)
    }
}

struct RandomUserRowView_Previews: PreviewProvider {
    static var previews: some View {
        RandomUserRowView(RandomUser.getDummy())
    }
}

