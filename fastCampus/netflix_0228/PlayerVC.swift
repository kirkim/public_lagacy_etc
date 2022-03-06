//
//  PlayerVC.swift
//  netflix_0228
//
//  Created by 김기림 on 2022/02/28.
//

import UIKit
import AVFoundation

class PlayerVC: UIViewController {

    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var playButton: UIButton!
    
    let player = AVPlayer()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.player = player
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        reset()
        self.dismiss(animated: false, completion: nil)
    }
    
    func reset() {
        pausePlayer()
        player.replaceCurrentItem(with: nil)
    }
    @IBAction func handlePlayButton(_ sender: UIButton) {
        if player.isPlaying {
            pausePlayer()
        } else {
            playPlayer()
        }
    }
    
    func pausePlayer() {
        player.pause()
        playButton.isSelected = false
    }
    func playPlayer() {
        player.play()
        playButton.isSelected = true
    }
    
}

//MARK: - extension AVPlayer - isPlaying()
extension AVPlayer {
    var isPlaying: Bool {
        guard self.currentItem != nil else { return false }
        return self.rate != 0
    }
}
