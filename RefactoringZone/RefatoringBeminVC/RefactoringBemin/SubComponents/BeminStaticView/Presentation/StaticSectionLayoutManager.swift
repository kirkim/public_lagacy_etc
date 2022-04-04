//
//  StaticSectionLayoutManager.swift
//  RefactoringBeminVC
//
//  Created by 김기림 on 2022/04/04.
//

import UIKit

struct StaticSEctionLayoutManager {
    private let itemSpacing: CGFloat = 16
    private let sideMargin: CGFloat = 16
    private let topMargin: CGFloat = 10
    private let bottomMargin: CGFloat = 5
    
    private let bigHeight: CGFloat = 0.5
    private let smallHeight: CGFloat = 0.2
    private let midiumHeight: CGFloat = 0.25
    private let bannerHeight: CGFloat = 0.35
    
    func staticSectionLayout(staticSectionType: StaticSectionType) -> NSCollectionLayoutSection {
        switch staticSectionType {
        case .big:
            return self.bigSection()
        case .medium:
            return self.mediumSection()
        case .medium_2:
            return self.medium_2Section()
        case .small_3:
            return self.small_3Section()
        case .small_4:
            return self.small_4Section()
        case .banner:
            return self.bannerSection()
        }
    }

    private func bigSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(bigHeight)), subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    private func mediumSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(smallHeight)), subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    private func medium_2Section() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(midiumHeight)), subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    private func small_3Section() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(smallHeight)), subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    private func bannerSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(bannerHeight)), subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    private func small_4Section() -> NSCollectionLayoutSection {
        let sevenSpacing:CGFloat = 1
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: sevenSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(smallHeight)), subitem: item, count: 4)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-sevenSpacing)
        return section
    }

}
