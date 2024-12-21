//
//  SimplePlayer.swift
//  PracticeAVFoundation
//
//  Created by 김기림 on 2022/02/09.
//

import AVFoundation

class SimplePlayer {
    static let shared = SimplePlayer()
    private let player = AVPlayer()
    
    var totalDuration: Double {
        return player.currentItem?.duration.seconds ?? 0
    }
    var currentTime: Double {
        return player.currentItem?.currentTime().seconds ?? 0
    }
    var isPlaying: Bool {
        return player.isPlaying
    }
    var currentItem: AVPlayerItem? {
        return player.currentItem
    }
    
    private init() { }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func seek(to time:CMTime) {
        player.seek(to: time)
    }
    
    func replaceCurrentItem(with item: AVPlayerItem?) {
        player.replaceCurrentItem(with: item)
    }
    
    func addPeriodicTimeObserver(forInterval interval: CMTime, queue: DispatchQueue?, using block: @escaping (CMTime) -> Void) -> Any {
        player.addPeriodicTimeObserver(forInterval: interval, queue: queue, using: block)
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        guard self.currentItem != nil else { return false }
        return self.rate != 0
    }
}
