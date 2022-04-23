//
//  DataSources2.swift
//  PracticeRxDataSourcesMultipleSection
//
//  Created by 김기림 on 2022/04/23.
//

import UIKit
import RxDataSources

enum SectionType {
    case one
    case two
    case three(header: String)
}

struct SectionModel2 {
    var sectionType: SectionType
    var items: [Item]
}

enum SectionItem2 {
    case StatusOne(s: Person)
    case StatusTwo(a: Int)
    case StatusThree(k: HasSubTitle)
}

extension SectionModel2: SectionModelType {
    typealias Item = SectionItem2
    
    init(original: SectionModel2, items: [SectionItem2]) {
        self = original
        self.items = items
    }
}

struct MainViewModel2 {
    let data = [
        SectionModel2(sectionType: .one, items: [
            SectionItem2.StatusOne(s: Person(name: "박지성", sex: .male, age: 23)),
            SectionItem2.StatusOne(s: Person(name: "지수", sex: .female, age: 21))
        ]),
        SectionModel2(sectionType: .two, items: [
            SectionItem2.StatusOne(s: Person(name: "박지성", sex: .male, age: 23)),
            SectionItem2.StatusOne(s: Person(name: "지수", sex: .female, age: 21))
        ]),
        SectionModel2(sectionType: .three(header: "헤더!!"), items: [
            SectionItem2.StatusTwo(a: 3),
            SectionItem2.StatusThree(k: HasSubTitle(title: "sss", subTitle: "eee"))
        ]),

    ]
    
    
    func dataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel2> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel2>(configureCell: { (datasource, collectionView, indexPath, item) in
            switch datasource[indexPath] {
            case .StatusOne(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell1.identifier, for: indexPath) as! Cell1
                cell.setTitle(person: item)
                return cell
            case .StatusTwo(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell2.identifier, for: indexPath) as! Cell2
                cell.setTitle(title: String(item))
                return cell
            case .StatusThree(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell3.identifier, for: indexPath) as! Cell3
                cell.setTitle(item: item)
                return cell
            }
        })
        
        dataSource.configureSupplementaryView = {(dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            switch dataSource[indexPath.section].sectionType {
            case .three(let headerValue):
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MagnetMenuHeaderCell.identifier, for: indexPath) as! MagnetMenuHeaderCell
                header.setData(title: headerValue)
                return header
            default:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BlankHeaderCell.identifier, for: indexPath)
                return header
            }
        }
        return dataSource
    }
}
