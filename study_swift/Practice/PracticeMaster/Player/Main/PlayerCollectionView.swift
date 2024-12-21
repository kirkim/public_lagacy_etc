//
//  CollectionViewUI.swift
//  PracticeAVFoundation
//
//  Created by 김기림 on 2022/02/09.
//

import UIKit

class PlayerCollectionView: UICollectionView {
    private var cellNibName: String = ""
    private var headerNibName: String = ""
    
    init(cellNibName: String, headerNibName: String, frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        self.cellNibName = cellNibName
        self.headerNibName = headerNibName
        self.collectionViewLayout = collectionViewFlowUI()
        registerCell()
        registerHeaderCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCell() {
        let cellNib = UINib(nibName: cellNibName, bundle: nil)
        self.register(cellNib, forCellWithReuseIdentifier: cellNibName)
        
    }
    
    private func registerHeaderCell() {
        let headerNib = UINib(nibName: headerNibName, bundle: nil)
        self.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerNibName)
    }
    
    private func collectionViewFlowUI() -> UICollectionViewFlowLayout{
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let margin: CGFloat = 10
        let minimumInteritemSpacing: CGFloat = 10
        let minimumLineSpacing: CGFloat = 10
        let width = (self.bounds.width - minimumInteritemSpacing) / 2 - margin
        let height = width + 90

        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = minimumLineSpacing
        layout.headerReferenceSize.height = 200
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }
}
