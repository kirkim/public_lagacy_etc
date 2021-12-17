//
//  ViewController.swift
//  PhotoGalleryApp
//
//  Created by 김기림 on 2021/12/14.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {

//    var images = [UIImage?]() 💩
    var fetchResults: PHFetchResult<PHAsset>?
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Photo Gallery App"
        makeNavigationItem()
        
        // 각셀의 크기를 지정해줄때 사용
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 1) / 2, height: 200)
        // 셀 가로 사이값 지정
        layout.minimumInteritemSpacing = 1
        // 셀 세로 사이값 지정
        layout.minimumLineSpacing = 1
        photoCollectionView.collectionViewLayout = layout
        
        photoCollectionView.dataSource = self
    }
    
    func makeNavigationItem() {
        let photoItem = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle"), style: .done, target: self, action: #selector(checkPermission))
        photoItem.tintColor = .black.withAlphaComponent(0.7)
        self.navigationItem.rightBarButtonItem = photoItem
        
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(refresh))
        refreshItem.tintColor = .black.withAlphaComponent(0.7)
        self.navigationItem.leftBarButtonItem = refreshItem
    }
        
    // showGallery()를 호출하기 전에 확인하는 코드작성
    // 이런식으로 권한 채크를 많이함 -> 안하면 심사에서 통과안됨
    @objc func checkPermission() {
        if PHPhotoLibrary.authorizationStatus() == .authorized ||
        PHPhotoLibrary.authorizationStatus() == .limited {
            DispatchQueue.main.async {
                self.showGallery()
            }
        } else if PHPhotoLibrary.authorizationStatus() == .denied {
            DispatchQueue.main.async {
                self.showAuthorizationDeniedAlert()
            }
        } else if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization { status in
                self.checkPermission()
            }
        }
    }
    
    func showAuthorizationDeniedAlert() {
        let alert = UIAlertController(title: "포토라이브러리 접근 권한을 활성화 해주세요.", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "설정으로 가기", style: .default, handler: { action in
            guard let url = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @objc func showGallery() {
        let library = PHPhotoLibrary.shared() // 싱글톤형식
        var configuration = PHPickerConfiguration(photoLibrary: library)
        configuration.selectionLimit = 10
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    @objc func refresh() {
        self.photoCollectionView.reloadData()
    }
}

extension ViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResults?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        if let asset = self.fetchResults?[indexPath.row] {
            cell.loadImage(asset: asset)
        }
        
        return cell
    }
}

extension ViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        // 고유 아이디 불러오는 방법 1 // 이 메서드 내부에 브레이크포인트를 잡고 확인해보자
//        results.map { $0.assetIdentifier }
        // 방법 2
//        let identifiers = results.map( \.assetIdentifier ) // 하지만 identifiers배열의 요소값이 옵셔널이므로 이것을 벗겨주기위해 다시옵셔널을이용
        let identifiers = results.map {
            $0.assetIdentifier ?? ""
        }
        self.fetchResults = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil) // cell에서 처리해주기위해 전역변수(클래스레벨)로 선언해주고 저장
        
        self.photoCollectionView.reloadData() // 이미지를 가져오고 나서 reload해야 cell에 적용 시킬 수있다.
        
        self.dismiss(animated: true, completion: nil)
//        // 공부해보자  ===> 이미지를 여기서 배열로 받아 저장(클레스레벨 변수에 저장)하는 것은 비효율적 cell처리함수에서 사용하는게 더좋음, 형식은PhotoCell에 선언해준다💩
//        fetchAssets.enumerateObjects { asset, Index, stop in
//            let imageManager = PHImageManager()
//
//        // 틈새) index, stop 사용법
//        if index == 2{
//            stop.pointee = true
//        }
//
//            let scale = UIScreen.main.scale
//            let imageSize = CGSize(width: 150 * scale, height: 150 * scale)
//
//            imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: nil) { image, info in
//                // 이미지에 브레이킹 포인트를 눌러보면 저화질, 고화질 이미지를 한번 씩받아와서 배열형태로 받아서 사용하는것은 좀 그렇다.
//                // self.images.append(image)
//            }
//        }
    }
    
    
}
