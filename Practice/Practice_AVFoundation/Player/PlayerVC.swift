//
//  PlayerVC.swift
//  PracticeAVFoundation
//
//  Created by 김기림 on 2022/02/08.
//

import UIKit

class PlayerVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.tabBarItem = UITabBarItem(title: "player", image: UIImage(systemName: "play.fill"), tag: 2)
    }
}

//MARK: - PlayerVC UICollectionViewDelegate
extension PlayerVC: UICollectionViewDelegate {
    
}

//MARK: - PlayerVC UICollectionViewDataSource
extension PlayerVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCell", for: indexPath)
        return cell
    }
    
    
}
