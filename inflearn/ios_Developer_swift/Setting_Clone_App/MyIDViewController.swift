//
//  MyIDViewController.swift
//  Setting_Clone_App
//
//  Created by 김기림 on 2021/12/10.
//

import UIKit

class MyIDViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
//    {
//        didSet {
//            nextButton.isEnabled = false          // => 이런식으로 비활성화 세팅을 해줘도 됨
//        }
//    }
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func doCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.textFieldDidChange(sender: emailTextField) // 처음에 창이 활성화됐을때 'Next'버튼이 비활성화되지 않는 문제때문에 직접 emailTExtField를 넣어 호출 대신에 self.nextButton.isEnabled = false를 작성해도 되는데 각자의 스타일에 맞춰서 작성하면 된다.
    }

    @objc func textFieldDidChange(sender: UITextField) {
        if sender.text?.isEmpty == true {
            self.nextButton.isEnabled = false
        } else {
            self.nextButton.isEnabled = true
        }
    }
}
