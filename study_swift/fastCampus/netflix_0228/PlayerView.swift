//
//  PlayerView.swift
//  netflix_0228
//
//  Created by 김기림 on 2022/02/28.
//

/// A view that displays the visual contents of a player object.

import AVFoundation
import UIKit

class PlayerView: UIView {

    // Override the property to make AVPlayerLayer the view's backing layer.
    override static var layerClass: AnyClass { AVPlayerLayer.self }
    
    // The associated player object.
    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }
    
    private var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}
