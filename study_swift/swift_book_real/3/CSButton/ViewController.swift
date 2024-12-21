//
//  ViewController.swift
//  chapter03-CSButton
//
//  Created by 김기림 on 2021/12/04.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
//        let frame = CGRect(x: 30 , y: 50, width: 150, height: 30)
//        let csBtn = CSButton(frame: frame)
        
        // frame속성을 설정해 주어야 표시됨
        let csBtn = CSButton()
        csBtn.frame = CGRect(x: 30 , y: 50, width: 150, height: 30)
        self.view.addSubview(csBtn)
        
        // 인자값에 따라 다른 스타일로 결정되는 버튼 1
        let rectBtn = CSButton(type: .rect)
        rectBtn.frame = CGRect(x: 30, y: 230, width: 150, height: 30)
        self.view.addSubview(rectBtn)
        
        // 인자값에 따라 다른 스타일로 결정되는 버튼 2
        let circleBtn = CSButton(type: .circle)
        circleBtn.frame = CGRect(x: 200, y: 230, width: 150, height: 30)
        self.view.addSubview(circleBtn)
    }
}

