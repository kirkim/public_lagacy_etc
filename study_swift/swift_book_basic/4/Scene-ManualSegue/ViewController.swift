//
//  ViewController.swift
//  Scene--ManualSegue
//
//  Created by 김기림 on 2021/11/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func wind(_ sender: Any) {
        // 세그웨이를 실행한다
        self.performSegue(withIdentifier:"ManualWind", sender: self)
    }
    
    @IBAction func unwindToVC(_ segue: UIStoryboardSegue) {
        
    }
}

