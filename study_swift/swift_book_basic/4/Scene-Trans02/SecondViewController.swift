//
//  SecondViewController.swift
//  Scene-Trans02
//
//  Created by 김기림 on 2021/11/23.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    @IBAction func back2(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
