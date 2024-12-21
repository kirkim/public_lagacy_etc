//
//  ExtensionAVPlayerItem.swift
//  PracticeAVFoundation
//
//  Created by 김기림 on 2022/02/09.
//

import AVFoundation
import UIKit

extension AVPlayerItem {
    func convertToTrack() -> Track? {
        let metadataList = asset.metadata
        var trackTitle: String?
        var trackArtist: String?
        var trackAlbumName: String?
        var trackType: String?
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
            case "type":
                trackType = metadata.stringValue
            case "artwork":
                guard let data = metadata.dataValue
                else { break }
                trackArtwork = UIImage(data: data)
            default:
                break
            }
        }
        
        guard let title = trackTitle,
              let artist = trackArtist,
              let albumName = trackAlbumName,
              let type = trackType,
              let artwork = trackArtwork
        else { return nil }
        
        return Track(title: title, artist: artist, albumName: albumName, type: type, artwork: artwork)
    }
}
