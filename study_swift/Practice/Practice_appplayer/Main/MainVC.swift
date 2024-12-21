//
//  MainVC.swift
//  Practice_appplayer
//
//  Created by 김기림 on 2022/02/07.
//

import UIKit

class MainVC: UIViewController {
    
    private let NIBNAME = "MainCollectionViewCell"
    private let trackManager = TrackManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makePlayerCollectionView()
    }
    
    private func makePlayerCollectionView() {
        let collectionView = PlayerCollectionView(nibName: NIBNAME)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
    }
}

//MARK: - UICollectionViewDataSource
extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.trackManager.tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else { return MainCollectionViewCell() }
        cell.updateUI(track: trackManager.track(at: indexPath.item))
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension MainVC: UICollectionViewDelegate {
    
}
