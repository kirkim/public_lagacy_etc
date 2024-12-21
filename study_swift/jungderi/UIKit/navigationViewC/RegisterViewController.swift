//
//  RegisterViewController.swift
//  NavigationViewC
//
//  Created by 김기림 on 2022/01/02.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var btnForLoginViewController: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func onLoginViewControllerBtnClicked(_ sender: UIButton) {
        print("Re클릭")
        self.navigationController?.popViewController(animated: true)
    }
    
}
