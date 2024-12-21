//
//  Extension+AVPlayerItem.swift
//  Practice_appplayer
//
//  Created by 김기림 on 2022/02/07.
//

import AVFoundation
import UIKit

import AVFoundation
import UIKit

extension AVPlayerItem {
    func convertToTrack() -> Track? {
        let metadataList = asset.metadata
        
        var trackTitle: String?
        var trackArtist: String?
        var trackAlbumName: String?
        var trackArtwork: UIImage?
        for metadata in metadataList {
            let key = metadata.commonKey?.rawValue
            switch key {
            case "title":
                trackTitle = metadata.stringValue
            case "artist":
                trackArtist = metadata.stringValue
            case "albumName":
                trackAlbumName = metadata.stringValue
            case "artwork":
                if let data = metadata.dataValue,
                   let image = UIImage(data: data) {
                    trackArtwork = image
                }
            default:
                break
            }
        }
        
        guard let title = trackTitle,
            let artist = trackArtist,
            let albumName = trackAlbumName,
            let artwork = trackArtwork else {
                return nil
        }
        return Track(title: title, artist: artist, albumName: albumName, artwork: artwork)
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        guard self.currentItem != nil else { return false }
        return self.rate != 0
    }
}
