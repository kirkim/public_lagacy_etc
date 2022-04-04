//
//  TestBannerVC.swift
//  RefactoringBannerUsingRxSwift
//
//  Created by 김기림 on 2022/03/21.
//

import UIKit
import SnapKit

class TestBannerVC: UIViewController {
    let banner = RxBannerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTestbanner()
    }
    
    private func setTestbanner() {
        self.view.addSubview(banner)
        banner.bind(RxBannerViewModel(plistType: .staticEvent), parentViewController: self)
        banner.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
}
