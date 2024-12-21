//
//  TrackManager.swift
//  PracticeAVFoundation
//
//  Created by 김기림 on 2022/02/09.
//

import AVFoundation

class TrackManager {
    var tracks: [AVPlayerItem] = []
    var todayTrack: AVPlayerItem?
    
    init() {
        self.tracks = loadTracks()
        updateTodayTrack()
    }
    
    func loadTracks() -> [AVPlayerItem] {
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        var resultTracks: [AVPlayerItem] = []
        for url in urls {
            resultTracks.append(AVPlayerItem(url: url))
        }
        return resultTracks
    }
    
    func updateTodayTrack() {
        self.todayTrack = tracks.randomElement()
    }
    
    func track(at index: Int) -> Track? {
        return tracks[index].convertToTrack()
    }
}
