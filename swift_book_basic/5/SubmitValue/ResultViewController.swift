//
//  ResultViewController.swift
//  SubmitValue
//
//  Created by 김기림 on 2021/11/23.
//

import Foundation
import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var resultEmail: UILabel!
    @IBOutlet var resultUpdate: UILabel!
    @IBOutlet var resultInterval: UILabel!
    
    var paramEmail: String = ""
    var paramUpdate: Bool = false
    var paramInterval: Double = 0
    
    override func viewDidLoad() {
        self.resultEmail.text = self.paramEmail
        self.resultUpdate.text = (self.paramUpdate == true ? "자동갱신" : "자동갱신안함")
        self.resultInterval.text = "\(Int(self.paramInterval))분 마다 갱신"
    }
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
