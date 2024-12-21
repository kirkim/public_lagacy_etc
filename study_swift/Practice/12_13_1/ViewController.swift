//
//  ViewController.swift
//  Practice12_13_1
//
//  Created by 김기림 on 2021/12/13.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var submitBtn: UIButton! {
        didSet {
            submitBtn.isEnabled = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && range.length != 0 {
            self.submitBtn.isEnabled = false
        } else {
            self.submitBtn.isEnabled = true
        }
        return true
    }
}
