//
//  ViewController.swift
//  Practice_customButton
//
//  Created by 김기림 on 2022/02/02.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButton()
        makeNaviTitle()
        makeBackButton()
        naviBackgroundDesign()
    }

    private func makeButton() {
        let btn = RotationButton()
        btn.setTitle("hi", for: .normal)
        btn.backgroundColor = .blue
        btn.tintColor = .white
        self.view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        btn.setImage(UIImage(named: "다운로드"), for: .normal)
    }
    
    private func makeNaviTitle() {
        let logo = UIImageView(image: UIImage(named: "pepsi"))
        logo.contentMode = .scaleAspectFit
        
        self.navigationItem.titleView = logo
    }
    
    private func makeBackButton() {
        let backImage = UIImage(named: "다운로드")!.withRenderingMode(.alwaysOriginal)
        let newWidth = 40
        let newHeight = 40
        let newImageRect = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)

        // 빈도화지의 크기를 만들어 그려준다는 느낌으로 다음의 코드가 동작 (한세트)
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        backImage.draw(in: newImageRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
        UIGraphicsEndImageContext()
        
        self.navigationController?.navigationBar.backIndicatorImage =  newImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage =  newImage
        self.navigationItem.backButtonTitle = ""
    }
    
    private func naviBackgroundDesign() {
        self.navigationController?.navigationBar.backgroundColor = .red
//        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.statusBar?.backgroundColor = .blue
    }
}

extension UIViewController {
    var statusBar: UIView? {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        if let statusBarView = sceneDelegate?.statusBarView {
            statusBarView.backgroundColor = .yellow
            sceneDelegate?.window?.addSubview(statusBarView)
        }
        return sceneDelegate?.statusBarView
    }
}
