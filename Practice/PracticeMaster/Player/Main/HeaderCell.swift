//
//  HeaderCell.swift
//  PracticeAVFoundation
//
//  Created by 김기림 on 2022/02/09.
//

import UIKit
import AVFoundation

class HeaderCell: UICollectionReusableView {

    @IBOutlet weak var headerThumbnail: UIImageView!
    @IBOutlet weak var headerDescriptionLabel: UILabel!
    var item: AVPlayerItem?
    var clickHandler: ((AVPlayerItem) -> Void) = { _ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(with item: AVPlayerItem?) {
        self.item = item
        guard let track = item?.convertToTrack() else { return }
        self.headerThumbnail.image = track.artwork
        self.headerThumbnail.contentMode = .scaleAspectFill
        self.headerDescriptionLabel.text = "Let's listen \"\(track.title)\""
    }
    @IBAction func openTodayTrack(_ sender: UIButton) {
        guard let item = self.item else { return }
        clickHandler(item)
    }
}
