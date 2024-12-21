//
//  ViewController3.swift
//  passingData1
//
//  Created by 김기림 on 2021/12/08.
//

import UIKit

class ViewController3: UIViewController {

    @IBOutlet weak var output: UILabel!
    var param: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.text = param
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
