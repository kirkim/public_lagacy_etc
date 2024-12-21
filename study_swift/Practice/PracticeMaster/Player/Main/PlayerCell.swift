//
//  PlayerCell.swift
//  PracticeAVFoundation
//
//  Created by 김기림 on 2022/02/09.
//

import UIKit

class PlayerCell: UICollectionViewCell {

    @IBOutlet weak var musicThumbnail: UIImageView!
    @IBOutlet weak var musicTitleLabel: UILabel!
    @IBOutlet weak var musicArtistLabel: UILabel!
    @IBOutlet weak var musicGenreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(track: Track?) {
        self.musicThumbnail.image = track?.artwork
        self.musicTitleLabel.text = track?.title
        self.musicArtistLabel.text = track?.artist
        self.musicGenreLabel.text = track?.genre
    }

}
