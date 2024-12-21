//
//  ListCell.swift
//  Practice_collection
//
//  Created by 김기림 on 2022/02/03.
//

import UIKit

class MusicCell: UICollectionViewCell {
    
    @IBOutlet weak var musicThumbnail: UIImageView!
    @IBOutlet weak var musicTitleLabel: UILabel!
    @IBOutlet weak var musicArtist: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        musicThumbnail.layer.cornerRadius = 4
        musicArtist.textColor = .systemGray2
    }
    
    func updateUI(item: Track?) {
        // TODO: 곡정보 표시하기
        guard let hasItem = item else { return }
        musicThumbnail.image = hasItem.artwork
        musicArtist.text = hasItem.artist
        musicTitleLabel.text = hasItem.title
    }
}
