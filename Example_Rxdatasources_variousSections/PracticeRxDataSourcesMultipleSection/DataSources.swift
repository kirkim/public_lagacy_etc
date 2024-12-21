//
//  DataSources.swift
//  PracticeRxDataSourcesMultipleSection
//
//  Created by 김기림 on 2022/04/22.
//

import UIKit
import RxDataSources

enum Sex {
    case male
    case female
}

struct Person {
    var name: String
    var sex: Sex
    var age: Int
}

struct HasSubTitle {
    var title: String
    var subTitle: String
}

enum SectionModel {
    case SectionOne(items: [SectionItem])
    case SectionTwo(items: [SectionItem])
    case SectionThree(header: String, items: [SectionItem])
}

enum SectionItem {
    case StatusOne(s: Person)
    case StatusTwo(a: Int)
    case StatusThree(k: HasSubTitle)
}

extension SectionModel: SectionModelType {
    typealias Item = SectionItem
    
    init(original: SectionModel, items: [SectionItem]) {
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
    
  var items: [SectionItem] {
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

struct MainViewModel {
    let data = [
        SectionModel.SectionOne(
            items: [
                SectionItem.StatusOne(s: Person(name: "손흥민", sex: .male, age: 29)),
                SectionItem.StatusOne(s: Person(name: "로제", sex: .female, age: 21)),
                SectionItem.StatusTwo(a: 4),
                SectionItem.StatusOne(s: Person(name: "박지성", sex: .male , age: 31)),
                SectionItem.StatusOne(s: Person(name: "지수", sex: .female , age: 11)),
            ]),
        SectionModel.SectionTwo(
            items: [
                SectionItem.StatusTwo(a: 1),
                SectionItem.StatusThree(k: HasSubTitle(title: "제목!!", subTitle: "서브제목!!")),
                SectionItem.StatusOne(s: Person(name: "박지성", sex: .male , age: 31)),
                SectionItem.StatusTwo(a: 3),
                SectionItem.StatusTwo(a: 4)
            ]),
        SectionModel.SectionThree(
            header: "ssee",
            items: [
                SectionItem.StatusThree(k: HasSubTitle(title: "제목+_+", subTitle: "서브제목+_+")),
                SectionItem.StatusThree(k: HasSubTitle(title: "제목", subTitle: "서브제목")),
            ]),
    ]
    
    
    func dataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel>(configureCell: { (datasource, collectionView, indexPath, item) in
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

