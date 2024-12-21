//
//  ViewController.swift
//  NavigationItem_NoStoryBoard
//
//  Created by 김기림 on 2022/01/03.
//

import UIKit

class MainNaviVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        self.navigationController?.navigationBar.barStyle = .black
        
        let navigationBarAppearace = UINavigationBarAppearance()
        navigationBarAppearace.backgroundColor = .brown
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearace
//        navigationBarAppearace.barTintColor = .blue
        
//        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearace
//        self.navigationController?.navigationBar.compactAppearance = navigationBarAppearace
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .white
        
        let leftNaviItem = UIBarButtonItem(image: UIImage(systemName: "message.fill"), style: .plain, target: self, action: #selector(moveToMessageBtn))

        let rightNaviItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(moveToProfileBtn))
        
        self.navigationItem.leftBarButtonItem = leftNaviItem
        self.navigationItem.rightBarButtonItem = rightNaviItem
    }
    
    @objc fileprivate func moveToProfileBtn() {
        print("moveToProfileBtn")
        let vc = ProfileVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc fileprivate func moveToMessageBtn() {
        print("moveToMessageBtn")
        let vc = MessageVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        self.navigationBar.barTintColor = .white
    }
}
