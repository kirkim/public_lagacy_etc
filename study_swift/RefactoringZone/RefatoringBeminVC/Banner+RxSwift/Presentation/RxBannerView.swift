//
//  MyBannerUsingRxSwift.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RxBannerView: UIView {
    let disposeBag = DisposeBag()
    private var bannerListView: RxBannerListView
    private let bannerButton = RxBannerButton()

    //MARK: - MyBannerUsingRxswift init
    init() {
        self.bannerListView = RxBannerListView(frame: CGRect.zero, collectionViewLayout: .init())
        super.init(frame: CGRect.zero)
        self.layout()
        self.attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - MyBannerUsingRxswift: layout, bind function
    private func layout() {
        self.addSubview(bannerListView)
        bannerListView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
        
        self.addSubview(self.bannerButton)
        self.bannerButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(self.bannerListView.snp.height).multipliedBy(0.15)
            $0.width.equalTo(self.bannerListView.snp.width).multipliedBy(0.25)
        }
    }
    
    private func attribute() {
    }
    
    func bind(_ viewModel: RxBannerViewModel, parentViewController: UIViewController) {
        self.bannerListView.bind(viewModel.bannerListViewModel)
        self.bannerButton.bind(viewModel.buttonViewModel)
        
        viewModel.buttonViewModel.buttonTapped.subscribe(onNext: {
            print("hello")
        })
        .disposed(by: disposeBag)
    }
}
