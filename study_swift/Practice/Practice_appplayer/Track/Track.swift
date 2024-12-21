//
//  Track.swift
//  Practice_appplayer
//
//  Created by 김기림 on 2022/02/07.
//

import UIKit

struct Track {
    let title: String
    let artist: String
    let albumName: String
    let artwork: UIImage
    
    init(title: String, artist: String, albumName: String, artwork: UIImage) {
        self.title = title
        self.artist = artist
        self.albumName = albumName
        self.artwork = artwork
    }
}

struct Album {
    let title: String
    let tracks: [Track]
    
    var thumbnail: UIImage? {
        return tracks.first?.artwork
    }
    
    init(title: String, tracks: [Track]) {
        self.title = title
        self.tracks = tracks
    }
}
