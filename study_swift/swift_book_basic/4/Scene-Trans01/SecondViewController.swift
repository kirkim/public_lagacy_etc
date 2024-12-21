//
//  SecondViewController.swift
//  Scene-Trans01
//
//  Created by 김기림 on 2021/11/22.
//

// import Foundation
import UIKit
class SecondViewController: UIViewController {
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
