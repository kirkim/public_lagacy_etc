//
//  DataSources.swift
//  PracticeRxDataSourcesMultipleSection
//
//  Created by 김기림 on 2022/04/22.
//

import UIKit
import RxDataSources

enum SectionModel {
  case SectionOne(items: [SectionItem])
  case SectionTwo(items: [SectionItem])
    case SectionThree(header: String, items: [SectionItem])
}

struct Person {
    var name: String
    var age: Int
}

enum SectionItem {
    case StatusOne(s: Person)
    case StatusTwo(a: Int)
    case StatusThree(k: Int)
}

extension SectionModel: SectionModelType {
    init(original: SectionModel, items: [SectionItem]) {
        switch  original {
        case .SectionOne(items: let items):
            self = .SectionOne(items: items)
        case .SectionTwo(items: let items):
            self = .SectionTwo(items: items)
        case .SectionThree(header: let header, items: let items):
            self = .SectionThree(header: header, items: items)
        }
    }
    
  typealias Item = SectionItem

    var headers: String {
        switch self {
        case .SectionThree(header: let header, items: _):
            return header
        default:
            return ""
        }
    }
    
  var items: [SectionItem] {
      switch self {
      case .SectionOne(items: let items):
          return items
      case .SectionTwo(items: let items):
          return items.map { $0 }
      case.SectionThree(let header, let items):
          return items.map { $0 }
      }
  }
    
  init(original: SectionModel) {
      switch  original {
      case .SectionOne(items: let items):
          self = .SectionOne(items: items)
      case .SectionTwo(items: let items):
          self = .SectionTwo(items: items)
      case .SectionThree(header: let headerr, items: let itemss):
          print(headerr)
          self = .SectionThree(header: headerr, items: itemss)
      }
  }
}

struct MainViewModel {
    let data = [
        SectionModel(original: SectionModel.SectionOne(items: [
            SectionItem.StatusOne(s: Person(name: "kk", age: 1)),
            SectionItem.StatusOne(s: Person(name: "kks", age: 21)),
            SectionItem.StatusOne(s: Person(name: "kdk", age: 31)),
            SectionItem.StatusOne(s: Person(name: "ksfk", age: 11)),
            SectionItem.StatusOne(s: Person(name: "ksdk", age: 41))
        ])
        ),
        SectionModel(original: SectionModel.SectionTwo(items: [
            SectionItem.StatusTwo(a: 1),
            SectionItem.StatusThree(k: 2),
            SectionItem.StatusTwo(a: 3),
            SectionItem.StatusTwo(a: 4)
        ])),
        SectionModel(original: SectionModel.SectionThree(header: "ssee", items: [
            SectionItem.StatusThree(k: 1),
            SectionItem.StatusThree(k: 2),
        ])),
    ]
    
    
    func dataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel>(configureCell: { (datasource, collectionView, indexPath, item) in
            switch datasource[indexPath] {
            case .StatusOne(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell1.identifier, for: indexPath) as! Cell1
                cell.setTitle(title: item.name)
                return cell
            case .StatusTwo(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell2.identifier, for: indexPath) as! Cell2
                cell.setTitle(title: String(item))
                return cell
            case .StatusThree(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell3.identifier, for: indexPath) as! Cell3
                cell.setTitle(title: String(item))
                return cell
            }
        })
        
        dataSource.configureSupplementaryView = {(dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            switch dataSource[indexPath.section] {
            case .SectionThree(header: let headerr, items: let items):
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MagnetMenuHeaderCell.identifier, for: indexPath) as! MagnetMenuHeaderCell
                print("s1", headerr)
                print("s2", items[0])
                header.setData(title: "내가 헤더")
                return header
            default:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BlankHeaderCell.identifier, for: indexPath)

                return header

            }
        }

        return dataSource
    }
}

