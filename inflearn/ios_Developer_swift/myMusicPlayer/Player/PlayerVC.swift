//
//  PlayerVC.swift
//  Practice_collection
//
//  Created by 김기림 on 2022/02/07.
//

import UIKit
import AVFoundation

class PlayerVC: UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalDurationTimeLabel: UILabel!
    @IBOutlet weak var playerControlButton: UIButton!
    
    let simplePlayer = SimplePlayer.shared
    var timeObserver: Any?
    var isSeeking: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateTime(time: CMTime.zero)
        
        timeObserver = simplePlayer.addPeriodicTimeObserver(forInterval:CMTime(seconds: 1, preferredTimescale: 10),queue: DispatchQueue.main, using: {time in
            self.updateTime(time: time)
        })
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        simplePlayer.pause()
        simplePlayer.replaceCurrentItem(with: nil)
    }
}

//MARK: - @IBAction function
extension PlayerVC {
    @IBAction func handlePlayerControlButton(_ sender: UIButton) {
        if simplePlayer.isPlaying {
            simplePlayer.pause()
        } else {
            simplePlayer.play()
        }
        togglePlayerControlButton()
    }
    @IBAction func beginDrag(_ sender: Any) {
        isSeeking = true
    }
    
    @IBAction func endDrag(_ sender: UISlider) {
        isSeeking = false
    }
    
    @IBAction func seek(_ sender: UISlider) {
        guard let currentItem = simplePlayer.currentItem else { return }
        let position = Double(sender.value) // 0...1 > 0.5
        let seconds = position * currentItem.duration.seconds
        let time = CMTime(seconds: seconds, preferredTimescale: 100)
        print(time)
        simplePlayer.seek(to: time)
    }
}

//MARK: - function
extension PlayerVC {
    func updateUI() {
        guard let track = simplePlayer.currentItem?.convertToTrack() else { return }
        self.thumbnailImageView.image = track.artwork
        self.titleLabel.text = track.title
        self.artistLabel.text = track.artist
    }
    
    func togglePlayerControlButton() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 30)
        if simplePlayer.isPlaying {
            let image = UIImage(systemName: "pause.fill", withConfiguration: configuration)
            playerControlButton.setImage(image, for: .normal)
        } else {
            let image = UIImage(systemName: "play.fill", withConfiguration: configuration)
            playerControlButton.setImage(image, for: .normal)
        }
    }
    
    func updateTime(time: CMTime) {
        currentTimeLabel.text = secondsToString(sec: simplePlayer.currentTime)
        totalDurationTimeLabel.text = secondsToString(sec: simplePlayer.totalDurationTime)
        
        if isSeeking == false {
            timeSlider.value = Float(simplePlayer.currentTime / simplePlayer.totalDurationTime)
        }
    }
    
    func secondsToString(sec: Double) -> String {
        guard sec.isNaN == false else { return "00:00" }
        let totalSeconds = Int(sec)
        let min = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", min, seconds)
    }
}
