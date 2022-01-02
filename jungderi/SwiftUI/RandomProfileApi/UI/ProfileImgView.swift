//
//  ProfileImgView.swift
//  RandomProfileApi
//
//  Created by 김기림 on 2021/12/31.
//

import SwiftUI
import URLImage

struct ProfileImgView: View {
    
    var imageUrl: URL
    
    var body: some View {
        URLImage(imageUrl, content: { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        })
            .frame(width: 50, height:50)
            .clipShape(Circle())
            .overlay(Circle().stroke(.yellow, lineWidth: 2))
    }
}

struct ProfileImgView_Previews: PreviewProvider {
    static var previews: some View {
         
        let url = URL(string: "https://randomuser.me/api/portraits/women/7.jpg")!
 
        
        ProfileImgView(imageUrl: url)
    }
}
