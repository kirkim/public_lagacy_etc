//
//  Bemin+StaticSection.swift
//  Bemin_0307
//
//  Created by 김기림 on 2022/03/09.
//

import UIKit
import RxSwift
import RxCocoa

struct StaticSectionViewModel {
    private let manager = StaticSectionViewManager()
    var bannerView: RxBannerView {
        return manager.bannerView
    }
    let cellData: Driver<[BeminStaticContent]>
    
    init() {
        cellData = Observable
            .just(manager.contents)
            .asDriver(onErrorJustReturn: [])
    }
    
    // 스테틱 셀 아이템 갯수
    func numberOfStaticItem(section: Int) -> Int {
        return manager.numberOfStaticItem(section: section)
    }
    
    // 스테틱 셀의 섹션레이아웃(
    func staticSectionLayout(sectionNumber: Int) -> NSCollectionLayoutSection {
        return manager.staticSectionLayout(sectionNumber: sectionNumber)
    }
    
    // 스테틱 섹션(Section)의 갯수
    func getStaticSectionTotalCount() -> Int {
        return manager.getStaticSectionTotalCount()
    }
    
    // 스테틱 섹션에 사용할 셀 클래스(Cell Class)를 부모 콜렉션뷰에 등록해줌
    func registerCells(on collectionView: UICollectionView) {
        return manager.registerCells(on: collectionView)
    }
    
    // indexPath에 맞는 셀(Cell)을 가공해서 반환해줌
    func getCellBySection(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return manager.getCellBySection(collectionView, cellForItemAt: indexPath)
    }
}

struct StaticSectionViewManager {
    var contents: [BeminStaticContent] {
        guard let path = Bundle.main.path(forResource: "BeminStaticContent", ofType: "plist") else {
            print("path error")
            return []
        }
        guard let data = FileManager.default.contents(atPath: path) else {
            print("FileManager error")
            return []
        }
        guard let list = try? PropertyListDecoder().decode([BeminStaticContent].self, from: data) else {
            print("decode error")
            return []
        }
        return list
    }
    
    private let sectionLayoutManager = StaticSEctionLayoutManager()
    let bannerView = RxBannerView()
         
    init() {
    }
    
    func getStaticSectionTotalCount() -> Int {
        print("STaticSectionModel getStaticSectionTotalCount called:", contents.count)
        return contents.count
    }
    
    func numberOfStaticItem(section: Int) -> Int {
        return contents[section].contentItem.count
    }
    
    func staticSectionLayout(sectionNumber: Int) -> NSCollectionLayoutSection {
        return sectionLayoutManager.staticSectionLayout(staticSectionType: contents[sectionNumber].sectionType)
    }

    
    func registerCells(on collectionView: UICollectionView) {
        collectionView.register(StaticBigCell.self, forCellWithReuseIdentifier: StaticBigCell.cellId)
        collectionView.register(StaticMediumCell.self, forCellWithReuseIdentifier: StaticMediumCell.cellId)
        collectionView.register(StaticMedium_2Cell.self, forCellWithReuseIdentifier: StaticMedium_2Cell.cellId)
        collectionView.register(StaticSmall_3Cell.self, forCellWithReuseIdentifier: StaticSmall_3Cell.cellId)
        collectionView.register(StaticSmall_4Cell.self, forCellWithReuseIdentifier: StaticSmall_4Cell.cellId)
        collectionView.register(StaticBannerCell.self, forCellWithReuseIdentifier: StaticBannerCell.cellId)
    }
    
    func getCellBySection(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let content = contents[indexPath.section]
        let item = content.contentItem[indexPath.row]
        switch content.sectionType {
        case .big:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticBigCell.cellId, for: indexPath) as? StaticBigCell else { return UICollectionViewCell() }
            cell.titleLabel.text = item.title
            cell.descriptionLabel.text = item.description
            cell.imageView.image = item.image
            return cell
        case .medium:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticMediumCell.cellId, for: indexPath) as? StaticMediumCell else { return UICollectionViewCell() }
            cell.titleLabel.text = item.title
            cell.descriptionLabel.text = item.description
            cell.imageView.image = item.image
            return cell
        case .medium_2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticMedium_2Cell.cellId, for: indexPath) as? StaticMedium_2Cell else { return UICollectionViewCell() }
            cell.titleLabel.text = item.title
            cell.descriptionLabel.text = item.description
            cell.imageView.image = item.image
            return cell
        case .small_3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticSmall_3Cell.cellId, for: indexPath) as? StaticSmall_3Cell else { return UICollectionViewCell() }
            cell.titleLabel.text = item.title
            cell.imageView.image = item.image
            return cell
        case .small_4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticSmall_4Cell.cellId, for: indexPath) as? StaticSmall_4Cell else { return UICollectionViewCell() }
            cell.titleLabel.text = item.title
            cell.imageView.image = item.image
            return cell
        case .banner:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticBannerCell.cellId, for: indexPath) as? StaticBannerCell else { return UICollectionViewCell() }
            cell.banner = self.bannerView
            return cell
        }
    }
}
