//
//  ViewController.swift
//  Practice_closure_delegate
//
//  Created by 김기림 on 2022/01/21.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func handleOpenTableVCBtn(_ sender: UIButton) {
        guard let TableVC = self.storyboard?.instantiateViewController(withIdentifier: "TableVC") as? TableVC else {
            return
        }
        TableVC.modalPresentationStyle = .fullScreen
        self.present(TableVC, animated: true, completion: nil)
    }
}

