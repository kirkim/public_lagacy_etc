//
//  DataSource4.swift
//  PracticeRxDataSourcesMultipleSection
//
//  Created by 김기림 on 2022/04/23.
//

import Foundation

import UIKit
import RxDataSources

enum SectionItem4 {
    case StatusOne(s: Person)
    case StatusTwo(a: Int)
    case StatusThree(k: HasSubTitle)
}

struct SectionModel4 {
    var header: String?
    var items: [Item]
}

extension SectionModel4: SectionModelType {
    typealias Item = SectionItem4
    
    init(original: SectionModel4, items: [SectionItem4]) {
        self = original
        self.items = items
    }
}

struct MainViewModel4 {
    let data = [
        SectionModel4(items: [
            SectionItem4.StatusOne(s: Person(name: "박지성", sex: .male, age: 32)),
            SectionItem4.StatusOne(s: Person(name: "지수", sex: .female, age: 12)),
            SectionItem4.StatusOne(s: Person(name: "손흥민", sex: .male, age: 22)),
        ]),
        SectionModel4(items: [
            SectionItem4.StatusTwo(a: 3),
            SectionItem4.StatusTwo(a: 5),
            SectionItem4.StatusOne(s: Person(name: "지수", sex: .female, age: 12))
        ]),
        SectionModel4(header: "header!!", items: [
            SectionItem4.StatusThree(k: HasSubTitle(title: "sfds", subTitle: "sub")),
            SectionItem4.StatusThree(k: HasSubTitle(title: "sfdsss", subTitle: "su1b")),
            SectionItem4.StatusThree(k: HasSubTitle(title: "sfd2s", subTitle: "seeub")),
            SectionItem4.StatusTwo(a: 5),
        ])
    ]
    
    
    func dataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel4> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel4>(configureCell: { (datasource, collectionView, indexPath, item) in
            switch datasource[indexPath] {
            case .StatusOne(s: let items):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell1.identifier, for: indexPath) as! Cell1
                cell.setTitle(person: items)
                return cell
            case .StatusTwo(a: let items):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell2.identifier, for: indexPath) as! Cell2
                cell.setTitle(title: String(items))
                return cell
            case .StatusThree(k: let items):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell3.identifier, for: indexPath) as! Cell3
                cell.setTitle(item: items)
                return cell
            }
        })
        
        dataSource.configureSupplementaryView = {(dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            switch indexPath.section {
            case 2:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MagnetMenuHeaderCell.identifier, for: indexPath) as! MagnetMenuHeaderCell
                header.setData(title: dataSource[indexPath.section].header ?? "")
                return header
            default:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BlankHeaderCell.identifier, for: indexPath)
                return header
            }
        }
        return dataSource
    }
}
