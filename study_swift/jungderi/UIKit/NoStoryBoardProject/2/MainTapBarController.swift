//
//  ViewController.swift
//  NoStoryBoardTabBar
//
//  Created by 김기림 on 2022/01/03.
//

import UIKit

class NaviData {
    private var data: [UINavigationController] = [
        UINavigationController.init(rootViewController: BaseViewController(titleText: "첫번째 뷰", bgColor: .red)),
        UINavigationController.init(rootViewController: BaseViewController(titleText: "두번째 뷰", bgColor: .orange)),
        UINavigationController.init(rootViewController: BaseViewController(titleText: "세번째 뷰", bgColor: .yellow)),
        UINavigationController.init(rootViewController: BaseViewController(titleText: "네번째 뷰", bgColor: .blue)),
        UINavigationController.init(rootViewController: BaseViewController(titleText: "다섯번째 뷰", bgColor: .green))
    ]
    
    func addNavigationController(NC: UINavigationController) {
        self.data.append(NC)
    }
    
    func getNavigationControllers()-> [UINavigationController] {
        return self.data
    }
    
    func setTabBarItem(index: Int, title: String, image: UIImage?) {
        self.data[index].tabBarItem = UITabBarItem(title: title, image: image, tag: index)
    }
}

class MainTapBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .white
        
        let NCData = NaviData()
        self.viewControllers =  NCData.getNavigationControllers()
        
        NCData.setTabBarItem(index: 0, title: "첫번째 아이템", image: UIImage(systemName: "square.and.arrow.up"))
        NCData.setTabBarItem(index: 1, title: "두번째 아이템", image: UIImage(systemName: "person"))
        NCData.setTabBarItem(index: 2, title: "세번째 아이템", image: UIImage(systemName: "mic.fill"))
        NCData.setTabBarItem(index: 3, title: "네번째 아이템", image: UIImage(systemName: "bubble.right"))
        NCData.setTabBarItem(index: 4, title: "다섯번째 아이템", image: UIImage(systemName: "airplane"))
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        self.navigationBar.backgroundColor = .white
        self.navigationBar.prefersLargeTitles = false
    }
}
