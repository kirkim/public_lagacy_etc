//
//  PlayerCollectionView.swift
//  Practice_appplayer
//
//  Created by 김기림 on 2022/02/07.
//

import UIKit

class PlayerCollectionView: UICollectionView {
    private var nibName: String = "MainCollectionViewCell"
    
    required override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.setplayerCollectionView()
    }
    
    convenience init(nibName: String) {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: UICollectionViewLayout())
        self.nibName = nibName
        self.setplayerCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setplayerCollectionView()
    }
    
    private func setplayerCollectionView() {
        let MainCellNib = UINib(nibName: self.nibName, bundle: nil)
        self.register(MainCellNib, forCellWithReuseIdentifier: self.nibName)
        self.collectionViewLayout = makeLayout()
    }
    
    private func makeLayout() -> UICollectionViewLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let margin: CGFloat = 10
        let minimumInteritemSpacing: CGFloat = 10
        let minimumLineSpacing: CGFloat = 10
        let width = (self.bounds.width - minimumInteritemSpacing) / 2 - margin
        let height = width + 60
        
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = minimumLineSpacing
        return layout
    }
}
