//
//  ViewController4.swift
//  passingData1
//
//  Created by 김기림 on 2021/12/08.
//

import UIKit

class ViewController4: UIViewController {

    var MainView: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func toMain(_ sender: Any) {
        self.MainView?.output.text = "Good!"
        self.dismiss(animated: true, completion: nil)
    }
    
}
