//
//  TrackManager.swift
//  Practice_collection
//
//  Created by 김기림 on 2022/02/04.
//

import UIKit
import AVFoundation

class TrackManager {
    // TODO: 프로퍼티 정의하기 - 트랙들, 앨범들, 오늘의 곡
    var tracks: [AVPlayerItem] = []
    var albums: [Album] = []
    var todayTrack: AVPlayerItem?
    
    // TODO: 생성자 정의하기
    init() {
        let tracks = loadTracks()
        self.tracks = tracks
//        self.albums = loadAlbums(tracks: tracks)
        self.todayTrack = tracks.randomElement()
    }
    
    // TODO: 트랙 로드하기
    func loadTracks() -> [AVPlayerItem] {
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        let tracks = urls.map { url in
            return AVPlayerItem(url: url)
        }
        return tracks
    }
    
    // TODO: 인덱스에 맞는 트랙 로드하기
    func track(at index: Int) -> Track? {
        return tracks[index].convertToTrack()
    }
    
    // TODO: 엘범 로딩메소드 구현
    func loadAlbums(tracks: [AVPlayerItem]) -> [Album] {
        let albumList: [Track] = tracks.compactMap { item in
            return item.convertToTrack()
        }
        
        var albums: [Album] = []
        let albumDics = Dictionary(grouping: albumList) { track in track.albumName }
        for (key, value) in albumDics {
            let album = Album(title: key, tracks: value)
            albums.append(album)
        }
        return albums
    }
    
    // TODO: 오늘의 트랙 랜덤으로 선택
    func loadOtherTodaysTrack() {
        self.todayTrack = tracks.randomElement()
    }
}
