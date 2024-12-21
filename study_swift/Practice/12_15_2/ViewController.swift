//
//  ViewController.swift
//  12_15_2
//
//  Created by 김기림 on 2021/12/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func nextPageBtn(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {
            return
        }
        vc.storyLabel?.text = "바뀐 스토리 Label"
        vc.codeLabel?.text = "바뀐 코드 Label"
        vc.classLevelCodeLabel.text = "바뀐 클래스코드 Label"
        self.present(vc, animated: true, completion: nil)
    }
}

