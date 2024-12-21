//
//  BaseViewController.swift
//  NoStoryBoardTabBar
//
//  Created by 김기림 on 2022/01/03.
//

import UIKit

class BaseViewController: UIViewController {
    
//    private var titleText: String = ""
//    private var bgColor: UIColor = .white
    
    convenience init(titleText: String, bgColor: UIColor) {
        self.init()
        self.title = titleText
        self.view.backgroundColor = bgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = titleText
//        self.view.backgroundColor = bgColor
    }
}
