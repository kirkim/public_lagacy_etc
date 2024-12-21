//
//  CollectionHeaderView.swift
//  Practice_collection
//
//  Created by 김기림 on 2022/02/07.
//

import UIKit
import AVFoundation

class CollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var thumbnailImageView: UIImageView! {
        didSet {
            self.thumbnailImageView.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: AVPlayerItem?
    var tapHandler: ((AVPlayerItem) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImageView.layer.cornerRadius = 4
    }
    
    func update(with item: AVPlayerItem) {
        // TODO: 헤더뷰 업데이트 하기
        self.item = item
        guard let track = item.convertToTrack() else { return }
        
        self.thumbnailImageView.image = track.artwork
        self.descriptionLabel.text = "Today's pick is \(track.artist)'s album - \(track.albumName), Let's listen."
    }
    
    @IBAction func cardTapped(_ sender: UIButton) {
        // TODO: 탭했을때 처리
        guard let todaysItem = item else { return }
        tapHandler?(todaysItem)
    }
    
}
