//
//  DataSources3.swift
//  PracticeRxDataSourcesMultipleSection
//
//  Created by 김기림 on 2022/04/23.
//

import UIKit
import RxDataSources

protocol SectionItem3 {
//    var code: Int { get }
}

struct StatusOne: SectionItem3 {
    var s: Person
}

struct StatusTwo: SectionItem3 {
    var a: Int
}

struct StatusThree: SectionItem3 {
    var k: HasSubTitle
}

enum SectionModel3 {
    case SectionOne(items: [StatusOne])
    case SectionTwo(items: [StatusTwo])
    case SectionThree(header: String, items: [StatusThree])
}

extension SectionModel3: SectionModelType {
    typealias Item = SectionItem3
    
    init(original: SectionModel3, items: [SectionItem3]) {
        self = original
    }

    var headers: String? {
        switch self {
        case .SectionThree(header: let header, items: _):
            return header
        default:
            return nil
        }
    }
    
  var items: [SectionItem3] {
      switch self {
      case .SectionOne(items: let items):
          return items
      case .SectionTwo(items: let items):
          return items
      case.SectionThree(_, let items):
          return items
      }
  }
}

struct MainViewModel3 {
    let data = [
        SectionModel3.SectionOne(items: [
            StatusOne(s: Person(name: "Jack", sex: .male, age: 13)),
            StatusOne(s: Person(name: "Jake", sex: .male, age: 33)),
            StatusOne(s: Person(name: "minji", sex: .female, age: 83))
        ]),
        SectionModel3.SectionTwo(items: [
            StatusTwo(a: 1),
            StatusTwo(a: 12),
            StatusTwo(a: 3),
        ]),
        SectionModel3.SectionThree(header: "sdfkjdsljlk", items: [
            StatusThree(k: HasSubTitle(title: "hee", subTitle: "sub@@@")),
            StatusThree(k: HasSubTitle(title: "qqq", subTitle: "sub+_+")),
            StatusThree(k: HasSubTitle(title: "weweqe", subTitle: "sub!!!")),
            StatusThree(k: HasSubTitle(title: "adsad", subTitle: "subkd")),
        ])
    ]
    
    
    func dataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel3> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel3>(configureCell: { (datasource, collectionView, indexPath, item) in
            switch datasource[indexPath.section] {
            case .SectionOne(items: let items):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell1.identifier, for: indexPath) as! Cell1
                guard let item = item as? StatusOne else { return cell }
                cell.setTitle(person: item.s)
                print(items)
                return cell
            case . SectionTwo(items: let items):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell2.identifier, for: indexPath) as! Cell2
                guard let item = item as? StatusTwo else { return cell }
                cell.setTitle(title: String(item.a))
                print("2", item)
                return cell
            case .SectionThree(header: _, items: let items):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell3.identifier, for: indexPath) as! Cell3
                guard let item = item as? StatusThree else { return cell }
                cell.setTitle(item: HasSubTitle(title: item.k.title, subTitle: item.k.subTitle))
                print("3", item)
                return cell
            }
            
            
        })
        
        dataSource.configureSupplementaryView = {(dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            switch dataSource[indexPath.section] {
            case .SectionThree(header: let headerValue, _):
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
