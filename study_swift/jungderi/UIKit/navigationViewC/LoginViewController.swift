//
//  ViewController.swift
//  NavigationViewC
//
//  Created by 김기림 on 2022/01/02.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 상단 네비게이션 바 부분을 숨김처리하기
        self.navigationController?.isNavigationBarHidden = true
        loginBtn.addTarget(self, action: #selector(moveToMainViewController), for: .touchUpInside)
    }

    @objc func moveToMainViewController() {
        let mainViewC = MainViewController()
        
        self.navigationController?.pushViewController(mainViewC, animated: true)
    }
}

