//
//  PhotoCell.swift
//  PhotoGalleryApp
//
//  Created by 김기림 on 2021/12/14.
//

import PhotosUI
import UIKit

class PhotoCell: UICollectionViewCell {
    
    func loadImage(asset: PHAsset) {
        
        let imageManager = PHImageManager()
        
        let scale = UIScreen.main.scale
        let imageSize = CGSize(width: 150 * scale, height: 150 * scale)
        
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic // 1.저화질 2.고화질 3. 저화질 -> 고화질(2번받음) 로 받아오는방식옵션 default: 3번
        
        self.photoImageView.image = nil // 새로고침할때 로딩중에 이전 이미지가 보여서 산만해보임 초기에 이미지 없도록 만들어줘서 해결
        
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: options) { image, info in // options에 nil주면 default
            
//            // info의 인덱스 값을 통해 고화질,저화질의 이미지를 구분해낼 수 있다.
//            if (info?[PHImageResultIsDegradedKey] as? Bool) == true {
//                // 저화질
//                self.photoImageView.image = image
//            } else {
//                //고화질
//            }
            
            self.photoImageView.image = image
        }
    }
    
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.contentMode = .scaleAspectFill // 이미지가 화면에 꽉차게 만들어줌
        }
    }
}
