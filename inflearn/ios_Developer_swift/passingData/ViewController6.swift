//
//  ViewController6.swift
//  passingData1
//
//  Created by 김기림 on 2021/12/08.
//

import UIKit

class ViewController6: UIViewController {

    var myClosure: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closureButton(_ sender: Any) {
        self.myClosure?("fromClosure!")
        self.dismiss(animated: true, completion: nil)
    }
}
