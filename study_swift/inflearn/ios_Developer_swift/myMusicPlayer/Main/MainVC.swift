//
//  ViewController.swift
//  Practice_collection
//
//  Created by 김기림 on 2022/02/03.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var myCollectionView: UICollectionView! {
        didSet {
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            let margin: CGFloat = 10
            let minimumInteritemSpacing: CGFloat = 10
            let minimumLineSpacing: CGFloat = 10
            let width = (UIScreen.main.bounds.width - minimumInteritemSpacing) / 2 - margin
            let height = width + 60
            
            layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
            layout.itemSize = CGSize(width: width, height: height)
            layout.minimumInteritemSpacing = minimumInteritemSpacing
            layout.minimumLineSpacing = minimumLineSpacing
            layout.headerReferenceSize = CGSize(width: 0, height: UIScreen.main.bounds.width * 2 / 3)
            self.myCollectionView.collectionViewLayout = layout
        }
    }
    
    let trackManager: TrackManager = TrackManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
    }
}

extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trackManager.tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicCell", for: indexPath) as? MusicCell else { return UICollectionViewCell() }
        let track = trackManager.track(at: indexPath.item)
        cell.updateUI(item: track)
        return cell
    }
    
    // 헤더뷰 어떻게 표시할까?
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let item = trackManager.todayTrack else { return UICollectionReusableView() }
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeaderView", for: indexPath) as? CollectionHeaderView else {
                return UICollectionReusableView()
            }
            header.update(with: item)
            header.tapHandler = { item in
//                print("----> item title: \(item.convertToTrack()?.title)")
                let storyboard = UIStoryboard(name: "Player", bundle: nil)
                guard let playerVC = storyboard.instantiateViewController(withIdentifier: "PlayerVC") as? PlayerVC else { return }
                SimplePlayer.shared.replaceCurrentItem(with: item)
                self.present(playerVC, animated: true, completion: nil)
            }
            
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
}

extension MainVC: UICollectionViewDelegate {
    // 클릭할때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Player", bundle: nil)
        guard let playerVC = storyboard.instantiateViewController(withIdentifier: "PlayerVC") as? PlayerVC else { return }
        let item = trackManager.tracks[indexPath.item]
        SimplePlayer.shared.replaceCurrentItem(with: item)
        self.present(playerVC, animated: true, completion: nil)
    }
}
