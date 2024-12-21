//
//  MainCollectionViewCell.swift
//  Practice_appplayer
//
//  Created by 김기림 on 2022/02/07.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var trackThumbnailImageView: UIImageView!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var trackArtistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI(track: Track?) {
        guard let hasTrack = track else { return }
        self.trackThumbnailImageView.image = hasTrack.artwork
        self.trackTitleLabel.text = hasTrack.title
        self.trackArtistLabel.text = hasTrack.artist
    }

}
