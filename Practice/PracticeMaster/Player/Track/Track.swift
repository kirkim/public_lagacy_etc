//
//  Track.swift
//  PracticeAVFoundation
//
//  Created by 김기림 on 2022/02/09.
//

import UIKit

struct Track {
    let title: String
    let artist: String
    let albumName: String
    let genre: String
    let artwork: UIImage
    
    init(title: String, artist: String, albumName: String, type: String, artwork: UIImage) {
        self.title = title
        self.artist = artist
        self.albumName = albumName
        self.genre = type
        self.artwork = artwork
    }
}
