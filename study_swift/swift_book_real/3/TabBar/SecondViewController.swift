//
//  SecondViewController.swift
//  Chapter03-TabBar
//
//  Created by 김기림 on 2021/12/03.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        
        title.text = "두번째 탭"
        title.textColor = .red // 텍스트는 빨간색으로
        title.textAlignment = .center // 레이블 내에서 중앙 정렬로
        title.font = UIFont.boldSystemFont(ofSize: 14) // 폰트는 System Font, 14pt
        
        title.sizeToFit()
        title.center.x = self.view.frame.width / 2 // x축의 중앙에 오도록
        
        self.view.addSubview(title)
        
//        self.tabBarItem.image = UIImage(named: "file-tree.png")
//        self.tabBarItem.title = "file"
    }
}
