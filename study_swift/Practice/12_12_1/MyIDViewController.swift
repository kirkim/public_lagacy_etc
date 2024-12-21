//
//  MyIDViewController.swift
//  Practice12_12_1
//
//  Created by 김기림 on 2021/12/12.
//

import UIKit

class MyIDViewController: UIViewController {

    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.isEnabled = false
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextFiled.delegate = self
        self.emailTextFiled.keyboardType = .emailAddress
        self.emailTextFiled.enablesReturnKeyAutomatically = true
    }
}

extension MyIDViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) && (textField.text?.count)! == 1{
                self.nextButton.isEnabled = false
            } else {
                self.nextButton.isEnabled = true
            }
        }
        if (textField.text?.count)! + string.count > 30 {
            return false
        } else {
            return true
        }
    }
}
