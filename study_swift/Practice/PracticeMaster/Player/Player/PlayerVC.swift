//
//  PlayerVC.swift
//  PracticeAVFoundation
//
//  Created by 김기림 on 2022/02/09.
//

import UIKit
import AVFoundation

class PlayerVC: UIViewController {

    @IBOutlet weak var playerThumbnail: UIImageView!
    @IBOutlet weak var musicTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalDurationLabel: UILabel!
    
    private let simplePlayer = SimplePlayer.shared
    private var timeObserver: Any?
    private var isSeeking: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerUI()
        updateTime()
        
        timeObserver = simplePlayer.addPeriodicTimeObserver(forInterval:CMTime(seconds: 1, preferredTimescale: 10), queue: DispatchQueue.main, using: { time in
            self.updateTime()
        })
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        simplePlayer.pause()
        simplePlayer.replaceCurrentItem(with: nil)
    }
    
    //MARK: - @IBAction function
    @IBAction func handlePlayButton(_ sender: UIButton) {
        if (simplePlayer.isPlaying == true) {
            simplePlayer.pause()
        } else {
            simplePlayer.play()
        }
        togglePlayButtonUI()
    }
    @IBAction func beginSlide(_ sender: UISlider) {
        isSeeking = true
    }
    @IBAction func endSlide(_ sender: UISlider) {
        isSeeking = false
    }
    @IBAction func handleSeek(_ sender: UISlider) {
        guard let currentItem = simplePlayer.currentItem else { return }
        let position = Double(sender.value)
        let seconds = position * currentItem.duration.seconds
        let time = CMTime(seconds: seconds, preferredTimescale: 100)
        simplePlayer.seek(to: time)
    }
    
    //MARK: - Custom function
    func playerUI() {
        guard let item:AVPlayerItem = simplePlayer.currentItem,
              let track = item.convertToTrack() else { return }
        self.playerThumbnail.image = track.artwork
        self.musicTitleLabel.text = track.title
        self.artistLabel.text = track.artist
    }
    
    func togglePlayButtonUI() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 30)
        if (simplePlayer.isPlaying == true) {
            let image = UIImage(systemName: "pause.fill", withConfiguration: configuration)
            playButton.setImage(image, for: .normal)
        } else {
            let image = UIImage(systemName: "play.fill", withConfiguration: configuration)
            playButton.setImage(image, for: .normal)
        }
    }
    
    func updateTime() {
        currentTimeLabel.text = secondsToString(sec: simplePlayer.currentTime)
        totalDurationLabel.text = secondsToString(sec: simplePlayer.totalDuration)
        
        if isSeeking == false {
            slider.value = Float(simplePlayer.currentTime / simplePlayer.totalDuration)
        }
    }
    
    func secondsToString(sec: Double) -> String {
        guard sec.isNaN == false else { return "00:00" }
        let totalSeconds = Int(sec)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
