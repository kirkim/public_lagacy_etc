//
//  BeminCollectionVC.swift
//  Bemin_0307
//
//  Created by 김기림 on 2022/03/09.
//

import UIKit
import RxSwift
import RxCocoa

class BeminStaticView: UICollectionViewCell {
    private let STATIC_SECTION_TOTALCOUNT: Int
    private let staticModel = StaticSectionViewModel()
    private let disposeBag = DisposeBag()
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
//MARK: - BeminCollectionVC init
    override init(frame: CGRect) {
        self.STATIC_SECTION_TOTALCOUNT = staticModel.getStaticSectionTotalCount()
        super.init(frame: CGRect.zero)
        attribute()
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - BeminCollectionVC: attribute, layout
    private func attribute() {
        staticModel.registerCells(on: collectionView)
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .white
    }
    
    private func layout() {
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: - BeminCollectionVC: bind
    private func bind() {
        //        let bannerViewModel = RxBannerViewModel(plistType: .staticEvent)
        staticModel.bannerView.bind(RxBannerViewModel(plistType: .staticEvent), parentViewController: UIViewController())
        
        staticModel.cellData
            .drive(collectionView.rx.items) { cv, row, data in
                print(cv, row, data)
                return self.staticModel.getCellBySection(cv, cellForItemAt: IndexPath(row: row, section: 0))
            }
            .disposed(by: disposeBag)
    }
    
    
    //MARK: - BeminCollectionVC custom function
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            return self.staticModel.staticSectionLayout(sectionNumber: sectionNumber)
        }
    }
}
