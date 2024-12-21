//
//  PlayerVC.swift
//  PracticeAVFoundation
//
//  Created by 김기림 on 2022/02/08.
//

import UIKit
import AVFoundation

class PlayListVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    private let trackManager = TrackManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeMusicCollectionView()
    }
    
    private func makeMusicCollectionView() {
        let y = titleLabel.frame.maxY + 5
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height - (self.tabBarController?.tabBar.frame.height ?? 0) - y
        let frame = CGRect(x: 0, y: y, width: width, height: height)
        let collectionView = PlayerCollectionView(cellNibName: "PlayerCell", headerNibName: "HeaderCell", frame: frame)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
    }
}

//MARK: - PlayerVC UICollectionViewDelegate
extension PlayListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = trackManager.tracks[indexPath.item]
        let vc = PlayerVC(nibName: "PlayerVC", bundle: nil)
        SimplePlayer.shared.replaceCurrentItem(with: item)
        self.present(vc, animated: true, completion: nil)
    }
}

//MARK: - PlayerVC UICollectionViewDataSource
extension PlayListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trackManager.tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCell", for: indexPath) as? PlayerCell else { return UICollectionViewCell() }
        let track = trackManager.track(at: indexPath.item)
        cell.update(track: track)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else { return UICollectionReusableView() }
            headerCell.update(with: trackManager.todayTrack)
            headerCell.clickHandler = { item in
                let vc = PlayerVC(nibName: "PlayerVC", bundle: nil)
                SimplePlayer.shared.replaceCurrentItem(with: item)
                self.present(vc, animated: true, completion: nil)
            }
            return headerCell
        default:
            return UICollectionReusableView()
        }

    }
}
