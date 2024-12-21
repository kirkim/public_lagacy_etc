//
//  TrackCollectionHeaderView.swift
//  Practice_collection
//
//  Created by 김기림 on 2022/02/05.
//

import UIKit
import AVFoundation

class TrackCollectionHeaderView: UICollectionReusableView {
    
    
    var item: AVPlayerItem?
    var tapHandler: ((AVPlayerItem) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(with item: AVPlayerItem) {
        // TODO: 헤더뷰 업데이트 하기
    }
}
