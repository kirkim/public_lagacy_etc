//
//  MagnetListSectionManager.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/19.
//

import UIKit

enum MagnetSectionType: Int {
    case banner
    case Info
    case stickHeader
    case menu
    var section: Int {
        return self.rawValue
    }
}

struct MagnetListSectionManager {
    let bannerCellHeightRatio:CGFloat = 10/13
    private let InfoCellHeightRatio:CGFloat = 8/13
    private let menuListCellHeightRatio:CGFloat = 0.1
//    let stickyHeaderPositionY:CGFloat
    private let menuListHeaderHeight:CGFloat = 30
    private let sectionSpace:CGFloat = 30
    
    
    init() {

    }
        
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 1:
                return self.noHeaderSection()
            default:
                return self.menuSection()
            }
        }
    }

    private func noHeaderSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(menuListCellHeightRatio)), subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: sectionSpace, trailing: 0)
        return section
    }
    
    private func menuSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(menuListCellHeightRatio)), subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: sectionSpace, trailing: 0)
        // header
        let globalHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(menuListHeaderHeight))
        let globalHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: globalHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        globalHeader.pinToVisibleBounds = false
        section.boundarySupplementaryItems = [globalHeader]
        return section
    }
}
