//
//  ViewController5.swift
//  passingData1
//
//  Created by 김기림 on 2021/12/08.
//

import UIKit

protocol ViewController5Delegate: AnyObject {
    func pushData(data: String)
}

class ViewController5: UIViewController {

    weak var delegate: ViewController5Delegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func toMain(_ sender: Any) {
        delegate?.pushData(data: "fromDelegate!")
        self.dismiss(animated: true, completion: nil)
    }
}
