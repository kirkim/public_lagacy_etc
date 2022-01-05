//
//  ViewController.swift
//  UsingYpImagePicker
//
//  Created by 김기림 on 2022/01/05.
//

import UIKit
import YPImagePicker

class ViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var YPImageBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myImageView.layer.cornerRadius = myImageView.frame.height / 2
        self.YPImageBtn.layer.cornerRadius = 10
        self.YPImageBtn.addTarget(self, action: #selector(openYPImage), for: .touchUpInside)
    }

    @objc fileprivate func openYPImage() {
        print("ViewController - openYPImage() called")
        var config = YPImagePickerConfiguration()
//        config.screens = [.library, .photo, .video]
        config.screens = [.library]
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            // 이미지가 하나라도 선택되면
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
            
                // 이미지를 등록
                self.myImageView.image = photo.image
            }
            // 이미지 선택창 닫기
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)

    }

}

