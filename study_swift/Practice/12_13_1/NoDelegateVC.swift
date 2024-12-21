//
//  NoDelgateVC.swift
//  Practice12_13_1
//
//  Created by 김기림 on 2021/12/13.
//

import Foundation
import UIKit

class NoDelegateVC: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var submitBtn: UIButton! {
        didSet {
            submitBtn.isEnabled = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.textField.addAction(UIAction(handler: {(s) in
            if sender.text?.isEmpty == true {
            self.submitBtn.isEnabled = false
        } else {
            self.submitBtn.isEnabled = true
        }}
    ), for: .editingChanged)
        
//    @objc func textFieldDidChange(sender: UITextField) {
//        if sender.text?.isEmpty == true {
//            self.submitBtn.isEnabled = false
//        } else {
//            self.submitBtn.isEnabled = true
//        }
//    }
}
