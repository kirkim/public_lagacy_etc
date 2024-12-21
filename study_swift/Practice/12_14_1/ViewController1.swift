//
//  ViewController.swift
//  Practice12_13_2
//
//  Created by 김기림 on 2021/12/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tempButton = UIButton(frame: CGRect(x: 200, y: 200, width: 200, height: 200))
        self.view.addSubview(tempButton)
        tempButton.addAction(<#T##action: UIAction##UIAction#>, for: <#T##UIControl.Event#>)
        
        let alert = UIAlertController()
        alert.frame = CGRect(frame: CGRect(x: 300, y: 300, width: 400, height: 200))
    }


}

