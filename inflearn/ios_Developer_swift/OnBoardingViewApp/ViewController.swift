//
//  ViewController.swift
//  OnBoardingViewApp
//
//  Created by 김기림 on 2021/12/13.
//

import UIKit

class ViewController: UIViewController {
    
    var didShowOnboardingView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    // viewDidLoad(), viewWillAppear()에서 처리하면 안됨. 화면 시점(라이프 사이클)에 대해서도 잘 알필요가 있다.
    override func viewDidAppear(_ animated: Bool) {
        if didShowOnboardingView == false { // 한번만 창이 나타나도록
            didShowOnboardingView = true
            // pageVC.transitionStyle값을 바꿔주려해도 get only가 나오는 경우가 있는데 이때는 생성과 동시에 설정해줘야하는 경우가 많다.
            let pageVC = OnBoardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
            pageVC.modalPresentationStyle = .fullScreen
            self.present(pageVC, animated: false, completion: nil)
        }
    }
}

